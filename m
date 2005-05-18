Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems syncing with bluetooth on multisync:
	evolution/blueotooth plugin
From: Tamer Higazi <tamer23@myrealbox.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1116366743.10063.122.camel@pegasus>
References: <1116313073.10074.8.camel@linux.site>
	 <4289A32A.1040907@citromail.hu>  <1116327973.21185.1.camel@linux.site>
	 <1116329361.10063.44.camel@pegasus>  <1116333932.32701.4.camel@linux.site>
	 <1116334551.10063.83.camel@pegasus>  <1116359055.8933.6.camel@linux.site>
	 <1116366743.10063.122.camel@pegasus>
Content-Type: text/plain
Message-Id: <1116403397.13203.4.camel@linux.site>
Mime-Version: 1.0
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
Date: Wed, 18 May 2005 10:03:17 +0200

Dear Marc, 
With sdptool i quired all services on my phone....

There are only 4 channels: 

1: Hands-Free Audio Gateway
10: OBEX File Transfer
11: SyncMLClient
12: Nokia OBEX PC Suite Services

channel "12" is not responding at all...
while the other do.  I thought 10 "SyncML Client" would do it, this is
why channel 11. 

For any help further, thank you 

Tamer

here is the output: 

joker@linux:/> sdptool browse
Inquiring ...
Browsing 00:E0:03:65:64:94 ...
Service Name: Hands-Free Audio Gateway
Service RecHandle: 0x10000
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handfree Audio Gateway" (0x111f)
    Version: 0x0101

Service Name: OBEX File Transfer
Service RecHandle: 0x10001
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 10
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: SyncMLClient
Service RecHandle: 0x10002
Service Class ID List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 11
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
    Version: 0x0100

Service Name: Nokia OBEX PC Suite Services
Service RecHandle: 0x10003
Service Class ID List:
  "Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10004
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: Dial-Up Networking
Service RecHandle: 0x10005
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
