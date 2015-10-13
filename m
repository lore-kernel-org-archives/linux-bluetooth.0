Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2015 10:59:02 -0700
Message-ID: <CAGXr9JEe-k+WDTAH3fu0-SK18BV2J=w00OWcCsYhirJB1vv36A@mail.gmail.com>
Subject: Why does BlueZ remove BLE device services with disconnect reason 0?
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

linux-bluetooth:

I'm seeing the following issue with BlueZ 5.30 and BLE HoG remote control:

The BLE HoG device is already paired and been able to reconnect to
BlueZ host previously.
But, every once in a while, the reconnect fails with "Reason:
Connection Failed to be Established (0x3e)" -> reason 0
(MGMT_DEV_DISCONN_UNKNOWN).
That causes BlueZ to remove all services of this HoG device
(disconnected -> unavailable), and after that, the HoG device is
useless on any future reconnect attempts.

Question:
Why does BlueZ tear down all services of a BLE device when there is an
intermittent connection error with reason 0
(MGMT_DEV_DISCONN_UNKNOWN)?

This obviously does not happen in the normal case when the disconnect
reason is 3 (MGMT_DEV_DISCONN_REMOTE).
Can someone point me to the relevant code? I need to prevent this BLE
service tear-down.

10/05,033059.590 bluez: bluetoothd[21161]:
src/adapter.c:dev_disconnected() Device 5C:31:3E:08:XX:XX
disconnected, reason 0
10/05,033059.591 btmon: > HCI Event: Disconnect Complete (0x05) plen 4
          [hci0] 05:30:59.590927
10/05,033059.591 btmon:         Status: Success (0x00)
10/05,033059.591 btmon:         Handle: 128
10/05,033059.592 btmon:         Reason: Connection Failed to be
Established (0x3e)
10/05,033059.592 btmon: @ Device Disconnected: 5C:31:3E:08:XX:XX (1) reason 0
10/05,033059.592 bluez: bluetoothd[21161]:
src/adapter.c:adapter_remove_connection()
10/05,033059.592 bluez: bluetoothd[21161]:
plugins/policy.c:disconnect_cb() reason 0
10/05,033059.592 bluez: bluetoothd[21161]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 5C:31:3E:08:XX:XX
type 1 status 0xe
10/05,033059.592 bluez: bluetoothd[21161]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
10/05,033059.592 bluez: bluetoothd[21161]:
src/device.c:device_bonding_failed() status 14
10/05,033059.593 bluez: bluetoothd[21161]: src/adapter.c:resume_discovery()

10/05,033059.593 bluez: bluetoothd[21161]:
src/device.c:gatt_service_removed() start: 0x0001, end: 0x000b
10/05,033059.594 bluez: bluetoothd[21161]:
src/service.c:change_state() 0x4f63f8: device 5C:31:3E:08:XX:XX
profile gap-profile state changed: disconnected -> unavailable (0)
10/05,033059.594 bluez: bluetoothd[21161]:
profiles/gap/gas.c:gap_driver_remove() GAP profile remove
(5C:31:3E:08:XX:XX)
10/05,033059.595 bluez: bluetoothd[21161]:
src/service.c:btd_service_unref() 0x4f63f8: ref=0
10/05,033059.595 bluez: bluetoothd[21161]:
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
Removed - start: 0x0001, end: 0x000b
10/05,033059.596 bluez: bluetoothd[21161]:
src/device.c:gatt_service_removed() start: 0x000c, end: 0x000f
10/05,033059.596 bluez: bluetoothd[21161]:
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
Removed - start: 0x000c, end: 0x000f
10/05,033059.597 bluez: bluetoothd[21161]:
src/device.c:gatt_service_removed() start: 0x0010, end: 0x0022
10/05,033059.597 bluez: bluetoothd[21161]:
src/service.c:change_state() 0x4f4cc8: device 5C:31:3E:08:XX:XX
profile deviceinfo state changed: disconnected -> unavailable (0)
10/05,033059.598 bluez: bluetoothd[21161]:
src/service.c:btd_service_unref() 0x4f4cc8: ref=0
10/05,033059.598 bluez: bluetoothd[21161]:
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
Removed - start: 0x0010, end: 0x0022
10/05,033059.599 bluez: bluetoothd[21161]:
src/device.c:gatt_service_removed() start: 0x0023, end: 0x0027
10/05,033059.599 bluez: bluetoothd[21161]:
src/service.c:change_state() 0x4eb1e0: device 5C:31:3E:08:XX:XX
profile Battery state changed: disconnected -> unavailable (0)
10/05,033059.600 bluez: bluetoothd[21161]:
profiles/battery/battery.c:batt_remove() BATT path
/org/bluez/hci0/dev_5C_31_3E_08_XX_XX
10/05,033059.600 bluez: bluetoothd[21161]:
src/service.c:btd_service_unref() 0x4eb1e0: ref=0
10/05,033059.600 bluez: bluetoothd[21161]:
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
Removed - start: 0x0023, end: 0x0027

10/05,033059.608 bluez: bluetoothd[21161]:
src/device.c:att_disconnected_cb() Function not implemented (89)
10/05,033059.608 bluez: bluetoothd[21161]: src/device.c:attio_disconnected()
10/05,033059.608 bluez: bluetoothd[21161]:
profiles/input/hog.c:attio_disconnected_cb() HoG disconnected
