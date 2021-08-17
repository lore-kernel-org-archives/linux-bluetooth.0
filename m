Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C74C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BC161019
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhHQXwi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbhHQXwf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 19:52:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E80C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:52:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z5so1713409ybj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yNPcfymF4HFO6cIGzRf0uFOfLBkV6ZbqTt+VHNpgeo=;
        b=hgO28caRqPHAtCc/FfthLhjQZscX8FUGi7AlAQ3lzb7FnoAKIURnBRk6Jj5mqVovEL
         CoShOQR4bT09fcdZwqpsaNQDR/vAAYFg4wP2KDpYFRsBlWPzPXPJrNxPE4/AnQbCSQqx
         aASA5ke1Yzvf3JEi6TswgsaqxWlNQz+NwVyax3d1I6EoAIVUmXiG8No/TYmihn6EqBp8
         dntg1ActWD6OemKwo/diRFbdwdFxlcMH3iW53z/PRO0OLu9Esns0ROUVgYuPQ7hxAXmQ
         jH2/UfXa1gPhrUwK/CW2DGhwNfuPl4Xu2WrQTN/X5DnKqpPrNear55vXskOjUK5IVyZk
         Wipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yNPcfymF4HFO6cIGzRf0uFOfLBkV6ZbqTt+VHNpgeo=;
        b=dLl2AgYPwdiqdbcyDFZIzJ+h+jDOnbeLYmvZ0MiwA/RXdV74JIk9VlkX39q44rd4aW
         p+wi+1RLyqT55me3KAiovAdCL7H3FVfImv19x9sPGgx1DL0XnY4xwmEuigk6nfT3AU3O
         I6jOI1R+vHnIs6LSU4u3XPzmxlXv0Z69Xg73Os5E3Mkt1G/M71HKHusyk0NW0V7cD8M5
         1Xfodmh0tH7SiokTPIZy87djc6bCvXdgjCxgg2U4EroCN0+I52ndDFJbApDY3r05UHFy
         WzwemOXUlzwlpd/r3BbUHuoY3/S81ghh3UrmwtgzQ1NfZYCSk5twttWuXmp5xGAQVbqt
         kdyQ==
X-Gm-Message-State: AOAM531nCcYq5+F0IrhS1RE8v00SUYzdbQT1RvOAfa7WemEP3p5KCNiY
        vIsJvP1v5jnYweTO1JmDQj4LZt+BpLm09FLz3EvexCkT
X-Google-Smtp-Source: ABdhPJyQqcedqvIb1Z5UJPtsevyfuo3eqrQc7Vs0vbypSndq6fpHGd+4EB49C9Cknkew1mGk3QvbXjjwkxDARsW5fOw=
X-Received: by 2002:a25:be02:: with SMTP id h2mr8004999ybk.91.1629244320873;
 Tue, 17 Aug 2021 16:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210817084941.22484-1-kiran.k@intel.com> <611b8394.1c69fb81.da430.3e1c@mx.google.com>
In-Reply-To: <611b8394.1c69fb81.da430.3e1c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Aug 2021 16:51:50 -0700
Message-ID: <CABBYNZLjM+-ubjM5jPyQtoFY_v82fea-vLBwzqHvZT93zbWWnw@mail.gmail.com>
Subject: Re: [v2] emulator: Add support enhanced SCO connection
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Tue, Aug 17, 2021 at 2:40 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=532611
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.37 seconds
> GitLint                       PASS      0.13 seconds
> Prep - Setup ELL              PASS      47.65 seconds
> Build - Prep                  PASS      0.12 seconds
> Build - Configure             PASS      8.57 seconds
> Build - Make                  PASS      209.92 seconds
> Make Check                    PASS      9.81 seconds
> Make Distcheck                PASS      246.03 seconds
> Build w/ext ELL - Configure   PASS      8.03 seconds
> Build w/ext ELL - Make        PASS      192.27 seconds
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
