Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A46C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C6865086
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhCPOsE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbhCPOrm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:47:42 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9AC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:47:41 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f124so35440608qkj.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Sel7CjSYeFwM1NVKc2oM1wagHYrgnQg6O5n29S75XMo=;
        b=gAg+ro02aiJ6th2s0+6QNNtnbWRf48Ds4RQK1ODLN1WoGSSucrtX3xKRGRLsqXxWs1
         KK+CwxTm3dFd1v2HkBeObQGS8z+z6cuWnAs2hCgZJbrtgFt9VkAt8vh/Ybhjz/f4lBSF
         4YHKxNyHGFM2Vy7wmYTcQtDm39qZMY7rZWh+KH1e7IFWrLuQiJmteqDHRGrnw7bQZVY4
         Mry/ce3BxobKe63I/02a9RfExv2HNvePjeaRbCNijyNrwlgisNm7GpPesUMyyVCI0rQX
         +T4qnrLjFdPnkaqO4qA9EwJOV2s4XKqzntu2m2QZBTaPCwC1Ixxsd3af2hGoBhgSUqdK
         G1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Sel7CjSYeFwM1NVKc2oM1wagHYrgnQg6O5n29S75XMo=;
        b=mOhwRPpueZVBpiQBpNDMEhzDtS7FS6DWLuU+U9sOJXy+0HppnSqXjoP2oseTOXPVoS
         nGNDXmD+pkJZhEC+c/9S4Sm+1xFKeIfbzeuEr6grPsKRN9hCsCK6FImb3Cxbx2X4rACY
         0I+cOUIJ3Sk5SqfND+RibEOgw5YLKd0nMdODHjrBMBvaccu1nQaHRa16Jat2FxjjhM4l
         MCcAcxz9CyttQ264jBHlMbtZZjmm/Gs800lsdFiC7GEYV0iFsPNn1c78jYsP3a8NBN4z
         irI+iDowbCkHBlMhwQKobmCNQu02JlF88hb+gKTXsiay7Jt8xxrGGxpyflm1hzujOUqu
         GuMw==
X-Gm-Message-State: AOAM5326v42635bqgxci5I6FrapHL/VK5yZ4xd8GpVGZjRqQfn3FtHFo
        y8v6jVXuLGCKvHsVWtGMpQ4fNYiZhuA=
X-Google-Smtp-Source: ABdhPJxAs06RwCCeWH4fypnxKPUA+eV75JxXf0gyu+wGfY0d2vY3VUd/DzNSfYLYGLaKeZ1p2vPKJg==
X-Received: by 2002:ae9:f706:: with SMTP id s6mr31303969qkg.163.1615906061051;
        Tue, 16 Mar 2021 07:47:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.210.24])
        by smtp.gmail.com with ESMTPSA id x36sm7438756qtd.57.2021.03.16.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:47:40 -0700 (PDT)
Message-ID: <6050c50c.1c69fb81.f1274.1170@mx.google.com>
Date:   Tue, 16 Mar 2021 07:47:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5378611895247084722=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [Bluez,v2] android/handsfree: Fix g_timeout_add_seconds_full call
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316142844.23872-1-frederic.danis@collabora.com>
References: <20210316142844.23872-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5378611895247084722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449117

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


--===============5378611895247084722==--
