Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2FBECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 21:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbiHYVJE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbiHYVJD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 17:09:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB8A656A
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:09:02 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i77so16996887ioa.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=efshHXP9gUX/Rn2HlD2fKyMPwbh7W1J65YmfnAc5BPk=;
        b=E2RzTGX33BG9Hf6a1lmpICDPAhZIXT3B6JZwUveL0PO7wr8sJvNIJkAXcwexXKtqTL
         np86gAzO1AR5dOu0Ucgash3S2IdXj0sqKUPVtYygCKdLPrky5A70G+Dc9kdYZ/0hXYTv
         Gbm8iRVFmHIFRf3/iebhpu/ecEWLDp1estyzHAPD/uRkxdKtAQJsQYKko1OYVwvC4e4y
         pJmrTj3H5uxD9YXAGBux7iCCkrgL9sA3H1l1aFTLyLtiBz7LLfcJ3yQQ5k/JceYYhMZg
         ddt/NrP+6Y4jAyamUFBdpOwjc5VbmYdvwTJXk4zCB2KQDvGPRVMlaScn9vwxS+VmmJbq
         w1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=efshHXP9gUX/Rn2HlD2fKyMPwbh7W1J65YmfnAc5BPk=;
        b=aJkqmU287EdLMMc+xgf5LP+mUb+/Yxgw4nI2q8lrH74l/6smFPU1A8Mi9jNq1N8lJF
         daTjOBEdlznHy+PPcEUDJgOZRE2K0p635gHlDdpDwwIxAQKSUV2AInvWSY1RhgQ5toFy
         ZX0UPLo5vvaC+/Nt7D9zFRIrTQ/ODPHKk54RHnrit3CvROxZPE9xaIM/bsC2AGNv9IH3
         n/PF2l1tvUWepDDG3dND96NIDeXwgNKiHFhrWH/RkGrB9f4Uh6ESfdnxgTIsRLxxao1x
         AuD3pBtMqUbtVZLOZ4hcmq/lHspdn71j9Hq89nbrRoxnE4G2VSjK4fk8xm8/2C4G3OaW
         WSzw==
X-Gm-Message-State: ACgBeo0KgUsc9kahxnBXdzIy/L1xtxbEOjNvcwyUNA5uZtP4o6r6rBNc
        LMQ7cCkWZrawwy44ChfN57zfUCp32J2hkQ==
X-Google-Smtp-Source: AA6agR5O2luzSoqfykxSpAX+GBfV4MPHIivdO0GjoNYrdv1VPUf7OSH1lDDjdCdg+5VfmZSZw3FMew==
X-Received: by 2002:a05:6638:13d2:b0:346:e0b8:ba2b with SMTP id i18-20020a05663813d200b00346e0b8ba2bmr2770406jaj.268.1661461741443;
        Thu, 25 Aug 2022 14:09:01 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.105.81])
        by smtp.gmail.com with ESMTPSA id q1-20020a056638344100b0034347c6183esm163243jav.92.2022.08.25.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:09:01 -0700 (PDT)
Message-ID: <6307e4ed.050a0220.cbc81.04b4@mx.google.com>
Date:   Thu, 25 Aug 2022 14:09:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3763367485982185162=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] gatt-api: Add error code ReadValue/WriteValue
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220825200758.1645136-1-luiz.dentz@gmail.com>
References: <20220825200758.1645136-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3763367485982185162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=671211

---Test result---

Test Summary:
CheckPatch                    PASS      2.27 seconds
GitLint                       PASS      1.61 seconds
Prep - Setup ELL              PASS      26.73 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      8.39 seconds
Build - Make                  PASS      969.49 seconds
Make Check                    PASS      11.87 seconds
Make Check w/Valgrind         PASS      286.82 seconds
Make Distcheck                PASS      235.16 seconds
Build w/ext ELL - Configure   PASS      8.64 seconds
Build w/ext ELL - Make        PASS      82.00 seconds
Incremental Build w/ patches  PASS      194.44 seconds
Scan Build                    WARNING   491.96 seconds

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
src/gatt-database.c:3535:14: warning: Value stored to 'iface' during its initialization is never read
        const char *iface = g_dbus_proxy_get_interface(proxy);
                    ^~~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/gatt-database.c:3536:14: warning: Value stored to 'path' during its initialization is never read
        const char *path = g_dbus_proxy_get_path(proxy);
                    ^~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.




---
Regards,
Linux Bluetooth


--===============3763367485982185162==--
