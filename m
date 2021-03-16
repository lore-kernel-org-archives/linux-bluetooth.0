Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1132C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6389664DF0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhCPVd4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCPVdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 17:33:53 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985AC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 14:33:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r14so12793433qtt.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=K3KbB3KcKHUE4EJhTTiz7Y++zJMCLTF/H5Ha8WDqRBQ=;
        b=Xer15MdyXIDpVa0RlSxn6eGML8lrp1Y4TZFKO3bf5NpRm1l/pRtofYJaqkyy6MK7yL
         cV1uwNAMfce+oSxsmoJEDkNAfvgtQwutlSgPcSFDY6rkYCmucMFnuX/EFoSaUJ++0VSe
         +K0pdagM8FDO3Url7z77aworTmGbh5BKWt3ktwAOpHoXYYk4ZtUI7XnLpL3VhF8lt1OM
         ZnLOgY4m8k6aYHo1bD5SoMxy9AdMsoTopDJu2J1Wp/w+BBA+g21wQiXgIQwLRYaPXJVr
         zv0YBVRDD35StL3ysix/j40bNqQko3EJy68CTfEc/pEZYi5gedPrHxBye9v4B1NPo+r1
         +Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=K3KbB3KcKHUE4EJhTTiz7Y++zJMCLTF/H5Ha8WDqRBQ=;
        b=HVH2FavcoDb44YcG+M/sJJy9yOm9LWLtpt32/J/JDfsewERlpGlCdaeJdXE768zfCj
         2rJCEXuAw8wZdO7mb04pYDZAi5HaDIOco/tMJD1jekHs2bjxO094JiRIHdGg5AQPhtGT
         vf8mrEdhuWs/YPYsXI4AuEJBmbXywx41IM3vefrq5zK/GYkO+wnmaKHm3HZ4yfoubl2k
         EUVy+14+YGS6cVvOYzL/ewVo/d7Oo3c4d87dmZIR4ROz1cFumsr1aPCz7Pp8rlGPX7Ct
         07aSh7EwZEwcef8u/CNbitr2rmk4LXj+uL/YEMlAkoDw6Q642KFvFtV9/4POKetw7A5i
         4k5w==
X-Gm-Message-State: AOAM532rfoLgSxuM3TmwBglAHeQETmccP6SoNy6A7IKaw1i/qRKxVK8Z
        4UEM1rs03zB1yRhYzld4XUVV4kd7ajg=
X-Google-Smtp-Source: ABdhPJw7H1/MUWMK04QQRPxaDKmjiFQBGRH0KzsF73V/LjyDvcnrClqWouHwL26rawtVgTekOgHeMQ==
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr904070qtr.258.1615930432050;
        Tue, 16 Mar 2021 14:33:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.147.165.42])
        by smtp.gmail.com with ESMTPSA id 75sm15663990qkj.134.2021.03.16.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:33:51 -0700 (PDT)
Message-ID: <6051243f.1c69fb81.f89b0.6255@mx.google.com>
Date:   Tue, 16 Mar 2021 14:33:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1807425321089676293=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] build: Fix build with latest tree
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316205838.2164464-1-luiz.dentz@gmail.com>
References: <20210316205838.2164464-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1807425321089676293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449519

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1807425321089676293==--
