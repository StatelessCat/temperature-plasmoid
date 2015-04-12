import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    Text {
        id: log;
        anchors.fill: parent;
        anchors.margins: 10
    }

    // update the view
    function showInfo(temperature) {
        log.text = temperature + "°C"
    }

    function request() {
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {
            if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {

            } else if (doc.readyState == XMLHttpRequest.DONE) {
                var a = doc.responseText

                // millicelsius to celsius
                a = a.substr(0, a.length-4)

                // update the view
                showInfo(a);
            }
        }
        doc.open("GET", "/sys/bus/platform/drivers/coretemp/coretemp.0/hwmon/hwmon0/temp1_input");
        doc.send();
    }
    Timer {
        running: true
        repeat: true
        triggeredOnStart: true
        interval: 1000
        onTriggered: request()
    }
}
