Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D9C48BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9748613E3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFIWVf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhFIWVe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 18:21:34 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01649C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jun 2021 15:19:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g142so18387201ybf.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UHNRyuoUDlo8+u4eTSmc2c0bkzGdrMljaWklg3zocgM=;
        b=AQxJb/W7MjEKjq0qt7/4zSVCFkYEz4QFr2LsOADpD7qzoYRYu7OkIvdPtvkB7pLYFz
         wZTmoxMhP4dJXN3+hR1m0zxP6loPlvvLiEAyPmpekR8fiSBYyg4JRtDCB5Xh7gv1hvZI
         rkVk/DWFcXmvtIAxOdmHfAElPLPSS1drz+ZOzUUzEXAJEgLWgsTWKY5YioujYgN4iw1e
         UDcIMb9LAjF9IXJd6CPAFJSCD1+RtdSZrednmIk5PakGPJXzTE9PruK0CW9RaX/vGuMy
         N0YsUPgtnEHR7lEdgcsuzY2cy7M9A4/QpkDA96fQqahbO9klpNm24ae1egaR6XQRWH4I
         oc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UHNRyuoUDlo8+u4eTSmc2c0bkzGdrMljaWklg3zocgM=;
        b=KFFvCmKqrqgcm+Ass6EsTVKsfLOc5xMwt5aC/UZ6gk6Kj2Qdzc8SujSg4pUeQoLTa+
         MBPRq8MQzPlzVnN7XeUtmIb2WTp2OB8F6S+b9Itvk+4CX6NZzprxkAYxLljuEOx3Ey80
         kgmZAB35D4JeYc1JbmTqzrqhs+OPKlX4tAt4BJq0KPKe2WFbrT9QIZxVPF1GGobwKJy0
         5I65PpQmMbd8JbnTClMeNelrK1Xnt0pX+DDBgPY9obRm13J/4oxCy0UGBO5pC9ecor/8
         3ocLuvaIuNh49ezf2Bm0Tc42DMcI7XwNiYpUFO5aw2im+TOz2RUNeOXCIHmi1511gW9P
         LAew==
X-Gm-Message-State: AOAM531eltaoYhyuY/b0xFMbPPYBdHvNIYvmvCWfY85o6DFrfKsyZ98N
        zMLJjiAHksD4k3Z9sKssg7zv0/g96FvVXOYlUCq/C6lK
X-Google-Smtp-Source: ABdhPJxfExjAxCQhjvAnYy/oiNa9QT6+3AR8CJjvdxSbiW77mt4XR4vEzp2C9xJmveCy7+t33nBMOEJ6tfvqOveKIrA=
X-Received: by 2002:a25:4048:: with SMTP id n69mr3176062yba.91.1623277164002;
 Wed, 09 Jun 2021 15:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210609212411.288330-1-luiz.dentz@gmail.com> <60c13b1c.1c69fb81.d4b97.87f3@mx.google.com>
In-Reply-To: <60c13b1c.1c69fb81.d4b97.87f3@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Jun 2021 15:19:13 -0700
Message-ID: <CABBYNZ+UuwGnQkfwANu5gGFTsg-oFwFO3CpOMbwijFRiTfYriQ@mail.gmail.com>
Subject: Re: [BlueZ] mgmt-tester: Fix adding padding for Ext Adv (Scan
 Response) Data
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jun 9, 2021 at 3:05 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=497549
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.81 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      48.50 seconds
> Build - Prep                  PASS      0.16 seconds
> Build - Configure             PASS      8.46 seconds
> Build - Make                  PASS      210.61 seconds
> Make Check                    PASS      9.60 seconds
> Make Distcheck                PASS      245.58 seconds
> Build w/ext ELL - Configure   PASS      8.34 seconds
> Build w/ext ELL - Make        PASS      198.66 seconds
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

Pushed.

-- 
Luiz Augusto von Dentz
