Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez and OBEX File Transfer
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Andrew Radke <andrew@radke.iig.com.au>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F229216.3060000@radke.iig.com.au>
References: <3F229216.3060000@radke.iig.com.au>
Content-Type: text/plain
Message-Id: <1059380203.1015.80.camel@pegasus>
Mime-Version: 1.0
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
Date: 28 Jul 2003 10:16:36 +0200

Hi Andrew,

> I just got myself a nice new Ericsson T610 and would love to be able to 
> use it's 'Browse files' funtion with bluez in the same way as with the 
> iPaq. From doing a 'sdptool browse $ipaq' I found the following which I 
> assume is what is handling this:
> 
> Service Name: OBEX File Transfer
> Service RecHandle: 0x10002
> Service Class ID List:
>    "OBEX File Transfer" (0x1106)
> Protocol Descriptor List:
>    "L2CAP" (0x0100)
>    "RFCOMM" (0x0003)
>      Channel: 3
>    "OBEX" (0x0008)
> Language Base Attr List:
>    code_ISO639: 0x656e
>    encoding:    0x6a
>    base_offset: 0x100
> Profile Descriptor List:
>    "OBEX File Transfer" (0x1106)
>      Version: 0x0100
> 
> Is there anything to handle the equivalent under Linux?

I have started a btftp client, which you can found in the BlueZ CVS in
the repository obex. But at the moment no btftpd exists.

BTW please send me "hcitool info <t610-bdaddr>" and the complete sdptool
browse for your phone.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
