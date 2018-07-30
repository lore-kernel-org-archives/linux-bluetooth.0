Return-Path: <pali.rohar@gmail.com>
Date: Mon, 30 Jul 2018 21:53:14 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: A2DP backchannel
Message-ID: <20180730195314.qa26kdvarvpkyms5@pali>
References: <20180711110406.hkcqfjkmxsqq5xqk@pali>
 <CABBYNZJQPJOz75cZ4M8WZO0ZL29ePnsi1V1Y1Rc6S-=DT0ox+w@mail.gmail.com>
 <20180711143747.lg6ve2lxkfphkftt@pali>
 <20180728192649.7aryivyczpr2ek47@pali>
 <4BA0F4BA-1CA9-46F1-8A86-212321742D4B@holtmann.org>
 <20180730171001.gehfsvgcnlf4jzzi@pali>
 <1449F90F-E5EE-43E3-8E3F-77DC50B1A722@holtmann.org>
 <20180730182532.abvthspuafhdbdl5@pali>
 <E042522B-87CF-4885-86A6-ADC9EF349991@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pmvcd7r5phstgitr"
In-Reply-To: <E042522B-87CF-4885-86A6-ADC9EF349991@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--pmvcd7r5phstgitr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 30 July 2018 21:39:09 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>>>>> Some vendor A2DP bluetooth codecs like FastStream or aptX Low La=
tency
> >>>>>>>> supports backchannel. Which means that they are bi-directional a=
nd in
> >>>>>>>> A2DP they supports not only (music) playback, but also receiving
> >>>>>>>> backchannel (microphone) voice.
> >>>>>>>>=20
> >>>>>>>> How to establish this bi-directional A2DP transfer with backchan=
nel via
> >>>>>>>> bluez daemon?
> >>>>>>>=20
> >>>>>>> There is no such thing as bi-directional in AVDTP, which is a scr=
ew up
> >>>>>>> from the spec authors,
> >>>>>>=20
> >>>>>> So it means that those vendor A2DP codecs somehow extends AVDTP, r=
ight?
> >>>>>> I would need to figure out how A2DP devices send voice data... At =
least
> >>>>>> backchannel activation for FastStream is via one bit in codec para=
meters
> >>>>>> like other codec parameters.
> >>>>>>=20
> >>>>>>> luckily we don't have to stick to it since our
> >>>>>>> sockets are bi-directional so you can send and receive data at sa=
me
> >>>>>>> time, though the configuration must be the same in either directi=
on
> >>>>>>> otherwise we would have to support transport multiplexing to have
> >>>>>>> multiple configuration done using the same channel.
> >>>>>>=20
> >>>>>> So does it mean that I can read from file descriptor received from=
 dbus
> >>>>>> which is used for sending encoded A2DP audio samples? And if other=
 side
> >>>>>> (e.g device with FastStream or aptX LL vendor codec) send voice vi=
a A2DP
> >>>>>> then I receive them on that file descriptor?
> >>>>>=20
> >>>>> Now I established A2DP connection with FastStream codec and in btmo=
n I
> >>>>> see that my headset started sending some data to channel 65 in this=
 A2DP
> >>>>> mode.
> >>>>>=20
> >>>>> So definitely it is possible to send data from headset to computer =
(that
> >>>>> backchannel) in A2DP mode despite what A2DP specification says.
> >>>>>=20
> >>>>> I managed to modify pulseaudio code to start encoding and streaming
> >>>>> FastStream data to headset and it is working.
> >>>>>=20
> >>>>> Now the challenge would be how to get those data which headset send=
 to
> >>>>> channel 65? Is bluez really sending them via file descriptor which =
is
> >>>>> used for writing from host to headset?
> >>>>>=20
> >>>>> Via btmon I was able to dump data from this channel 65 and via some
> >>>>> sed/perl magic I converted received voice data and played it:
> >>>>>=20
> >>>>> $ btmon > /tmp/dump
> >>>>> CTRL+C
> >>>>> $ grep 'Channel: 65' -A 14 /tmp/dump | grep '^        ' | sed 's/^ =
       //;s/  .*//' | tr ' ' '\n' | perl -ne 'print chr(hex($_))' > /tmp/vo=
ice.sbc
> >>>>> $ sbcdec -f /tmp/voice.snd /tmp/voice.sbc
> >>>>> $ play /tmp/voice.snd
> >>>>>=20
> >>>>> And I heard clear voice. So FastStream is really just rebranded SBC
> >>>>> codec (with fixed parameters; without RTP) and in A2DP bluetooth pr=
ofile
> >>>>> provides nice bi-directional channels.
> >>>>=20
> >>>> can you show us at least a few of these channel 65 frames from btmon=
 decoding. If it is via L2CAP fixed PSM, then in theory there needs to be s=
ome sort of channel establishment. Or if this via L2CAP fixed CID, then it =
is essentially unicast connectionless data. Both can be handled via L2CAP s=
ockets, but you need to create sockets for these to receive the data.
> >>>>=20
> >>>> On a side note, fixed CID 65 and fixed PSM 65 are both Bluetooth SIG=
 reserved values, so seems like this codec is still violating the standard.
> >>>=20
> >>> Hi! In attachment is btmon dump with codec negotiation, connect, both
> >>> sink and source data and disconnect. Interesting is that now channel =
65
> >>> is used for both sink and source. Yesterday when I was doing tests I
> >>> remember that different channel was used for microphone input and aud=
io
> >>> playback.
> >>=20
> >> so the Channel: 65 is a CID and is assigned dynamically. They can be d=
ifferent in each direction and by chance you get Source CID: 65 and Destina=
tion CID: 65. What I am seeing is that you get TX and RX on that PSM 25 whi=
ch seems to be the established media channel. This means the file descripto=
r you already have for sending audio, just read from it and you should be g=
etting the back channel receiving audio. L2CAP channels are always bi-direc=
tional.
> >=20
> > Interesting. Now I repeated my tests again and channels 77 and 64 are
> > used (64 for voice microphone). Just in case, btmon output is attached.
>=20
> that is fine. As I said, different CID numbers are assigned for each dire=
ction. They are negotiated when the L2CAP channel is created. That they are=
 the same rarely happens, but it can. Anyhow, the L2CAP socket from the ker=
nel will map CID 64 into recv and CID 77 into send.

Ok.

> > I would try to read directly from file descriptor used for sending data
> > and see if I can easily decode it in pulseaudio. As sbcdec was able to
> > decode it I hope that there would not be problem with libsbc in
> > pulseaudio.
>=20
> No idea why it would be SBC encoded, but sure. I don=E2=80=99t know enoug=
h detail about Fast Stream codec.

=46rom information which I have:

FastStream A2DP codec for audio sink uses SBC codec without RTP wrapping
with following parameters: frequency rate 44.1 kHz or 48 Hz, Block 16,
Sub-bands 8, Joint Stereo, Loudness and Bitpool 29. Data rate is 212
kbps, packet size 72*3+4 =3D 220. DSP decoders round 71 bytes to 72 (that
is why sbc size in packet is 72 and not 71). FastStream is presented as
low latency A2DP codec; but it is just rebranded SBC codec with fixes
parameters.

Backchannel in FastStream A2DP codec uses SBC codec too with parameters:
frequency rate 16 kHz, Blocks 16, Sub-bands 8, Mono, Loudness, Bitpool
32. Data rate is 72 kbps, packet size 72*3+4 =3D 220. Again 71 bytes are
rounded to 72 in DSP.

I do not know yet what should be stored on that 72. byte. When I put
there zero byte, my headset is happy and play music without glitches
(This zero byte can be seen also in dumps which I sent). But received
voice data seems to always have different value on that position. So I
guess it could be some checksum...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--pmvcd7r5phstgitr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW19sqAAKCRCL8Mk9A+RD
UtmlAKCZ0HaOx8I/HbgByMMnoHemZQHNTACeI3+Jje3Xjl80WWjqU8IWOkZtcB8=
=rFiw
-----END PGP SIGNATURE-----

--pmvcd7r5phstgitr--
