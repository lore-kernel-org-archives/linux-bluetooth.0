Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9700C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 21:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5682247F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgLWV7R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWV7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Dec 2020 16:59:17 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4B5C06179C
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Dec 2020 13:58:37 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a109so364519otc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Dec 2020 13:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SJHcCgtgVVKt/Pej81EDgUd9SouQdOx+rpevAQbQuzA=;
        b=WzVc5Bt6jDncS7q2aOA2RVfn2pJxBlh4qsP2xkoP7mkLajHpyCilidvWKHTJRvlSCU
         XC2cE3coi4gaRRNyFfw7o0qE/d1id9Dv88J9lfiJGyTpzu0kkoloADoKo1r76VdboSnC
         KQT6F2sPXbMLwfw5m0ReLVosoe5fpiHt9Ycz/ek8z0rmjL8S3zFnxYwejXkttSJk10+b
         VqdbBCt3YHD/IG+iYPNkuRQWDQdpsTI2558aMv+97UJZo8coxw+FV0v+UllxYtSjS778
         Gg1Y/M5tnXX1J2HfNp3EqBfZWN0AeOvBLDkrmDpvZBxcV009BQyh5/9cXQzK2uJm4JXb
         7asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SJHcCgtgVVKt/Pej81EDgUd9SouQdOx+rpevAQbQuzA=;
        b=mifV/oDCyEft61gh9+QuQX5Fg3UVLNnYdV4s/2+PXBkT15S6bg/ZDxHNQ2suhC9Hgf
         LIws7xrV7v5N7IObcNvWYJ+Hw545nDEX1sd69DeWYTCKbA2jzPGXkXMrJYJTWkMvqbEB
         eIHX7Is/sFw1RfWNRpgiFCTTqdNSDwwS1Ja46B9lHIQQvuIPyIQu4Clh41hfG5eedyoO
         annEiuQNFGsS/eesWCvKQfYqhbWOeom8deF91pMe015BlUPDYt8c/EfIDuAP87dQ8J4K
         HiEx6HJp64P4+k06eFbYDM29bfM5KkvuWKetg+/0ACvJ4rMLIDkQ7/MB0wBKPTWGxME0
         Z3Bg==
X-Gm-Message-State: AOAM531ZsA7a+0i78QgpWmKKA44NDdWAbPoNA81ghS1eNj4TrTojHveS
        YduowPE2dMB00BrUXrH1Dy2AZj1DSF25+wk0VrA=
X-Google-Smtp-Source: ABdhPJwcfL79oqV8IN527PSBNqOZk/kpHsQR7aZugfmrFvPCIyq4Rb4dPeJTcaaitaPOWuvdlKYyGKIarD713oyGvt4=
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr21026241otq.371.1608760716666;
 Wed, 23 Dec 2020 13:58:36 -0800 (PST)
MIME-Version: 1.0
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <20201221210707.evrdeyiki45pivux@pali> <26db80417b43d919b6e33a4ee56c0e44a2f42a5c.camel@infinera.com>
 <20201223155624.uzbxfxtowenjrwm2@pali>
In-Reply-To: <20201223155624.uzbxfxtowenjrwm2@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Dec 2020 13:58:25 -0800
Message-ID: <CABBYNZK1kRCvhXnoMbskTYdoFUCOTSAdfUVqv3yftfp_G3NxFA@mail.gmail.com>
Subject: Re: Default to HW mSBC on capable controllers ?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali, Joakim,

On Wed, Dec 23, 2020 at 7:58 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 23 December 2020 15:41:01 Joakim Tjernlund wrote:
> > On Mon, 2020-12-21 at 22:07 +0100, Pali Roh=C3=A1r wrote:
> > > On Friday 18 December 2020 13:32:29 Joakim Tjernlund wrote:
> > > > There seems to be quite a few USB controllers gaining the BTUSB_WID=
EBAND_SPEECH which I guess means HW mSBC
> > >
> > > No, it does not mean mSBC.
> > >
> >
> > I forgot, if BTUSB_WIDEBAND_SPEECH does not mean capable of HW mSBC, wh=
at does it mean?
>
> BTUSB_WIDEBAND_SPEECH flag is just for usb bluetooth adapters. Not for
> UART or SDIO bluetooth adapters.
>
> It is a hint set for some bluetooth adapters which are on kernel
> whitelist that wideband speech support is possible for them.

Actually it is meant indicate to application that BT_PKT_STATUS can be
used which enables the implementation of PLC (Packet Loss
Concealment), Ive been advocating to change it or just remove it
entirely and move it to be queried with BT_PKT_STATUS.

> mSBC is not the only one codec which has wideband support.
>
> Based on current "whitelist" implementation it does not mean adapters
> without this hint are not mSBC capable (e.g. new adapters could not be
> on this list) and also there is a theoretical chance that some with this
> flag are not capable of mSBC. But this is only theoretical and I think
> you can say that BTUSB_WIDEBAND_SPEECH is sufficient for mSBC. But it is
> not necessary condition for mSBC (e.g. because of UART or SDIO adapters
> or adapters which are not whitelist yet).
>
> I hope to see AuriStream support which is also wideband speech codec but
> should work also with some adapters which are not able to provide enough
> bandwidth for mSBC.



--=20
Luiz Augusto von Dentz
