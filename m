Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 02:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B914A6112F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 02:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhIVCat (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhIVCas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 22:30:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F363C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 19:29:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d8so1350136qtd.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 19:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=920MyeQisbvfrHog9QQQJfSkpFAD9YDWaOvLAfWOHII=;
        b=hs1+GHhDvTvMnmPO1GkCn9e6AjVF2q2StvYOt1K3GwYGsyAyCXLgIwFYygHyJsfs34
         XayQ2s0PIhA/P2QUU1x/L53PM0P+fvgXqkrUOFFmLurH1o9pKq3V5UmaPSnkln87btSk
         3O+CIw3Zd2C15qEvqv1HJF2kpN+vqO/FlSbA2ZSeLbtx+oDRdeKBL53GKE7ZHQhOEFSe
         8BL0czbj1PZ2zm0u/h+/LiZZRlK6h+0f9tPT9QI8XKW+RIOGfjGDNw+Vr8nE1Mi79+5b
         FhnXujF1j9t8v0/Vv9VDY8OoarkbzWSyEGxpJQQ28fmaLjdrhMOjimLtRYoKGpMhhMfy
         DXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=920MyeQisbvfrHog9QQQJfSkpFAD9YDWaOvLAfWOHII=;
        b=u8bXQngmaVuErKOxO3vNJshv1rBx/aRRV0x94CANBz2Pfj55lCVA9ZqVMTScf++zv1
         cxdNPTaKPlz8HYbw6XwZrGc95rd3WMtnBM+rTv9Yb+yop/0P4a5hqqaLNfGnn8Wk6CdB
         rYNz88rSJDBPgr9qGtsb1qNgF6eH+vmQaiUsiKWUs+9uEiP7UcMexnq+sFYKdl4Trg3h
         aJ+LNEJz4CSfD6khQirJZMKF/dBEnmdluZhJ4MtLncKthdMpIrIJJSwxtKm09rwnWNL4
         WvqF+I5bHiUqsgxDQKT5djIdHBSOeW8+3/9bAH5MytDx6DKt0N/posYGSu8kOU2r0BK8
         xBvA==
X-Gm-Message-State: AOAM531omQD/1xoZ8bnzmMTEPCfk8s0VWQUGzrYIA/SzVpUt6Ys+FD/E
        jRTtG+9S3mksZVnXhk6/aL0waTxcaYwj/g==
X-Google-Smtp-Source: ABdhPJyC/KQ40/V4NYuBq+2DOVc4VdQaJ/iB7x0bGQkfcs/ofM/faKHsx8JLk4rn6YDzoQXKhlZsDw==
X-Received: by 2002:a05:622a:190a:: with SMTP id w10mr22907322qtc.300.1632277758513;
        Tue, 21 Sep 2021 19:29:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.7.206])
        by smtp.gmail.com with ESMTPSA id v3sm712926qkf.131.2021.09.21.19.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 19:29:17 -0700 (PDT)
Message-ID: <614a94fd.1c69fb81.e92c5.5267@mx.google.com>
Date:   Tue, 21 Sep 2021 19:29:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0253364985496911846=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v1] adv_monitor: Mark the device as lost on device_lost_timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210921181243.BlueZ.v1.1.I261f9c1ee78b90f81a6c323c23065615be917c33@changeid>
References: <20210921181243.BlueZ.v1.1.I261f9c1ee78b90f81a6c323c23065615be917c33@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0253364985496911846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=550651

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       FAIL      0.91 seconds
Prep - Setup ELL              PASS      42.64 seconds
Build - Prep                  PASS      0.53 seconds
Build - Configure             PASS      7.76 seconds
Build - Make                  PASS      190.42 seconds
Make Check                    PASS      9.55 seconds
Make Distcheck                PASS      218.16 seconds
Build w/ext ELL - Configure   PASS      7.83 seconds
Build w/ext ELL - Make        PASS      174.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v1] adv_monitor: Mark the device as lost on device_lost_timeout
2: B4 Second line is not empty: "again next time."




---
Regards,
Linux Bluetooth


--===============0253364985496911846==--
