Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00857C3DA6F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Aug 2023 18:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjHYSfF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHYSe4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 14:34:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB337210A
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 11:34:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so18705831fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692988492; x=1693593292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ZsEqa8HL0mzJwKckoVSEsL0e/JZ/vz94U9qah2WJo=;
        b=EMNew+zUyZnTXOIeJQIEMDh7a0aCnXoR0agrWBA5m3zo9vqwZd7QUsrImqPSFC3EGG
         uxrviqOtQ+DtfnlmWjXkihiiytaXuEYhDpe0S3vLN9JL5a7GvKrux/fdXHdKGV3HryTK
         rWC+H+4SL1zRMWqPaMn5K9mb37oNSUTZ0M9k8HJzxK8OFwdWH938RwTFCxbLABYPje2a
         SFwChUq6DZNumeERbh7wRNLOQje25/rQ3/DhO50cTjiVS5Jk9EGWt72epU6NSjpNzzIB
         ggsb0w/zlP0VRXKKgKzWYyJ6ILSiy+IMqJYOSb1iykoTZhwZL+s5GXuw4B8OFgmY0yr/
         y7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988492; x=1693593292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97ZsEqa8HL0mzJwKckoVSEsL0e/JZ/vz94U9qah2WJo=;
        b=OnBdlW5kLTBsd5/xzt+1drfeqXxwlFHvZMaX8z9FeWkE0zlr2dCGVHyRz4flI5VRGN
         3w9yHcfs6bBrcJNZR/pV92nnSExIw/k28NnMYrxN12aOoyEKA1W9MTbITAN0HYio0PX7
         K8PuYexTUoDw7hiZfR/fHD4qEXGlGC+UOhJRgUsihhfdWbcciuliPA4jO+qStSNjFpTF
         V712HzTvKPDVnQSv4VpuF3h2hRRj6At6ZLcoCb5VTSn6gQ5cbdU078gDngWbY9lu4Nwn
         QmPFxeUpuYmhfIKVbS+BEUUD6BPc/UFi/EH3ikF+HVcHV2xsvxKXXEvKvFzTZ5xZUkZK
         uvPQ==
X-Gm-Message-State: AOJu0YySzqREfidSaBn3DCuGxYkMeFPCqZTZsMiUpVcKO1BbUQRwkLVw
        bTxiuCJ+qfRzScVLbCeMKUtOc8ESZIqLpB16+kY=
X-Google-Smtp-Source: AGHT+IFg+jASWEorPNnVLYTuKrbPMIKOari4tsblLSpfH6CFoQYsDakRzDJ3a/w/Zc1Dm45TG0Elc5eFZmm+uji3gKc=
X-Received: by 2002:a2e:b049:0:b0:2bc:c38a:bd7c with SMTP id
 d9-20020a2eb049000000b002bcc38abd7cmr12271826ljl.33.1692988491492; Fri, 25
 Aug 2023 11:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230824212153.11050-1-luiz.dentz@gmail.com> <CABBYNZ+OcMjUsnJiehvnnAn-fZv+Tyy=ei3qWefJr4A3prSzbg@mail.gmail.com>
 <bb06322befebb5ce0164bc4b3cc5ee94e487f3ab.camel@iki.fi>
In-Reply-To: <bb06322befebb5ce0164bc4b3cc5ee94e487f3ab.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Aug 2023 11:34:39 -0700
Message-ID: <CABBYNZJxF5gKZ_LswfYsAJ-jW_uWw6Ty_VUx4jgahS+D78v4qQ@mail.gmail.com>
Subject: Re: [BlueZ RFC] media-api: Make QoS a single property
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org,
        Claudia Draghicescu <claudia.rosu@nxp.com>,
        iulia-tanasescu <iulia.tanasescu@nxp.com>,
        Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Aug 25, 2023 at 8:44=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-08-24 kello 14:28 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi,
> >
> > On Thu, Aug 24, 2023 at 2:21=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This moves QoS related propertis to a single dictionary.
> > > ---
> > >  doc/media-api.txt | 44 +++++++++++++++++++++-----------------------
> > >  1 file changed, 21 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > index 3a0ec38e244d..9f2482e73ac1 100644
> > > --- a/doc/media-api.txt
> > > +++ b/doc/media-api.txt
> > > @@ -816,42 +816,40 @@ Properties        object Device [readonly]
> > >                         Linked transport objects which the transport =
is
> > >                         associated with.
> > >
> > > -               byte CIG [ISO only, optional, experimental]
> > > +               dict QoS [ISO only, optional, experimental]
> > >
> > > -                       Indicates configured QoS CIG.
> > >                         Only present when QoS is configured.
> > >
> > > -               byte CIS [ISO only, optional, experimental]
> > > +                       Possible values for Unicast:
> > >
> > > -                       Indicates configured QoS CIS.
> > > -                       Only present when QoS is configured.
> > > +                       byte CIG
> > >
> > > -               uint32 Interval [ISO only, optional, experimental]
> > > +                               Indicates configured QoS CIG.
> > >
> > > -                       Indicates configured QoS interval.
> > > -                       Only present when QoS is configured.
> > > +                       byte CIS
> > >
> > > -               boolean Framing [ISO only, optional, experimental]
> > > +                               Only present when QoS is configured.
> > >
> > > -                       Indicates configured QoS framing.
> > > -                       Only present when QoS is configured.
> > > +                       uint32 Interval
> > >
> > > -               byte PHY [ISO only, optional, experimental]
> > > +                               Indicates configured QoS interval.
> > >
> > > -                       Indicates configured QoS PHY.
> > > -                       Only present when QoS is configured.
> > > +                       boolean Framing
>
> While we are breaking things, it would be useful to unify this API with
> SelectProperties/SetConfiguration, where PHY is string "1M" or "2M" not
> byte.
>
> Can we make it byte everywhere? I think the enum ultimately comes from
> Core spec, so not sure the string names are that useful.

Fair enough, there was already some feedback that it doesn't
correspond to the values when read to the socket, so yeah I will
change that was well.

> > >
> > > -               uint16 SDU [ISO only, optional, experimental]
> > > +                               Indicates configured QoS framing.
> > >
> > > -                       Indicates configured QoS SDU.
> > > -                       Only present when QoS is configured.
> > > +                       byte PHY
> > >
> > > -               byte Retransmissions [ISO only, optional, experimenta=
l]
> > > +                               Indicates configured QoS PHY.
> > >
> > > -                       Indicates configured QoS retransmissions.
> > > -                       Only present when QoS is configured.
> > > +                       uint16 SDU
> > >
> > > -               uint16 Latency [ISO only, optional, experimental]
> > > +                               Indicates configured QoS SDU.
> > >
> > > -                       Indicates configured QoS latency.
> > > -                       Only present when QoS is configured.
> > > +                       byte Retransmissions
> > > +
> > > +                               Indicates configured QoS retransmissi=
ons.
> > > +
> > > +                       uint16 Latency
> > > +
> > > +                               Indicates configured QoS latency.
> > > --
> > > 2.41.0
> >
> > Let me know if you have anything against doing these changes, this
> > will break backward compatibility but since they are still marked as
> > experimental we can still do these changes.
>
> I think it's fine if Pipewire targets BlueZ master branch as long as
> the feature is experimental.

We are planning to do a release first before starting to do these changes.

>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
