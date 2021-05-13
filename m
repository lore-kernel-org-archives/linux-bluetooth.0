Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54083C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6060725
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 20:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhEMU2H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhEMU2G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 16:28:06 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EAEC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 13:26:55 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q144so3990428ybq.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Qnxl9TVkkFUbHxonFK709IMbzSuvUJZ7KVYBleqyd/o=;
        b=m5RgY7Z41W60jBsr7OuzdME4f2uJFgsUeZ14Xcf+yDGx04XkOUT4gR5gSR6sXwEGXo
         MyvpSmfFRurkHwCweCwHftnUZJ33UDZu1MLUeDO1so7BQs7OPIHIQyyAFnMu+uFgUpsf
         2t2Fg5AIoodQMxDL45p8tJ2BSzlc52F3MzVNkqtCipVYGj9ryFptVUkLEZ8rGCA8kWyM
         QUYz9qgTkKlIuULyJV1IhsGFx3CZpZbCG1lT6tvH5qqZ8A8B4ODIsSm7YfKwuHlqgm6T
         r9TYqdWj9EhZbWxn7zW9JV2/9QV9cyloGGC1cSJuQ/3wQTouDwcOdqNCwnITi+c/sFdY
         4fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Qnxl9TVkkFUbHxonFK709IMbzSuvUJZ7KVYBleqyd/o=;
        b=HFImJwAjCNQHmGM2rtqFePLaZlxuCidQEvJScclFULxtDckEfkMTgH38YepgDhunsX
         6XtEYC9Jbw9onwMcs2aZJgOzTLh06rNU63yW2h7HaXqnHwig6n9ggPztZMfQggXqtdpR
         REi5gQIARB5Mv0ba4M7c8yd5PcbXG7Xqq/xUbNF/MdIepSDp7QepFuLbol+bRt3iRDAI
         TmgdfC7TPhg5P1ImQiTEksH3qgyXnZBezHS8ZD1YEvA97Q3Ly2AaQOuDiHhHqvKpUnN7
         oI4wRw4k3/VtHeTlzA3CRYwc6hEhC7HebdIo0imD1B66p5rKx2s/FJ9oOVQqjUGvAmWZ
         ZBSA==
X-Gm-Message-State: AOAM530KC6VskqMgCH8AZ6ap0PcJlD+8C3mxjiZ7RoryJAmGZE+dcHTz
        S7h9wMhbkB29W0D9+WGtpiukwKhaHxA2UILSGzRRf2B1
X-Google-Smtp-Source: ABdhPJxQyPPZQPh5E1XHjzNCzvMtq4IaSbwkqrpiq6eOBnkQVkZDL726h7dgcCyh0h59tcgB03C8OlPYA4BHVfjfFkQ=
X-Received: by 2002:a25:a466:: with SMTP id f93mr59146552ybi.264.1620937614859;
 Thu, 13 May 2021 13:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210513003428.2576827-1-luiz.dentz@gmail.com> <609c850a.1c69fb81.6aa5b.3d78@mx.google.com>
In-Reply-To: <609c850a.1c69fb81.6aa5b.3d78@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 May 2021 13:26:44 -0700
Message-ID: <CABBYNZ+r16wR1R9VZ2snLpY1F_rrnz8T53qtseo9UzSTB43tJQ@mail.gmail.com>
Subject: Re: [BlueZ] client/advertising: Add support for setting min/max intervals
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, May 12, 2021 at 6:46 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=481575
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.87 seconds
> GitLint                       PASS      0.15 seconds
> Prep - Setup ELL              PASS      52.17 seconds
> Build - Prep                  PASS      0.15 seconds
> Build - Configure             PASS      8.90 seconds
> Build - Make                  PASS      223.46 seconds
> Make Check                    PASS      9.53 seconds
> Make Distcheck                PASS      261.17 seconds
> Build w/ext ELL - Configure   PASS      9.00 seconds
> Build w/ext ELL - Make        PASS      210.86 seconds
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
