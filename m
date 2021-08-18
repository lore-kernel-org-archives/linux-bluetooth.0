Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7CEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19CB60FE8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhHRXy3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhHRXy3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 19:54:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A5C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:53:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w17so8694202ybl.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IfUmmztXZ+1hnOSVKGsa0KtnYShGfrvwSEg7K/H2OI=;
        b=C1sm2x7bGGCxr+jpbxPJuva3IPjL+FSKdDk+Os/CCB0mNYC8Jssn4J2u2XbaSVa8cN
         0TXErky/rfbEe2ceLwWWOLVOtpDeKK5vNXxjv8MUf6XWQyHpHO57ACoEUIinQyghqFs3
         epxgICjsiSyevthUeM7JC12zNUfkDP8sVfW8LzO5+kPl9gTyMMkfpTJ4GZbuoVvMzsVz
         +GxT7IykEwGdv0/dnHUwqkAWDcv4y7WsKtwpcG2bC6ETcq4yGV0GdfdulW/rhBonWcrY
         abqxAX4/tPgLpQYRrR1qgWxr1C+nII4voV7cwKpcAr2P/0kG1IDCS7htVxJKpyxy9pub
         Zumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IfUmmztXZ+1hnOSVKGsa0KtnYShGfrvwSEg7K/H2OI=;
        b=O3n909SBW4wxm6+9tB7VBv4fFmtsuHXm9Ha9zk0dBgKTwCJo1MShXmF27HsYw67vmh
         T/HvCYMR5FuV1NOAJ1lstUTWl4RWHuhz2pDzbemHqA5RUtIWkbYhwicFXtE9NxoJyQzG
         rQMz3QU2/eJXxYZsczPZedARxULKSrHN9R9kPR1OPXytXWdlXReVDpEvcAmKcEJtiSGt
         ZhMdj26sjldRy+hBNjJsMkAoJvPXBuqaaCzLjIsi+I/Rqvn1IpKcHYb4KQOJBiDoxuy1
         LcFtoqmDlC5+MJdY4igd//LVI6lBBkyycsf51FJl/Xge3KCGDhg7e+kbS2fK0qaygs6Z
         sjLQ==
X-Gm-Message-State: AOAM533CmJ5khZ3ED9oiBROeUGGrknNWS+4VyoVHeHmShkwvV92r0MZM
        BODW2STZJf9Jm6UeoZk3lxrBHsJ7QxzwfD9ukgsfAnlC
X-Google-Smtp-Source: ABdhPJwcRdTsuRyxciEBD6Ja3WmkEKldi3DVq7q0D7FgsYt2KCL3fnb8g44RZMRljZs/58CmEnA65IsDjM/9Slu+PRo=
X-Received: by 2002:a25:be02:: with SMTP id h2mr15187837ybk.91.1629330832822;
 Wed, 18 Aug 2021 16:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210818055948.22616-1-kiran.k@intel.com> <611cac3b.1c69fb81.84b7c.51ac@mx.google.com>
In-Reply-To: <611cac3b.1c69fb81.84b7c.51ac@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 18 Aug 2021 16:53:41 -0700
Message-ID: <CABBYNZ+mdpx6BvL2eWskad6JipCOwNQb8L50DAavYLQu8f78Vw@mail.gmail.com>
Subject: Re: [v3,1/2] mgmt: Set offload codec mgmt feature
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Tue, Aug 17, 2021 at 11:48 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=533151
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.56 seconds
> GitLint                       PASS      0.25 seconds
> Prep - Setup ELL              PASS      48.34 seconds
> Build - Prep                  PASS      0.11 seconds
> Build - Configure             PASS      8.67 seconds
> Build - Make                  PASS      205.77 seconds
> Make Check                    PASS      9.70 seconds
> Make Distcheck                PASS      244.21 seconds
> Build w/ext ELL - Configure   PASS      8.30 seconds
> Build w/ext ELL - Make        PASS      194.59 seconds
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
