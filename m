Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B109ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 23:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIUXL3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIUXL1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 19:11:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F141A6C40
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 16:11:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u132so7501782pfc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+iPHYzw5U3tteYsFcxRJNb70mL7hiWZHq3g9bY69i64=;
        b=i+gToOLOtX9G2Z3LM+3ZwGcaEpus/VlccGhSCaJADFBan0qGLFh7xJC1xFdq/t9Fhq
         Qj6/NtbM5HxWAWPzmf4J2rV3LXltkPSel/RpxMd4e55ySLqfHNghr5PJc3//e/Jhagvj
         0RmCWM4GTOiGMEh9DKdZGbq4V+WuqeJIIjo43S4wygXnymVw95Z5HthKRF9JhsonFAt1
         AweOPMZUYU93TWLQmgsvsHhdIJTZf5CaFPGv3ULDCxdvVOa30brOsUyNedyaK6RdKn6G
         C1aN6pBQP7wqpHM+cH19BA3nklDG33sI35GVlgYooIk/xxApXyqWx8MzXZfwulO0RUfa
         LXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+iPHYzw5U3tteYsFcxRJNb70mL7hiWZHq3g9bY69i64=;
        b=J2YlE+RT4NehjjheKX/zgN5crT3qKX8LVA+wZK+mYGyssWQKaLVV9r//gWF0nfygQb
         Hmujs2eIK2VcytBGSGYOzMJOBxJDEat3j3u/50Gy5VnkVGK5KFByNGJeWHyM3rbX4ZIg
         mvVNSozM2b8TDrWvSn1qcpPsOhMTsyYQyu+XvTbKgJdt1zT1ACfhMEkRZkWaRnjIqUno
         09nrRJKKzjR6Mz1NokMHpcSVOuxvUob1xjnnQ9URXUsHocNCkAAqDlBgA4ndyXzf884d
         x6iRRjoZeWFxgZz12NKmSYf15+hgN2k3jyzfV139JaQC+v4SlH/D3fbPenFjgb/YxIPi
         3hrQ==
X-Gm-Message-State: ACrzQf0Mhen/oG6ImXZAc1Gh6X0qEaccQaQRGJu/6hK0Z9R9Ev6G2zWE
        PZHGnzE6k2udbBDTdpsP86c9ZzthSJc=
X-Google-Smtp-Source: AMsMyM4qfrfc5fF+jD+KrgIOPy4A541yWfBVvc8c+NRpa8JMOwdxTEGfPtGqnzC0bFmhRPscPL7KGg==
X-Received: by 2002:a05:6a00:1353:b0:541:5258:4e43 with SMTP id k19-20020a056a00135300b0054152584e43mr532464pfu.6.1663801886343;
        Wed, 21 Sep 2022 16:11:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.59.106.228])
        by smtp.gmail.com with ESMTPSA id e186-20020a621ec3000000b0053b2681b0e0sm2755964pfe.39.2022.09.21.16.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:11:26 -0700 (PDT)
Message-ID: <632b9a1e.620a0220.a4fe8.60dc@mx.google.com>
Date:   Wed, 21 Sep 2022 16:11:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4506799762901760476=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt: Fix scan-build warnings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220921215041.2243423-1-luiz.dentz@gmail.com>
References: <20220921215041.2243423-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4506799762901760476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679175

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      31.33 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      10.18 seconds
Build - Make                  PASS      925.33 seconds
Make Check                    PASS      12.18 seconds
Make Check w/Valgrind         PASS      333.67 seconds
Make Distcheck                PASS      282.86 seconds
Build w/ext ELL - Configure   PASS      10.16 seconds
Build w/ext ELL - Make        PASS      98.70 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   584.44 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
src/gatt-database.c:1138:10: warning: Value stored to 'bits' during its initialization is never read
        uint8_t bits[] = { BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING,
                ^~~~     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============4506799762901760476==--
