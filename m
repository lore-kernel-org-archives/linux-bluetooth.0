Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3515BC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 07:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCTHBt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCTHBr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 03:01:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C891B328
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 00:01:46 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id o14so5007282ioa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 00:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679295706;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=buZAIGg2Tful+9qJrTwxkT8LXVOaK4323/DfqIdXgKA=;
        b=XVodiLhzO4g8gVcn/eie9je+PaZfTle0BmrIRg7tglrPiZcsNjTMReZ30HnQsB3ap2
         g7TNmT5v8TmZgX8xwucq0xnWNzJTQKzWhZvQgMdKQKwSiB4Cuvm6l1PxKwVOJXYG43kH
         NVt9Bj6pg/sRDGVCZljm8tDvgNVwN2uGFGeJmEVtxUChpfscaOXR6ZLR0n2SVwO1M4L5
         o977C0bdmazMRVQn4c2ifU0voMZqxX0UxqQfIam46d5bxbUa3bBecndYrl8yje/cpsxJ
         E+u2EPobcNJTSsOZVjeaqVtxHyCUOZ2j10JEJMrjgAGrhdDtDEf4x2dGaifleELf0Wsj
         WVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679295706;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buZAIGg2Tful+9qJrTwxkT8LXVOaK4323/DfqIdXgKA=;
        b=2F/EjPGL58WkmSKur7H3pG2RHeOSZQSoc7b/ch0x+Xe/1k4unhXsTXKbxRmA/k0Xas
         ftRhfjBzmVWjJdeFl4AyyafhmXANER1S0o79Ihd21gnrqVUoang+OugNktaweCc6gWXJ
         tvgyDUr5h+lqJl2l8Zgs73p7szryp4H9YGwIIZbiELtCgWJaHIiYFy80LTTTc1roWrEY
         vOYfZDRfPj7tOW5CgmXeX/fT8Wntn2OAcLh5ecFejOHHs7SvDbEIQ1+tBLNgx/dZviWZ
         pr6wFhoXwz1ibKPr+iNNILp+p+4k8ihzSAMuo9VRbIQ4G//VowSVqKxbDFCAVUAmpdDi
         Aslg==
X-Gm-Message-State: AO0yUKVenEwNte9CBycUaE5xMD893yuXfuisBJggMLZHsD/wVvN5V5KE
        6aMhSs1p5IyKn/Z3Wgujvhgukdrtz5Y=
X-Google-Smtp-Source: AK7set/hkRl0wzqrSQOIoXFM+TAccbzp6a5L/qouHPAMBJjM2PBo+n7bq9B2t7wc55M3pW90esIvNQ==
X-Received: by 2002:a6b:c411:0:b0:74c:a578:e3a0 with SMTP id y17-20020a6bc411000000b0074ca578e3a0mr4268487ioa.5.1679295706046;
        Mon, 20 Mar 2023 00:01:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.28.134])
        by smtp.gmail.com with ESMTPSA id g33-20020a028524000000b00403d770399csm2992564jai.3.2023.03.20.00.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 00:01:45 -0700 (PDT)
Message-ID: <641804d9.020a0220.62a3d.4d4e@mx.google.com>
Date:   Mon, 20 Mar 2023 00:01:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1330309508058496041=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiasheng@iscas.ac.cn
Subject: RE: [1/2] Bluetooth: 6LoWPAN: Modify the error handling in the loop
In-Reply-To: <20230320063156.31047-1-jiasheng@iscas.ac.cn>
References: <20230320063156.31047-1-jiasheng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1330309508058496041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=731694

---Test result---

Test Summary:
CheckPatch                    PASS      1.19 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      31.55 seconds
CheckAllWarning               PASS      33.97 seconds
CheckSparse                   PASS      38.70 seconds
CheckSmatch                   PASS      107.11 seconds
BuildKernel32                 PASS      30.13 seconds
TestRunnerSetup               PASS      432.96 seconds
TestRunner_l2cap-tester       PASS      16.56 seconds
TestRunner_iso-tester         PASS      16.45 seconds
TestRunner_bnep-tester        PASS      5.35 seconds
TestRunner_mgmt-tester        PASS      107.41 seconds
TestRunner_rfcomm-tester      PASS      8.65 seconds
TestRunner_sco-tester         PASS      7.99 seconds
TestRunner_ioctl-tester       PASS      9.25 seconds
TestRunner_mesh-tester        PASS      6.81 seconds
TestRunner_smp-tester         PASS      7.76 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      33.26 seconds



---
Regards,
Linux Bluetooth


--===============1330309508058496041==--
