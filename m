Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050614100531.18199.qmail@web50705.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] Problem with dund and LG 325 phone-fixed
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1117177674.12036.93.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Tue, 14 Jun 2005 03:05:31 -0700 (PDT)

Ok, through using konqurer and kdebluetooth and
telling it to do action/send file over bluetooth, it
paired my phone and adapter:)

however, I now get the connection refused error.  I am
wanting to use btcid(bluetooth caller ID), but it
gives the same error eric got, so I tried changing the
channel to channel 5 in /etc/bluetooth/rfcomm.conf,
still the same.  what should I do? this is the output
of sdptool --browse

 sdptool browse
Inquiring ...
Browsing 08:00:37:12:C4:B1 ...
Service Name: WBTEXT
Service RecHandle: 0x10000
Service Class ID List:
  "Error: This is UUID-128"
(0xdb1d8f12-95f3-402c-9b97-bc504c9a55c4)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128"
(0x1cdb1d8f-1295-f340-2c9b-97bc504c9a55)
    Version: 0x0100

Service Name: LG LX325 Headset AG Service
Service RecHandle: 0x10001
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: LG LX325 Hands-Free AG Service
Service RecHandle: 0x10002
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0100



		
__________________________________ 
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
