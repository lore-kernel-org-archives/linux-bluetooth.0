Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C72C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443FE60F14
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhHFVvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbhHFVvB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:51:01 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB76C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:50:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z128so17619505ybc.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pF04pbC4e8nbmb2CdYPGz/jR+dK+l2Nsyp/N4BB/aaE=;
        b=r3H5skv8wK8tKe+6x+kptAgQgNX53bE2SX6Omn1n3woC2OjBlgZYEYU2pXZ5cdQ8TL
         /grENKh7YIMkoE4QxOjJQCUmQ2vWiEVu7gAWMhgYOoR+1cpNCX614nF1Am8NICV7Wsrc
         T11NLmapOIDbnf5URF0eVovk0EM1gc6THH2t4KcSnjWU2Ol7mR8IWtpGfE5GjRBWBbCq
         N8kQq48wnk6Z/iHAgZ5lal9OfsBL4+IDqJyPFFfHQyWF7sHLDjMGPPoelctNKdZfdTLi
         K7a3ftVaCIQ44dukFfha80Jt7jTcDV82ui0W27PKqP+52CYMBi+rFabdi8vrjFhxOgmu
         iuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pF04pbC4e8nbmb2CdYPGz/jR+dK+l2Nsyp/N4BB/aaE=;
        b=sFr4jBUCN2igOyAN+U2x3iGlAPYZDOqaqtt5/MijCgcS6pVOCuRET3pubQ8eLP+FQe
         ar+tzOlqhJSCXsOgUyifgc87iMlZF4/Oo/glRjP9CM3f5rt7P7q4i0ynyfM3iMTThYJ8
         bfmQdamIWTIUdPGbrgc3tiMAgYWtn8PH8N2w1ysFU8urVm7yBJMwMu5MyWe/MYhDkg+K
         7r5jUAfL/8pQDwE8ATzZlXlQAMQz6K+Qp00wpFDJxL38rrldBU7hfo2Wx8j9eF5QWE/W
         5p8oGcTWa1JRqNfNBQCKwu1/azsivu35unIGrrvGszJiqZ8rEQZ1k65ooISuMFcXKa84
         4Frg==
X-Gm-Message-State: AOAM532ufhNe9U4Wd2owqY+kBsFLmj9mZv9S+2SMwVGc438+dkK3VZg+
        s8PWGHRTixdnhyDd3p6sMLpN9ic9OpwVbQWs3k+UV+pj
X-Google-Smtp-Source: ABdhPJy4Wvp8/qqQWCTrMdnZUYXaQv/S4hQBBIrn+zADtBOjVNmVEGRFxri4hOPJEYhvygxz6QdOVYsC3zze6Fwe8kY=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr16635324ybu.282.1628286643336;
 Fri, 06 Aug 2021 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210804234858.345329-1-luiz.dentz@gmail.com> <610b3e41.1c69fb81.9fb5f.ee0b@mx.google.com>
In-Reply-To: <610b3e41.1c69fb81.9fb5f.ee0b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 6 Aug 2021 14:50:32 -0700
Message-ID: <CABBYNZKOFuyeeXjGwQ-PHxr70JciHmmNR3w+3mdZtd5XWxdsEA@mail.gmail.com>
Subject: Re: [BlueZ] btdev: Add proper handling for own_address_type 0x03
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Aug 4, 2021 at 6:26 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=526609
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.47 seconds
> GitLint                       PASS      0.12 seconds
> Prep - Setup ELL              PASS      45.58 seconds
> Build - Prep                  PASS      0.13 seconds
> Build - Configure             PASS      7.95 seconds
> Build - Make                  PASS      202.00 seconds
> Make Check                    PASS      9.33 seconds
> Make Distcheck                PASS      240.65 seconds
> Build w/ext ELL - Configure   PASS      8.38 seconds
> Build w/ext ELL - Make        PASS      193.00 seconds
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
