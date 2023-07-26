Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8264C001DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 13:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjGZNNj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGZNNi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 09:13:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D6F7
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 06:13:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so66891185e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690377216; x=1690982016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6gSA5PL35AzkgCllg9cHuiAfjEjkZ8RQFxZz76TCO0=;
        b=XHQwUU3fmQTf+XPg9GkGulrIr+AKylO4P8i+rUVDFr9l6pRqhbFuwaJbRawr4fUPJc
         /WKolh+73Yjo3OR/3JK6i2gXK81vvCeca0pQxkJiIw8Tt0mMiPXKsTelUHhIKYggY4/x
         cKGt2xW0BQGGZPm7NxgyKvTSACx6rtX4XFEs6vwPaAqoM6UJ9Ug3vSF/ADmTOYDN2CFg
         6dD+6jIR2ov9U9WQHG6lgedeCK1/8ynNikDCivhD1KNfydbe97hlZFbX6IhE298uJECk
         QNv3bwUAL4/7Rbta+dRAK0tEceBmR8FDKrJ1Tci5CcBNa9U/Ijamey9nnlwSnFIHq7xx
         GriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377216; x=1690982016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6gSA5PL35AzkgCllg9cHuiAfjEjkZ8RQFxZz76TCO0=;
        b=hi77NFc5q8Uo1eN7SBq4Jdt5IyHHwe3f1Uq1o3qt4ZMPWslazenvqwx/Ty7qQ6t+zd
         qT+L/e1LyoXDMEG5ALKX2wFv2c5Qry8xg3kJDX6JJOT5euIORE2MRgsaN9qyyLLm2jsn
         HXrwJLv9+Ymf8tibczGcZZa5JMqXX8zzZdRMsWKWdlsZCk7oYhZPM24GsALifccOMYSF
         r/xffZRnn3qXLItQBFiMfENHcp4eJETNWEX/QEXZ8mVUB+xRc5NL0DpAQ9rTeFDXkfoS
         DfqfNE3SvvKO5Vr7Ck6bAH/DhmlKgTGQm8mgaiHaGUhnjhcb5YgurYFfdKLQxDFnOGph
         L/Mg==
X-Gm-Message-State: ABy/qLammHXSmEIQAm4jj+cmFvejDa41H7Qr7CZHked0Gs+w+TSRTMCR
        9lslH0oyBf3Rt2A6iAFTUzhrRXlBnfYYfZkqvqTewxWzQwqPgQ==
X-Google-Smtp-Source: APBJJlGjDdIKeA/gjeQ2wrxr1AMU+VPc/CZzfdSVrZpeIKl0PDj31l43iRvocjjhi01RTW2xAy7F4Re+wjZ2qc03vY8=
X-Received: by 2002:a5d:428e:0:b0:317:5de3:86fb with SMTP id
 k14-20020a5d428e000000b003175de386fbmr1297128wrq.10.1690377215635; Wed, 26
 Jul 2023 06:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvW=MyYArpr-bpiHkHjrqmkGsiSpMqyAivbMCLepV1HajyAzA@mail.gmail.com>
 <CABBYNZ+Keecvkfzf4+m+e3M5ohc6rGHrFs_wYEYzSV9fSt-aZA@mail.gmail.com>
In-Reply-To: <CABBYNZ+Keecvkfzf4+m+e3M5ohc6rGHrFs_wYEYzSV9fSt-aZA@mail.gmail.com>
From:   Stefnotch <brandmairstefan@gmail.com>
Date:   Wed, 26 Jul 2023 15:12:59 +0200
Message-ID: <CAAvW=MzR_h2sYxz-wRWeBoP1QoQGaP11sm+TrGxq5Drat7-uXg@mail.gmail.com>
Subject: Re: Bluetooth for hearing aids support (ASHA)
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

On Tue, Jul 25, 2023 at 8:07=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Stefnotch,
>
> On Tue, Jul 25, 2023 at 6:49=E2=80=AFAM Stefnotch <brandmairstefan@gmail.=
com> wrote:
> >
> > Hello
> >
> > I have hearing aids, which can be connected to devices that support
> > the Bluetooth ASHA protocol.
> > https://source.android.com/docs/core/connect/bluetooth/asha
> > That protocol is open and somewhat well documented. However, it is
> > only supported on Android devices at the moment. BlueZ on Linux does
> > not appear to support it.
> >
> > The idea is with Bluetooth ASHA, one can stream audio from a computer
> > directly to a pair of hearing aids. Without Bluetooth ASHA, I'm
> > limited to using a battery powered, clumsy accessory from Cochlear.
> >
> >  I was wondering if it would be worthwhile to support that in BlueZ.
> >
> > For the record, this has been requested in the past, but hasn't
> > progressed any further.
> > https://www.reddit.com/r/linuxquestions/comments/l54zku/accessibility_f=
or_the_deaf/
> > https://github.com/bluez/bluez/issues/481
>
> Don't think there is any objection to having support for ASHA, the
> problem is that most of the companies contributing to BlueZ are
> focusing on LE Audio which supersedes ASHA, so the challenge is to
> find someone to support this feature.
>
> --
> Luiz Augusto von Dentz

Glad to hear that I found the right place to ask about this. Do you
think it would be worthwhile to try to find someone to support this
feature, or is the Bluetooth team usually very short staffed?

From a user-perspective, I think that a number of existing hearing
aids support ASHA, and might never receive a firmware update for any
newer Bluetooth Audio Standards. For example, the Cochlear Nucleus 7
supports ASHA, however it has been superseded by the Cochlear Nucleus
8. I really don't know if companies have much incentive to update old
devices that many people rely on.
Considering the price tag on some of those hearing aids, I fear that
this ASHA support request might still be relevant in 10 years.

If it is indeed worthwhile to try and find someone to support this
feature, is there anything I could do to support this?

--
Stefnotch
