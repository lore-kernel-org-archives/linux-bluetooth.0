Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB-drivers
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Steven Singer <steven.singer@csr.com>
Cc: Riikka =?ISO-8859-1?Q?Jylh=E4?= <jylhar@ac.tut.fi>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F2E5F7D.50702@csr.com>
References: <000201c35a85$b18576d0$ae2ae682@ac.tut.fi>
	<1060001774.955.4.camel@pegasus>  <3F2E5F7D.50702@csr.com>
Content-Type: text/plain
Message-Id: <1060007336.954.29.camel@pegasus>
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
Date: 04 Aug 2003 16:28:50 +0200

Hi Steven,

> > My CSR dongles only support linear PCM (2's complement) with 8 or 16 bit
> > for input. See output of "hciconfig hci0 voice".
> 
> That shouldn't be the whole truth. The full list should be:
> 
>    Linear:
>      16 bit with up to 7 MSBs ignored, or 8 bit
>      1's complement, 2's complement or sign-magnitude
>    Logarithmic:
>      8 bit u-law or A-law

you are right. I made a mistake in encoding the voice setting value and
assumed that u-law and A-law are not allowed for input.

> The sample rate is fixed at 8 kHz (as defined by the Bluetooth spec).
> 
> I wouldn't recommend sending mp3s over a SCO link. Wavs should be
> fine provided they're resampled at 8 kHz, you set the voice setting
> to the appropriate data format, you skip the header and you get the
> rate matching right.

I use the following command to convert the raw data from a player
program like mpg123 into the needed format for SCO input (0x0060)

	sox -t raw -r 44100 -c 2 -s -w - -t raw -r 8000 -c 1 -s -w -

And I can hear MP3's over a Bluetooth headset and the quality is good ;)

Do anyone have easy C code for resampling to 8 KHz or converting to PCM,
u-law or A-law? Or do anyone know a good C library for this job?

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
