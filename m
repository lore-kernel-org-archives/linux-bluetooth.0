Return-Path: <jylhar@ac.tut.fi>
From: =?iso-8859-1?Q?Riikka_Jylh=E4?= <jylhar@ac.tut.fi>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] USB-drivers
Date: Tue, 5 Aug 2003 15:38:46 +0300
Message-ID: <000201c35b4e$83b52790$ae2ae682@ac.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1060007336.954.29.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Hi,

> it is also not in 2.4.21-mh3, because it is not the complete solution.
You > can see it as a quick hack to make it working, but you have to
apply it by > yourself. The patch sent by Jonathan Paisley makes it
working for voice > > setting 0x0040 (8 bit). If you want to use the
default setting 0x0060 (16 > bit) you have to use ISOC alternate setting
2 which is indicated by packet > size 17.

I applied the patch, or actually wrote to the few files myself because
there were problems with patching. Now using the new better kernel and
trying to send audio files to my headset (actually Windows PC acting as
a headset) with hstest. Voice setting is set to 0x0040 as it's supposed
to be. Now soxing audio file:

sox sound.wav -t raw -r 8000 -c 1 -s -b 8bit_sound.wav
(last option not being -w as in Marcels example below because of the
0x0040)

and playing it:

./hstest play 8bit_sound.wav xx:xx:xx:xx:xx 7=20

I call it progress that I hear something but it's just noise. Trying
with some .au-file output is not noise but it certainly isn't the
original sound.

Am I using wrong kind of inputs or is the voice setting supposed to be
0x0060 instead of 0x0040 as the hstest wants it to be?=20

> If you want to use the default setting 0x0060 (16 bit) you have to use
> ISOC alternate setting 2 which is indicated by packet size 17.

If I want to use this default voice setting do I have to change the
kernel code again? Is the right correction changing MaxPacketSize to 17
instead of 9 as shown in the part of patch below?

...
@@ -830,7 +831,7 @@
=20
  #ifdef CONFIG_BLUEZ_USB_SCO
  case USB_ENDPOINT_XFER_ISOC:
 -if (ep->wMaxPacketSize < size)
 +if (ep->wMaxPacketSize !=3D 9)    <--- in 0x0060 9 is changed to 17?
  break;
  size =3D ep->wMaxPacketSize;
...


> I use the following command to convert the raw data from a player
> program like mpg123 into the needed format for SCO input (0x0060)
>
> 	sox -t raw -r 44100 -c 2 -s -w - -t raw -r 8000 -c 1 -s -w -
>
> And I can hear MP3's over a Bluetooth headset and the quality is good
;)
>
> Regards
>
> Marcel

--
Riikka Jylh=E4
