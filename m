Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E9DC43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 06:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04E22081C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 06:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9fGzbO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfECGRr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 02:17:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECGRq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 02:17:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id b10so5629868wmj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yUFz1pPuhLmhYPDG80QoNb+aEbDoRhs7gdTEGMj9ocs=;
        b=d9fGzbO92yiXoXLC9LPzLUVE//tJdaZA31XssAE93LpbtCXw+wI5zKDF7FRtFy8XUs
         zSnRFcn9kDDfNJgm3Zsaoo1s9C4k3l+b71bC5DE4ou8XX+dM3CqM8g7EqsSf1mHXgjL4
         3dHruuMYgDCw/NLlvWuyRvnkQE9QeLBsf+LxW/NtRJk/GNiwPlaaYngvs9ri48aqyjwt
         yrdGmKKZPADSkjzHOaAif9nIt+9Utlpkjo3HGbhsVHz7uhrUHUd5JmhvTmJYp5r50st1
         tqweIYkd+onXgwims1GPS8+D7v+l+2V8I/skwJ8SgFY5Wgde3O2lihYqF/4p9/hPmCR0
         M0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yUFz1pPuhLmhYPDG80QoNb+aEbDoRhs7gdTEGMj9ocs=;
        b=g9uDCokgUHkP35NYtCmk41GAaClatmEuB75i3SjdNhL+/aB6y/vwftj9a+ZaTYJGFk
         dEhkvnMOLniLhljyu9jXh9a5rnZoPsTXV1JyiwpRNJ2aMkODFYWNjcTXUK7mV/yWpcFQ
         ZBrFXGYZpF/003PG8qG94pGs0VEGY6UJ0fGM7kxe/ZZ3/6MKMOrukWUixMi6AAV8skd3
         xFNe2zVEbs4934yYM2BghB8gN0efs3BDUU7gf4SL8SQEHswHGdBJuXppyf0lnFNBF9JH
         0pPzL7FT7TobTF8SSelpne3DqVdQHs9yoIqZjTuocAd0FxedC7V3e1/O+DiOooxSArbC
         B1FA==
X-Gm-Message-State: APjAAAVaTV3Vt1GYgZpGTQvwiPRfpoq1jFg1+MmL0bjpaSXr2SytxSC+
        +7yQ+ZIlgKjxrcwxEf4gmu4bW1CY
X-Google-Smtp-Source: APXvYqwWMcVBMB087iWeF7Q3BMMrucfEWLnpUHNosW5evliEyMf6BwSreMDZa9COWPsngL4DPgOzaw==
X-Received: by 2002:a1c:304:: with SMTP id 4mr2676844wmd.39.1556864263554;
        Thu, 02 May 2019 23:17:43 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y4sm1079503wmj.20.2019.05.02.23.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 23:17:42 -0700 (PDT)
Date:   Fri, 3 May 2019 08:17:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190503061741.jw4lcyfi2cetrxrt@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hjmg7yxxfk7bbtt4"
Content-Disposition: inline
In-Reply-To: <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--hjmg7yxxfk7bbtt4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 January 2019 13:24:22 Luiz Augusto von Dentz wrote:
> Hi Pali,
> On Tue, Jan 22, 2019 at 7:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Tuesday 22 January 2019 16:20:12 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > > On Tue, Jan 22, 2019 at 3:45 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > This adds the possibility to expose remote SEP using MediaEndpoint
> > > > interface to allow setting a configuration.
> > > > ---
> > > >  doc/media-api.txt | 27 +++++++++++++++++++++++++--
> > > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > index b5ad2db12..af9485342 100644
> > > > --- a/doc/media-api.txt
> > > > +++ b/doc/media-api.txt
> > > > @@ -500,14 +500,23 @@ Properties        object Player [readonly]
> > > >  MediaEndpoint1 hierarchy
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > >
> > > > -Service                unique name
> > > > +Service                unique name (Server role)
> > > > +               org.bluez (Client role)
> > > >  Interface      org.bluez.MediaEndpoint1
> > > > -Object path    freely definable
> > > > +Object path    freely definable (Server role)
> > > > +               [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_X=
X_XX/sepX
> > > > +               (Client role)
> > > >
> > > >  Methods                void SetConfiguration(object transport, dic=
t properties)
> > > >
> > > >                         Set configuration for the transport.
> > > >
> > > > +                       For client role transport must be set with =
a server
> > > > +                       endpoint oject which will be configured and=
 the
> > > > +                       properties must contain the following prope=
rties:
> > > > +
> > > > +                               array{byte} Capabilities
> > > > +
> > > >                 array{byte} SelectConfiguration(array{byte} capabil=
ities)
> > > >
> > > >                         Select preferable configuration from the su=
pported
> > > > @@ -532,6 +541,20 @@ Methods            void SetConfiguration(objec=
t transport, dict properties)
> > > >                         endpoint, because when this method gets cal=
led it has
> > > >                         already been unregistered.
> > > >
> > > > +Properties     string UUID [readonly, optional]:
> > > > +
> > > > +                       UUID of the profile which the endpoint is f=
or.
> > > > +
> > > > +               byte Codec [readonly, optional]:
> > > > +
> > > > +                       Assigned number of codec that the endpoint =
implements.
> > > > +                       The values should match the profile specifi=
cation which
> > > > +                       is indicated by the UUID.
> > > > +
> > > > +               array{byte} Capabilities [readonly, optional]:
> > > > +
> > > > +                       Capabilities blob, it is used as it is so t=
he size and
> > > > +                       byte order must match.
> > > >
> > > >  MediaTransport1 hierarchy
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > --
> > > > 2.17.2
> > >
> > > Can you try this set?
> >
> > Hi! In V3 you added only "a2dp: Add reverse discovery" patch right?
> > I tested my setup also with this patch and there is no difference,
> > pulseaudio is working fine :-)
> >
>=20
> Applied.
>=20

Now I found another bug. The whole codec switching does not work with
some Ausdom headset. When pulseaudio try to switch codec profile it just
get from bluez org.bluez.Error.Failed: Invalid argument DBus error
message. And in bluez log is just: avdtp_close: Invalid argument

In btmon I'm seeing following output:

< ACL Data TX: Handle 35 flags 0x00 dlen 7              #4093 [hci0] 112.87=
9357
      Channel: 2242 len 3 [PSM 0 mode 0] {chan 0}
        60 09 04                                         `..            =20
> HCI Event: Number of Completed Packets (0x13) plen 5  #4094 [hci0] 112.87=
9474
        Num handles: 1
        Handle: 35
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5  #4095 [hci0] 112.88=
3600
        Num handles: 1
        Handle: 35
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5  #4096 [hci0] 112.88=
4598
        Num handles: 1
        Handle: 35
        Count: 1
> ACL Data RX: Handle 35 flags 0x02 dlen 6              #4097 [hci0] 112.90=
6614
      Channel: 66 len 2 [PSM 0 mode 0] {chan 0}
        62 09                                            b.             =20
=3D bluetoothd: avdtp_close: Invalid argument                          112.=
908009

Any idea why that avdp_close is failing?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--hjmg7yxxfk7bbtt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMvdAgAKCRCL8Mk9A+RD
Um7uAJ4o+7Xgxb41GHlynBcMJIKtWxUIJQCeJoGKKc67dWBmBYDiVn8QodcsOIg=
=vZB0
-----END PGP SIGNATURE-----

--hjmg7yxxfk7bbtt4--
