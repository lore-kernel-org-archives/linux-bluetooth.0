Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4047EEE57EE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 10:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbjIHKB6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbjIHKB5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 06:01:57 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60114213E
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 03:01:14 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bba7717d3bso1441529fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Sep 2023 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694167272; x=1694772072; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LSHgJmwtkVlRd75/h7uUy/WD1N5gYPrsUjGLI6GWpIc=;
        b=i832Jy+hPCA5JwS+8r5cijrq5+82MiwlqajGrlqp8qbebYUL1Hibmg17/zXWKMpQBt
         Krv1k/X8hHy5V567ZQI/T58K/e03uVWvqaGRjTPsKg+eWpxmGrW0qXuJIobUzqL0RGIi
         H8eVs+GIS+Ch1CUBrejoQ3+mjxsbUdYxbGe/UF8qlSt5N+rRw+mLkug/EAYXX8GY1g+a
         xycHFbuMbwSQfB6ZLi0m8CSCb1+aeai8TXMY8pk4QSck1P1ntvCCIiQ50J7B4hCnpYCY
         /lPK4EIBrEcKyerJGn1ANJ/GEd6s4ffG/YZq1KQm9GWmgA95D56BYwk255N9xYnVh+X5
         6MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694167272; x=1694772072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSHgJmwtkVlRd75/h7uUy/WD1N5gYPrsUjGLI6GWpIc=;
        b=bBMrxLtMtV8dj8vKzrkhvXjfSSbEJrZXmDqvGOpE8BfYjRjpVzRfvGAzsXV085C35m
         7vsNVoAzS3osXCecfLuO0PXhlJJLNkQ+jnD0DbsAwYvsMGl0sAzX/pLwV0i5XtYIO//V
         9WbCVHwSHhCk3SwObgcp5Y8aMujT9KGqY1EpEV7uTLZNv7GBwf3Q8a3Tj7xOQUnXL0GG
         FpQZuz4DqioYHPeTrATK8OWeNA6O9zOirgh23wCze69qeTAyIh5KgnqwApqkD8QohtPp
         2UfYeeZav4c6K8r+ccLWTTEDZBv+w0eaNMfCnm4lUpAa2+9NcQkpcrNasCSajAOH5wIG
         Z5gg==
X-Gm-Message-State: AOJu0Yy0F3eWOoxna6ucXA2UnERJHX6wjYVHd6U1r+m7qR6OKVaBQ3qA
        Sivwk6GO/hb8lk3Yns3p0qVDyG2jb8g=
X-Google-Smtp-Source: AGHT+IFHUPQn+KUxRwSPmhrcgnwEbAsiaZvXxTqOtElKQd5ZWnanNY1tsoPgdB0AiIq8JxOEKFf4pg==
X-Received: by 2002:a05:6870:f14a:b0:1d0:e36f:dc42 with SMTP id l10-20020a056870f14a00b001d0e36fdc42mr2269001oac.57.1694167272523;
        Fri, 08 Sep 2023 03:01:12 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.52.227])
        by smtp.gmail.com with ESMTPSA id fn2-20020a056638640200b0042aec33bc26sm379475jab.18.2023.09.08.03.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:01:12 -0700 (PDT)
Message-ID: <64faf0e8.050a0220.884d2.06ee@mx.google.com>
Date:   Fri, 08 Sep 2023 03:01:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1072277191829598135=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: [1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
In-Reply-To: <20230908091624.20040-4-vlad.pruteanu@nxp.com>
References: <20230908091624.20040-4-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1072277191829598135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782459

---Test result---

Test Summary:
CheckPatch                    FAIL      0.93 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.44 seconds
CheckAllWarning               PASS      35.99 seconds
CheckSparse                   PASS      40.02 seconds
CheckSmatch                   PASS      112.82 seconds
BuildKernel32                 PASS      31.05 seconds
TestRunnerSetup               PASS      477.41 seconds
TestRunner_l2cap-tester       PASS      27.08 seconds
TestRunner_iso-tester         PASS      48.17 seconds
TestRunner_bnep-tester        PASS      10.35 seconds
TestRunner_mgmt-tester        PASS      215.71 seconds
TestRunner_rfcomm-tester      PASS      15.58 seconds
TestRunner_sco-tester         PASS      18.97 seconds
TestRunner_ioctl-tester       PASS      17.45 seconds
TestRunner_mesh-tester        PASS      12.96 seconds
TestRunner_smp-tester         PASS      13.89 seconds
TestRunner_userchan-tester    PASS      10.91 seconds
IncrementalBuild              PASS      30.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13377269.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1072277191829598135==--
