Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Paul Hedderly <bulkpaul@mjr.org>
To: Daniel Scott <danieljamesscott@gmail.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MS Optical Desktop for bluetooth - Stops working after a time
Message-ID: <20040920104135.GU26469@wacka.mjr.org>
References: <6835906b04091701465c5e3c7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6835906b04091701465c5e3c7c@mail.gmail.com>
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
Date: Mon, 20 Sep 2004 11:41:35 +0100

I have an Ericsson K700i. In the bluetooth menu there is an option
"remote control" and when you sdptool brose the phone you get:

Service Name: Mouse & Keyboard
Service Description: K700
Service Provider: Sony Ericsson
Service RecHandle: 0x1001c
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100

So I tried "hidd -c 00:..." with hidd --server runnning of course.

Now the phone wakes up and says "Start remote control? Yes/No" And I say
yes... it goes into remote control mode for a moment then quits saying
"No more files".

Anybody got their k700 to work as a mouse/keybd? What file is it
expecting?

Blues-utils/libs 2.9 (Debian/Sid) under 2.4.27-mh1.

I've dumped the exchange:


HCIDump - HCI packet analyzer ver 1.10
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  D6 72 E5 07 0E 00 18 CC 02 00 00 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 04 05 04 
> HCI Event: Link Key Request (0x17) plen 6
  D6 72 E5 07 0E 00 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  D6 72 E5 07 0E 00 17 E3 7A 74 3E 30 9F 9A 40 3A AE 33 B6 09 
  54 F4 
> HCI Event: Command Complete (0x0e) plen 10
  04 0B 04 00 D6 72 E5 07 0E 00 
> HCI Event: Connect Complete (0x03) plen 11
  00 01 00 D6 72 E5 07 0E 00 01 01 
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  01 00 0F 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> HCI Event: Command Complete (0x0e) plen 6
  04 0D 08 00 01 00 
> HCI Event: Max Slots Change (0x1b) plen 3
  01 00 05 
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005f scid 0x0040 result 0 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x005f flags 0x0000 clen 4
    MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> ACL data: handle 0x0001 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 48 
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 674 
< ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x005f flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0060 scid 0x0041 result 0 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0060 flags 0x0000 clen 4
    MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> ACL data: handle 0x0001 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
    MTU 48 
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 674 
< ACL data: handle 0x0001 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0060 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> ACL data: handle 0x0001 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0000 result 4 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 10
    L2CAP(s): Command rej: reason 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 

WAITING FOR "YES/NO" KEYPRESS...

> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0060
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0060
> ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x005f
< ACL data: handle 0x0001 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x005f
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 01 00 01 00 
> HCI Event: Disconn Complete (0x05) plen 4
  00 01 00 13 


--
Paul


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
