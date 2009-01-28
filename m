Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2009 07:01:47 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Reply-To: netdesign_98@yahoo.com
Subject: Re: Can we connected HFP and A2DP at the same time?
To: =?utf-8?B?5Y2e56OK?= <mykofzone@gmail.com>,
  Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1233121919.18259.15.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <368895.1189.qm@web52602.mail.re2.yahoo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Newer stereo headset might support this. I did one last year but it is
base on CSR's BlueLab. The stream will be suspended or paused when call act=
ive or SCO active and automatic resumed/play after the call. But as usual t=
here are cases that the phone did the same thing, so it could be messy.

Cheers,
Edwin
--- On Wed, 1/28/09, Marcel Holtmann <marcel@holtmann.org> wrote:

> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: Can we connected HFP and A2DP at the same time?
> To: "=E5=8D=9E=E7=A3=8A" <mykofzone@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Date: Wednesday, January 28, 2009, 12:51 AM
> Hi,
>=20
> >      This is the case for the cellphone : suppose the
> user is
> > listening music via A2DP, then a call coming, the user
> can answer this
> > call via HFP (press answer key in the bluetooth
> headset). After the
> > call ending, the cellphone will continue to play music
> via A2DP.
> >     I test several headset on Moto A1200
> > (iTech/Jabra/SonyEricsson/Moto bluetooth headset). But
> not all the
> > headset can answer the call by pressing answer key.
> Only the
> > iTech/Jabra can pass this case.
> >     My question is : does the bluez protocol support
> connected HFP and
> > A2DP at the same time? Then how can i judge whether a
> headset support
> > this or not? Thanks.
>=20
> in theory you can, but there are certain physical limits
> and I don't
> know of any headset that does support it. BlueZ would be
> just fine in
> doing so.
>=20
> Regards
>=20
> Marcel
>=20
>=20
> --
> To unsubscribe from this list: send the line
> "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=20
> http://vger.kernel.org/majordomo-info.html=0A=0A=0A      
