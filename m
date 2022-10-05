Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFCEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJEV1d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJEV1c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 17:27:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9F647ED
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 14:27:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i9so97337qvo.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Oct 2022 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=S4ildT6T7j0fRQ7pXtSYLkLmlVgDa4AbuOH/ZsuUGOo=;
        b=oLEKyhd36KJHN8N/zBNp2DDzOFxBLEWEegheOoGG/Sfjrblshf0fF1o2VQgTGbtg2I
         9nHFOdZkdHBe5xTVHU5O+3WvzZNu9+60C58LLcUQzy2eLJeQGzmc8arDlb6h4a+Slh1/
         jzwFUObUl1HYZP/fJzm0Fsf3JqI/tR5ePJRRlUuup++7JGh+dKtbRGfw6C0W3m61L4m9
         JRRFJgNbyamKi3jE8hr3mZ8JWrfy3jKbxDMJWkqlsh5HHQWaXGtOvfc4klyrxX6g/XYr
         npq7tqYSidZRWnSXWwkilg+mW5aP9lO/qODR/g5pWvbLlsKpAX/IUCyafQ0m+s7fL5U5
         dbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=S4ildT6T7j0fRQ7pXtSYLkLmlVgDa4AbuOH/ZsuUGOo=;
        b=Y/udBbqw0ptcZTAvxv6GzUZ8aj0OW+TfaFmCqH6uJ0Gi/uuXPQba804xJW+95H0daH
         OhIDI9CPYutcsmURCBSqFmKpZFSBvPEQW04/8WDOyhSYpJcXa7DOtOkOfsDq3iwPDnTw
         /rsCwvPXlxW7BVSA2XxrAEypPfXLVJvjVyrmJ5IDBCPmmBKed7v2AwiAucxkAWJ6NHKg
         yxoNwBnWhM6PCN+0ecTZm0uM7aPLgU8sokja8MbGHEc6IGeSZzrjrxMsx4oPzY2vMVXg
         9DISP3Cp7VUetNxdn5kFXkZIJcw4dkK0gPn4s/d1mEy0N34/1w4Jq/pxW/H/QcL9WJ7M
         zL0A==
X-Gm-Message-State: ACrzQf0CrIo0uOWAAtiXx8tJZ9Mq+RNMYxMGgfD0DCbsEbBBQQgofcqx
        7NZGwlxkLWDfbe/Vo893cQJDq17sSao=
X-Google-Smtp-Source: AMsMyM60QyrBn+L3dr+a7ZJEZfpiKvWxUjdpMTr/BRRMG2qXu8D1CcGOmDSsrUmHd22rushjVqSmpg==
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d9a with SMTP id gy10-20020a056214242a00b004aa9c945d9amr1360828qvb.64.1665005250174;
        Wed, 05 Oct 2022 14:27:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.114.65.99])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a410300b006b5bf5d45casm18822333qko.27.2022.10.05.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 14:27:29 -0700 (PDT)
Message-ID: <633df6c1.050a0220.1bd5c.556b@mx.google.com>
Date:   Wed, 05 Oct 2022 14:27:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0216166161920091775=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Fix mesh to work with MESH_IO_TYPE_UNIT_TEST
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221005204309.65983-1-inga.stotland@intel.com>
References: <20221005204309.65983-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0216166161920091775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683315

---Test result---

Test Summary:
CheckPatch                    FAIL      1.45 seconds
GitLint                       PASS      1.06 seconds
Prep - Setup ELL              PASS      27.23 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      8.75 seconds
Build - Make                  PASS      840.73 seconds
Make Check                    PASS      11.94 seconds
Make Check w/Valgrind         PASS      293.53 seconds
Make Distcheck                PASS      240.01 seconds
Build w/ext ELL - Configure   PASS      8.73 seconds
Build w/ext ELL - Make        PASS      85.17 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      502.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] mesh: Fix mesh to work with MESH_IO_TYPE_UNIT_TEST
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '9966cb8b6999a5f54fc13acbd7e1526512a84342', maybe rebased or not pulled?
#67: 
commit 9966cb8b6999a5f54fc13acbd7e1526512a84342

/github/workspace/src/12999613.patch total: 0 errors, 1 warnings, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12999613.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0216166161920091775==--
