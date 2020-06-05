Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E694C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 11:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FCF206FA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoZJRBVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFELJk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgFELJj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 07:09:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0BC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 04:09:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n24so9662129ejd.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P8k8ZdOIifunvsrmegiPYMpeM8W/2y6H66fWsRcTZsU=;
        b=AoZJRBVKg6ex8aorUoRkGBNkqMV0FvVddH3jQ1ca9FxW1vnS8dbfFQaOcg4VM5XO70
         KAidZXTs+IetiqW478+9Q9KF3p6rcbLU5flul/Ce/R5WyngVzxu3GHEZg+jxsn3pvJ58
         QlGbxCS1rW+zuH8YiAv1ERGQc0i7np0n1rvXrE99TlGro7TIPv2YIFf2fv+WJiyTCfmF
         QvLljcAxYAou+9OmSFax7XCWSd65N2GPSSypLN3cbnJ1eKoKNuK/W6Cggbm2KzMhyktu
         pS9MvmSZRa70cTPeZgtBPJNyyC1l9mAG/Y9Iv+mP5Vy78a8l8UUi6WIdvV0U8RA+Ftx0
         9oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P8k8ZdOIifunvsrmegiPYMpeM8W/2y6H66fWsRcTZsU=;
        b=gY/FXXzF+Wh3qQRN3hDti/vfj7bn0Gfc2aioYn0nWpMjuIcBVYlINptDl+UhCtBwbM
         mAAgTANR5MfVQPtXf2Nb9Tld6rBDbfiducBEDIQ9maDQrxo3uLgcKRuQu03pqfr2PxmQ
         4iaSvk4OFn1bGKAM03vQwX+p8+fxTcHXJaxW5AxjZIYgTZWiriAVxkgUMrzzQGa1kGCn
         dGiJy+zxXPThnZy3Uk3w9J110Tihs1xKigG4FubhxMbVvhpUff1/6/vgEv+WbPllIplh
         06DqG+kAZ+b/AFP7Y1tujMDCwJhi/uyU9h667W7KGn+dYKOgDxfKMcnkthNTvN4c4jNb
         j2Gg==
X-Gm-Message-State: AOAM531fmBCohKTp/o1JS7aqHmyVCy89OLOKQ6ShRm6/4fuOwSvLyiDv
        wZy3Fu3PrS7cGRxyBLkM5cawEVjlR6UN9NR3kf8V+A==
X-Google-Smtp-Source: ABdhPJxCwBblHYjh8nAVVOHovgGW4V0SIYf4z45MXoMPpHq4psjJ23/HUWQ06I4LpvKS2yRcitc9CAahzZeoKXwdgWM=
X-Received: by 2002:a17:906:2e9a:: with SMTP id o26mr8013724eji.538.1591355377456;
 Fri, 05 Jun 2020 04:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPHZWUe9sLt8jsD57i3=PQxMfjODP7dUYLBm2qpSXFdgd9cvAQ@mail.gmail.com>
 <64A824C9-7C3C-4B08-8A9E-827121C4786D@holtmann.org> <CABBYNZJtgCNeZCYQ9tWno9qD9Vi2AaJNLH5TLxMtASHS-c+ySQ@mail.gmail.com>
In-Reply-To: <CABBYNZJtgCNeZCYQ9tWno9qD9Vi2AaJNLH5TLxMtASHS-c+ySQ@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Fri, 5 Jun 2020 19:09:25 +0800
Message-ID: <CAPHZWUd=t6icDXpz=td0teDoKHtE6FMH3OPE5R+BH53GOrXAdg@mail.gmail.com>
Subject: Re: Should we disable ERTM as default?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS BT Qualification <chromeos-bt-qual@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the responses!

I think it is more likely to be the PTS's limitations. I realized the
problem is in the media channel not in the signaling channel. PTS
wants to use streaming mode, but bluez rejects it, and then PTS aborts
the test. According to the MPS 1.0 Spec 6.2, L2CAP streaming mode is
the recommendation for optimization when using MPS media control
channels, so I think bluez doesn't do anything wrong during this test.

Thanks.

On Thu, Jun 4, 2020 at 3:52 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yun-hao,
>
> On Wed, Jun 3, 2020 at 10:43 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Yun-hao,
> >
> > > When I ran the following tests in PTS qualification on Chrome OS, I
> > > couldn=E2=80=99t pass all of them because they all failed to create a=
n AVDTP
> > > connection with channel type as =E2=80=98Streaming=E2=80=99 or =E2=80=
=98Enhanced
> > > Retransmission=E2=80=99.
> > >
> > > - MPS/AG-SRC-TG/HFAV/CLH/SD/BV-03-I
> > > - MPS/AG-SRC-TG/HFAV/CLH/SD/BV-04-I
> > > - MPS/AG-SRC-TG/HFAV/CLH/SD/BV-05-I
> > > - MPS/AG-SRC-TG/HFAV/CLH/SD/BV-06-I
> > >
> > > It looks like bluez doesn=E2=80=99t want to change its mode even thou=
gh it
> > > claims it supports them. Our question is do we still want to enable
> > > this feature as default?
>
> We don't use ERTM on AVDTP connections, in fact only AVRCP Browsing
> channel requires that but I guess you want low level testing of L2CAP
> parameters it more common to use l2test instead, or this does not come
> from L2CAP test spec?
>
> > I am a bit confused. So when you use the disable_ertm kernel parameters=
, these test pass? But ERTM is mandatory for AVRCP 1.3 and later.
> >
> > Are we sure that MPS test cases are correct? I mean, we never required =
ERTM for HFP since that is based on RFCOMM and ERTM is useless for RFCOMM.
> >
> > Regards
> >
> > Marcel
> >
>
>
> --
> Luiz Augusto von Dentz
