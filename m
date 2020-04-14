Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DCBC2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 20:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D1A2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 20:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZcVo5Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633121AbgDNU2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633098AbgDNU2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 16:28:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA4C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 13:28:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d7so6573347oif.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oHLK6jbVxYzy/ZM8Uos9+t0W+iDGilP/t5XQ+FmCEoE=;
        b=aZcVo5XpjoYIgpepLN9t7xsYVXtNf+Y6vGt0efNUKWzACUT0mV2VcxpOLD9ja+5kB/
         USYaBxHHhX6uG+n4YSbvbc9Bid848/zDQylyPjHMSIQy5TFiYBMjGf+jMbCnTF5m23bF
         E00yMlf6rNHNkzUUELw9/1dF7WpR1JKv0q2aBKZyEwOYbaGI9JhF60t31ez5fn7A2UrD
         xv6uqeBx5nD23h1BeeK7EBAK5Ir/2+5SI1kI+X2+tYwL1ub2Bv27OY5Y73UEGaWBc3JV
         S2QDfbn98yAmZ7lVPEB+ImR/nXYAUAs4QMnhrtwxpaZSDSXEIf+wgvGeFzOsI6qzMSv5
         5Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oHLK6jbVxYzy/ZM8Uos9+t0W+iDGilP/t5XQ+FmCEoE=;
        b=lrwf9f+PTUYAvi0y9o4tPt7uG12CymTFsPXCVf//RycJrbtxHx1qIRv1peUZSdfkey
         EX62BaKe2vVY9CvUJ1jR7ztDZZiKiSPe4bmrqSwjcwKtkqoip3rVNZY2MeUzWZMbRb2b
         Rv5R5C7VltScpM+2GQw98HbSO0z/49RbBmfJQz+744MLlOB2ebd4kwy9aUcKwHEKIXMN
         DP735oOFaGOqsTQEB/lbTxMEbWQUCqnKTLnPRgCRJPC91z190Za3k66oSt/vzPYigg6R
         dH0J5yEJZFMvh8zSNP4bjzrcsksqr/jFEhsWmOZDhPkkohMF51SgdwEfyA+vRMNQDdBr
         kXVg==
X-Gm-Message-State: AGi0PuYepglK1cKqYyXKqU/GqpH9eimwIDATc1XjtO6uzahZdK+cH7Sv
        ifJTwQVJ9d7UsGe7JzaFloOR1BxMsoZONT7hDWA=
X-Google-Smtp-Source: APiQypJo+G9DUa0AOTg4t7e3tnvf+UberJxSNUVooAj9dKfttQBvseDuhbUm5/hwWOe2r7hevGrdpkd6EyDLWJaoBAQ=
X-Received: by 2002:aca:db8a:: with SMTP id s132mr6953867oig.110.1586896113014;
 Tue, 14 Apr 2020 13:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
 <CABBYNZLvuDMoFhFSFq50hnjG24DatsHDHNiN2axeC75fSmDRsw@mail.gmail.com> <20200414195334.cucssmdt3xj7lf2y@pali>
In-Reply-To: <20200414195334.cucssmdt3xj7lf2y@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Apr 2020 13:28:19 -0700
Message-ID: <CABBYNZ+BD2g35wWHocp25kK_s07y7Yec8+51pEv37bh3U-fR-Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] bluez: Export SDP "Remote audio volume control" item
 for HSP profile
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

Can you send a proper patch adding these, have you changed the code
already to use channel 7?

On Tue, Apr 14, 2020 at 12:53 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello Luiz!
>
> I have there another simple change for updating documentation:
>
> diff --git a/doc/profile-api.txt b/doc/profile-api.txt
> index ec18034a6..183c6c11a 100644
> --- a/doc/profile-api.txt
> +++ b/doc/profile-api.txt
> @@ -16,10 +16,33 @@ Object path /org/bluez
>                         If an application disconnects from the bus all
>                         its registered profiles will be removed.
>
> +                       Some predefined services:
> +
> +                       HFP AG UUID: 0000111f-0000-1000-8000-00805f9b34fb
> +
> +                               Default profile Version is 1.7, profile F=
eatures
> +                               is 0b001001 and RFCOMM channel is 13.
> +                               Authentication is required.
> +
>                         HFP HS UUID: 0000111e-0000-1000-8000-00805f9b34fb
>
> -                               Default RFCOMM channel is 6. And this req=
uires
> -                               authentication.
> +                               Default profile Version is 1.7, profile F=
eatures
> +                               is 0b000000 and RFCOMM channel is 7.
> +                               Authentication is required.
> +
> +                       HSP AG UUID: 00001112-0000-1000-8000-00805f9b34fb
> +
> +                               Default profile Version is 1.2, RFCOMM ch=
annel
> +                               is 12 and Authentication is required. Doe=
s not
> +                               support any Features, option is ignored.
> +
> +                       HSP HS UUID: 00001108-0000-1000-8000-00805f9b34fb
> +
> +                               Default profile Version is 1.2, profile F=
eatures
> +                               is 0b0 and RFCOMM channel is 6. Authentic=
ation
> +                               is required. Features is one bit value, s=
pecify
> +                               capability of Remote Audio Volume Control
> +                               (by default turned off).
>
>                         Available options:
>
>
>
> There is a mistake in documentation that default rfcomm channel for HFP
> HS profile is 6. But in reality default rfcomm channel for HFP is 7.
> Channel 6 is default for HSP HS profile as can be seen in src/profile.c.



--=20
Luiz Augusto von Dentz
