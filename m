Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC5C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 12:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AA62189E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZifXsYXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfGCMoh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:44:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44774 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCMoh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 08:44:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so1905044oib.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HUulj4iGse+VuxzoWrXa27W9vQmHvUNyvKyAgRRe7JA=;
        b=ZifXsYXGitIdnvSwcduQ3hp3Yn2R8Rhgg3E3zCpkbmxGCl/lA11lrQ8XhgtiJ1FfTY
         38uNywhKyEvfekKprJ5Wep0j8an7NkjRKmNouh7Xh4sasfws+3zKiuD+MmT0P3X3MRhb
         x5ErBlCezg9+aahyyCacBS8AoyeelmZjzUxshB859ZbfHohHI9469GAirXF51pl2xf94
         L53fUIeRHpGad0VcXE0MQQuxhBfBeq7ozPh1h1R0LHHuhNBYtnttpLUqNvTlHwOfS6Le
         EqNkIcvU5BKXbm1fZ1Q3m7cX+dJEmtJV4pRvGoumAQ+jP5dNcHvhnYUZjM6QRkMPSEIe
         gYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HUulj4iGse+VuxzoWrXa27W9vQmHvUNyvKyAgRRe7JA=;
        b=e9gRb+iRXfWVhBH2bl/V141u4MSsv3OSb06p1wzcDzjc9I+dQ1xOZRGKY0JtcojN2A
         xaiFiv36zVFYGdjS5ismceFRqTZamyVpAfb1vexZYvkeB0emiB24CtGPEFcwajWAwRwj
         Jz+t8TBUSZ22rPkbKwCKdEYQrARNrYCR6rQmvPeN8bgMO9wzs9MIZryjREqu1dh1gSCC
         2j/1RG3FibZG3EF3NNTdWKgolQThbGhdOILaB2mi2RjKqowqiwYmQGsfmD8ACm795ZRr
         8FgHhFpWTdW8YDl+wWXc5pIxdHQ1Gk1rPMm7VhsentdEk4cRMx/br2pOJhEBBs3uTxP9
         nfkw==
X-Gm-Message-State: APjAAAUVApK5GhuwM93s11efysKkcyeXUsv5nFP/oUfHAmJnUFZd8vLv
        jTYaPl2yjffHPO1kZ+NwqYjqU+4Dp2o7b7WQInBBqBWrKcnMKg==
X-Google-Smtp-Source: APXvYqxh/H56EEJayqVc/mWOHtS3FvsisCx8lG7TnHxFa/AILHukXsoBG6CxlJ5GjaMaGPgWMyO6YZIti6nVXLNc+Bc=
X-Received: by 2002:a05:6808:f:: with SMTP id u15mr6797006oic.21.1562157876440;
 Wed, 03 Jul 2019 05:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190619160320.kwumolq6sgetfuzf@pali> <20190703103902.2llvxp4nrmia2wkc@pali>
In-Reply-To: <20190703103902.2llvxp4nrmia2wkc@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jul 2019 15:44:24 +0300
Message-ID: <CABBYNZ+nKPBD7+keXqBy-yrwJqJ8kc3ovCxdhTpZQ7idphHdpg@mail.gmail.com>
Subject: Re: bluez: avctp_connect_cb(): BT_IO_OPT_IMTU for omtu?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Jul 3, 2019 at 1:39 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Wednesday 19 June 2019 18:03:20 Pali Roh=C3=A1r wrote:
> > Hello, in bluez source code is function avctp_connect_cb() with
> > following code:
> >
> >       bt_io_get(chan, &gerr,
> >                       BT_IO_OPT_DEST, &address,
> >                       BT_IO_OPT_IMTU, &imtu,
> >                       BT_IO_OPT_IMTU, &omtu,
> >                       BT_IO_OPT_INVALID);
> >
> > Why is BT_IO_OPT_IMTU used for retrieving omtu? Should not be there
> > BT_IO_OPT_OMTU for retrieving omtu? Seems like a typo: imtu vs omtu.
> >
> > Above code was introduced in commit b5666a3747 (AVCTP: Allocate memory
> > to hold incoming/outgoing PDUs).
>
> Hello, I would like to remind this question. It above code bluez correct?

Fixed:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Db2fd4c7e1ec=
f715a0f56e0a4534329db9b4e44b1

--=20
Luiz Augusto von Dentz
