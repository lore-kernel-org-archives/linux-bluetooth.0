Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <420CF980.1090004@thomae-privat.de>
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------080906020305060701070006"
Subject: [Bluez-users] For device database: Siemens S65
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
Date: Fri, 11 Feb 2005 19:29:20 +0100

This is a multi-part message in MIME format.
--------------080906020305060701070006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

here is some info about the Siemens S65v (I guess 'v' stands for the 
Vodafone-branded edition) for your device database.

Does LMP version 1.2 mean it's a Bluetooth 1.2 device?

Greets
Matthias

--------------080906020305060701070006
Content-Type: text/plain;
 name="s65info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s65info.txt"

Requesting information ...
	BD Address:  00:01:E3:xx:xx:xx
	Device Name: S65
	LMP Version: 1.2 (0x2) LMP Subversion: 0x750
	Manufacturer: Infineon Technologies AG (9)
	Features: 0xff 0xff 0x1d 0xc0 0x18 0x18 0x00 0x00
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
		<HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
		<transparent SCO> <inquiry with RSSI> <extended SCO> 
		<AFH cap. slave> <AFH class. slave> <AFH cap. master> 
		<AFH class. master> 

--------------080906020305060701070006
Content-Type: text/plain;
 name="s65sdp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s65sdp.txt"

Browsing 00:01:E3:xx:xx:xx ...
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
    Version: 0x0101

Service Name: SIM Access
Service RecHandle: 0x1112d
Service Class ID List:
  "" (0x112d)
  "Generic Telephony" (0x1204)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "" (0x112d)
    Version: 0x0100


--------------080906020305060701070006--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
