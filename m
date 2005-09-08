Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: david <gangchen@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1126165252.2643.1.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] file transfer problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 08 Sep 2005 15:40:52 +0800

hi,

I meet a problem while doing file transfer using bluez-2.9.
Some phone cannot find my services I register. I browse my sevice and
get the following message:

/************browse my phone*******************/
Browsing 00:0D:18:01:1C:2E ...
Service Name: SDP Server
Service Description: Bluetooth service discovery server
Service Provider: BlueZ
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
    Version: 0x0001
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Service Name: Public Browse Group Root
Service Description: Root of public browse hierarchy
Service Provider: BlueZ
Service RecHandle: 0x804d008
Service Class ID List:
  "Browse Group Descriptor" (0x1001)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Service Name: OBEX Object Push
Service RecHandle: 0x804d9f0
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: Serial Port
Service RecHandle: 0x804fa00
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Serial Port" (0x1101)
    Version: 0x0100

/*****************************/



So I compare my phone's service with others'. I find the only difference
between them is that my Service RecHandle is different from others. My
Service Rechandle is very big such as ox804fa00. Others are 0x10000,
0x10001...,and so on. Is there anything to do with Service RecHandle why
other bluetooth devices cannot find my bluetooth services?
I am expecting for you reply. Thanks very much.

/*****other bluetooth device's service***/


sdptool browse 00:E0:03:35:9C:C3
Browsing 00:E0:03:35:9C:C3 ...
Service Name: OBEX Object Push
Service RecHandle: 0x10000
Service Class ID List:
 "OBEX Object Push" (0x1105)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 9
 "OBEX" (0x0008)
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "OBEX Object Push" (0x1105)
   Version: 0x0100

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
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "OBEX File Transfer" (0x1106)
   Version: 0x0100

Service Name: Dial-up networking
Service RecHandle: 0x10002
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

Service Name: Nokia PC Suite
Service RecHandle: 0x10003
Service Class ID List:
 "Serial Port" (0x1101)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 15
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100

Service Name: COM 1
Service RecHandle: 0x10004
Service Class ID List:
 "Serial Port" (0x1101)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 3
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100

Service Name: Voice Gateway
Service RecHandle: 0x10005
Service Class ID List:
 "" (0x111f)
 "Generic Audio" (0x1203)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 13
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "" (0x111e)
   Version: 0x0101

Service Name: Audio Gateway
Service RecHandle: 0x10006
Service Class ID List:
 "Headset Audio Gateway" (0x1112)
 "Generic Audio" (0x1203)
Protocol Descriptor List:
 "L2CAP" (0x0100)
 "RFCOMM" (0x0003)
   Channel: 12
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "Headset" (0x1108)
   Version: 0x0100
/********************************8/




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
