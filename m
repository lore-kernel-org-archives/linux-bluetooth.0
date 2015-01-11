Return-Path: <cyrus@holtmann.org>
Date: Sun, 11 Jan 2015 19:45:13 +0100
From: Reinhard Speyerer <rspmn@arcor.de>
To: marcel@holtmann.org
Cc: Reinhard Speyerer <rspmn@arcor.de>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] make Belkin F8T013 devices work again by adding
 BTUSB_BROKEN_STORED_LINK_KEY flag
Message-ID: <54b2c4ba.ejKVqomjev/ni7OD+L8fy9Fa@arcor.de>
References: <54b19c34.HFakUiNRADxA91CC0vhvfVD1@arcor.de>
 <558296E1-B802-4B20-BE09-9C154C16F90F@holtmann.org>
In-Reply-To: <558296E1-B802-4B20-BE09-9C154C16F90F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann <marcel@holtmann.org> wrote:

>
> can you run "hciconfig hci0 commands" and see if the Delete Stored Link Key command is actually listed. If this is a real Broadcom dongle (and not a fake one), then it used to have this listed correctly.
>
> What concerns me a bit is that it uses error 0x11 and not just responds with Invalid HCI command.
>

Hi Marcel,

according to the "hciconfig hci0 commands" output attached below it seems to
be a real Broadcom dongle as the Delete Stored Link Key command is listed.

>
> However I am not a big fan of manually marking each core quirk as .driver_info. That would easily get out of hand at some point.
>

Since so far only one type of Broadcom-based dongles seems to be affected by
this an alternative (at the price of having the USB VID/PID repeated) would
be to enable the quirk directly in btusb_probe().

--- drivers/bluetooth/btusb.c-std	2014-08-04 00:25:02.000000000 +0200
+++ drivers/bluetooth/btusb.c	2015-01-11 18:41:21.502229549 +0100
@@ -1683,6 +1683,11 @@ static int btusb_probe(struct usb_interf
 		data->isoc = NULL;
 	}
 
+	/* Belkin F8T013 responds to Delete Stored Link Key with Status 0x11 */ 
+	if (data->udev->descriptor.idVendor == cpu_to_le16(0x050d) &&
+	    data->udev->descriptor.idProduct == cpu_to_le16(0x0013))
+		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
 							data->isoc, data);

> Maybe it would be better to see if Belkin Windows driver comes with a firmware in either .hex or .hcd format and we can just patch this broken device (if it is actually broken).
>

Unfortunately the CD that came with it does not contain a firmware in the
above formats.

Regards,
Reinhard

# hciconfig hci0 commands
hci0:	Type: BR/EDR  Bus: USB
	BD Address: <BDADDR>  ACL MTU: 1017:8  SCO MTU: 64:8
	Commands: Octet 0  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 1  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 2  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 3  = 0x03 (Bit 0 1)
		  Octet 4  = 0xfe (Bit 1 2 3 4 5 6 7)
		  Octet 5  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 6  = 0xcf (Bit 0 1 2 3 6 7)
		  Octet 7  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 8  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 9  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 10 = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 11 = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 12 = 0x03 (Bit 0 1)
		  Octet 14 = 0xf8 (Bit 3 4 5 6 7)
		  Octet 15 = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 16 = 0x07 (Bit 0 1 2)
	'Inquiry' 'Inquiry Cancel' 'Periodic Inquiry Mode' 
	'Exit Periodic Inquiry Mode' 'Create Connection' 'Disconnect' 
	'Add SCO Connection' 'Cancel Create Connection' 
	'Accept Connection Request' 'Reject Connection Request' 
	'Link Key Request Reply' 'Link Key Request Negative Reply' 
	'PIN Code Request Reply' 'PIN Code Request Negative Reply' 
	'Change Connection Packet Type' 'Authentication Requested' 
	'Set Connection Encryption' 'Change Connection Link Key' 
	'Master Link Key' 'Remote Name Request' 'Cancel Remote Name Request' 
	'Read Remote Supported Features' 'Read Remote Extended Features' 
	'Read Remote Version Information' 'Read Clock Offset' 
	'Read LMP Handle' 'Hold Mode' 'Sniff Mode' 'Exit Sniff Mode' 
	'Park State' 'Exit Park State' 'QoS Setup' 'Role Discovery' 
	'Switch Role' 'Read Link Policy Settings' 'Write Link Policy Settings' 
	'Read Default Link Policy Settings' 
	'Write Default Link Policy Settings' 'Flow Specification' 
	'Set Event Mask' 'Reset' 'Set Event Filter' 'Flush' 'Read PIN Type' 
	'Write PIN Type' 'Write Stored Link Key' 'Delete Stored Link Key' 
	'Write Local Name' 'Read Local Name' 'Read Connection Accept Timeout' 
	'Write Connection Accept Timeout' 'Read Page Timeout' 
	'Write Page Timeout' 'Read Scan Enable' 'Write Scan Enable' 
	'Read Page Scan Activity' 'Write Page Scan Activity' 
	'Read Inquiry Scan Activity' 'Write Inquiry Scan Activity' 
	'Read Authentication Enable' 'Write Authentication Enable' 
	'Read Encryption Mode' 'Write Encryption Mode' 'Read Class Of Device' 
	'Write Class Of Device' 'Read Voice Setting' 'Write Voice Setting' 
	'Read Automatic Flush Timeout' 'Write Automatic Flush Timeout' 
	'Read Num Broadcast Retransmissions' 
	'Write Num Broadcast Retransmissions' 'Read Hold Mode Activity' 
	'Write Hold Mode Activity' 'Read Transmit Power Level' 
	'Read Synchronous Flow Control Enable' 
	'Write Synchronous Flow Control Enable' 
	'Set Host Controller To Host Flow Control' 'Host Buffer Size' 
	'Host Number Of Completed Packets' 'Read Link Supervision Timeout' 
	'Write Link Supervision Timeout' 'Read Number of Supported IAC' 
	'Read Current IAC LAP' 'Write Current IAC LAP' 
	'Read Page Scan Period Mode' 'Write Page Scan Period Mode' 
	'Read Page Scan Mode' 'Write Page Scan Mode' 
	'Set AFH Channel Classification' 'Read Local Version Information' 
	'Read Local Supported Commands' 'Read Local Supported Features' 
	'Read Local Extended Features' 'Read Buffer Size' 'Read Country Code' 
	'Read BD ADDR' 'Read Failed Contact Counter' 
	'Reset Failed Contact Counter' 'Get Link Quality' 'Read RSSI' 
	'Read AFH Channel Map' 'Read BD Clock' 'Read Loopback Mode' 
	'Write Loopback Mode' 'Enable Device Under Test Mode' 
