Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "João Santos" <jsantos_pt@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F42TuLCBnwNLh1000006b9@hotmail.com>
Subject: [Bluez-users] audio links problem
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
Date: Mon, 15 Mar 2004 16:45:31 +0000

Hi all,
I'm working with sco links and i had found a strange problem, and i don't 
have any idea who it appears and who to fix it.
i'm using a Nokia 6310i phone, a casira module and the bluez stack.
linux-kernel 2.4.25-mh1
In the hcidump appears:

>##SCO data: handle 0x002b dlen 144
>##SCO data: handle 0x002b dlen 144
>##SCO data: handle 0x002b dlen 144
>HCI Event: Disconn Complete(0x05) plen 4
>##SCO data: handle 0x002b dlen 144
>##SCO data: handle 0x002b dlen 144
>##SCO data: handle 0x002b dlen 144
< HCI Command: Reset(0x03|0x0003) plen 0
>>>Receive failed: Broken pipe

i think that the disconn appends because the phone enter in park mode, but 
the reset command i don't have any idea why this appends.


[root@olivia jsantos]# hciconfig -a
hci0: Type: USB
BD Address: 00:02:5B:FF:05:AC ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN AUTH ENCRYPT
RX bytes:2481 acl:0 sco:0 events:56 errors:0
TX bytes:522 acl:0 sco:0 commands:33 errors:0
Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DH1 HV1
Link policy: HOLD SNIFF PARK
Link mode: MASTER
Name: 'Olivia'
Class: 0x200404
Service Classes: Audio
Device Class: Audio/Video, Device conforms to the Headset profile
HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
Manufacturer: Cambridge Silicon Radio (10)

[root@olivia jsantos]# hciconfig hci0 revision
hci0: Type: USB
BD Address: 00:02:5B:FF:05:AC ACL MTU: 192:8 SCO MTU: 64:8
HCI 12.7
Chip version: BlueCore01b (ES)
SCO mapping: HCI



This is strange to append, i thing that the last command that should appears 
in the hcidump was:

>HCI Event: Disconn Complete(0x05) plen 4

But he continue receiving sco data and then he make a reset, that causes a 
broken pipe.


Thanks

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
