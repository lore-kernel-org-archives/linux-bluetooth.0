Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BAB94E.9060905@szift.org>
Date: Mon, 17 Jul 2006 00:10:22 +0200
From: =?ISO-8859-2?Q?=A3ukasz_Hejnak?= <blue@szift.org>
MIME-Version: 1.0
To: Bluetooth <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] BD hardware address problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi
I've been trying to make a bluetooth link between two computers, a 
windows run laptop and my linux box - using two bluetooth usb dongles

The devices see each other (hcitool inq) but I can't get them connected 
using pand:
Jul 16 18:55:20 szift pand[5200]: Connecting to 11:11:11:11:11:11
Jul 16 18:55:20 szift pand[5200]: Connect to 11:11:11:11:11:11 failed. 
No route to host(113)

I think the problem is quite obvious: they both have been assigned the 
same bd address: 11:11:11:11:11:11
whatever I try, both devices still have the same bd addresses leading 
even to a situation like this (when connected to the same PC):

root@szift:/home/szift#hciconfig -a
hci0:   Type: USB
         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
         RX bytes:2511835 acl:13393 sco:0 events:8268 errors:0
         TX bytes:693525 acl:8233 sco:0 commands:25 errors:0
         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
         Packet type: DM1 DH1 HV1
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP 
Subver: 0x1fe
         Manufacturer: Integrated System Solution Corp. (57)

hci1:   Type: USB
         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
         RX bytes:118 acl:0 sco:0 events:15 errors:0
         TX bytes:312 acl:0 sco:0 commands:15 errors:0
         Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
         Packet type: DM1 DH1 HV1
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP 
Subver: 0x1fe
         Manufacturer: Integrated System Solution Corp. (57)


So I guess no wonder why pand didn't know which device I've been talking 
about when I typed 11:11:11...

Apart from this, both devices work fine.
I tested them with my nokia 6310i to get a gprs connection and it works.

So my question is:
is there anything I can do to change those bd addresses?
or is there any other way to get the connection up and going?

*My target is to share an EDGE link from the windows machine via these 
bluetooth adapters to my linux box*

I use bluez libs/utils 2.25 with a 2.6.16 kernel
The windows is a XP home with the drivers that were shipped together 
with the dongles (that side also works fine with the phone).

--
Best wishes
Lukasz 'Szift' Hejnak


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
