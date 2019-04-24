Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D26C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545DA2148D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSH/o+5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfDXRB0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:01:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33362 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfDXRB0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 13:01:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so1337157wrp.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2019 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lpv8GQf4rq/eDT/91bx5sIbcM72yOqcWsdXcesxiUnU=;
        b=MSH/o+5nyywFeQ9viFCoUbWbYxm/WramaJcM2zbhHhIiZO5ewBB9jz+k3xNwRQUpQi
         A3P7GSHO9s9ca/TAcg+vgdSfWWMPQoeDEXTpzoH4dzAODLIic0HeIaH5H9zbzxd43QxB
         QFlSrX8m19xA9MCRoCb37FPH8Wl+BVQ7ueikgk4wp7eRAwUDWuRMxpoGvTaQDj97dYyp
         KtTzPhTlp81XO4uM86Ar+QkHOfAl0CR4GrOqJxnfFzcqkp3rJlvB7pxp8m49yEUPEI0e
         4c4dmQMTVYbBDqaROHf6OwbmhexmnChIedr0SVuwIdnE3JBUuqgSfQ1Tw7OSuxzV7iw+
         8Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lpv8GQf4rq/eDT/91bx5sIbcM72yOqcWsdXcesxiUnU=;
        b=kwCoZPw9MEU0Qn8hyB4s45+1vul9yladsP+JEFBkjOstBigMew0TLFG83CQe3JjaRp
         jNEgJOwg27hkXeAyCmj804jAnQ4FqUEhBJPVIwnC+XzzHKuREVFCjcgfLzaTTVNTpjvC
         IyWIbrnKjJJYnYjG4fm9o2tAhYXHxdZwKP+AfWVpcxtxkMAXAftRrNNngifM2zKjvZYr
         7x7jiqbF8jacX5gfR18Z8yx0FLMxSILvGFzItZ4LtHQFC4uhAyvnqOwUAmVFSAAnOd02
         vtrKUP0Ua60MwWHJZferXUqwakAFKoQiix9xJCltGnS6V+zHR0wRcwEHVx/khct+zjUE
         /kUQ==
X-Gm-Message-State: APjAAAUy+2SYsVnDEay9kDLy0e83gH7RiipTDWyv7mvEVrvQBkqq1LU5
        DEGfuzLRl8yCmrkjjyjvocQ=
X-Google-Smtp-Source: APXvYqyuBudS6OvniuvPRtHYyRROXb8HlY72bX7RxtjSBvz8KcbMAOL0S57kOYeHa1WkZQ55oXdIQw==
X-Received: by 2002:a5d:664c:: with SMTP id f12mr23382077wrw.302.1556125285231;
        Wed, 24 Apr 2019 10:01:25 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t15sm21001357wmt.2.2019.04.24.10.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 10:01:23 -0700 (PDT)
Date:   Wed, 24 Apr 2019 19:01:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
Message-ID: <20190424170122.4szmly36ztnn6l3e@pali>
References: <20190424083921.15679-1-luiz.dentz@gmail.com>
 <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kvudtbvjngme6t2y"
Content-Disposition: inline
In-Reply-To: <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--kvudtbvjngme6t2y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 April 2019 12:42:22 Luiz Augusto von Dentz wrote:
> On Wed, Apr 24, 2019 at 11:39 AM Luiz Augusto von Dentz
> > @@ -2355,8 +2421,12 @@ done:
> >  static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *l=
ist,
> >                                         const char *sender)
> >  {
> > +       struct a2dp_sep *first =3D NULL;
> > +       struct a2dp_channel *chan =3D find_channel(session);
> > +
> >         for (; list; list =3D list->next) {
> >                 struct a2dp_sep *sep =3D list->data;
> > +               struct avdtp_remote_sep *rsep;
> >
> >                 /* Use sender's endpoint if available */
> >                 if (sender) {
> > @@ -2370,14 +2440,22 @@ static struct a2dp_sep *a2dp_find_sep(struct av=
dtp *session, GSList *list,
> >                                 continue;
> >                 }
> >
> > -               if (avdtp_find_remote_sep(session, sep->lsep) =3D=3D NU=
LL)
> > +               rsep =3D avdtp_find_remote_sep(session, sep->lsep);
> > +               if (!rsep)
> >                         continue;
> >
> > +               /* Locate last used if set */
> > +               if (chan->last_used) {
> > +                       if (chan->last_used->sep =3D=3D rsep)
> > +                               return sep;
> > +                       first =3D sep;

This assignment is useless as 2 lines below you are returning sep from
function. So assignment of sep into first does nothing.

> > +               }
> > +
> >                 return sep;
> >
> >         }
> >
> > -       return NULL;
> > +       return first;
> >  }
> >
> >  static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t=
 type,

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--kvudtbvjngme6t2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMCWXwAKCRCL8Mk9A+RD
Uqz9AKCQNr/PsXbf3e7epHVpVBQkwQMNoQCfUQa0T0bzfr0dS3vmK0Yg8dp9QSs=
=+ZH5
-----END PGP SIGNATURE-----

--kvudtbvjngme6t2y--
