Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7376C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A886621873
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7deWz7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLRQCx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:02:53 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38050 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeLRQCx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 11:02:53 -0500
Received: by mail-ot1-f48.google.com with SMTP id e12so16148174otl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Dec 2018 08:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RydDoVg4xl3yLxjf/bQsaGQSs3/q4YMgTBhf87Ej7B8=;
        b=K7deWz7fcW026AS54V5Nk7FOrWTDP8p8sFWDFZSxrXbAfn+q1wa5Qcthaf/uwFjYHI
         ahgl5SpNey8vRxUj8AuGV1SRdXW4D00/7dUIrxRfvT4u4ypetgH/FT8wHpio650i9NNH
         zsRkTsw1PZDkV/ei2jk1hGy8QuXdwOhj/4Ty1Kqu6TMs1rfoMQjKfALTxofVsg8jgH4q
         kam6+QoG9MMO8Yf4XsPShYAxdo9Ru9+MGbUhCG9IzmFsp4gW9M04x8n5ANELIRt5hM6n
         jrcg6dK/qm9q9kgmIT6WCawOr0WDEMwg6/7RW3sMB8Juuziw8mREtvVd97icVSDKjnM4
         C0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RydDoVg4xl3yLxjf/bQsaGQSs3/q4YMgTBhf87Ej7B8=;
        b=nUMv/s6VFPb+SbbBQd7iQAehaJFOH0iZLyKkUOwoiA2aW+Kr48uM3g53sMWXG6nwIr
         a2IJcKUaCn9KW0XIdTnfQasyZJQNCO7yS0WgYFnytnEGURlqiAwZtPeSygxQHLYGLTIV
         N0zYti5zwxemv+f2o8kbikvKM0jREbRbpVEPatmEZ8Lr5TffWix0LTkjVfnuz1CeCG/V
         oh9mLG/4cbYiP6lES0SQi7mdfZW63VW5MeAJSl8jdhB1pKbnKiwr3ORG1Pkioq6KWwV7
         3aX9QVZIDNKVVDoGGVyQuV8yB8eT+QTR9yz/XwJJDU6YKcmrmfWCCRRXjKHJhXi7Nx1Q
         oYFg==
X-Gm-Message-State: AA+aEWavV8W660kU5fqMseLcaZE5TWhg3hr2xG9t9y8ccC1flzwc2cRh
        G/0uutzh5gJcv6JeVea9hOqLnBdfEgn5uis1F/NIJuEV
X-Google-Smtp-Source: AFSGD/VdBrz2m5u6WtIDXFoOUTJe0ejl1wyXtnlF6WuZfUW83QW31rp8YzukWlHa+DJwnOY1CO5rc8UAPyoklUYz2js=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr12198472otp.254.1545148970870;
 Tue, 18 Dec 2018 08:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20180711082352.oo6srapfnol5nkxq@pali> <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali> <20181215202910.j24amjshrvjqprll@pali>
In-Reply-To: <20181215202910.j24amjshrvjqprll@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Dec 2018 13:02:39 -0300
Message-ID: <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
Subject: Re: bluez: dbus method call for switching endpoint
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sat, Dec 15, 2018 at 5:29 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Wednesday 11 July 2018 16:45:01 Pali Roh=C3=A1r wrote:
> > On Wednesday 11 July 2018 16:27:07 Luiz Augusto von Dentz wrote:
> > > One way to solve all of these is that we would expose the remote
> > > endpoints using MediaEndpoint1
> >
> > So client application (like pulseadio) would see list of remote
> > endpoints (one for each codec) and choose one for connection?
> >
> > Looks like this should solve this problem.
>
> Are there any progress on such API in bluez?
>
> On pulseaudio mailing list other people proposed patches for other A2DP
> codecs and basically bluez API for choosing A2DP codec is still missing
> part...

Im currenlty on vacation but will try to find time for that, that said
that shouldn't stop us to include support for other codecs, the last
set seems to have some sort of priority for ordering the registration
of the codecs.

> > > though only SelectConfiguration would
> > > be really useful here and that doesn't contain the remote capabilitie=
s
> > > that probably should be made into properties, along with codec type
> > > and uuid.
> >
> > Remote capabilities are needed. And for codec type =3D=3D vendor it is =
needed
> > to know also vendor id and codec id.
> >
> > > Besides a good headset would probably
> > > remember what codec you selected the last time and just connect with
> > > it, this btw is what I would do when operating as a sink.
> >
> > I hope that Linux would support also not-so-good headsets.
> >
> > Anyway, dual booting between systems which support different set of
> > codecs makes those "good headset" with remember support just
> > "no-so-good" one.
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
