Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C937DC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 01:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D7021527
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 01:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDFhkfjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgKYBUC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgKYBUB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 20:20:01 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A49CC0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 17:20:00 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h19so785877otr.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 17:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNoO9Xjn0oaYZIiAyIFjyPPh97yVhlSmSPv1u5l0nYw=;
        b=dDFhkfjyLSnQie4HeXSUBEBHk3bsHxw/2eU/zl/uL8bAaIxmEfVoCXZ4zHGRW8ws/8
         1aNwoFHjGnhSnxPPvuecUwPJ93oqWpKvipa5rm3PNt8Jd1ut/yo/JZXVFsl/QJsaFHPY
         m8TfQEUG7zbdhU+Zh/8ztLUcdEjtR7N9BTMICK8mGQohvlnPUxU8++rCu4V4Utrzd0NK
         wHTq8F70ZWPgtzXy1Q78GN2iqaPpiaDu7x9o2AVF4L/ANNIuf9TRj2yGPYvkgDnYWQo2
         muZPWuH78XyoT/8DEnKzdbFWSixTYx8IJQaBl4EMdrEgReviFi8L2+z9wgGV1GYXPp9Z
         +SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNoO9Xjn0oaYZIiAyIFjyPPh97yVhlSmSPv1u5l0nYw=;
        b=PjdxzLaneU5LFsN9uPNEnAapR2cdG81RRylkuIOKGRo11tFD+W/L/MquW0J7lNSOdz
         AiwrJpjgh0rHxlXfpkuxCENL7uNjnMdYtHXEk5T2n5wXjzKiWAzFo+YluzWJ6thGxDPN
         jxFJuEM673Zk209wyU8UApK9271uJNT/q1PsxTkTEbd9BbLYM5EkuPj48g581cD9ojLY
         oh6C7H7JOuFuo4xey3slKc1BqmM2PkhEADhjIbKkMVt+gAo/x+sPmET460+vhfVYISph
         O9s1pRJq7Slp4v9lzH2uxZGxnayd8HFe1XUN5NP9zCUrwCDVVdmd1SM3iW3W8oY2AUej
         DU5w==
X-Gm-Message-State: AOAM533F6zo4SYGr5gpoPyh7mNZZhpiNTlV8fV5rqbsq2q2BsDahv8/f
        vu3XG3We99pauKi+qEV8UHqyZXdR/zm7oOS7qVwj+vdY
X-Google-Smtp-Source: ABdhPJwfgSTSOebInBhRPzyZVO+5dGfk1v/JRbC435qiBwJp8jRMxdOE6M1tXzma46YdO90Q2D1qtKpeG/D9oeQqmU8=
X-Received: by 2002:a05:6830:18f8:: with SMTP id d24mr1139326otf.44.1606267199393;
 Tue, 24 Nov 2020 17:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20201124224658.32605-1-rpigott@berkeley.edu> <5fbd9701.1c69fb81.12fae.4010@mx.google.com>
In-Reply-To: <5fbd9701.1c69fb81.12fae.4010@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Nov 2020 17:19:48 -0800
Message-ID: <CABBYNZ+PsG_8E_2j4_p7Qp==MyXKNnPOH=dGJc4T7wh18BNKvQ@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: use correct key for BREDR configuration
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Ronan Pigott <rpigott314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ronan,

On Tue, Nov 24, 2020 at 4:07 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390539
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.


-- 
Luiz Augusto von Dentz
