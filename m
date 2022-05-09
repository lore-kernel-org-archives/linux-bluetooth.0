Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 14:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiEIOt2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiEIOt1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 10:49:27 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D4917EC1A
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 07:45:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id n8so10507541qke.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 May 2022 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=451XOlORzvbPXRdhFh5N+OjNp+NIi3ZiC1xScMo0MMc=;
        b=oJV0XbB4n0JmpGQOFz0Mzd6j7snA25i6N3K78oAWieJL3h4PethIuE1q/2nBJbLGDc
         xvQOnOcB504fA9XyFAdygkryteY3dl1J7gB6oL4bU3KQBInT/n5bFMhjV5VDrZOl5e7f
         bfhwkOR3wMCepquShChOUiIH5azNluTqXVLj8Ztf/TlMYm0LGeauS6g3w2Leqf7a5aQc
         EamhlQK2cNAu/8N3uKm1QTcUer8lL0QCL4XLowDxWIyqrXdRJutdHQsZanCGRKZjx83s
         arDnlWaHppjEHsfiNV3WYN1bXqRXrLyvxkDzd5FuJh7N8M0cBAF6IKo5zPUoSAhCLd0d
         wGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=451XOlORzvbPXRdhFh5N+OjNp+NIi3ZiC1xScMo0MMc=;
        b=O8eRGfwktK7+go1g4qxy9SFD8pIIhV7kJyGlVMhtFccsMh7so/Va543P4rW7JqV6ke
         X8BNfcRqoEkzvk0kwwxuEetGelTUKkIX2/uKy+2XBpld8DNWYcob7Pu3RoJwyotWXNvq
         v+KTDSAt8JPdQuZvUSisjmhpv6r6BUJjPkB3bjen/fmTsQAPaFIm3sR8X2kVUr5IRaFE
         uKjcHfXrUDm0PEKp+sbsh69QkeVkoDHSvjJ2naq3exSv8WETdeLkrQnfg+H5zouOwA5f
         AsmIVUqupneb5Q+7vOzcYCMQisE0p3KU185u80RR9vDsGZw4St1ZKH18Um7hcO01z/g6
         fnfA==
X-Gm-Message-State: AOAM533V9XhBQb8FqsjIEYJhrESpmbobM1n/NI+VHKdqp2cJBVobQYog
        gdgBX5I/2GIgWD9UUJla7X2sWRwJRCxUyA==
X-Google-Smtp-Source: ABdhPJxM/RE+7+NrH+y2bqBSBHrMNJkr0/8UWV9EHo9MuScQYPLQpuZ21Cq/LRQsVfRqsQFGQYKRTg==
X-Received: by 2002:a37:9381:0:b0:69f:62c6:56a7 with SMTP id v123-20020a379381000000b0069f62c656a7mr11922900qkd.643.1652107532164;
        Mon, 09 May 2022 07:45:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.82.214])
        by smtp.gmail.com with ESMTPSA id f18-20020ac84992000000b002f3b82571b1sm7738326qtq.1.2022.05.09.07.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 07:45:31 -0700 (PDT)
Message-ID: <6279290b.1c69fb81.f6114.5a95@mx.google.com>
Date:   Mon, 09 May 2022 07:45:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1127416819469466262=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: device: Fix the problem that pairing has failed due to the error of Already Paired (0x13)
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220509131239.12189-1-wangyouwan@uniontech.com>
References: <20220509131239.12189-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1127416819469466262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639748

---Test result---

Test Summary:
CheckPatch                    FAIL      1.50 seconds
GitLint                       FAIL      1.00 seconds
Prep - Setup ELL              PASS      41.32 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      8.04 seconds
Build - Make                  PASS      1197.43 seconds
Make Check                    PASS      11.55 seconds
Make Check w/Valgrind         PASS      436.71 seconds
Make Distcheck                PASS      226.71 seconds
Build w/ext ELL - Configure   PASS      8.17 seconds
Build w/ext ELL - Make        PASS      1168.73 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
device: Fix the problem that pairing has failed due to the error of Already Paired (0x13)
ERROR:OPEN_BRACE: that open brace { should be on the previous line
#77: FILE: src/device.c:3109:
 	if (!req)
+	{

/github/workspace/src/12843539.patch total: 1 errors, 0 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12843539.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
device: Fix the problem that pairing has failed due to the error of Already Paired (0x13)
1: T1 Title exceeds max length (89>80): "device: Fix the problem that pairing has failed due to the error of Already Paired (0x13)"




---
Regards,
Linux Bluetooth


--===============1127416819469466262==--
