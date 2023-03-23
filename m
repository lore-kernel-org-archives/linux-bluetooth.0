Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C94C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 11:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjCWLm1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 07:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjCWLm0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 07:42:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215311E1E0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 04:42:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hf2so21938180qtb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679571734;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0oyqxfnD+KBqDKBD01OzpsydhSCyYFg6e93sh8xPoJE=;
        b=QhOrfmPD4Lz4BFjhaWkRtW2xL0khBx7oJDVK0FULi9PXsQAQkjzGisO/qxZRikpO92
         zLhHfoAnux1jKWntdhi+xXKie02uVMEmULXKl42HhY8aPBPcWPf00oyCRhNQNq9LUdKg
         i8NDFJmUrpbc4i0b8We9qi5i/p1cQKRqsFozrgFKuDhe5ZiBeC6anv/UnUX4r39XmnRa
         JuL5II+ix4ViETgaZyc9utfYW9H5kb7FM2WEm3BK6tfXKhXcKCc9l030w6WuO284AyLo
         6Tc/FoOX274iH69uN5boEOBFsA2s++ruh4xlHhpooI72pV3IhJ1T/asjqyJ/vWSify/j
         7XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679571734;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oyqxfnD+KBqDKBD01OzpsydhSCyYFg6e93sh8xPoJE=;
        b=AHKNRydupmn3DKEmMupoq7unp7+YEwJlHnSA/jSQX6jtnwNvF/jH3HXQMCy8WWineW
         ODpYJzEqWmUUnTAaXEIHQ0KSyKfNibgW/ZM2ojfLT+NlppglVoZPTNNGbPe3FyAnWEkE
         13PJFpVULm+Jc8bpng7tFssQVMkWbUmDw3apCWPrDz4xpwOd4mj36g6g+giZHwLyaXtY
         5FbBEndG6c+C5l94MXyUbgUcpLWNo4v1nA0ed6sxyC/NUoaVkrpzFEJT4jMqfInFf5i0
         gXGXBmRHeJXNw6f3I/WmOLkM9LbkdBrINU6kNFYM/1Ie4qtUIUSkBgmo59jrcQeHdnMB
         kssg==
X-Gm-Message-State: AO0yUKWHGcjyfQAXb7Jfs4enO4TJMJHSRO9cveGgVa7ynmZz5/ruWcHK
        Qn8AFc++R6gVdM8E+zvuN2t4thiEORA=
X-Google-Smtp-Source: AK7set9+YsfmDg5HzycTujYQArsA8Dn9ZVFOv0f36gufTEH/nF8U4tBBhU3n+YSUasV/vKAcevwZiA==
X-Received: by 2002:a05:622a:2d2:b0:3e3:803b:e5c7 with SMTP id a18-20020a05622a02d200b003e3803be5c7mr8846949qtx.19.1679571734177;
        Thu, 23 Mar 2023 04:42:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.128.128])
        by smtp.gmail.com with ESMTPSA id 196-20020a3707cd000000b007426e664cdcsm2468031qkh.133.2023.03.23.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:42:13 -0700 (PDT)
Message-ID: <641c3b15.370a0220.3162d.a88b@mx.google.com>
Date:   Thu, 23 Mar 2023 04:42:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0210359026686532777=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: l2test fix+feature
In-Reply-To: <20230323102732.566440-2-simon.mikuda@streamunlimited.com>
References: <20230323102732.566440-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0210359026686532777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733107

---Test result---

Test Summary:
CheckPatch                    FAIL      1.31 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      26.34 seconds
BluezMake                     PASS      752.58 seconds
MakeCheck                     PASS      11.03 seconds
MakeDistcheck                 PASS      147.91 seconds
CheckValgrind                 PASS      240.89 seconds
CheckSmatch                   PASS      320.56 seconds
bluezmakeextell               PASS      97.38 seconds
IncrementalBuild              PASS      1229.04 seconds
ScanBuild                     PASS      972.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] l2test: Fix setting mode for BR/EDR l2cap socket
ERROR:SWITCH_CASE_INDENT_LEVEL: switch and case should be at the same indent
#108: FILE: tools/l2test.c:160:
+	switch (mode) {
+		case BT_MODE_BASIC:
[...]
+		case BT_MODE_ERTM:
[...]
+		case BT_MODE_STREAMING:
[...]
+		case BT_MODE_LE_FLOWCTL:
[...]
+		case BT_MODE_EXT_FLOWCTL:
[...]
+		default:

/github/workspace/src/src/13185459.patch total: 1 errors, 0 warnings, 44 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13185459.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0210359026686532777==--
