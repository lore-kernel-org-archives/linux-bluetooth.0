Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200407231216.i6NCGiSw095359@www1.pochta.ru>
From: Роман <papa@rbcmail.ru>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Subject: [Bluez-users] TECOM BT3035
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
Date: Fri, 23 Jul 2004 16:16:44 +0400 (MSD)

Is anybody solved it under kernel 2.4?

I Have Tecom BT3035.
It works easy and find under SuSE 9.1 with kernel 2.6..
But I need to use it under kernel 2.4

thats what I see from dmesg

hub.c: new USB device 00:1f.2-2, assigned address 3
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 00:1f.2-2.1, assigned address 4
usb.c: USB device 4 (vend/prod 0xa5c/0x200a) is not
claimed by any active driver.
hub.c: new USB device 00:1f.2-2.2, assigned address 5
usb.c: USB device 5 (vend/prod 0xa5c/0x3502) is not
claimed by any active driver.
hub.c: new USB device 00:1f.2-2.3, assigned address 6
usb.c: USB device 6 (vend/prod 0xa5c/0x3503) is not
claimed by any active driver.

when I type lsusb i see
Bus 001 Device 003: ID 0a5c:3535 Broadcom Corp.
Bus 001 Device 004: ID 0a5c:200a Broadcom Corp.
Bus 001 Device 005: ID 0a5c:3502 Broadcom Corp.
Bus 001 Device 006: ID 0a5c:3503 Broadcom Corp.


hciconfig displays 

hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO
MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
        Features: 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy:
        Link mode: SLAVE ACCEPT


Is there something that I can do to make it work?

Thanks


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
