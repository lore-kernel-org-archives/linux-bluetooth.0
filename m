Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6CFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 16:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347319AbiASQsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiASQsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 11:48:45 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B15C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 08:48:45 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q14so2530828qtx.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xB1P1hCtoFwFkS2KwphjR7Jx5raGK2UIXgw3QNeDU/0=;
        b=en31X1lNWXK7/0Sj57m3ngNTEaiYG3DKVZyF3lHEUQe767tNsSkjqJkjYAfWhZ0TNJ
         2D1z2JDDTRUBAzw/atpyXHfgGqSTZwQq1jZPTBeUCseE5Tbt1QhLQ1nT843PGTfikrPr
         VTZrnd6IGqKBXjtqosCvhybwK/uyfRXIsdLn/PIpi5182owoejPebURcfPw2JLxiX17b
         UWX99oepA57ObGRv7RPxjyto3C1/Csf2CBSpO6UiNmD4mrwoisvC+7aDy8HM9H0paGVB
         GjNDNHJ2nuYIo1VGpgprAc9XeQy1gISNOLaTxJ4jFUwC3Txz6DrCfb/h1A/gDLiXUDvA
         5F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xB1P1hCtoFwFkS2KwphjR7Jx5raGK2UIXgw3QNeDU/0=;
        b=FjxC98SkKT6ySsjY7YUyDALZiVrEMiNh6nlVmwEfYPfoN8zI9ucFrCR0xHuzoyQ81w
         nAfi9nke3kemknw7a8ZkCSNlNq9LyF9TRuSlrLEkhwmS8QCsAXuK+uTVIOuAHJO7R/AC
         jKkG58P0v4NDrokkkxEFm99lmsJ9tlF2BUppz+ufySgukW9t0/SJKw8VnxvXQzsVrAMd
         3+/i0ioli6wfxs6HnSxQr9h7vnu3ES8jGQAMuSeU0sWpfEgVjENPzbL5AElSsc9P05X2
         HDCuEeb5YsGUIXQ5J2j8/u66m5TJCaM5EALCr9jqAcHrcbUgLkkmWWoOjq+2cl28thRP
         uNGw==
X-Gm-Message-State: AOAM532PXH3x7z4WPUb4eiInJ/eTfnCcYmwD/Z6TXuwOD5gLg7ueRwVL
        gG3JRQKsK0iq3gAtZtsWz7J/aSHpfjinLg==
X-Google-Smtp-Source: ABdhPJwvZN99wpD/ntwE78s6wqOXCQCv0uIkgIcp+J5XnWhT4C/7SXl5SYpgHKfJjKxBjd5AGjQ5UQ==
X-Received: by 2002:ac8:5813:: with SMTP id g19mr25404555qtg.136.1642610924541;
        Wed, 19 Jan 2022 08:48:44 -0800 (PST)
Received: from [172.17.0.2] ([40.114.30.140])
        by smtp.gmail.com with ESMTPSA id y16sm22448qtw.4.2022.01.19.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:48:44 -0800 (PST)
Message-ID: <61e840ec.1c69fb81.39b7d.031b@mx.google.com>
Date:   Wed, 19 Jan 2022 08:48:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4271420155005237817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Fix sequence number of message in friend queue
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220119154931.182497-1-brian.gix@intel.com>
References: <20220119154931.182497-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4271420155005237817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=606649

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.95 seconds
Prep - Setup ELL              PASS      41.93 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.39 seconds
Build - Make                  PASS      1232.92 seconds
Make Check                    PASS      12.18 seconds
Make Check w/Valgrind         PASS      434.57 seconds
Make Distcheck                PASS      223.46 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      1212.99 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4271420155005237817==--
