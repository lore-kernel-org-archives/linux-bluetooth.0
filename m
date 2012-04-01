Return-Path: <cyrus@holtmann.org>
Message-ID: <4F7869F1.9020109@tu-ilmenau.de>
Date: Sun, 01 Apr 2012 16:45:05 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: pand-error after installing bluez4.99 & patch
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

it's me again and it's pretty annoying that i don't found any forum user 
who can help me, that's why i write to the mailinglist:
Until last week i've had no problems using the pand-command (with 
BlueZ-4.98).
But after installed BlueZ-4.99 and the Patch <<Adding SSP debug mode 
configuration to hciconfig>> (March, 19th) this command doesn't work.
Two PCs with a bluetooth3.0-Dongle:
PC2 # sdptool add NAP
PC1 # sdptool add NAP
PC2 # pand -s -r NAP -M
PC1 # pand -c <bluetooth-address>
-> no error message, but the connection failed, as seen in 
/var/lib/messages (of PC1):

Mar 29 16:12:29 localhost kernel: usb 2-1.1: new full-speed USB device numb
er 4 using ehci_hcd
Mar 29 16:12:29 localhost kernel: usb 2-1.1: New USB device found, idVendor
=0a5c, idProduct=2198
Mar 29 16:12:29 localhost kernel: usb 2-1.1: New USB device strings: 
Mfr=1, Product=2, SerialNumber=3
Mar 29 16:12:29 localhost kernel: usb 2-1.1: Product: Broadcom Bluetooth 
3.0 Device
Mar 29 16:12:29 localhost kernel: usb 2-1.1: Manufacturer: Broadcom Corp
Mar 29 16:12:29 localhost kernel: usb 2-1.1: SerialNumber: 000272240204
Mar 29 16:12:29 localhost bluetoothd[2208]: HCI dev 0 registered
Mar 29 16:12:29 localhost bluetoothd[2208]: Listening for HCI events on hci0
Mar 29 16:12:29 localhost /etc/init.d/bluetooth[3063]: status: inactive
Mar 29 16:12:29 localhost bluetoothd[2208]: HCI dev 0 up
Mar 29 16:12:29 localhost bluetoothd[2208]: Unable to load keys to 
adapter_ops: Function not implemented (38)
Mar 29 16:12:29 localhost bluetoothd[2208]: Adapter /org/bluez/2205/hci0 
has been enabled
Mar 29 16:12:49 localhost pand[3095]: Bluetooth PAN daemon version 4.99
Mar 29 16:12:49 localhost pand[3095]: Connecting to 00:02:72:AE:58:73
Mar 29 16:12:50 localhost pand[3095]: Connect to 00:02:72:AE:58:73 
failed. Connection refused(111)


Hope somebody can tell me what's the problem.

Regards,
Steffen
