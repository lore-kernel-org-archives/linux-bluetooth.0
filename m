Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 28 Jul 2018 21:26:49 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: A2DP backchannel
Message-ID: <20180728192649.7aryivyczpr2ek47@pali>
References: <20180711110406.hkcqfjkmxsqq5xqk@pali>
 <CABBYNZJQPJOz75cZ4M8WZO0ZL29ePnsi1V1Y1Rc6S-=DT0ox+w@mail.gmail.com>
 <20180711143747.lg6ve2lxkfphkftt@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h6mrh6ak5itbjx67"
In-Reply-To: <20180711143747.lg6ve2lxkfphkftt@pali>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--h6mrh6ak5itbjx67
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 July 2018 16:37:47 Pali Roh=C3=A1r wrote:
> On Wednesday 11 July 2018 16:34:14 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >=20
> > On Wed, Jul 11, 2018 at 2:04 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> > > Hi!
> > >
> > > Some vendor A2DP bluetooth codecs like FastStream or aptX Low Latency
> > > supports backchannel. Which means that they are bi-directional and in
> > > A2DP they supports not only (music) playback, but also receiving
> > > backchannel (microphone) voice.
> > >
> > > How to establish this bi-directional A2DP transfer with backchannel v=
ia
> > > bluez daemon?
> >=20
> > There is no such thing as bi-directional in AVDTP, which is a screw up
> > from the spec authors,
>=20
> So it means that those vendor A2DP codecs somehow extends AVDTP, right?
> I would need to figure out how A2DP devices send voice data... At least
> backchannel activation for FastStream is via one bit in codec parameters
> like other codec parameters.
>=20
> > luckily we don't have to stick to it since our
> > sockets are bi-directional so you can send and receive data at same
> > time, though the configuration must be the same in either direction
> > otherwise we would have to support transport multiplexing to have
> > multiple configuration done using the same channel.
>=20
> So does it mean that I can read from file descriptor received from dbus
> which is used for sending encoded A2DP audio samples? And if other side
> (e.g device with FastStream or aptX LL vendor codec) send voice via A2DP
> then I receive them on that file descriptor?

Now I established A2DP connection with FastStream codec and in btmon I
see that my headset started sending some data to channel 65 in this A2DP
mode.

So definitely it is possible to send data from headset to computer (that
backchannel) in A2DP mode despite what A2DP specification says.

I managed to modify pulseaudio code to start encoding and streaming
FastStream data to headset and it is working.

Now the challenge would be how to get those data which headset send to
channel 65? Is bluez really sending them via file descriptor which is
used for writing from host to headset?

Via btmon I was able to dump data from this channel 65 and via some
sed/perl magic I converted received voice data and played it:

$ btmon > /tmp/dump
CTRL+C
$ grep 'Channel: 65' -A 14 /tmp/dump | grep '^        ' | sed 's/^        /=
/;s/  .*//' | tr ' ' '\n' | perl -ne 'print chr(hex($_))' > /tmp/voice.sbc
$ sbcdec -f /tmp/voice.snd /tmp/voice.sbc
$ play /tmp/voice.snd

And I heard clear voice. So FastStream is really just rebranded SBC
codec (with fixed parameters; without RTP) and in A2DP bluetooth profile
provides nice bi-directional channels.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--h6mrh6ak5itbjx67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW1zDdwAKCRCL8Mk9A+RD
Uj67AJ4h517Z4IKNn4HjTc2iT17OnQFgmgCdHTnhy5XjZrsykPOQWo+FcRtZDX8=
=MXr+
-----END PGP SIGNATURE-----

--h6mrh6ak5itbjx67--
