/**
 * This file is part of PushIt.
 *
 * Copyright 2015 (C) Mario Guerriero <marioguerriero33@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/

import QtQuick 2.2
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0

Dialog {
    id: root
    title: i18n.tr("Select a Device")

    ListModel {
        id: model
    }

    ListView {
        id: list
        height: units.gu(24)
        model: model
        clip: true
        delegate: Standard {
            text: nickname
            iconSource: "../../../data/" + type + ".png" // TODO: find a better way yo do that
            onClicked: {
                caller.value = nickname;
                caller.deviceIden = iden;
                PopupUtils.close(root);
            }
        }
    }

    Component.onCompleted: {
        var devices = pbData.devices;

        // Append the 'All' list entry
        model.append({  "iden":         null,
                         "nickname":    i18n.tr("All"),
                         "type":        "device-fallback"
                     });

        for(var n = 0; n < devices.length; n++) {
            var device = devices[n];
            model.append({  "iden":         device.iden,
                             "push_token":  device.push_toekn,
                             "app_version": device.app_version,
                             "fingerprint": device.fingerprint,
                             "active":      device.active,
                             "nickname":    device.nickname,
                             "manufacturer":device.manufacturer,
                             "type":        device.type,
                             "created":     device.created,
                             "modified":    device.modified,
                             "model":       device.model,
                             "pushable":    device.pushable
                         });
        }
    }
}
