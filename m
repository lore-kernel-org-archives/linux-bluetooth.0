Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?iso-8859-1?Q?Riikka_Jylh=E4?= <jylhar@ac.tut.fi>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] USB-drivers
Message-ID: <000501c35bea$45557850$ae2ae682@ac.tut.fi>
MIME-Version: 1.0
In-Reply-To: <000201c35b4e$83b52790$ae2ae682@ac.tut.fi>
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
Date: Wed, 6 Aug 2003 10:13:43 +0300
Content-Type: text/plain; CHARSET=iso-8859-1

Replying myself as more testing was done. I converted a .wav-file into
.sb and hsplaying that sounds like the original sound but slowed. Voice
is lower than the original and the quality is not very good. Commands I
used: "sox sound1.wav sound1.sb"  and "./hstest play sound1.sb
xx:xx:xx:xx:xx 7"

If I try to convert sound to 8 bit with command "sox sound1.wav -b
sound1.sb" result is noise. I don't know if it's a bluez problem anymore
but I thought someone might know what the problem is.=20

I'm using voice setting 0x0040. Should I use the default setting with
sox:ed file? The problem is I can't listen to the .sb-file before it is
sent cause no audio player recognizes the format. Ideas?

--
Riikka Jylh=E4

-----Original Message-----
> Hi,
>
> > it is also not in 2.4.21-mh3, because it is not the complete
solution.
> You > can see it as a quick hack to make it working, but you have to
> apply it by > yourself. The patch sent by Jonathan Paisley makes it
> working for voice > > setting 0x0040 (8 bit). If you want to use the
> default setting 0x0060 (16 > bit) you have to use ISOC alternate
setting
> 2 which is indicated by packet > size 17.
>
> I applied the patch, or actually wrote to the few files myself because
> there were problems with patching. Now using the new better kernel and
> trying to send audio files to my headset (actually Windows PC acting
as
> a headset) with hstest. Voice setting is set to 0x0040 as it's
supposed
> to be. Now soxing audio file:
>
> sox sound.wav -t raw -r 8000 -c 1 -s -b 8bit_sound.wav
> (last option not being -w as in Marcels example below because of the
> 0x0040)
>=20
> and playing it:
>=20
> ./hstest play 8bit_sound.wav xx:xx:xx:xx:xx 7=20
>=20
> I call it progress that I hear something but it's just noise. Trying
> with some .au-file output is not noise but it certainly isn't the
> original sound.
>=20
> Am I using wrong kind of inputs or is the voice setting supposed to be
> 0x0060 instead of 0x0040 as the hstest wants it to be?=20
>=20
> > If you want to use the default setting 0x0060 (16 bit) you have to
use
> > ISOC alternate setting 2 which is indicated by packet size 17.
>=20
> If I want to use this default voice setting do I have to change the
> kernel code again? Is the right correction changing MaxPacketSize to
17
> instead of 9 as shown in the part of patch below?
>=20
> ...
> @@ -830,7 +831,7 @@
> =20
>   #ifdef CONFIG_BLUEZ_USB_SCO
>   case USB_ENDPOINT_XFER_ISOC:
>  -if (ep->wMaxPacketSize < size)
>  +if (ep->wMaxPacketSize !=3D 9)    <--- in 0x0060 9 is changed to 17?
>   break;
>   size =3D ep->wMaxPacketSize;
> ...
>=20
>=20
> > I use the following command to convert the raw data from a player
> > program like mpg123 into the needed format for SCO input (0x0060)
> >
> > 	sox -t raw -r 44100 -c 2 -s -w - -t raw -r 8000 -c 1 -s -w -
> >
> > And I can hear MP3's over a Bluetooth headset and the quality is
good
> ;)
> >
> > Regards
> >
> > Marcel
>=20
> --
> Riikka Jylh=E4
>=20
>=20





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
