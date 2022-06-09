Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D81C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 11:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiFILCn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiFILCn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 07:02:43 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275271C904
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 04:02:42 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-f2cbceefb8so30509022fac.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/cosRkRDax5R+lWd45JDayIkT0EwMTUAaN9ZKy3500k=;
        b=L0J0VpeMdKeIMM0PfQkMp1Mkdzomu1wZ4/KbSKba9IKrjMvV/7v2wTX/UD8Jd/MZWf
         U4Y8tci3SQT/Mw3lCYJu+stUDQofHN9H4Ef32cJa1HTXgAjZcBwOD0O7ERjBhMTFox2F
         2jLSOhwqQAv7h0M0wcnDmTY5BjBhq/yu6JUjE+FEfNCIhifSaGl84gnXYdUNOH4nZ1Ac
         Kii9VAyu/hD9J8PA+MSV2Q6TVgTsqKVKh+R3lLYl3w34uGlzSuTTbwEujbg3ZkHCKdFh
         nQT5CNwQMdnBsOM7OkgQs0BqSdMzudTRPxJCRvu3ls6XfsY5jcGO5DBeJrIoBC6gLGgn
         SZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/cosRkRDax5R+lWd45JDayIkT0EwMTUAaN9ZKy3500k=;
        b=rvU5+AXIT8/dJYmhis7nGuQUXWJYBqFSC8nQAY81swZ69587h2TH0lh1tZAaN16JOk
         yWgDfoyudharXW1DjvQYhc/QQnOz+AUhLtHPUuAeinOMRqRli6WyDkC35vWJXuQhZwAq
         CSFUxqPa51rsseYhDd3f7e0eQD831nzR7jiG5V41rlcyumWpNJCPL636P9ESv+Lb5ZG6
         hMipSmAx/d/qvRZVMi1pSzMVqBbTeTGzUoTXRpS74kyVQpSbpbgBBe4Mhi3EkPa1ZHpc
         f4EoUVjUyd6QWa15fKhXgoeqBtGeOdtD8qJ1pBppVc9lWiCGjJTYrQT6Y+XamTn7glVM
         7nWw==
X-Gm-Message-State: AOAM5327Zl4WAUpvQsqJUW+vjKO+JPNzUg9D9k0TJYOWz0lk5XTvpatK
        f7L3nH8qDof5sil15P5n5EnC3PGgDdjeHQ==
X-Google-Smtp-Source: ABdhPJwkpCL+HrSMF/XEDWkK0IkK7rQkkYvrUu7J1yJtYtjZrDqJFY3KcO0kL3iToPdkXPPys7GTjw==
X-Received: by 2002:a05:6871:149:b0:f5:d454:d5ac with SMTP id z9-20020a056871014900b000f5d454d5acmr1379211oab.76.1654772561234;
        Thu, 09 Jun 2022 04:02:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.221.108])
        by smtp.gmail.com with ESMTPSA id k11-20020a0568080e8b00b00328a7641583sm13150355oil.32.2022.06.09.04.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:02:39 -0700 (PDT)
Message-ID: <62a1d34f.1c69fb81.12673.e987@mx.google.com>
Date:   Thu, 09 Jun 2022 04:02:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4205125478144966060=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jonas@dptechnics.com
Subject: RE: Fix bug where bluetooth-meshd stops sending
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220609090832.9945-2-jonas@dptechnics.com>
References: <20220609090832.9945-2-jonas@dptechnics.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4205125478144966060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648769

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       PASS      0.74 seconds
Prep - Setup ELL              PASS      52.08 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      10.12 seconds
Build - Make                  PASS      1878.37 seconds
Make Check                    PASS      12.93 seconds
Make Check w/Valgrind         PASS      530.30 seconds
Make Distcheck                PASS      280.29 seconds
Build w/ext ELL - Configure   PASS      10.22 seconds
Build w/ext ELL - Make        PASS      1835.88 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/1] Fix bug where bluetooth-meshd stops sending
WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#111: FILE: mesh/mesh-io-generic.c:746:
+							l_queue_isempty(pvt->tx_pkts) &&

/github/workspace/src/12875093.patch total: 0 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12875093.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4205125478144966060==--
