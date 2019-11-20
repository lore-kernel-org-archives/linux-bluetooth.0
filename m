Return-Path: <SRS0=VswU=ZM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A7C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 07:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E8720872
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 07:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTdgvmI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfKTHoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:44:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41503 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKTHoR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Nov 2019 02:44:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so25444980wrj.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2019 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tefvos9kLtUZwmHCK08dl320Y5NZrBjhjzi57h2Hn00=;
        b=TTdgvmI6IGkoBTTftSxPA5bm8NA7BsHHiIk5PWdR5yoBhon8O/9SYZaZuB+FMo9SLQ
         VUewo3vovPod0UtJMnwBSpVUvLSVNvIK/B1iSrnBVleQTMmfjqkpv2hJjqAj7ae3YIns
         mEeWcWyr1XKcAdVx/KrI0N1fYBNCF9JsvV/HXC9OzyU61xSGnolc0HVt0pzguwRmP5QA
         UbCDuOuQd4MyePOs1CR2repngWz1upp1cb37au90QAaKadXbUtWZWpPNYfBBQQmjG5bY
         WpVIR7OPOOk5PyUG/j8GjfwTp8RzJZz7qT8MhmIj8CQbQfNNi6OCVnhJK3JzgFfGN6XN
         NK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tefvos9kLtUZwmHCK08dl320Y5NZrBjhjzi57h2Hn00=;
        b=Hzjyoj3lI0zrOefdxro5hrPGvQI2FjOFHEzM9spy6Mknsp1j62+V+Mx9TwbFKIZzbJ
         UT7ZmUpTg7dg6whT3TSw4G1whX4HVUUy6hjYLNUZMIgROGrNtWxERf383F2LBHy9FwHB
         cxiDFouB/B2IQVCr3xSWjE1LOUIszBRdwSy+maqZE13+NJHJq0IPNki+Qdd23GWBcmC4
         2f43iaV058fg5G3Ljs7KD0XfzHlpAsZpcrkCSmtzjM5Q5X26kssiapgMTYPVfayKkpI2
         UX4eujNYpC+skeAvQuU1+pEjb2vjtwObGCs7X2jXxLXVcHLLjxa6gFEz8pfWTHhcDsRU
         YVAw==
X-Gm-Message-State: APjAAAUzkcmq82DikO1xNDBtFlWsQ4GdHWgg7WGVbFS4pmfv66vZhGcK
        4ki+aOUO0OfZVsLOOgPjs/8=
X-Google-Smtp-Source: APXvYqxhwaIlp0g1IrR8GrH7SRaAsBKRp0cWEZWbmC2dpXpDyfPyvFeacfkf7YOSINb3qnv8qoUlTg==
X-Received: by 2002:adf:9dcb:: with SMTP id q11mr1450610wre.42.1574235853179;
        Tue, 19 Nov 2019 23:44:13 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h15sm32948350wrb.44.2019.11.19.23.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 23:44:11 -0800 (PST)
Date:   Wed, 20 Nov 2019 08:44:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191120074411.xtyw34kb3gc73zvk@pali>
References: <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <20191027220945.wmb3g55wtrmqbnmz@pali>
 <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
 <20191119171342.mwfzszu7xwabi7to@pali>
 <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mqtgsyfjw5s7wnuk"
Content-Disposition: inline
In-Reply-To: <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--mqtgsyfjw5s7wnuk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 20 November 2019 00:47:56 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>>>>>>>>>>> to be honest, I would rather see WBS implementation finally
> >>>>>>>>>>>>>> reach PA before we start digging into this.
> >>>>>>>>>>>>>=20
> >>>>>>>>>>>>> First I want to finish improving A2DP codec support in puls=
eaudio. Later
> >>>>>>>>>>>>> I can look at HSP/HFP profiles. Ideally it should have modu=
lar/plugin
> >>>>>>>>>>>>> extensible design. So the aim is that adding new codec woul=
d be very
> >>>>>>>>>>>>> simple, without need to hack something related to mSBC/WBC,=
 AuriStream
> >>>>>>>>>>>>> or any other codec.
> >>>>>>>>>>>>=20
> >>>>>>>>>>>> Well HSP don't have support for codec negotiation, but yes a=
 modular
> >>>>>>>>>>>> design is probably recommended.
> >>>>>>>>>>>>=20
> >>>>>>>>>>>>> But for AuriStream I need to set custom SCO parameters as d=
escribed
> >>>>>>>>>>>>> below and currently kernel does not support it. This is why=
 I'm asking
> >>>>>>>>>>>>> how kernel can export for userspace configuration of SCO pa=
rameters...
> >>>>>>>>>>>>=20
> >>>>>>>>>>>> We can always come up with socket options but we got to see =
the value
> >>>>>>>>>>>> it would bring since AuriStream don't look that popular among
> >>>>>>>>>>>> headsets, at least Ive never seem any device advertising it =
like
> >>>>>>>>>>>> apt-X, etc.
> >>>>>>>>>>>=20
> >>>>>>>>>>> Pali clearly has such device and he is willing to work on it.=
 Surely
> >>>>>>>>>>> that means it is popular enough to be supported...?
> >>>>>>>>>>=20
> >>>>>>>>>> Just put AT+CSRSF=3D0,0,0,0,0,7 to google search and you would=
 see that
> >>>>>>>>>> not only I have such device...
> >>>>>>>>>>=20
> >>>>>>>>>> So I would really would like to see that kernel finally stops =
blocking
> >>>>>>>>>> usage of this AuriStream codec.
> >>>>>>>>>=20
> >>>>>>>>> we need to figure out on how we do the kernel API to allow you =
this specific setting.
> >>>>>>>>=20
> >>>>>>>> Hi Marcel! Kernel API for userspace should be simple. Just add t=
wo
> >>>>>>>> ioctls for retrieving and setting structure with custom paramete=
rs:
> >>>>>>>>=20
> >>>>>>>> syncPktTypes =3D 0x003F
> >>>>>>>> bandwidth =3D 4000
> >>>>>>>> max_latency =3D 16
> >>>>>>>> voice_settings =3D 0x63
> >>>>>>>> retx_effort =3D 2
> >>>>>>>>=20
> >>>>>>>> Or add more ioctls, one ioctl per parameter. There is already on=
ly ioctl
> >>>>>>>> for voice settings and moreover it is whitelisted only for two v=
alues.
> >>>>>>>=20
> >>>>>>> it is not that simple actually. Most profiles define a certain se=
t of parameters and then they try to configure better settings and only fal=
lback to a specification defined default as last resort.
> >>>>>>=20
> >>>>>> Ok. I see that there is another "example" configuration for AuriSt=
ream
> >>>>>> with just different syncPktTypes =3D 0x02BF and bandwidth =3D 3850.
> >>>>>>=20
> >>>>>> So it really is not simple as it can be seen.
> >>>>>=20
> >>>>> currently the stepping for mSBC and CVSD are hard-coded in esco_par=
am_cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the -=
>setting parameter.
> >>>>>=20
> >>>>> So either we provide an new socket option (for example BT_VOICE_EXT=
) or we extend BT_VOICE to allow providing the needed information. However =
this needs to be flexible array size since we should then be able to encode=
 multiple stepping that are tried in order.
> >>>>>=20
> >>>>> My preference is that we extend BT_VOICE and not introduce a new so=
cket option. So feel free to propose how we can load the full tables into t=
he SCO socket. I mean we are not really far off actually. The only differen=
ce is that currently the tables are in the hci_conn.c file and selected by =
the provided voice->setting. However nothing really stops us from providing=
 the full table via user space.
> >>>>=20
> >>>> Ok. I will look at it and I will try to propose how to extend current
> >>>> BT_VOICE ioctl API for supporting all those new parameters.
> >>>=20
> >>> Below is inline MIME part with POC patch which try to implement a new
> >>> IOCTL (currently named BT_VOICE_SETUP) for configuring voice sco
> >>> settings.
> >>>=20
> >>> It uses flexible array of parameters <tx_bandwidth, rx_bandwidth,
> >>> voice_setting, pkt_type, max_latency, retrans_effort>, but with
> >>> maximally 10 array members (due to usage of static array storage). cv=
sd
> >>> codec uses 7 different fallback settings (see voice_setup_cvsd), so f=
or
> >>> POC 10 should be enough.
> >>>=20
> >>> Because a new IOCL has different members then old BT_VOICE I rather
> >>> decided to introduce a new IOCTL and not hacking old IOCTL to accept =
two
> >>> different structures.
> >>>=20
> >>> Please let me know what do you think about this API, if this is a way
> >>> how to continue or if something different is needed.
> >>>=20
> >>> --=20
> >>> Pali Roh=C3=A1r
> >>> pali.rohar@gmail.com
> >>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> >>> index fabee6db0abb..0e9f4ac07220 100644
> >>> --- a/include/net/bluetooth/bluetooth.h
> >>> +++ b/include/net/bluetooth/bluetooth.h
> >>> @@ -122,6 +122,19 @@ struct bt_voice {
> >>> #define BT_SNDMTU		12
> >>> #define BT_RCVMTU		13
> >>>=20
> >>> +#define BT_VOICE_SETUP		14
> >>> +#define BT_VOICE_SETUP_ARRAY_SIZE 10
> >>> +struct bt_voice_setup {
> >>> +	__u8 sco_capable:1;
> >>> +	__u8 esco_capable:1;
> >>> +	__u32 tx_bandwidth;
> >>> +	__u32 rx_bandwidth;
> >>> +	__u16 voice_setting;
> >>> +	__u16 pkt_type;
> >>> +	__u16 max_latency;
> >>> +	__u8 retrans_effort;
> >>> +};
> >>> +
> >>> __printf(1, 2)
> >>> void bt_info(const char *fmt, ...);
> >>> __printf(1, 2)
> >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> >>> index 094e61e07030..8f3c161da1c4 100644
> >>> --- a/include/net/bluetooth/hci_core.h
> >>> +++ b/include/net/bluetooth/hci_core.h
> >>> @@ -477,7 +477,7 @@ struct hci_conn {
> >>> 	__u8		passkey_entered;
> >>> 	__u16		disc_timeout;
> >>> 	__u16		conn_timeout;
> >>> -	__u16		setting;
> >>> +	struct bt_voice_setup voice_setup[BT_VOICE_SETUP_ARRAY_SIZE];
> >>> 	__u16		le_conn_min_interval;
> >>> 	__u16		le_conn_max_interval;
> >>> 	__u16		le_conn_interval;
> >>> @@ -897,8 +897,8 @@ static inline struct hci_conn *hci_lookup_le_conn=
ect(struct hci_dev *hdev)
> >>> }
> >>>=20
> >>> int hci_disconnect(struct hci_conn *conn, __u8 reason);
> >>> -bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
> >>> -void hci_sco_setup(struct hci_conn *conn, __u8 status);
> >>> +int hci_setup_sync(struct hci_conn *conn, __u16 handle);
> >>> +int hci_sco_setup(struct hci_conn *conn, __u8 status);
> >>>=20
> >>> struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_=
t *dst,
> >>> 			      u8 role);
> >>> @@ -920,7 +920,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *h=
dev, bdaddr_t *dst,
> >>> struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> >>> 				 u8 sec_level, u8 auth_type);
> >>> struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdad=
dr_t *dst,
> >>> -				 __u16 setting);
> >>> +				 struct bt_voice_setup *voice_setup);
> >>> int hci_conn_check_link_mode(struct hci_conn *conn);
> >>> int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> >>> int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 aut=
h_type,
> >>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>> index bd4978ce8c45..0aa2ad98eb80 100644
> >>> --- a/net/bluetooth/hci_conn.c
> >>> +++ b/net/bluetooth/hci_conn.c
> >>> @@ -35,30 +35,6 @@
> >>> #include "smp.h"
> >>> #include "a2mp.h"
> >>>=20
> >>> -struct sco_param {
> >>> -	u16 pkt_type;
> >>> -	u16 max_latency;
> >>> -	u8  retrans_effort;
> >>> -};
> >>> -
> >>> -static const struct sco_param esco_param_cvsd[] =3D {
> >>> -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
> >>> -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
> >>> -	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
> >>> -	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01 }, /* D1 */
> >>> -	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01 }, /* D0 */
> >>> -};
> >>> -
> >>> -static const struct sco_param sco_param_cvsd[] =3D {
> >>> -	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
> >>> -	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
> >>> -};
> >>> -
> >>> -static const struct sco_param esco_param_msbc[] =3D {
> >>> -	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
> >>> -	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
> >>> -};
> >>> -
> >>=20
> >> can you split this into multiple logical patches. And ensure sending i=
t with git send-email.
> >=20
> > I just send it as is to know if such API make sense and should I
> > continue or not. Preparing patches for git send-email takes a lot of
> > time and I wanted to know if such API is OK or should be fully
> > rewritten. So I do not spend on something which does not make sense.
> > Above patch is not mean to be complete not ready for merge.
>=20
> What is wrong with git-format-patch? I don=E2=80=99t need much time to pr=
epare patches. Anyway, I going to have a look what is the best way to load =
these parameter tables into the kernel.
>=20
> Regards
>=20
> Marcel
>=20

I was playing with another suggestion for API:

+#define BT_VOICE_SETUP		14
+struct bt_voice_pkt_type {
+	__u8 capability; /* 0x01 - SCO; 0x02 - eSCO */
+	__u8 retrans_effort;
+	__u16 pkt_type;
+	__u16 max_latency;
+};
+struct bt_voice_setup {
+	__u16 voice_setting;
+	__u16 pkt_types_count;
+	__u32 tx_bandwidth;
+	__u32 rx_bandwidth;
+	struct bt_voice_pkt_type pkt_types[];
+};

So voice_setttings, pkt_types_count and badwidth would not be repeated
as it is same for every pkt_type/retrans_effors/max_latency.

But above uses C99 flexible arrays, so I do not know if API kernel <-->
userspace API is allowed to use C99 flexible arrays.

But getsockopt/setsockopt functions are possible to write with above
API.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--mqtgsyfjw5s7wnuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdTuyQAKCRCL8Mk9A+RD
UgWzAJ9PhRPZPfoiLh8JpSfdREUZl7iXQQCgvrhh0n7kZKbRqqk05KhYjE9/hrY=
=dxEg
-----END PGP SIGNATURE-----

--mqtgsyfjw5s7wnuk--
