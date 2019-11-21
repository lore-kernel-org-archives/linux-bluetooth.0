Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A67C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 22:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D57020692
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 22:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q22KUqDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKUWrp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:47:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54397 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUWrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 17:47:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id x26so5217063wmk.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0SRwNXc8LlXOobMkI3w6GL5bC9bzsvn68BtnlduNlHQ=;
        b=q22KUqDLuK1oiFlTZ6vJU0o55mMG2YbdcUPNh2uFVsTIvvKjPiWUf6tCMBv484oHD4
         99eFstMh3r7YQdkxXihltGmXOYJ9lJ0QNJIbV0eA0SE5+CCQBRtP6Zr6UgDNMW+OM23e
         yh+NoVyqxar+c0uyPXxsjPKwflQw6CAXaXIHXDTrPAULytBoSUqpd7iVm4WbUgfwguKw
         a7K8DsSak5/XRvb1Pq48gCE5gE6edVS3VcGQimufzpSmJ7Wq5BLaz5dNP1kDz3vrI/Mm
         zB840ZW1VHK5a3+e/FAr62p2vapJbq3hD2/FtZZkFdsvq2dd2f1sJWjAg0IqcOkljFvS
         RweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0SRwNXc8LlXOobMkI3w6GL5bC9bzsvn68BtnlduNlHQ=;
        b=fHQAx3YdWEAwr1/urTmIDfXKMQynABAw480rpGY+GFOGDL6GH9ZGU+BVH4WkblbOLk
         9pxKGlFnng+oQnqCUykMREWRGyFASw9UBYDq/HYpfHYhp5jOqhFXX8qk+YlP92q3gFRQ
         efkaSd9wEUGkiQLSqPupMFg776jZ/jHq0JM/dTdykFgh2iV+Ewz0kybOogbBUxjME88L
         g1msgXel/isaain0hEDF/67w+ikQLkCTs2UY4kMpWCJ1LWUwogdduy+vzNwzJ6z7EpS+
         eftOVeTFzwjG465OiKZkuAy0wkp4xTNOoMNRgus6Jcq1+TUW6GddNJ8NbRwb6gYLl8xH
         V31A==
X-Gm-Message-State: APjAAAU8z01Ldb2/TzYYED50jnoCGqrDRFXt/VLf2wTom5Wi/x9Hf6ty
        lRhWd38l3esCXIwrVDXi4INBXPGG
X-Google-Smtp-Source: APXvYqwRqDflo8cMANaZXoY2spJ22d7jpaOaMNHLgthOzDKYCHd2gd1ORQJAvjevmkk6IdUy2KqyaQ==
X-Received: by 2002:a7b:c445:: with SMTP id l5mr12891242wmi.140.1574376460241;
        Thu, 21 Nov 2019 14:47:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i25sm1135900wmd.25.2019.11.21.14.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 14:47:39 -0800 (PST)
Date:   Thu, 21 Nov 2019 23:47:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191121224738.darrzzxk4zzronoc@pali>
References: <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <20191027220945.wmb3g55wtrmqbnmz@pali>
 <20191112210633.cjhpb7eczzta63mf@ucw.cz>
 <20191113092256.bxc6ixuk7ctrmt57@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yjngod7q33go2uqp"
Content-Disposition: inline
In-Reply-To: <20191113092256.bxc6ixuk7ctrmt57@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--yjngod7q33go2uqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 13 November 2019 10:22:56 Pali Roh=C3=A1r wrote:
> On Tuesday 12 November 2019 22:06:33 Pavel Machek wrote:
> > Hi!
> >=20
> > > > > >>>>>>>> But for AuriStream I need to set custom SCO parameters a=
s described
> > > > > >>>>>>>> below and currently kernel does not support it. This is =
why I'm asking
> > > > > >>>>>>>> how kernel can export for userspace configuration of SCO=
 parameters...
> > > > > >>>>>>>=20
> > > > > >>>>>>> We can always come up with socket options but we got to s=
ee the value
> > > > > >>>>>>> it would bring since AuriStream don't look that popular a=
mong
> > > > > >>>>>>> headsets, at least Ive never seem any device advertising =
it like
> > > > > >>>>>>> apt-X, etc.
> > > > > >>>>>>=20
> > > > > >>>>>> Pali clearly has such device and he is willing to work on =
it. Surely
> > > > > >>>>>> that means it is popular enough to be supported...?
> > > > > >>>>>=20
> > > > > >>>>> Just put AT+CSRSF=3D0,0,0,0,0,7 to google search and you wo=
uld see that
> > > > > >>>>> not only I have such device...
> > > > > >>>>>=20
> > > > > >>>>> So I would really would like to see that kernel finally sto=
ps blocking
> > > > > >>>>> usage of this AuriStream codec.
> > > > > >>>>=20
> > > > > >>>> we need to figure out on how we do the kernel API to allow y=
ou this specific setting.
> > > > > >>>=20
> > > > > >>> Hi Marcel! Kernel API for userspace should be simple. Just ad=
d two
> > > > > >>> ioctls for retrieving and setting structure with custom param=
eters:
> > > > > >>>=20
> > > > > >>> syncPktTypes =3D 0x003F
> > > > > >>> bandwidth =3D 4000
> > > > > >>> max_latency =3D 16
> > > > > >>> voice_settings =3D 0x63
> > > > > >>> retx_effort =3D 2
> > > > > >>>=20
> > > > > >>> Or add more ioctls, one ioctl per parameter. There is already=
 only ioctl
> > > > > >>> for voice settings and moreover it is whitelisted only for tw=
o values.
> > > > > >>=20
> > > > > >> it is not that simple actually. Most profiles define a certain=
 set of parameters and then they try to configure better settings and only =
fallback to a specification defined default as last resort.
> > > > > >=20
> > > > > > Ok. I see that there is another "example" configuration for Aur=
iStream
> > > > > > with just different syncPktTypes =3D 0x02BF and bandwidth =3D 3=
850.
> > > > > >=20
> > > > > > So it really is not simple as it can be seen.
> > > > >=20
> > > > > currently the stepping for mSBC and CVSD are hard-coded in esco_p=
aram_cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the=
 ->setting parameter.
> > > > >=20
> > > > > So either we provide an new socket option (for example BT_VOICE_E=
XT) or we extend BT_VOICE to allow providing the needed information. Howeve=
r this needs to be flexible array size since we should then be able to enco=
de multiple stepping that are tried in order.
> > > > >=20
> > > > > My preference is that we extend BT_VOICE and not introduce a new =
socket option. So feel free to propose how we can load the full tables into=
 the SCO socket. I mean we are not really far off actually. The only differ=
ence is that currently the tables are in the hci_conn.c file and selected b=
y the provided voice->setting. However nothing really stops us from providi=
ng the full table via user space.
> > > >=20
> > > > Ok. I will look at it and I will try to propose how to extend curre=
nt
> > > > BT_VOICE ioctl API for supporting all those new parameters.
> > >=20
> > > Below is inline MIME part with POC patch which try to implement a new
> > > IOCTL (currently named BT_VOICE_SETUP) for configuring voice sco
> > > settings.
> > >=20
> > > It uses flexible array of parameters <tx_bandwidth, rx_bandwidth,
> > > voice_setting, pkt_type, max_latency, retrans_effort>, but with
> > > maximally 10 array members (due to usage of static array storage). cv=
sd
> > > codec uses 7 different fallback settings (see voice_setup_cvsd), so f=
or
> > > POC 10 should be enough.
> > >=20
> > > Because a new IOCL has different members then old BT_VOICE I rather
> > > decided to introduce a new IOCTL and not hacking old IOCTL to accept =
two
> > > different structures.
> > >=20
> > > Please let me know what do you think about this API, if this is a way
> > > how to continue or if something different is needed.
> >=20
> >=20
> > New ioctl sounds like good idea.
> >=20
> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> > > index fabee6db0abb..0e9f4ac07220 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -122,6 +122,19 @@ struct bt_voice {
> > >  #define BT_SNDMTU		12
> > >  #define BT_RCVMTU		13
> > > =20
> > > +#define BT_VOICE_SETUP		14
> > > +#define BT_VOICE_SETUP_ARRAY_SIZE 10
> > > +struct bt_voice_setup {
> > > +	__u8 sco_capable:1;
> > > +	__u8 esco_capable:1;
> > > +	__u32 tx_bandwidth;
> > > +	__u32 rx_bandwidth;
> > > +	__u16 voice_setting;
> > > +	__u16 pkt_type;
> > > +	__u16 max_latency;
> > > +	__u8 retrans_effort;
> > > +};
> > > +
> >=20
> > Is this the new ioctl? I'd assume it should go to include/user/..
> > somewhere to be exported to userspace...?
>=20
> I put it into same file where is structure for old ioctl BT_VOICE.

Userspace headers are provided by bluez project. So once this API would
be in kernel, bluez headers needs to be extended.

> > Is it good idea to use __u8 :1 in user<->kernel API?
>=20
> I do not know. Should it be rather (C99) bool? Or just one __u8?

In next proposed API I used one __u8 with bitmask macros. So there are
no :1 anymore.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yjngod7q33go2uqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdcUCAAKCRCL8Mk9A+RD
Uh3PAJ4pd62AHSXdXqS6fXMR+EegJzk+2ACdGhOqs65nYGXsNdJiEEsZMkcbOsI=
=v4fI
-----END PGP SIGNATURE-----

--yjngod7q33go2uqp--
