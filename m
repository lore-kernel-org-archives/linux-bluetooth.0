Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C45C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71DF6135F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEGWOq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 18:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEGWOi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 18:14:38 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66CC061761
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 May 2021 15:13:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 82so13811951yby.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 May 2021 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tP4rHvlfZR23oajz8appJQEH+NFAy+ACcrtoRe4S2U=;
        b=bWS2QVLiR0KSr72jnPbdFB8YiuGSLg0Qk9xryx89uPd/Qgt4Yhife/5fWx82SdpayK
         VE4VpVnns4plj1FnfCFSwmKSAO8p7687i6MqglBdZTKYYYVriLX031djL6U8VQSf+YBc
         sexRrH8H80eBVWm66nsoiaNn8vFHuuBjmLAgwV8azkHakwwYiR5VFUroD7IV7YMJhIkw
         r6YlTRt+oBNW42x51SVfcW5lfu3olrw/GT3VSQVN+XWk3ncXJXkzS1SgBXsvWup6CZXL
         FP+zJmkKDT2+gqtVXgvoVB9QbtoEzq9vIpb9OX2vjB4dHFJi0+u79lEJgCAaLJ9Atl82
         HxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tP4rHvlfZR23oajz8appJQEH+NFAy+ACcrtoRe4S2U=;
        b=GGUpdpRSxy3EI4u2gzTBOVhAnpkodFjM+zMw2Yz0kv8jQqo1RsfKRiXz3iGsEFNIx+
         taNbqqRYRT7Xhlq0lnVCC4M6Ck4x4fF+LJejCf1Gl1zSQE/CZY5n6RUoQXy0d0WnmTDZ
         qat/u1wGXNnzDGz19aRj+L5Wf7GnIAgQdjoD61DIU57mCt5iLV+/mz+FulcN0rS4r2RW
         RhLyTAiY4TtN5oLg3TRI6BEErXAc9XmX6d0oOTUYncf962dXzgmJrdKUfL1KBBfttUEH
         daKyMXnjbMFJZoVddwY1vOb2aGAf0t9GkVMxpY7rdQMmRYWdM9g486FPZQaA/xHJtdM6
         VKjA==
X-Gm-Message-State: AOAM530FIcQ2jJc8CSo6QFsIOkRDfIHi5TDEFsWsW0QQ1YDlXhiWt/nD
        nLYY2wT9HPK+h+nt/zw4Rm51Kf7mHnymlABqiCY=
X-Google-Smtp-Source: ABdhPJzcfY2hvejFTadJ7Zm+Iv3T2OAHYPwor0spKwCxVB7KE7OLLczTg9YMU9po/Bq0EKLQd9EPmy5roOpgaB8Qr1M=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr580800ybn.440.1620425616752;
 Fri, 07 May 2021 15:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210504111454.29697-1-sathish.narasimman@intel.com>
 <CABBYNZJX+YrpFyDotc5uZUQLc5P6LiR_F-7AmOa3bPq1m97L=w@mail.gmail.com> <CE33C971-7C6F-4D1E-9031-77FE07200038@holtmann.org>
In-Reply-To: <CE33C971-7C6F-4D1E-9031-77FE07200038@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 May 2021 15:13:25 -0700
Message-ID: <CABBYNZ+kQn-H7QSEieWdP=oTjb+m4NBP03i2VoUy5pcfx0UD8A@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] btmgmt: Fix enable adding irk when turining
 privacy on
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, May 7, 2021 at 1:26 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >> Unable to add the IRK in btmgmt when need to be updated. The option is
> >> enabled now.
> >>
> >> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> >> ---
> >> tools/btmgmt.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> >> index 02fec1dca184..bf3b460d0f04 100644
> >> --- a/tools/btmgmt.c
> >> +++ b/tools/btmgmt.c
> >> @@ -5277,7 +5277,7 @@ static const struct bt_shell_menu main_menu = {
> >>        cmd_advertising,                "Toggle LE advertising",        },
> >>        { "bredr",              "<on/off>",
> >>                cmd_bredr,              "Toggle BR/EDR support",        },
> >> -       { "privacy",            "<on/off>",
> >> +       { "privacy",            "<on/off> [irk]",
> >>                cmd_privacy,            "Toggle privacy support"        },
> >
> > I wonder why you didn't incorporate in the first parameter though
> > given that things like privacy off [irk] makes no send, or perhaps
> > have a dedicated command for setting the irk so it would persist
> > between privacy on/off.
>
> that is not how the kernel API works. If you want to enable Privacy, you need to also provide the IRK. We just simplified the tool to use /dev/urandom in case it is not provided.

Just to be clear I was suggesting to use a dedicated command for setting an irk:

> irk <value>

That way it is persisted, that way the tool remembers what was the
last set irk in case privacy needs to be toggled for some reason.


-- 
Luiz Augusto von Dentz
