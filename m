Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9B8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 21:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1291360EB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 21:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhGWVJo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVJn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 17:09:43 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4CC061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 14:50:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id w17so4413140ybl.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUxvpQv/3uJaUv61dWCLp+UJLwSZS9HAZ5GAfQUs4g8=;
        b=dY92e/GKf+AGAqHMmjSsyHK7tkX1xSsyVNtGphgSY8ImMzyrkZxaEwsBsTLRlbG4AT
         JFkBh7O5aCClUrB1+iDW9oqx41k9t1tQjUA6mBg4HGdO/CpR7w4GrLhsytSzFYRgBbTe
         Yee/doqP9HA6pryMOGPopZXh/5MBuKkVTFNlHmfqQSOavHMXMkiCrdtPXoI5jiKArBK/
         desogCRPH10PoxCZQSIYm/zxElUILRCxK3JUuxqIT7Rb2VZu/9HswIBJVquYD2KlrO21
         N5st3/5yNUvGRq3v1sb1wM5EDV3blLTLNdUW8SgbTuy2yd9Y+m4w/zz9XcRRBBnW7CDJ
         Vwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUxvpQv/3uJaUv61dWCLp+UJLwSZS9HAZ5GAfQUs4g8=;
        b=PnaJUGqfKBmtszbW5bx5z5n7WNwMGnBZo09bmCxgsBHWP+Caq5e2MX9vt0isJT93wv
         EfpM2cQyDkAiK3HQauSABLKXCnuBBTzs4YKaAW8wM8qqWVmShORrK0Q+eya3nHcV4xLu
         oAAp6yLAvF/Bj/1liefS6lHKzHk/iwgV3Ptut1hBItawBCu2nPTCm43+0m6Y43VLeu98
         0AWXLdcAP2BgNkyBgzHGrEkETK9K+28T/LG82JFWuuxkIIUTF73j5f793IBBUqKzdkeR
         IIfSw+sFKDnh6WCqBHjm8/vmNWH4db5kdQWdo8i930KltuNJ6Lb3C5+Vsg5NgZFXsdee
         HabQ==
X-Gm-Message-State: AOAM533I/cVkHBpdx3Xr+Y6Zj8keycTrBnrmMMVLf5QRpbYRKH1hnh9r
        qWnmaOerOQOVT9hExY7O6IFgshmnvqFdo6M7PE3BYWAo
X-Google-Smtp-Source: ABdhPJxIt/aN1Ts5gDi/reEOPDdli0CEeZfzzw+BV/xg1268xamZQavBbRWxptNflHChptJcUSId+H5jmyGN+cEKgSg=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr9610802ybu.282.1627077015083;
 Fri, 23 Jul 2021 14:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210723135824.8032-2-me@dylanvanassche.be> <60fad2fc.1c69fb81.4c2fc.785c@mx.google.com>
In-Reply-To: <60fad2fc.1c69fb81.4c2fc.785c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Jul 2021 14:50:04 -0700
Message-ID: <CABBYNZJKAAoCFyBy-6-9TggZU9Wu5wrRESkHbJAwXp8Gr1CxnQ@mail.gmail.com>
Subject: Re: obexd: phonebook-ebook: modernize
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     me@dylanvanassche.be
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dylan,

On Fri, Jul 23, 2021 at 7:33 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=520361
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.25 seconds
> GitLint                       PASS      0.38 seconds
> Prep - Setup ELL              PASS      36.63 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      6.37 seconds
> Build - Make                  PASS      159.94 seconds
> Make Check                    PASS      9.12 seconds
> Make Distcheck                PASS      195.35 seconds
> Build w/ext ELL - Configure   PASS      6.54 seconds
> Build w/ext ELL - Make        PASS      150.40 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
