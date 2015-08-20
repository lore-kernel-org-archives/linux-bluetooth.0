Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Aug 2015 22:20:49 -0700
From: "Mark A. Haun" <haunma@keteu.org>
To: linux-bluetooth@vger.kernel.org
Subject: Intel 7260 spontaneous USB disconnect/reconnect every 23h18m07s
Message-ID: <20150819222049.15ca98f0@angwin.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a late-model Intel 7260 wifi/bluetooth mini-PCIE card plugged into
my Nvidia Jetson board.  Bluetooth is basically working, but I've noticed
the following odd pattern in my logs:

(previous 12 days omitted for brevity; pattern is same as below)

[...]

Aug 16 03:33:00 kolonia kernel: [921790.543197] usb 1-1: USB disconnect, device number 12
Aug 16 03:33:00 kolonia kernel: [921790.761151] usb 1-1: new full-speed USB device number 13 using tegra-ehci
Aug 16 03:33:00 kolonia kernel: [921790.889599] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
Aug 16 03:33:00 kolonia kernel: [921790.896428] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Aug 16 03:33:00 kolonia kernel: [921790.922681] Bluetooth: hci0: read Intel version: 3707100180012d0d06
Aug 16 03:33:00 kolonia kernel: [921790.929091] Bluetooth: hci0: Intel device is already patched. patch num: 06
Aug 16 03:33:00 kolonia bluetoothd[1888]: Sap driver initialization failed.
Aug 16 03:33:00 kolonia bluetoothd[1888]: sap-server: Operation not permitted (1)
Aug 16 03:33:00 kolonia bluetoothd[1888]: Failed to set mode: Busy (0x0a)

[...]

Aug 18 02:09:13 kolonia kernel: [1089565.056222] usb 1-1: USB disconnect, device number 13
Aug 18 02:09:13 kolonia kernel: [1089565.271214] usb 1-1: new full-speed USB device number 14 using tegra-ehci
Aug 18 02:09:13 kolonia kernel: [1089565.400011] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
Aug 18 02:09:13 kolonia kernel: [1089565.406942] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Aug 18 02:09:13 kolonia kernel: [1089565.431982] Bluetooth: hci0: read Intel version: 3707100180012d0d06
Aug 18 02:09:13 kolonia kernel: [1089565.438483] Bluetooth: hci0: Intel device is already patched. patch num: 06
Aug 18 02:09:13 kolonia bluetoothd[1888]: Sap driver initialization failed.
Aug 18 02:09:13 kolonia bluetoothd[1888]: sap-server: Operation not permitted (1)
Aug 18 02:09:13 kolonia bluetoothd[1888]: Failed to set mode: Busy (0x0a)

[...]

Aug 19 01:27:20 kolonia kernel: [1173452.517103] usb 1-1: USB disconnect, device number 14
Aug 19 01:27:20 kolonia kernel: [1173452.734122] usb 1-1: new full-speed USB device number 15 using tegra-ehci
Aug 19 01:27:20 kolonia kernel: [1173452.865078] usb 1-1: New USB device found, idVendor=8087, idProduct=07dc
Aug 19 01:27:20 kolonia kernel: [1173452.872018] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Aug 19 01:27:20 kolonia kernel: [1173452.899169] Bluetooth: hci0: read Intel version: 3707100180012d0d06
Aug 19 01:27:20 kolonia kernel: [1173452.905689] Bluetooth: hci0: Intel device is already patched. patch num: 06
Aug 19 01:27:20 kolonia bluetoothd[1888]: Sap driver initialization failed.
Aug 19 01:27:20 kolonia bluetoothd[1888]: sap-server: Operation not permitted (1)
Aug 19 01:27:20 kolonia bluetoothd[1888]: Failed to set mode: Busy (0x0a)

The interval is very consistent at 23 hours, 18 minutes, and 7 seconds, plus
or minus a second.  This happens almost every day, but you can see it skipped
August 17th for some reason.  In that case the interval was exactly 2x, i.e.
the pattern continues.

Any idea why this would be happening?  It doesn't seem to have any adverse
effects, but I like a good mystery.
