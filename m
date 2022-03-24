Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C390C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 23:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353028AbiCXXqc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355627AbiCXXqb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 19:46:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532EABB915
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 16:44:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so6681108pjq.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ObF7P8uKhQHxg0379sxaF4mKuMReFjSHG4IPd8gmEFw=;
        b=emjEyOmtlHxk4iimhYJh77qI3lefJPeP0/K2W64/YXPnEwayEolL01A2PFk/5w77Cr
         1Jz7i+2aDARk0ZdTJxrtRY9D9TAwlGBSbdRd3Wvv3RsPdMXa5sQGXcj6IbMhtsVE/PeQ
         IUhS9ZNeImiBCrQ3lueb1Sg2/NZz8cMB6fyHd7v9RBRmOvJziQ+aKPSRvnxMjlv8QU0r
         GbD3dGy4grCZc6xY8y+no261FuiWSQk4dtUi0qiwAILvouo+6Y53S0afcpqSRmNUygeZ
         6RT7vUtHaj//+r/d9v4HozFuiT6cWrNnJ/zTboXM87B4+hVcvwA5KGntK8jIbe7OgJMr
         TyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ObF7P8uKhQHxg0379sxaF4mKuMReFjSHG4IPd8gmEFw=;
        b=52CTrnC2406y2Y8bTuUiE2otwKRxIj9pGF7JbqN/wf6fBnRyF2pJeKYO8VhwGlHY+0
         Mar9b2y+aBnUQZBm2FpKsYUeq5lFN71qzjOIATo59sI2xff+dEQuf5wHjcjVVfCWjL61
         3N+ph7Q1tUlXCBXg8cKWvoX0s6CcHo5hA+gR/b5xD83f9ZEiAXcmCMvsdJFxjpN/ahqf
         mgvgI6F9AZur7ZUTrfPu93Uevjj2G/Inx2DzXp+nBQCE2KTE9GCgeYbp+9IwQnEwVGvu
         Gm/v2rR7AY3hLbZuk84KP3V4fBEcKTgOzFshHvYFIIUhi+4+8xsP0CUXnlSujfvbHfPE
         weiA==
X-Gm-Message-State: AOAM530pzV5bg+iwnQGH6dwjYU/qqFpF/z6KQVWbXdx2lN3yr2A/03jX
        owWDHrolPJ/dPokTtuU9YTUGRm8FmJc=
X-Google-Smtp-Source: ABdhPJztJc+B1z5P0y8jUYvUE9tKi8StpU+igNugFTI9Q4lEi7yLQiuoLwInPZ7SIaM19rBZ8GEpmg==
X-Received: by 2002:a17:90b:3908:b0:1c7:7a14:2083 with SMTP id ob8-20020a17090b390800b001c77a142083mr16174157pjb.230.1648165498646;
        Thu, 24 Mar 2022 16:44:58 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.16.254])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090aa40800b001c6ccb2c395sm3902676pjp.9.2022.03.24.16.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:44:58 -0700 (PDT)
Message-ID: <623d027a.1c69fb81.1c342.c1fe@mx.google.com>
Date:   Thu, 24 Mar 2022 16:44:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5485650607254804445=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] a2dp: Always invalidate the cache if its configuration fails
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220324221818.81338-1-luiz.dentz@gmail.com>
References: <20220324221818.81338-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5485650607254804445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626173

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.51 seconds
Prep - Setup ELL              PASS      54.69 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      10.80 seconds
Build - Make                  PASS      1880.84 seconds
Make Check                    PASS      12.88 seconds
Make Check w/Valgrind         PASS      571.74 seconds
Make Distcheck                PASS      301.33 seconds
Build w/ext ELL - Configure   PASS      10.99 seconds
Build w/ext ELL - Make        PASS      1833.37 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5485650607254804445==--
