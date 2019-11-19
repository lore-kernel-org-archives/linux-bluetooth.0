Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB47FC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1152080F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+xDmmfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfKSRNr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:13:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34503 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKSRNq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 12:13:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so2993339wmk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2019 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ku/mzHidSAHZLFkb11vjao4wtEBVgv9Nd6yecCImVY=;
        b=l+xDmmfvwTLo3wEsIEqugmeaGOSlCP5CMSYvvxULPcZey+Fdf7rSRfmteqZp/eNIBS
         D+DTKtyT4T0byo1/WgiBpMzH+O6tZY3qQb7ave7Umk/jGMhJdEIls+Lwoethq/EPSVTA
         8kJig8XFKtUPjc7Ny+JS3VgxF7Kb2ZdlEdClag+RvzHgEOPEKOK8NalbwV/PrOSdM7Wx
         HAa/zClVJtp7B8MwvyTXL5utcb3qZjQwQ/1SjuduJMm1wPlTSyZHUy9UkDW5jANugmUF
         K8pgO0P+cLbWXZ79XVhJbzDNITrh7/vzGi8OEEzTT6vMO/QenGJ2sEhmdrZQHE/BG61T
         LStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ku/mzHidSAHZLFkb11vjao4wtEBVgv9Nd6yecCImVY=;
        b=E6jhCPYZ4LM6aK5ZV+RXWUxyWXxFAJD0Yv5EyRhddK3NfFZV5lebtd4EIxXEJOxJSe
         WolvRzVdYAC8MEQMxUT0LlX1tn5mU49UrP5zKgQb/LCAcbJO/oqDwG+iCxaTC1u/dRzC
         US102TKhloqMimk44F3PClcTM5rFNwx4bi9THTdyAcsuBfH6yPW72L2fQWYPKLr/y9Bs
         NGHgkUxmB8wl1ykZhFaQYr7lLrQb2XGEB7vy1RZR+C3wQ3BbwHJ1WtATAC2V4Bcd7dSg
         0ana7LYskjYeOOFyh9Tplc6Qbeef0pXYgVwG7g/RZHmSymrOFPjUqRHE6uPGo7ye2doZ
         qV6A==
X-Gm-Message-State: APjAAAWNL0tdgRbvIazlStYkVpdtqbiFvb6MY4e36XR4dRoFlUadr01k
        +WASrJEyqsEkTUHOLCuCuOA=
X-Google-Smtp-Source: APXvYqyB/lI15mHJ1Wkx4JBT+otWpnTNwqq2KvL2ZtFuCLCx/9//4ckJKjmOHdriH3NXhHQAkE0r6w==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr7083046wme.152.1574183623997;
        Tue, 19 Nov 2019 09:13:43 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g138sm3844668wmg.11.2019.11.19.09.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 09:13:43 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:13:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191119171342.mwfzszu7xwabi7to@pali>
References: <20190519212157.GB31403@amd>
 <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <20191027220945.wmb3g55wtrmqbnmz@pali>
 <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sxabdunfzdfznox3"
Content-Disposition: inline
In-Reply-To: <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--sxabdunfzdfznox3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 19 November 2019 18:04:36 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>>>>>>>>> to be honest, I would rather see WBS implementation finally
> >>>>>>>>>>>> reach PA before we start digging into this.
> >>>>>>>>>>>=20
> >>>>>>>>>>> First I want to finish improving A2DP codec support in pulsea=
udio. Later
> >>>>>>>>>>> I can look at HSP/HFP profiles. Ideally it should have modula=
r/plugin
> >>>>>>>>>>> extensible design. So the aim is that adding new codec would =
be very
> >>>>>>>>>>> simple, without need to hack something related to mSBC/WBC, A=
uriStream
> >>>>>>>>>>> or any other codec.
> >>>>>>>>>>=20
> >>>>>>>>>> Well HSP don't have support for codec negotiation, but yes a m=
odular
> >>>>>>>>>> design is probably recommended.
> >>>>>>>>>>=20
> >>>>>>>>>>> But for AuriStream I need to set custom SCO parameters as des=
cribed
> >>>>>>>>>>> below and currently kernel does not support it. This is why I=
'm asking
> >>>>>>>>>>> how kernel can export for userspace configuration of SCO para=
meters...
> >>>>>>>>>>=20
> >>>>>>>>>> We can always come up with socket options but we got to see th=
e value
> >>>>>>>>>> it would bring since AuriStream don't look that popular among
> >>>>>>>>>> headsets, at least Ive never seem any device advertising it li=
ke
> >>>>>>>>>> apt-X, etc.
> >>>>>>>>>=20
> >>>>>>>>> Pali clearly has such device and he is willing to work on it. S=
urely
> >>>>>>>>> that means it is popular enough to be supported...?
> >>>>>>>>=20
> >>>>>>>> Just put AT+CSRSF=3D0,0,0,0,0,7 to google search and you would s=
ee that
> >>>>>>>> not only I have such device...
> >>>>>>>>=20
> >>>>>>>> So I would really would like to see that kernel finally stops bl=
ocking
> >>>>>>>> usage of this AuriStream codec.
> >>>>>>>=20
> >>>>>>> we need to figure out on how we do the kernel API to allow you th=
is specific setting.
> >>>>>>=20
> >>>>>> Hi Marcel! Kernel API for userspace should be simple. Just add two
> >>>>>> ioctls for retrieving and setting structure with custom parameters:
> >>>>>>=20
> >>>>>> syncPktTypes =3D 0x003F
> >>>>>> bandwidth =3D 4000
> >>>>>> max_latency =3D 16
> >>>>>> voice_settings =3D 0x63
> >>>>>> retx_effort =3D 2
> >>>>>>=20
> >>>>>> Or add more ioctls, one ioctl per parameter. There is already only=
 ioctl
> >>>>>> for voice settings and moreover it is whitelisted only for two val=
ues.
> >>>>>=20
> >>>>> it is not that simple actually. Most profiles define a certain set =
of parameters and then they try to configure better settings and only fallb=
ack to a specification defined default as last resort.
> >>>>=20
> >>>> Ok. I see that there is another "example" configuration for AuriStre=
am
> >>>> with just different syncPktTypes =3D 0x02BF and bandwidth =3D 3850.
> >>>>=20
> >>>> So it really is not simple as it can be seen.
> >>>=20
> >>> currently the stepping for mSBC and CVSD are hard-coded in esco_param=
_cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the ->s=
etting parameter.
> >>>=20
> >>> So either we provide an new socket option (for example BT_VOICE_EXT) =
or we extend BT_VOICE to allow providing the needed information. However th=
is needs to be flexible array size since we should then be able to encode m=
ultiple stepping that are tried in order.
> >>>=20
> >>> My preference is that we extend BT_VOICE and not introduce a new sock=
et option. So feel free to propose how we can load the full tables into the=
 SCO socket. I mean we are not really far off actually. The only difference=
 is that currently the tables are in the hci_conn.c file and selected by th=
e provided voice->setting. However nothing really stops us from providing t=
he full table via user space.
> >>=20
> >> Ok. I will look at it and I will try to propose how to extend current
> >> BT_VOICE ioctl API for supporting all those new parameters.
> >=20
> > Below is inline MIME part with POC patch which try to implement a new
> > IOCTL (currently named BT_VOICE_SETUP) for configuring voice sco
> > settings.
> >=20
> > It uses flexible array of parameters <tx_bandwidth, rx_bandwidth,
> > voice_setting, pkt_type, max_latency, retrans_effort>, but with
> > maximally 10 array members (due to usage of static array storage). cvsd
> > codec uses 7 different fallback settings (see voice_setup_cvsd), so for
> > POC 10 should be enough.
> >=20
> > Because a new IOCL has different members then old BT_VOICE I rather
> > decided to introduce a new IOCTL and not hacking old IOCTL to accept two
> > different structures.
> >=20
> > Please let me know what do you think about this API, if this is a way
> > how to continue or if something different is needed.
> >=20
> > --=20
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index fabee6db0abb..0e9f4ac07220 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -122,6 +122,19 @@ struct bt_voice {
> > #define BT_SNDMTU		12
> > #define BT_RCVMTU		13
> >=20
> > +#define BT_VOICE_SETUP		14
> > +#define BT_VOICE_SETUP_ARRAY_SIZE 10
> > +struct bt_voice_setup {
> > +	__u8 sco_capable:1;
> > +	__u8 esco_capable:1;
> > +	__u32 tx_bandwidth;
> > +	__u32 rx_bandwidth;
> > +	__u16 voice_setting;
> > +	__u16 pkt_type;
> > +	__u16 max_latency;
> > +	__u8 retrans_effort;
> > +};
> > +
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 094e61e07030..8f3c161da1c4 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -477,7 +477,7 @@ struct hci_conn {
> > 	__u8		passkey_entered;
> > 	__u16		disc_timeout;
> > 	__u16		conn_timeout;
> > -	__u16		setting;
> > +	struct bt_voice_setup voice_setup[BT_VOICE_SETUP_ARRAY_SIZE];
> > 	__u16		le_conn_min_interval;
> > 	__u16		le_conn_max_interval;
> > 	__u16		le_conn_interval;
> > @@ -897,8 +897,8 @@ static inline struct hci_conn *hci_lookup_le_connec=
t(struct hci_dev *hdev)
> > }
> >=20
> > int hci_disconnect(struct hci_conn *conn, __u8 reason);
> > -bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
> > -void hci_sco_setup(struct hci_conn *conn, __u8 status);
> > +int hci_setup_sync(struct hci_conn *conn, __u16 handle);
> > +int hci_sco_setup(struct hci_conn *conn, __u8 status);
> >=20
> > struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t =
*dst,
> > 			      u8 role);
> > @@ -920,7 +920,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hde=
v, bdaddr_t *dst,
> > struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> > 				 u8 sec_level, u8 auth_type);
> > struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr=
_t *dst,
> > -				 __u16 setting);
> > +				 struct bt_voice_setup *voice_setup);
> > int hci_conn_check_link_mode(struct hci_conn *conn);
> > int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> > int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_=
type,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index bd4978ce8c45..0aa2ad98eb80 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -35,30 +35,6 @@
> > #include "smp.h"
> > #include "a2mp.h"
> >=20
> > -struct sco_param {
> > -	u16 pkt_type;
> > -	u16 max_latency;
> > -	u8  retrans_effort;
> > -};
> > -
> > -static const struct sco_param esco_param_cvsd[] =3D {
> > -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
> > -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
> > -	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
> > -	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01 }, /* D1 */
> > -	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01 }, /* D0 */
> > -};
> > -
> > -static const struct sco_param sco_param_cvsd[] =3D {
> > -	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
> > -	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
> > -};
> > -
> > -static const struct sco_param esco_param_msbc[] =3D {
> > -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
> > -	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
> > -};
> > -
>=20
> can you split this into multiple logical patches. And ensure sending it w=
ith git send-email.

I just send it as is to know if such API make sense and should I
continue or not. Preparing patches for git send-email takes a lot of
time and I wanted to know if such API is OK or should be fully
rewritten. So I do not spend on something which does not make sense.
Above patch is not mean to be complete not ready for merge.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--sxabdunfzdfznox3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdQixAAKCRCL8Mk9A+RD
Uj4gAJ4saXVTqo+rNXBn2Rur/ouqiFrvQwCeK/FBAwGzf7NyEKtMI8lQAvDcLc0=
=dqUs
-----END PGP SIGNATURE-----

--sxabdunfzdfznox3--
