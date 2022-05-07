Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D88FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 17:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386654AbiEGR5h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEGR5g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 13:57:36 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2952A258
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 10:53:49 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu47so8263280qtb.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 May 2022 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9wZbt+HrOKdfC+bHkhBjKH96G5XQvcxanCXrdDWXxjg=;
        b=VUIpIj2oePrVLffa2xObqjsI/yJeWCmLNfu9dLM4v6jRQ6MPMnEdRk+vn+G65DCamz
         0Z2hzM8QoNuEHY9MnTeCykbDh1PQGw4aOCRmj7fw0nnn+lBKqKFFTcVSiqUq/l8k7KWY
         g3RDhguJJFNuDK1LzcIJqZl1vsw59OabOCY+G2BurTjnV7i59uGCp0joH/1XLm5eXvX5
         o7xbq0T47Pf1BYlqQ4qF70X2tmOwk3M6Ja+UAt6Z8y732rsGH/B0hF7FCL+V+oWe82YS
         PXyl5/17MK5VMITF4MKFk77XtKAU6PL4wsu96eC0KlBb1a1WqYY2EKzOX65sW1x82ezc
         7eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9wZbt+HrOKdfC+bHkhBjKH96G5XQvcxanCXrdDWXxjg=;
        b=ELbX00vTH1tKT24pMLS3EuwuqpOZGcLQXjKLzZRi5Z+yha0V/A+jQJ+82UR35FMdHG
         uiyBsT/YRjkmnJhWDoz3q0DjEZY26OLAoIFqxfwUxrQufceRptcvvY23RaGhB7whWVi1
         qaVp7oiVLsO5YukYrE8nz42rTBS9AW0FjRdacic1A0FT/Bo2MJNP4t+k1TRttNMUGKrV
         DyS8i9rWGDPmf+VCx1539f6Ruv81g1qSQnrc2/iaZ8h4jRA9vAYpqaHUxSyVlCIFFG+v
         5qHugfSFIrl0LV1wjv2FlDW8YIfE9547gVkRSozEexVuh2CZJ4Ql461n/VWwQF+WqupN
         TMtg==
X-Gm-Message-State: AOAM530ndLtuU29K57vMk1rZL0hMo/3a55W2g/OL9EYmqwwR6kACIRWk
        CN4wd2hs6MCWbjZIKc5T7j5HxxOC+XcbGw==
X-Google-Smtp-Source: ABdhPJyc5UG8SDlZM0l6Yy/PUdJDbNlMUwYzQQGOi7/W2cAh1+Jl2gkfrssbZulyg00fnuAYQdq/9A==
X-Received: by 2002:ac8:5896:0:b0:2f3:d231:58a9 with SMTP id t22-20020ac85896000000b002f3d23158a9mr2446794qta.131.1651946028549;
        Sat, 07 May 2022 10:53:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.7.104])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a129600b0069fc13ce20fsm4124268qki.64.2022.05.07.10.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 10:53:48 -0700 (PDT)
Message-ID: <6276b22c.1c69fb81.b2993.5e2a@mx.google.com>
Date:   Sat, 07 May 2022 10:53:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2044092015509781725=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, i.kamaletdinov@omp.ru
Subject: RE: Fix few more bugs found by SVACE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220507150657.28240-2-i.kamaletdinov@omp.ru>
References: <20220507150657.28240-2-i.kamaletdinov@omp.ru>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2044092015509781725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639408

---Test result---

Test Summary:
CheckPatch                    FAIL      5.63 seconds
GitLint                       PASS      3.84 seconds
Prep - Setup ELL              PASS      42.34 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.45 seconds
Build - Make                  PASS      1317.42 seconds
Make Check                    PASS      11.74 seconds
Make Check w/Valgrind         PASS      438.85 seconds
Make Distcheck                PASS      226.73 seconds
Build w/ext ELL - Configure   PASS      8.47 seconds
Build w/ext ELL - Make        PASS      1317.12 seconds
Incremental Build with patchesPASS      5316.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/4] tools: Fix memory leak in hciconfig
WARNING:LINE_SPACING: Missing a blank line after declarations
#68: FILE: tools/hciconfig.c:84:
+	char *str;
+	str = hci_lptostr(di->link_policy);

/github/workspace/src/12842044.patch total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12842044.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,2/4] tools: Fix memory leaks in btgatt-server/client
ERROR:ASSIGN_IN_IF: do not use assignment in if condition
#68: FILE: tools/btgatt-client.c:1358:
+	if ((read = getline(&line, &len, stdin)) == -1) {

/github/workspace/src/12842046.patch total: 1 errors, 0 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12842046.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2044092015509781725==--
