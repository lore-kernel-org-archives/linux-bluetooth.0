Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Nov 2010 00:30:42 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluez-4.78 broken for me
Message-ID: <20101108003042.35493250@susi.home.s3e.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

since I did upgrade to bluez-4.78, all I get when enabling the bluetooth
adapter on my Thinkpad X200s is:

kernel: [248420.020080] usb 4-2: new full speed USB device using uhci_hcd and address 7
kernel: [248420.179082] usb 4-2: New USB device found, idVendor=0a5c, idProduct=2145
kernel: [248420.179087] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
kernel: [248420.179090] usb 4-2: Product: ThinkPad Bluetooth with Enhanced Data Rate II
kernel: [248420.179094] usb 4-2: Manufacturer: Lenovo Computer Corp
bluetoothd[4390]: Bluetooth deamon 4.78
bluetoothd[4393]: Starting SDP server
bluetoothd[4393]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[4393]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[4393]: HCI dev 0 registered
bluetoothd[4393]: HCI dev 0 up
bluetoothd[4393]: Starting security manager 0
bluetoothd[4393]: Parsing /etc/bluetooth/serial.conf failed: No such file or directory
bluetoothd[4393]: Adapter /org/bluez/4390/hci0 has been enabled
bluetoothd[4393]: Unable to find matching adapter
bluetoothd[4393]: No matching adapter found
bluetoothd[4393]: Unable to find matching adapter
bluetoothd[4393]: No matching adapter found
bluetoothd[4393]: Unable to find matching adapter
bluetoothd[4393]: No matching adapter found
bluetoothd[4393]: Unable to find matching adapter

And it does not work at all. Downgrading to 4.77 brings:
kernel: [248504.361041] usb 4-2: new full speed USB device using uhci_hcd and address 8
kernel: [248504.517100] usb 4-2: New USB device found, idVendor=0a5c, idProduct=2145
kernel: [248504.517104] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
kernel: [248504.517107] usb 4-2: Product: ThinkPad Bluetooth with Enhanced Data Rate II
kernel: [248504.517109] usb 4-2: Manufacturer: Lenovo Computer Corp
bluetoothd[4570]: Bluetooth deamon 4.77
bluetoothd[4573]: Starting SDP server
bluetoothd[4573]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[4573]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[4573]: HCI dev 0 registered
bluetoothd[4573]: HCI dev 0 up
bluetoothd[4573]: Starting security manager 0
bluetoothd[4573]: Parsing /etc/bluetooth/serial.conf failed: No such file or directory
bluetoothd[4573]: probe failed with driver input-headset for device /org/bluez/4570/hci0/dev_00_24_EF_D1_B3_23
bluetoothd[4573]: probe failed with driver input-headset for device /org/bluez/4570/hci0/dev_C0_E4_22_68_82_5E
bluetoothd[4573]: probe failed with driver input-headset for device /org/bluez/4570/hci0/dev_00_12_EE_23_CE_EA
bluetoothd[4573]: Adapter /org/bluez/4570/hci0 has been enabled

and then the usual messages from NetworkManager:
kernel: [248504.741917] NetworkManager[1228]: <warn> (00:24:EF:D1:B3:23): failed to look up interface index
kernel: [248504.741929] NetworkManager[1228]: <info> BT device seife C510 (00:24:EF:D1:B3:23) added (DUN NAP)
kernel: [248504.741939] NetworkManager[1228]: <info> (00:24:EF:D1:B3:23): new Bluetooth device (driver: 'bluez' ifindex: -1)
kernel: [248504.741948] NetworkManager[1228]: <info> (00:24:EF:D1:B3:23): exported as /org/freedesktop/NetworkManager/Devices/9
....

and moving the mouse gives:
kernel: [248514.682684] input: Bluetooth Travel Mouse as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/bluetooth/hci0/hci0:11/input24
kernel: [248514.682950] generic-bluetooth 0005:046D:B002.000B: input,hidraw0: BLUETOOTH HID v48.09 Mouse [Bluetooth Travel Mouse] on 0C:60:76:88:2C:4C

This all is missing with 4.78
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
