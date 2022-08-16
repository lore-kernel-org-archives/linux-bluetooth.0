Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E2FC25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 19:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiHPT7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiHPT7O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 15:59:14 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191697C18B
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 12:59:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n133so13242432oib.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=hdnhjlRtaCk4D1FkNmTDvRTPyTO8XoSoMi7KA2cA7oM=;
        b=kzqxJmNMAN3N1Lah6SAkEIjnK77sXL27CnGLaxN72mzReiESA2S7yF5kC+ey2LKAQ8
         5eaPVnEbr0WvW/est5BI286QU2ukvKxm0nv1Wgz32yW05yVFgO8ZGRLkfha/gAaDfVid
         KwK3yZ5DfqAgq3bNyh3uJLf7ojNJ6g5NH9lcbPWo1+xn0vJq/HBdY3MFsOIX8BASDKqU
         m+uFTEJaplEpFajOY20FCJIHXGD6ferNCK6L+2aC4YHdImR4IJS3m1lR2uUlLBUg3pzs
         Yf+CoHEvB7byyZnbEL8QpU9Hq6usTZXe7996M78El2tdsdLvzOi0oIu5bRcl7twOz/JM
         H0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=hdnhjlRtaCk4D1FkNmTDvRTPyTO8XoSoMi7KA2cA7oM=;
        b=rPP6sBBFd6AgYNRkqo628+2YRDE2g+94xybmySlbTKTp+yvbxJvblRISHbGXCRpral
         O2sDg4GEcEoT07LGClVpsw3Tfnx31cNZ/QEEA7PrDlVpeUI/6tSac9JTuPR0X5kGlPMI
         rQn3jKFFFCA0xghRSdmIiPb6PMV0oBxb0oaVNDZMwkMQw06Kzz851d9uSqbiuhsObCIr
         VYau20eILswBH51K1ken1DfV6DVpOS79MHzHMX6E2SlbX2fiX3IJfjyK88+jgUc8COQa
         y0ryS0N+dXmlt24TPZ3H7NUG1p9Va419H4PfReKSbD29zq9yX4fJQ2pBiF8hlf6zCh0j
         BlfQ==
X-Gm-Message-State: ACgBeo11tPm1wu4frCbZlOroGWynmCczW4RFbL7iL+UIj8QXDcgHzgmh
        i4a6TTUWzASzHEGcCp5ToPnnzg8qFKk=
X-Google-Smtp-Source: AA6agR4n5QrHvBntA32aiYa5rtIwJ/dZFVzILOHuSbQpRT68SJUSfhxyMmvzhWnTFFGTszHPKfGTFg==
X-Received: by 2002:a05:6808:1483:b0:344:ac63:b87a with SMTP id e3-20020a056808148300b00344ac63b87amr92620oiw.104.1660679952268;
        Tue, 16 Aug 2022 12:59:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.15.38])
        by smtp.gmail.com with ESMTPSA id g10-20020a056870d20a00b0011856117469sm2275864oac.10.2022.08.16.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:59:12 -0700 (PDT)
Message-ID: <62fbf710.050a0220.64224.8dc4@mx.google.com>
Date:   Tue, 16 Aug 2022 12:59:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1205759789054470854=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] hog-lib: Don't restrict Report MAP size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220816191144.1515498-1-luiz.dentz@gmail.com>
References: <20220816191144.1515498-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1205759789054470854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668191

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.77 seconds
Prep - Setup ELL              PASS      30.64 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      9.49 seconds
Build - Make                  PASS      898.07 seconds
Make Check                    PASS      11.97 seconds
Make Check w/Valgrind         PASS      304.89 seconds
Make Distcheck                PASS      253.90 seconds
Build w/ext ELL - Configure   PASS      8.99 seconds
Build w/ext ELL - Make        PASS      88.47 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   544.06 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
profiles/input/hog-lib.c:600:19: warning: Access to field 'handle' results in a dereference of a null pointer (loaded from variable 'chr')
        report->handle = chr->handle;
                         ^~~~~~~~~~~
profiles/input/hog-lib.c:637:11: warning: Access to field 'value_handle' results in a dereference of a null pointer (loaded from variable 'chr')
                start = chr->value_handle + 1;
                        ^~~~~~~~~~~~~~~~~
profiles/input/hog-lib.c:1240:11: warning: Access to field 'value_handle' results in a dereference of a null pointer (loaded from variable 'chr')
                start = chr->value_handle + 1;
                        ^~~~~~~~~~~~~~~~~
profiles/input/hog-lib.c:1444:7: warning: Branch condition evaluates to a garbage value
                if (map.iov_len) {
                    ^~~~~~~~~~~
4 warnings generated.




---
Regards,
Linux Bluetooth


--===============1205759789054470854==--
