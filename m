Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4340F256.3040605@ruault.com>
From: Charles-Edouard Ruault <bluez@ruault.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Nokia 6680 services....
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
Date: Mon, 03 Oct 2005 10:56:54 +0200

Hello,
i just got a 6680 and i'm trying to play with bluetooth.
Using sdptool browse 00:xx:xx:xx:xx:xx
i'm getting the following services. I've noticed that the last 2
services are flagged with an error ...
I'm using the latest bluez version ( bluez-libs-2.21& bluez-utils-2.21 ).
Does anyone know what it means ?
Thanks in advance.


Browsing 00:xx:xx:xx:xx:xx ...
Service Name: Dial-Up Networking
Service RecHandle: 0x10000
Service Class ID List:
"Dialup Networking" (0x1103)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 1
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"Dialup Networking" (0x1103)
Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10001
Service Class ID List:
"OBEX Object Push" (0x1105)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 9
"OBEX" (0x0008)
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"OBEX Object Push" (0x1105)
Version: 0x0100

Service Name: Imaging
Service RecHandle: 0x10002
Service Class ID List:
"Imaging Responder" (0x111b)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 15
"OBEX" (0x0008)
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"Imaging" (0x111a)
Version: 0x0100

Service Name: Hands-Free Audio Gateway
Service RecHandle: 0x10003
Service Class ID List:
"Handfree Audio Gateway" (0x111f)
"Generic Audio" (0x1203)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 2
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"Handfree Audio Gateway" (0x111f)
Version: 0x0101

Service Name: Headset Audio Gateway
Service RecHandle: 0x10004
Service Class ID List:
"Headset Audio Gateway" (0x1112)
"Generic Audio" (0x1203)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 3
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"Headset" (0x1108)
Version: 0x0100

Service Description: OBEX File Transfer
Service RecHandle: 0x10005
Service Class ID List:
"OBEX File Transfer" (0x1106)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 10
"OBEX" (0x0008)
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"OBEX File Transfer" (0x1106)
Version: 0x0100

Service Name: SyncMLClient
Service RecHandle: 0x10006
Service Class ID List:
"Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 11
"OBEX" (0x0008)
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
Version: 0x0100

Service Name: Nokia OBEX PC Suite Services
Service RecHandle: 0x10007
Service Class ID List:
"Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
Protocol Descriptor List:
"L2CAP" (0x0100)
"RFCOMM" (0x0003)
Channel: 12
"OBEX" (0x0008)
Language Base Attr List:
code_ISO639: 0x454e
encoding: 0x6a
base_offset: 0x100
Profile Descriptor List:
"Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
Version: 0x0100

-- 
Charles-Edouard Ruault
GPG key Id E4D2B80C



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
