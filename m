Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F9CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 11:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85A360187
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 11:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhHDLbO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhHDLbN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 07:31:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7DC0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 04:31:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h27so1125460qtu.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UZ2Zv09MgWzyZqAt+L89RHQKTRwUUBSVPzOCQ21WS14=;
        b=iVRyODCFqOT2r6M7s83q1+6eWHX69zt0xlbgP1giS/gzBAoBfu9cv356kdHOvFC+Iw
         mQH2jBXzVhjeUFSSiVxrpD9scrMHr7xo2Hm0hkJ3CweNmTXkPTRyvyZkQaQZ5oMwViBH
         IB3hwdV+YcPQVEzR0LEQt1gTOs+PeheL16LXk9bxdA4Ug/Ze7dq/zttylfFBpIOdbYnv
         yc3HOcpUofnKO+aIVRk7htfmQgW4e/oPGYh+VVwdu1rLGVGl3hvIBoetv4rtzRpeceOD
         YNr+Xjzj2XP7gspfPOTx6v0QZxx3fVorhuludr6jRx43NdLJH0oCjq74Eh2o1GVZnVhx
         FHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UZ2Zv09MgWzyZqAt+L89RHQKTRwUUBSVPzOCQ21WS14=;
        b=fmOqlkeioeGktTcMc7IvTYKe7Z2qwkocc182c4JNVHFflEIefJ7fSE508stbZH2CyH
         5uCDY7z1TGtrXmMogXgl3DV0+ErbFYH1l0HEHF3QbHiKfEygfB38/hOp/NmHacFqTn7F
         jovFekmIoV8lVM+WtiSkNgg1f1RfBCKyBfZQwBIzxYt30TtnHD/x95ffdvWOSrGmnk0w
         LrJZO+kHrSZLg6k1WP2IThZ2Wk9bvDPvcDRrUqeKD3xuVKpnmlw3yod5RsHQKFEe7XPQ
         1nl4tNsV2QM/5fhYoHfyjuakQe0NONXhAhz8PrK3E4NkI5ezlNuZP2QPGsOgPxFRQk1y
         TX0A==
X-Gm-Message-State: AOAM53305aGkF8xCEdM/JNE9fxfRE96l48dK1U1N52xX6518wyKpZ9Ng
        v1FQjWVMSZIOX56idX+/1CGg3uQ9wcZy/w==
X-Google-Smtp-Source: ABdhPJx5xarA48K2u2JdvXBbeGWk0TdvvohWPcSje3j29LLsrOPCuSsPJj2oT+Px/qzTSrt+1SNjbw==
X-Received: by 2002:ac8:4799:: with SMTP id k25mr22517801qtq.333.1628076659550;
        Wed, 04 Aug 2021 04:30:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.166.16])
        by smtp.gmail.com with ESMTPSA id i24sm1130879qki.61.2021.08.04.04.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:30:59 -0700 (PDT)
Message-ID: <610a7a73.1c69fb81.b1ac4.5c79@mx.google.com>
Date:   Wed, 04 Aug 2021 04:30:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6728512688974777096=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mariusz.skamra@codecoup.pl
Subject: RE: [v2] monitor: Fix truncated server socket path parameter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210804105446.556937-1-mariusz.skamra@codecoup.pl>
References: <20210804105446.556937-1-mariusz.skamra@codecoup.pl>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6728512688974777096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=526191

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.73 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.15 seconds
Build - Make                  PASS      178.63 seconds
Make Check                    PASS      9.18 seconds
Make Distcheck                PASS      210.60 seconds
Build w/ext ELL - Configure   PASS      7.26 seconds
Build w/ext ELL - Make        PASS      168.20 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============6728512688974777096==--
