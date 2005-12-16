Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: A blue chamaleon to be
References: <1134636788.5198.42.camel@localhost> <op.s1tiptlkxabado@portatilegio> <1134638529.11856.1.camel@localhost> <op.s1tj7dd6xabado@portatilegio> <1134642179.11856.30.camel@localhost> <op.s1t0xmg8xabado@portatilegio> <op.s1t2ws0rxabado@portatilegio> <op.s1t63hh3xabado@portatilegio> <20051215211716.GB12373@elmicha.333200002251-0001.dialin.t-online.de> <op.s1uu2mo1xabado@portatilegio> <20051216031937.GE12373@elmicha.333200002251-0001.dialin.t-online.de>
Message-ID: <op.s1vdldx5xabado@portatilegio>
From: "zio tom" <zio.tom@gmail.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
In-Reply-To: <20051216031937.GE12373@elmicha.333200002251-0001.dialin.t-online.de>
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
Date: Fri, 16 Dec 2005 10:21:03 +0100

In data Fri, 16 Dec 2005 04:19:37 +0100, Michael Mauch  
<michael.mauch@gmx.de> ha scritto:

> What's the output of "rfcomm" now?

linux:/home/giovanni # rfcomm
rfcomm0: 00:0A:28:0C:D4:EF channel 1 clean

> That's all ok if "rfcomm" shows:

>  rfcomm0: 00:0A:28:0C:D4:EF channel 1 clean

> before you use wvdial.

So, I use it and I obtain:

linux:/home/giovanni # wvdial
--> WvDial: Internet dialer version 1.54.0
--> Cannot open /dev/rfcomm0: Connection refused
--> Cannot open /dev/rfcomm0: Connection refused
--> Cannot open /dev/rfcomm0: Permission denied
linux:/home/giovanni #

> Are you sure that the channel number 1 is correct? It's different on
> each device. Did you lookup this channel on your device with "sdptool
> browse 00:0A:28:0C:D4:EF" or (if that doesn't work) with "sdptool
> records 00:0A:28:0C:D4:EF"?
> Look for the "Service Name" and the "Channel" lines. I don't know for  
> which
> service name you should look, on my phone it's called "SSA" (I don't
> know if these names come from the phone or from bluez). If you can't
> figure out the suitable channel, post the output of "sdptool records
> 00:0A:28:0C:D4:EF".

linux:/home/giovanni # sdptool browse 00:0A:28:0C:D4:EF
Browsing 00:0A:28:0C:D4:EF ...
Service RecHandle: 0x0
Service Class ID List:
   "SDP Server" (0x1000)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "SDP" (0x0001)
Profile Descriptor List:
   "SDP Server" (0x1000)
     Version: 0x0100

Service Name: Dial-up networking Gateway
Service Description: Dial-up networking Gateway
Service Provider: Motorola
Service RecHandle: 0x10001
Service Class ID List:
   "Dialup Networking" (0x1103)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
   code_ISO639: 0x6672
   encoding:    0x6a
   base_offset: 0xd800
   code_ISO639: 0x6465
   encoding:    0x6a
   base_offset: 0xd803
   code_ISO639: 0x6974
   encoding:    0x6a
   base_offset: 0xd806
   code_ISO639: 0x6573
   encoding:    0x6a
   base_offset: 0xd809
   code_ISO639: 0x7472
   encoding:    0x6a
   base_offset: 0xd80c
   code_ISO639: 0x656c
   encoding:    0x6a
   base_offset: 0xd80f
Profile Descriptor List:
   "Dialup Networking" (0x1103)
     Version: 0x0100


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
