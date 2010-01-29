Return-Path: <cyrus@holtmann.org>
Subject: Re: headset target seems to be playing but no sound
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20100128215042.4cfc0eb1@atom.pigiron.org>
References: <8396c2281001242007n5ae20eccj53d496f1297e5d22@mail.gmail.com>
	 <8396c2281001242013y1246bcaaq73ad85ff82f57cab@mail.gmail.com>
	 <1264393316.22989.862.camel@pc.interlinx.bc.ca>
	 <20100125192334.6725779d@atom.pigiron.org>
	 <8396c2281001261928r31d2a5a9w6e4a2a3b5b96221e@mail.gmail.com>
	 <20100128215042.4cfc0eb1@atom.pigiron.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-h/T8G3A7pEVmcc6z4Iwk"
Date: Fri, 29 Jan 2010 15:23:56 -0500
Message-ID: <1264796636.26570.612.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-h/T8G3A7pEVmcc6z4Iwk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-01-28 at 21:50 -0600, pigiron@gmx.com wrote:=20
>=20
> Good point. I set up a debug environment (again), created some 8k Hz audi=
o
> files, and confirmed that you are correct.
>=20
> But the 8k mono file worked in my environment.

Unfortunately it doesn't in my environment.  :-(

> I put the S805 headset into HFP mode and did this:

Hrm.  I don't know that I have to or know how to do this with my
headset.  Can you elaborate?

> $ aplay -D s805 8k.wav
>   Playing WAVE '8k.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

When I use sox to provide the same kind of input, I get no luck:

$ sox /mnt/mp3/bad_mouth.wav -c 1 -b 8 -r 8k -t wav - | aplay -D bluetoothf=
oo
Playing WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono

I still get nothing except the headset beeps when the stream starts and
then ends.  FWIW, my alsa configuration for bluetoothfoo:

pcm.bluetoothraw {
   type bluetooth
   device 00:1A:45:1B:19:89
   #profile "auto" #optional, supported profiles are: auto, hifi and
voice
   #profile "voice" #optional, supported profiles are: auto, hifi and
voice
}

pcm.bluetoothfoo {
    type plug
    slave {
        pcm bluetoothraw
    }
}

Trying to use bluetoothraw directly doesn't work either:

$ sox /mnt/mp3/bad_mouth.wav -c 1 -b 8 -r 8k -t wav - | aplay -D bluetoothr=
aw
Playing WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
aplay: set_params:979: Sample format non available

> and verified that I was using the SCO path (HSP/HFP) by firing up hcidump
> during playback:
>=20
>   # hcidump -x

Me too:

>   [snip]

> SCO data: handle 1 flags 0x00 dlen 48
    DD FF 2C 00 B9 FD 86 FF 5D FF 06 FE 52 FF 89 FD F6 FE 55 FF=20
    77 FD 4A FF 84 FF 4C FE FA FE ED FF 6C 00 D6 FF 43 FE 20 00=20
    E1 00 E3 FF FD 00 03 00=20
> SCO data: handle 1 flags 0x00 dlen 48
    CB FE C0 FE 24 FE 77 FE 39 FF A3 FD B6 FF A9 FF 32 FD 6C 01=20
    B5 FE E5 FD DD 00 4A FE 2F 01 C1 FF C0 FD B2 00 05 00 61 FF=20
    FE FF CF FF F3 FF 03 FF=20
> SCO data: handle 1 flags 0x00 dlen 48
    3A 00 71 00 3E FF 4D 00 59 FF D7 FF 1C 00 E7 FE 3B FF E9 FF=20
    2A FE 2E FF BC FF 7E FC AC FE 1A FF 70 FE 30 FF A8 FD 58 FF=20
    69 FF 68 FE 76 FF 4E 00=20



> The bluetooth USB computer dongle:
>=20
>   # hciconfig -a
>   hci0:   Type: USB
>         BD Address: AA:BB:CC:DD:EE:FF ACL MTU: 1021:7 SCO MTU: 64:1
>         UP RUNNING PSCAN
>         RX bytes:64829124 acl:41 sco:1271103 events:139 errors:0
>         TX bytes:3077 acl:43 sco:0 commands:85 errors:0
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'atom-0'
>         Class: 0x4a0104
>         Service Classes: Networking, Capturing, Telephony
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 2.1 (0x4) HCI Rev: 0x5332 LMP Ver: 2.1 (0x4) LMP Subver:=
 0x420e
>         Manufacturer: Broadcom Corporation (15)

Just for contrast, here's mine:

$ hciconfig -a
hci0:	Type: USB
	BD Address: 00:0D:18:01:3B:9B ACL MTU: 1017:8 SCO MTU: 64:0
	UP RUNNING PSCAN ISCAN=20
	RX bytes:3679050 acl:84 sco:72118 events:143 errors:13
	TX bytes:2177 acl:75 sco:0 commands:59 errors:0
	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH HOLD SNIFF PARK=20
	Link mode: SLAVE ACCEPT=20
	Name: 'pc-0'
	Class: 0x0a0104
	Service Classes: Networking, Capturing
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.0 (0x3) HCI Rev: 0x4000 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
	Manufacturer: Broadcom Corporation (15)

Interestingly enough, both are Broadcom dongles.

> Keep me posted (maybe privately???)

Please, to the list, so that everyone can benefit.

> if you find any good nuggets.

b.


--=-h/T8G3A7pEVmcc6z4Iwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktjQ9gACgkQl3EQlGLyuXAUAQCg3U6NyGGP17jJsxoqp/fj2BJ3
8VUAn0PdN1+37MOPQEj/jngJ2GfcGadm
=FoRZ
-----END PGP SIGNATURE-----

--=-h/T8G3A7pEVmcc6z4Iwk--

