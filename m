Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] USB-drivers
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Riikka =?ISO-8859-1?Q?Jylh=E4?= <jylhar@ac.tut.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000201c35a85$b18576d0$ae2ae682@ac.tut.fi>
References: <000201c35a85$b18576d0$ae2ae682@ac.tut.fi>
Content-Type: text/plain
Message-Id: <1060001774.955.4.camel@pegasus>
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
Date: 04 Aug 2003 14:56:04 +0200

Hi Riikka, 

> > You need to apply a patch for using two ISOC URB's
> > per TX and RX path. 
> 
> Is this included in patch-2.4.21-mh2.gz. There is "Quirk for devices
> with no ISOC endpoints" at the Changelog. There is ISOC mentioned but is
> this the right patch or do I have to use the one I remember sawing
> somewhere in the bluez-developers mail-archive?

it is also not in 2.4.21-mh3, because it is not the complete solution.
You can see it as a quick hack to make it working, but you have to apply
it by yourself. The patch sent by Jonathan Paisley makes it working for
voice setting 0x0040 (8 bit). If you want to use the default setting
0x0060 (16 bit) you have to use ISOC alternate setting 2 which is
indicated by packet size 17. 

The quirk you mention and which can be found in 2.4.21-mh2 is only for
the buggy USB Bluetooth devices that have no ISOC interface. This is not
allowed by the H:2 specification, but some manufacturers are unable to
read such documents. 

> What audio formats are supported? Am I able to send .wav and .mp3
> sounds?

My CSR dongles only support linear PCM (2's complement) with 8 or 16 bit
for input. See output of "hciconfig hci0 voice".

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
