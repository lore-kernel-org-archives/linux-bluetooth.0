Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] USB-drivers
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Riikka =?ISO-8859-1?Q?Jylh=E4?= <jylhar@ac.tut.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000501c35bea$45557850$ae2ae682@ac.tut.fi>
References: <000501c35bea$45557850$ae2ae682@ac.tut.fi>
Content-Type: text/plain
Message-Id: <1060168749.935.76.camel@pegasus>
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
Date: 06 Aug 2003 13:18:59 +0200

Hi Riikka,

> Replying myself as more testing was done. I converted a .wav-file into
> .sb and hsplaying that sounds like the original sound but slowed. Voice
> is lower than the original and the quality is not very good. Commands I
> used: "sox sound1.wav sound1.sb"  and "./hstest play sound1.sb
> xx:xx:xx:xx:xx 7"
> 
> If I try to convert sound to 8 bit with command "sox sound1.wav -b
> sound1.sb" result is noise. I don't know if it's a bluez problem anymore
> but I thought someone might know what the problem is. 
> 
> I'm using voice setting 0x0040. Should I use the default setting with
> sox:ed file? The problem is I can't listen to the .sb-file before it is
> sent cause no audio player recognizes the format. Ideas?

	man play

BTW the hard coded voice setting of 0x0040 in hstest can be ignored, if
you now what you are doing. If it is set to 0x0060 (default) the audio
file must be converted to .sw and hci_usb driver must use ISOC alternate
setting 2. I am working on a new version of hstest which calls sox by
itself with the correct params according to the current voice setting.

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
