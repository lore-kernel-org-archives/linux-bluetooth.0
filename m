Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
From: Michael Albinus <michael.albinus@gmx.de>
Message-ID: <87acxxxly1.fsf@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Printer adapter w/o SDP
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
Date: Sun, 18 Jul 2004 19:30:14 +0200

Hello,

I have a bt printer adapter with a broken SDP:

magdalene:~# sdptool browse
Inquiring ...
Browsing 00:0C:55:00:B2:B4 ...
Service Name: BrightCom SPP print Server
Service RecHandle: 0x4f4a0001
Service Class ID List:
  "Error: This is uuid32" (0x00001101)
Protocol Descriptor List:
  "Error: " (0x00000100)
  "Error: " (0x00000003)
    uint8: 0x1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0x110

Service Name: BrightCom OPP Server
Service RecHandle: 0x4f4a0002
Service Class ID List:
  "Error: This is uuid32" (0x00001105)
Protocol Descriptor List:
  "Error: " (0x00000100)
  "Error: " (0x00000003)
    uint8: 0x2
  "Error: " (0x00000008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0x110
Profile Descriptor List:
  "Error: This is uuid32" (0x00001105)
    Version: 0x0100

It is bound via serial protocol:

magdalene:~# rfcomm
rfcomm0: 00:0C:55:00:B2:B4 channel 1 clean 

But I'm unable to use it as CUPS printer ("Can't get service
information"). The CUPS URI is "bluetooth://000C5500B2B4/spp".

Is there a way to bind it to CUPS without SDP? I hoped specifying the
protocol in the URI would be sufficient.

Best regards, Michael.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
