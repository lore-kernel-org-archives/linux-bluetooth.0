Return-Path: <cyrus@holtmann.org>
From: "Daniel O'Connor" <doconnor@gsoft.com.au>
Content-Type: text/plain; charset=windows-1252
Subject: Problem with an Apple bluetooth keyboard
Date: Tue, 22 Feb 2011 00:28:17 +1030
Message-Id: <AA50FBAC-6B8B-4D61-83A0-0B8D4B24B967@gsoft.com.au>
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1082)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I have an Apple BT keyboard talking to Ubuntu 10.04 and it only works if I unplug and replug the dongle.

dmesg shows the following :-

[22723.580234] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[22723.697163] apple 0005:05AC:0239.0002: parse failed
[22723.697172] apple: probe of 0005:05AC:0239.0002 failed with error -14

<unplug/replug USB BT dongle.

[22727.040345] usb 3-1: USB disconnect, address 2
[22727.041256] btusb_intr_complete: hci0 urb ffff880037286840 failed to resubmit (19)
[22727.041272] btusb_bulk_complete: hci0 urb ffff8800372860c0 failed to resubmit (19)
[22727.042257] btusb_bulk_complete: hci0 urb ffff880037286900 failed to resubmit (19)
[22727.042574] btusb_send_frame: hci0 urb ffff88002bf97a80 submission failed
[22728.784680] usb 3-1: new full speed USB device using uhci_hcd and address 3
[22729.170802] usb 3-1: configuration #1 chosen from 1 choice
[22733.044904] input: darius’s keyboard as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1:1.0/bluetooth/hci0/hci0:40/input8
[22733.045006] apple 0005:05AC:0239.0003: input,hidraw1: BLUETOOTH HID v0.50 Keyboard [darius’s keyboard] on 00:10:DC:57:76:BE

Is there some command I can run to re-probe it as a work around? Or perhaps some debugging I can enable to find out exactly what is going wrong.

Thanks.

--
Daniel O'Connor software and network engineer
for Genesis Software - http://www.gsoft.com.au
"The nice thing about standards is that there
are so many of them to choose from."
 -- Andrew Tanenbaum
GPG Fingerprint - 5596 B766 97C0 0E94 4347 295E E593 DC20 7B3F CE8C

