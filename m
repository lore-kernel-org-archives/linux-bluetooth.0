Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: chris vigelius <chris.vigelius@gmx.net>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603291912.14217.chris.vigelius@gmx.net>
Subject: [Bluez-users] hci_scodata_packet messages flooding syslog
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 29 Mar 2006 19:12:14 +0200

Hi,

I am having problems with a BT USB dongle manufactured by Vivanco (Model 
18031, FCC-ID NV6-CS8024, if that matters). 

Everytime I connect the stick, the syslog is flooded with messages

> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0

There are about 500 messages generated EACH SECOND, causing a high load (and 
lots of wasted disk space) on my system. Is there anything I can do to get 
rid of them? 

I believe the problem discussed in the thread below is about the same issue, 
but unfortunately there was no solution posted: 

http://sourceforge.net/mailarchive/message.php?msg_id=13791329

Output of hciconfig -a: 

> hci0:   Type: USB
>         BD Address: 00:0C:78:30:EE:F2 ACL MTU: 339:4 SCO MTU: 60:9
>         UP RUNNING
>         RX bytes:249022 acl:0 sco:73200 events:16 errors:0
>         TX bytes:310 acl:0 sco:0 commands:14 errors:0
>         Features: 0xff 0xff 0x81 0x00 0x18 0x18 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'null-0'
>         Class: 0xb3010c
>         Service Classes: Positioning, Networking
>         Device Class: Computer, Laptop
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x222 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x222 Manufacturer: RTX Telecom A/S (21)

Any help would be appreciated. 

regards,
 chris


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
