Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2177C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbiFNOef (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiFNOed (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 10:34:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393A136E24
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 07:34:33 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u8so6586234qvj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=79wdcgWW02hnv2XWTvAVq4GNMHrvhUXBw8GdFe+JNuc=;
        b=qIyh6QLknYkpS6z2zTj+UIWkhBqWyaQWWaB+xQd3GoVhNHJojRpv5TnZ7ytSUHebUD
         Va1n0VNyXP6vKxhsWedRlp3i/OBntMBa+09FF9ZwBQzFCXq+qQLwfffgPgJgvlsakYDf
         t2CTYvtk1xTjZsQSDcsEdm4s9jC99LAKxcRl4fLLnhU8plQ6bh/WEikeS8E0GCG8Xd/N
         g8rHRwEl+rXOoB2bo6B0vTCEaX72JlxJCP0Sg37lJgoknonkwbVJRkVi8PSmfsIzEdxQ
         t7EAVUwPI3zfqMRlLyNz7sVgKYhdh35K1DMK0zPaH6/pS27ROGm0GoYhdG62BhTe4NWS
         M44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=79wdcgWW02hnv2XWTvAVq4GNMHrvhUXBw8GdFe+JNuc=;
        b=b2Z0jrF6xW0uHs+sAeAUcP9AR8Y9XSkPQPb6HAQmLlGrK+5+kgf1E4g52NIw/Wz2YI
         1ecEPddfF6g8Msb4Fxlrr6i9y9YM8YyLXYPdw/wg4tP9K5m0STJDbBKImVzpA0tpY25R
         PUR7xWaNNxN3hmo+YxCiT4E+uRRvzuUHPfjtKt7AE4usyT9/6ySkayduLuvczEtH8vpd
         TZ9YDaw7FNayEYft4cnDRAN5A69EJrYCD+KTS/7SbkmRr0cl11A1e5YmYJz/MmWqkjrw
         Ur9J0j0Xk2/l7wLmwaQNnIodmYP23xmmaziYOInTSSRGKurkdCFQavZDBBK+B/pbDf7h
         afDg==
X-Gm-Message-State: AJIora/KaT+zkEPa+CQF4rJQnJ1ZJDeGunjNhxFhJh/12nkHKC6DT5Ba
        vd3hQB7vu1BXHnYMBLQ6SilNhF6sgV3S2A==
X-Google-Smtp-Source: AGRyM1sglUPw5z8Fg4p7pMCTI52fwG12VDtrgy3HggsGQGjBFEb2TWnRVJvbJO9tl21TFO+8qNtjjQ==
X-Received: by 2002:a05:6214:27e8:b0:46e:3933:76b0 with SMTP id jt8-20020a05621427e800b0046e393376b0mr3657782qvb.92.1655217271478;
        Tue, 14 Jun 2022 07:34:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.4.166])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a40d400b006a6c9e17088sm10088954qko.65.2022.06.14.07.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 07:34:31 -0700 (PDT)
Message-ID: <62a89c77.1c69fb81.64364.158f@mx.google.com>
Date:   Tue, 14 Jun 2022 07:34:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5143161686641115249=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix transfer has been free in transfer_abort_response
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614131549.22054-1-wangyouwan@uniontech.com>
References: <20220614131549.22054-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5143161686641115249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650234

---Test result---

Test Summary:
CheckPatch                    FAIL      1.56 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      43.03 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.50 seconds
Build - Make                  PASS      1283.86 seconds
Make Check                    PASS      10.99 seconds
Make Check w/Valgrind         PASS      442.66 seconds
Make Distcheck                PASS      231.34 seconds
Build w/ext ELL - Configure   PASS      8.35 seconds
Build w/ext ELL - Make        PASS      1210.16 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
obexd: Fix transfer has been free in transfer_abort_response
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#80: 
Breakpoint 3, transfer_complete (transfer=0x5555555f7000, err=0x5555555f6d60,

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#158: FILE: gobex/gobex-transfer.c:96:
+		transfer->complete_func(transfer->obex, err, transfer->user_data);

/github/workspace/src/12881169.patch total: 0 errors, 2 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12881169.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5143161686641115249==--
