Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3F229216.3060000@radke.iig.com.au>
From: Andrew Radke <andrew@radke.iig.com.au>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] bluez and OBEX File Transfer
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 27 Jul 2003 00:37:10 +1000

Hi all,

I just got myself a nice new Ericsson T610 and would love to be able to 
use it's 'Browse files' funtion with bluez in the same way as with the 
iPaq. From doing a 'sdptool browse $ipaq' I found the following which I 
assume is what is handling this:

Service Name: OBEX File Transfer
Service RecHandle: 0x10002
Service Class ID List:
   "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 3
   "OBEX" (0x0008)
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "OBEX File Transfer" (0x1106)
     Version: 0x0100

Is there anything to handle the equivalent under Linux?

Forgive me if I should be asking this on an openobex list but I was 
hoping someone here might know and I don't want to subscribe to yet 
another list just for one quick question. :-)

Regards,

Andrew Radke



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
