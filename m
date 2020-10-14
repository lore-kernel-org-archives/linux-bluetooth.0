Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB30C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC22C221EB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 17:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFbgA8vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgJNRPj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgJNRPj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 13:15:39 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDD6C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 10:15:39 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t77so4002965oie.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYJlbLCn4RUOQbx9X73Up8m3sYQR5mD46eL3gKN+c28=;
        b=bFbgA8vq4c9raBXnrKpyEdJQW6MXKClUpJ0bGqke6r1276ee7JzeU+85IvHqcV8CEM
         DP/i3G/ixkBNWaf0FDKNzTy2VPdMiPBJSy9Jszm8zyh3Z/92ISpSN0iNe9Gv6FQC5uvd
         rbjMnpACcHLeBVvMmTJFRnuFDkKcUvPQkT2cUQlM0crlaFl24P25RB15yrZaqb8CGlUd
         cwVb30/yOXABTulXYK+FYNb3IAFE+RYRCOBhfr9XDg1L25vkhKKTcnt4mSQBfwetBUYA
         i22xDa2vcRCv8+RNyYLxrSEyeNr9KVhSUbopXaHDJBKztFBZDjcr+pjmLMzQAsQtL83l
         Ljwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYJlbLCn4RUOQbx9X73Up8m3sYQR5mD46eL3gKN+c28=;
        b=NBCggMyVQimK/sIEpkz7tnrmbUEnyY09/UquPSxgZqcJ84TsDeiiWafBUdum+ISadB
         DZ0EZc5ZI4LqWL+Hej57CpeZ1xKkrb7ujaRFOjmIzCzz9/8+JwCMaskb2/juo75a+Pva
         IQ1NGzxRVI9mUq0hne5rkb8/07iuCSzSHl6XNHd9BAGDStTlERF/2mdrHUXNSVmxMMEb
         F/CqnWimB5/zQsW1sj/7pvjr+FEhoNN3GpN3d44+/1DVDihSTfX6ScT1p/VXlzTZn4Oq
         T0xiB0Mssk4FUjOig/Nwpg1G5c2dMCGpeqvHAy2iGjUc7cUo0d8pgNk7o47puQDl4/du
         zUgw==
X-Gm-Message-State: AOAM532B+ywP8L1OPwlSXghy59kLhV1jor2IOLAEWofMEZ3CtFoB9pNC
        8OjLmfe7gvnBDrXhWcNzC95hcfxlk5+r/LIFcAF0/ako
X-Google-Smtp-Source: ABdhPJxN82kSmKWSax+jZ5c31bmyxr2fFOaTEkCE+W9KDyEqZVpbFSqoRsbim6xdKQxnbCjhnA81tMCYypqTzcTBdIs=
X-Received: by 2002:aca:30d4:: with SMTP id w203mr238174oiw.64.1602695738182;
 Wed, 14 Oct 2020 10:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <333e38b3-da26-e3c6-76fb-1ee1caf90299@tcd.ie> <CABBYNZLFV6THotUuzATG0YJFgDh9cFoU575QqLD+Q2+EHoiPTA@mail.gmail.com>
 <6030b6bc-73f1-6fbd-e5c5-58e2ce4a5d26@tcd.ie>
In-Reply-To: <6030b6bc-73f1-6fbd-e5c5-58e2ce4a5d26@tcd.ie>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Oct 2020 10:15:26 -0700
Message-ID: <CABBYNZLMciCQP_f+e7EM1v=9eS3BAnP17gxYBUNCVE4KxO_8-Q@mail.gmail.com>
Subject: Re: Bose QC 35 Battery/ANC Support
To:     Peter Mullen <omaolaip@tcd.ie>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On Tue, Oct 13, 2020 at 10:06 PM Peter Mullen <omaolaip@tcd.ie> wrote:
>
> Hi Luiz,
>
> On 2020-10-12 9:43 a.m., Luiz Augusto von Dentz wrote:
> > Hi Peter,
> >
> > On Sun, Oct 11, 2020 at 1:04 PM Peter Mullen <omaolaip@tcd.ie> wrote:
> >>
> >> Hi all,
> >>
> >> I've been working on a plugin that adds support for battery level
> >> reporting and Active Noise Cancelling (ANC) control for the Bose QC 35
> >> headphones. The patch is nearly ready to go, but because of the
> >> non-standard way it's implemented I figured it might be necessary to get
> >> some preliminary feedback on it prior to submission (or to see if it's
> >> worth submitting).
> >>
> >> As a brief overview of device control, the QC35 has a set of additional
> >> controls operating over rfcomm channel 8 where messages are passed back
> >> and forth between devices. The messages consist of a 3-byte opcode, a
> >> 1-byte payload length, and N-bytes of payload. There's some more
> >> information on the specifics here:
> >> https://blog.davidventura.com.ar/reverse-engineering-the-bose-qc35-bluetooth-protocol.html
> >>
> >> As this is a non-standard "profile", there's no profile UUID assigned to
> >> it which makes adding a profile somewhat more complicated. My solution
> >> here was to add a profile under the iPod Accessory Protocol (iAP)
> >> profile UUID which the QC35 lists, and to then filter out devices in the
> >> profile probe callback based on manufacturer ID, device class, and
> >> product ID. This isn't ideal as the probe will be called for any device
> >> listing the iAP UUID, so suggestions for alternative approaches (if
> >> necessary) are appreciated.
> >
> > We could in possibly add pid/vid to btd_profile that way it can be
> > probed by pid/vid in addition to UUID, that way one can make a driver
> > that is specific to a vendor or a product.
> Had a go at that this evening as a proof-of-concept; so far it's working
> well, so this could be viable. I'll finish it off and test it out properly.
>
> >> For session state control, I've hooked into the AVDTP state-change
> >> callback. Again, possibly non-standard but this seemed to be the best
> >> way to trigger the initiatiation/tearing down of the rfcomm connection.
> >
> > I would recommend hooking to the btd_service state, like for example
> > the policy plugin is doing.
> I was able to get the plugin working based on the btd_service state cb,
> but had a couple of concerns with it, mainly because we'll be receiving
> events for all services on all devices, so the filtering of unused
> events adds a bit of overhead.
> I was also able to use the AVCTP state callback without issue, which may
> be better suited than the AVDTP one.

I guess we could add support for subscribing to state changes of a
specific service, that way you don't need to filter anything at the
plugin, how about that?

> >> For ANC integration, I've added a new dbus interface under
> >> "org.bluez.Anc1". The interface contains a read-only "Range" property,
> >> which indicates the number of discrete values the ANC can be set to, and
> >> a read-write property "Level" which gets/sets the level. This interface
> >> layout was chosen to be device agnostic, so that ANC support could
> >> potentially be added for more devices in future.
> >
> > I'd probably add Bose to the name of the interface if it is bose specific.
> While the plugin is Bose specific, I had tried to keep the interface
> itself generic so that integration with the DE or similar won't need any
> changes if ANC support is added for other devices later.
>
> --
> Peter Mullen



-- 
Luiz Augusto von Dentz
