Return-Path: <SRS0=9HFX=YG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA84C4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 07:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1D8222CB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 07:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI+nYS5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfJMHgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Oct 2019 03:36:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52759 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfJMHgH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Oct 2019 03:36:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so14093773wmh.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2019 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=id7mKCZEWx8qh0MP8Ee7l6jWWyRr5SQl7a7m3YE6NnM=;
        b=CI+nYS5ro+7W2Yh6QIgjPZlGDWGsSfiATN+7sY73SYMIY5PLfmpaEvREgzRKB92tsY
         WT+2oGLS/Tz1xeFs6miXEeSBiV7tan88uyuFsnAXcIPQ5ApbhlJYhZH/n3GkM9AOHpqt
         yDsGLulZvVAlgKgQ09/aUJ73lmyVBjXJ6tvYcb6i0GA5HBYwJaA6i7UW9SPPw/Ig2GlI
         ZyUZAaZiZjcF6acIcnyh7z/WqQf7aPcK0wpwlULO+kgPZPUSv2g5CkaGtI1GJddeT8Je
         t68JenqlNmczrWvk9sax9o8AipFCF6Q7XsEXlxf4iZQmZKednPlrJ0dVpJoH6Mq8QDkv
         lyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=id7mKCZEWx8qh0MP8Ee7l6jWWyRr5SQl7a7m3YE6NnM=;
        b=mAOrOvfrO4e1bKjJDaz2iluXVAWhtmWOdcqXSfzeRY8kdPGRb2f9OVRn7QSmf/2oVP
         bXJqemFn7aG/F7wdwa172SzLtoW0YOFaZZBMBNCkTd0FEQx4unVLJeS5rqcT8vFSXWe/
         UPA4OS5M8ag0qiAowuuW8tUUErcZ8El2fwiue/jqtGjSBoWg4IdYdhbnRLQ5fmHyRbnD
         C5rVtvKBLszJxGOCGrUS1YeNX2LRA9UlHMh5dLlQWOU95ZVN9ART1lmevzYg2DoHlLl1
         RADygJailGLTuU0GmIbTWpX0gK1XD25I0z+zVw7iTmQ1ZAUKubSTR7svTQLqct9pht3r
         1acg==
X-Gm-Message-State: APjAAAVwiGZTXRD4/5h4z4zEtJZFwj1yTHT7icX2jCah1Wr4qcBcN1gm
        q/Yi36EVytFuYupe2000icY=
X-Google-Smtp-Source: APXvYqy1+J6sQWaAMBTwsD+iSy7jZaLT6JZT6NKPuIzCZngjgjq0NlqPyixjtKqNTG9izptPhAnE2Q==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr10789191wma.39.1570952165500;
        Sun, 13 Oct 2019 00:36:05 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 36sm19609935wrp.30.2019.10.13.00.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Oct 2019 00:36:04 -0700 (PDT)
Date:   Sun, 13 Oct 2019 09:36:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Message-ID: <20191013073603.6jnczqr4fk7lpyxq@pali>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
 <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali>
 <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
 <20191011200420.hbrutdclfva2uqpv@pali>
 <CABBYNZL8u2kUnPqiA56DtZyAPZEAUQBaBOC-wuqUQmOW6ZJ=Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mfv3fespc5xytaj3"
Content-Disposition: inline
In-Reply-To: <CABBYNZL8u2kUnPqiA56DtZyAPZEAUQBaBOC-wuqUQmOW6ZJ=Og@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--mfv3fespc5xytaj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 12 October 2019 10:23:58 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Oct 11, 2019 at 11:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> >
> > On Friday 11 October 2019 19:05:56 Gix, Brian wrote:
> > > On Fri, 2019-10-11 at 19:00 +0000, Gix, Brian wrote:
> > > > Hi Pali,
> > > >
> > > > On Fri, 2019-10-11 at 20:35 +0200, Pali Roh=C3=A1r wrote:
> > > > > Currently bluez API, method Acquire() already inform called appli=
cation
> > > > > what is socket MTU for input and output. So from this information=
 it is
> > > > > possible to detect if device supports EDR 3 or not.
> > > > >
> > > > > But it is too late to have this information. I need to send SBC
> > > > > parameters to bluez first when doing A2DP negotiation, this is ea=
rly
> > > > > steps before Acquire() is called.
> > > >
> > > > This seems to be the kind of information which is fixed, for the li=
fe of the pairing.
> > > >
> > > > What if you assumed the lower speed the first time you connected, d=
etermined the
> > > > speed during the first streaming, and then either immediately reneg=
otiate (caching the identifying
> > > > information
> > > > of the SNK), or just cache the information for future connections.
> > > >
> > > > Or the reverse, and assume fast, but immediately adjust down if you=
 aren't getting what you hoped for.
> > > >
> > > > In any case, this would be a "Device Setup" glitch which you could =
note as a routine part of pairing in the
> > > > documentation.
> > >
> > > Or, Stream "Silence" the first time you connect, in order to determin=
e throughput.  It would add 1-2 seconds to
> > > your connection time perhaps, but would be less noticable to the user.
> >
> > This increase connection time, increase complexity of implementation
> > (lot of things can fail) and just complicate lot of things there. Plus
> > adds that glitch which is not user friendly.
> >
> > Also bluetooth devices, like headsets, probably do not expects that
> > somebody is going to do such thing and we can hit other implementation
> > problems...
> >
> > And moreover it is just big hack and workaround for that problem. Not a
> > reasonable solution.
> >
> > In btmon I can see it, so kernel already knows that information. Why it
> > cannot tell it to userspace and bluetooth daemon to client application?
> >
> > Client application (e.g. pulseaudio) should really know if is going to
> > talk with bluetooth device with EDR 2 or EDR 3.
> >
> > > >
> > > > > Therefore I'm asking for some way how to get information if device
> > > > > supports EDR 2 or EDR 3. This is basically requirement for proper
> > > > > implementation of SBC in high quality mode. So if there are not s=
uch API
> > > > > yet, could it be exported from kernel to userspace and bluetoothd
> > > > > daemon?
> > > > >
> > > > > See these two articles for more details about SBC and its high qu=
ality:
> > > > >
> > > > > https://habr.com/en/post/456182/
> > > > > http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-xq-b=
luetooth-audio-codec
> > > > >
> > > > > > > Is there any bluez API for it?
> > > > > > >
>=20
> There quite a few assumption here that are not really how it is
> implemented in BlueZ:
>=20
> 1. The L2CAP MTU is not based on the ACL link (should be relatively
> easy to change)
> 2. L2CAP MTU is not required to be symmetric.
> 3. Since the ACL link is shared for all channels we shouldn't really
> assume all throughput will be available
> 4. PA flow control is not just filling up packets and sending them
> when they are full to maximize speed, instead it send packets when
> necessary to maintain a constant speed so the MTU may not be fully
> used, in fact trying to maximize the MTU may result in higher latency
> since packets would be sent less frequently.
>=20
> With this in mind I think the only thing we should look into is to
> adjust the default L2CAP MTU to match the underline ACL Link, so it
> maximizes throughput, the remote side may choose a different MTU which
> will have to follow though.

Hi Luiz! The main problem is not MTU size, as I wrote I cannot use it
normally for distinguish for usage of SBC XQ or not. Instead of MTU I
rather need to know if device supports EDR 2 or EDR 3.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--mfv3fespc5xytaj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXaLT4QAKCRCL8Mk9A+RD
UmjIAJ9neSxcyNLrQyMD2gaXogEM0JQz8wCfSGO3nrfdmDFCxrykuOjyPeSZ7xo=
=rxMF
-----END PGP SIGNATURE-----

--mfv3fespc5xytaj3--
