Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <412CBEB3.6090606@t-online.de>
From: detlef.grittner@t-online.de (Detlef Grittner)
MIME-Version: 1.0
To: Simone Gotti <simone.gotti@email.it>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Pocket PC 2003 and Linux
References: <412C5482.3010909@t-online.de> <200408251202.48482.simone.gotti@email.it> <412C9332.7010002@t-online.de> <200408251612.44110.simone.gotti@email.it>
In-Reply-To: <200408251612.44110.simone.gotti@email.it>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
Date: Wed, 25 Aug 2004 18:30:43 +0200

Simone Gotti wrote:

>So the Obex Push service is right registered but the Pocket PC can't find it?
>you said that it can find only the kbtserialchat, can you confirm this?
>I can only think that probably there are registered more than one obexservice. 
>Can you post the full output of "sdptool browse local"?
>
>P.S. I don't know if this is the right place to talk about kdebluetooth. 
>Probably we should move our thread to the kdebluetooth mailing list (avoiding 
>any crossposting).
>
>Bye!
>  
>

It's not only kdebluetooth that isn't working, but opd as well.
And yes,  kserialchat is detected by the Pocket PC.

Here is the output, which looks alright:
Browsing FF:FF:FF:00:00:00 ...
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

Service Name: Obex Push Server
Service Description: KDE OBEX Object Push Service
Service RecHandle: 0x8050770
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: KBtHandsfree
Service Description: KDE Bluetooth Phone Client
Service RecHandle: 0x8050b58
Service Class ID List:
  "" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Profile Descriptor List:
  "" (0x111e)
    Version: 0x0101

Service Name: KBtSerialChat
Service Description: KDE Bluetooth Serial Chat Service
Service RecHandle: 0x8050eb0
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
