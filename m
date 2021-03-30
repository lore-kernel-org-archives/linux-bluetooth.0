Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B3C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B82619CF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhC3SFJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhC3SFC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:05:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A303C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:05:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so12266721pgs.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2y/E8RYsFniPamUDqDZkNnu90ddg/3Lyxcdg7vIsmWQ=;
        b=iz9A7lUvWCAuy+xOxLx3JugdXWay7ZOVjNZcW7dJFKqfMpFLAg5EhbnaCMCFGtrMXU
         gFwNXPT5Y7pXoFFamcRhnxY/h1Edf8R1RlhxBy2EkhPHDoXDxD8Qfst1fn5dgVjGTM8D
         Ba6dE0q/1Jt9uNb10kie6sF/M3MG3YEEzcfss7kR0RYJFE1FaKU0a1cjjR3V46h9MMqK
         VHtU4SB5TaUWfpEHLhHVs8PMvUsHACGz2Hs6gp245aIpg+sAupAMYUdsg+Z+eK1WC+oC
         /JzAXzQ2HPxf15H4dOB3oyUlGn180tIY3zFZ6QCGJidhJ4/gICITH/RvuaenQRy1gE2W
         66pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2y/E8RYsFniPamUDqDZkNnu90ddg/3Lyxcdg7vIsmWQ=;
        b=sdAHmMWljPoTNqe9VvqfIyvE24W9dnVBZgcJhM1y7x+2Qj87mG3ppc3CL/Cd/fhVdL
         NLFi1cBqyKRDyE2/Ivqtug33CI8IZ4sQH1E27YNetdQY+zdtnlasmVYskQLbd5aD1Htr
         eW/QehGqvAawWofuFXer/PIpLtX01FmumQXaYoBsPIZJwiTFnNRaECDbO8bBnbHJQCdx
         CCC0AyWRxO4iNrB15Sb4cibfaBbU/JkzEEAbZScIha8uZdDXYowUhaOVttjiT5pUwYO6
         Ihdl3C3BbqSFi7g6R/eQZ2qBKPk3XWP5ZxMDjRUMiPGZt0AD8ZTKzzv+pqik4bcYo4EO
         aizA==
X-Gm-Message-State: AOAM531TVklcn1DqViiONTfnpFpS2catRwDJjE8koxBPnhP1NhMuh24g
        ULcubH3l8z0F4oJ99nel2rN/25hZCCI=
X-Google-Smtp-Source: ABdhPJx8G5kiV7UWgfaHTtzNxVDzee3R109C0heOIYMF5q+KSgHZLYzp/yObMvSnkU+BxX4BJqVLyA==
X-Received: by 2002:a65:5289:: with SMTP id y9mr28496218pgp.447.1617127501540;
        Tue, 30 Mar 2021 11:05:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.191.65.149])
        by smtp.gmail.com with ESMTPSA id y9sm3134173pja.50.2021.03.30.11.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 11:05:01 -0700 (PDT)
Message-ID: <6063684d.1c69fb81.92ce9.74d9@mx.google.com>
Date:   Tue, 30 Mar 2021 11:05:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3448437139321631641=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] profiles/battery: Always update initial battery value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210330171137.17112-1-sonnysasaka@chromium.org>
References: <20210330171137.17112-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3448437139321631641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=458225

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============3448437139321631641==--
