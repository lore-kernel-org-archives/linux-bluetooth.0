Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] TECOM BT3035
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?=F2=CF=CD=C1=CE?= <papa@rbcmail.ru>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407231216.i6NCGiSw095359@www1.pochta.ru>
References: <200407231216.i6NCGiSw095359@www1.pochta.ru>
Content-Type: text/plain
Message-Id: <1090586446.4791.48.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 23 Jul 2004 14:40:46 +0200

Hi,

> Is anybody solved it under kernel 2.4?
> 
> I Have Tecom BT3035.
> It works easy and find under SuSE 9.1 with kernel 2.6..
> But I need to use it under kernel 2.4
> 
> thats what I see from dmesg
> 
> hub.c: new USB device 00:1f.2-2, assigned address 3
> hub.c: USB hub found
> hub.c: 3 ports detected
> hub.c: new USB device 00:1f.2-2.1, assigned address 4
> usb.c: USB device 4 (vend/prod 0xa5c/0x200a) is not
> claimed by any active driver.
> hub.c: new USB device 00:1f.2-2.2, assigned address 5
> usb.c: USB device 5 (vend/prod 0xa5c/0x3502) is not
> claimed by any active driver.
> hub.c: new USB device 00:1f.2-2.3, assigned address 6
> usb.c: USB device 6 (vend/prod 0xa5c/0x3503) is not
> claimed by any active driver.
> 
> when I type lsusb i see
> Bus 001 Device 003: ID 0a5c:3535 Broadcom Corp.
> Bus 001 Device 004: ID 0a5c:200a Broadcom Corp.
> Bus 001 Device 005: ID 0a5c:3502 Broadcom Corp.
> Bus 001 Device 006: ID 0a5c:3503 Broadcom Corp.
> 
> 
> hciconfig displays 
> 
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO
> MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy:
>         Link mode: SLAVE ACCEPT
> 
> 
> Is there something that I can do to make it work?

the fix for these dongles went into 2.4 on March 15th.

ChangeSet@1.1302.47.6, 2004-03-15 21:31:08+01:00, marcel@holtmann.org
  [Bluetooth] Send HCI_Reset for some Broadcom dongles
  
  This patch introduces a quirk flag for sending the HCI_Reset command. In
  general the HCI_Reset is not needed, but some Broadcom dongles uses this
  reset command to switch from HID to HCI mode. And it is not safe to send
  the HCI_Reset to every Bluetooth device, because the CSR firmware prior
  HCI 12.x will reset the host transport and this is wrong according to the
  Bluetooth specification.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
