Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20041111114420.3497.qmail@webmail2.aruba.it>
References: <20040727145602.30665.qmail@webmail.aruba.it>
            <1090940808.4845.21.camel@pegasus>
In-Reply-To: <1090940808.4845.21.camel@pegasus>
From: "ubaldo" <ubaldo@eja.it>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Subject: [Bluez-devel] Re: Re: siemens s55
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 Nov 2004 12:44:20 +0100

Ciao Brad, 

> we have wacky problems with bluetooth-alsa when you connect to the 
> handsfree rather than the headset profile. does sdptool show you are 
> connecting to the channel for the phone"s headset profile?

this is what I get with "sdptool browse 00:01:E3:6F:7E:55", I try both 
channel 2 and channel 3, 

Browsing 00:01:E3:6F:7E:55 ...
Service Name: SerialPort
Service RecHandle: 0x11101
Service Class ID List:
 "Serial Port" (0x1101)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 1
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "Serial Port" (0x1101)
   Version: 0x0100 

Service Name: Dial-up networking
Service RecHandle: 0x11103
Service Class ID List:
 "Dialup Networking" (0x1103)
 "Generic Networking" (0x1201)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 1
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "Dialup Networking" (0x1103)
   Version: 0x0100 

Service Name: Fax
Service RecHandle: 0x11111
Service Class ID List:
 "Fax" (0x1111)
 "Generic Telephony" (0x1204)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 1
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "Fax" (0x1111)
   Version: 0x0100 

Service Name: OBEX File Transfer
Service RecHandle: 0x11106
Service Class ID List:
 "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 5
 "OBEX" (0x0008)
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "OBEX File Transfer" (0x1106)
   Version: 0x0100 

Service Name: OBEX Object Push
Service RecHandle: 0x11105
Service Class ID List:
 "OBEX Object Push" (0x1105)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 4
 "OBEX" (0x0008)
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "OBEX Object Push" (0x1105)
   Version: 0x0100 

Service Name: OBEX Synchronisation
Service RecHandle: 0x11104
Service Class ID List:
 "IrMCSync" (0x1104)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 5
 "OBEX" (0x0008)
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "IrMCSync" (0x1104)
   Version: 0x0100 

Service Name: Voice gateway
Service RecHandle: 0x11112
Service Class ID List:
 "Headset Audio Gateway" (0x1112)
 "Generic Audio" (0x1203)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 2
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "Headset" (0x1108)
   Version: 0x0100 

Service Name: Voice gateway
Service RecHandle: 0x1111f
Service Class ID List:
 "" (0x111f)
 "Generic Audio" (0x1203)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 3
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "" (0x111e)
   Version: 0x0100 

and this is what I get with "hcitool con" while the connection is on (with 
"hstest record ...") 

Connections:
       < SCO 00:01:E3:6F:7E:55 handle 44 state 1 lm SLAVE
       < ACL 00:01:E3:6F:7E:55 handle 41 state 1 lm MASTER ENCRYPT 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
