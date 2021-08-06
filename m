Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A37BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75683611B0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhHFV5U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhHFV5U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:57:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438D0C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:57:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f12so10343015qkh.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sBGZs7RFfSVEJCjaAEW9FnN17eYWckKbRPEebkZo8xM=;
        b=I83aJBp5GiGCcJAvEMxekkFuu+iW2A1zdgzdY4O1DVq5ZN5eiS/ouG76Aek3DYlPOx
         I5tbp6sWYZCUedAOCSqBwkvzeUafc5xacGZAuPIev6hR8JJGULbzu4J6cB0ulvBhRRll
         fEdv8y7sdqkrQzb1bSb0s6hm2zwGT2L0PmcXUXuKxXPWynP/5UAkS4AOVWqmTiqXPgKb
         8ayvbzH/pP9dy6VYs9IBdhtloW6Z6MaNJStysTXzeQG6HyVw7q3Upg77kLvbZOY+S42P
         e2BcDi+RhfB5I3khwv3+Hv68vd63/5dZu2bizsfTFee71VrrwQfLy7WQ4PH70vlAeubs
         V05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sBGZs7RFfSVEJCjaAEW9FnN17eYWckKbRPEebkZo8xM=;
        b=N3yG6kPx0kFrVbjBW42ilU9P+Xyqq9Qs9GXhpwc3MfOs5ewxTzdCw1lLmlOu2XsrZ3
         NteIJ9es3pUteZPTpY71BoNRUg11JeoZJH8T22sO2OsO7huQtRWNkGMtDuHcoAFAs1u1
         Uk5DY2cXIJ+vVHq1aBYzm1XuBRrZvkJZ+khOqahOCcYvbzyK0uK6msDwxTi7rK8RxrRd
         pl+s7CRGjbqfkzwQlXHcADp6g1j5Asndcja8bS/cFX2zUqR+jU8+5M9czZjQBW5ekzPb
         UyBeTAZhq/41jPMCIQqP5z1ffbjufxojHJkzTUeLb7RqXt5JnbtHbTxemHw22nfnwi9H
         k2FQ==
X-Gm-Message-State: AOAM532UehQDsWy60Pxf3q/mZOzE2VDLkaWXFoM3om9OXTpmiaXvKodA
        pb13wKeKJntUilzsXOGpXn+CwHTT6szQog==
X-Google-Smtp-Source: ABdhPJwqzz6pXBvRsCKghuKBYgFA2rTTJ2BCPnojH37+P5jvVNhxztivAtxogSWrKFA/+ustRpoD7A==
X-Received: by 2002:ae9:e813:: with SMTP id a19mr12485546qkg.246.1628287023352;
        Fri, 06 Aug 2021 14:57:03 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.85.67])
        by smtp.gmail.com with ESMTPSA id b1sm4055137qtq.12.2021.08.06.14.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:57:02 -0700 (PDT)
Message-ID: <610db02e.1c69fb81.9030e.b7e0@mx.google.com>
Date:   Fri, 06 Aug 2021 14:57:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8559558478487710022=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] monitor: Fix median packet size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210806213558.16442-1-luiz.dentz@gmail.com>
References: <20210806213558.16442-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8559558478487710022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=527765

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.49 seconds
Prep - Setup ELL              PASS      47.25 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      8.43 seconds
Build - Make                  PASS      202.22 seconds
Make Check                    PASS      9.20 seconds
Make Distcheck                PASS      241.47 seconds
Build w/ext ELL - Configure   PASS      8.36 seconds
Build w/ext ELL - Make        PASS      196.00 seconds

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


--===============8559558478487710022==--
