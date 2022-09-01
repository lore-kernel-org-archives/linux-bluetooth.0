Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18378ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 21:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiIAVDr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiIAVDn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 17:03:43 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB8246
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 14:03:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d1so87129qvs.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=BzSv8X2/Qs9qSpV+7tDGS7qJ+RTGMWVmzRftZbXnLDs=;
        b=Myj0MbMQlf7O0Dzsyoy/7hTSLrnmmchwWKlNo8qGahNkuL+zXfy2uVxE1LjbRyzIug
         hYNb7ccq0t+YHgs04To/M3SPYLQi8TdxMICfEg+UZPYaEaX68ImkdU4dRrW8bpPeBBnW
         6LIug7EpDfVRxXtGtOjHBNGW04DEsSBeNO/vVTAxHXioYUXhKMoMiL/rokWEe190DGt/
         tISmIgNWd++yu7ZgEIEcz1lOSUHoVs0oE8sYaYmsP5tlkxv3ftynNXglfuJjG8vC5eJg
         HInHrZ/WkCKJtERKyvLr87Bm9A0x11BIrxCwgEVK1B1mZBk1A29x6iNYJiKQTakMG4tA
         sLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BzSv8X2/Qs9qSpV+7tDGS7qJ+RTGMWVmzRftZbXnLDs=;
        b=6dGBWgMmtQ2PTOT1gXGUauknl8+vMR6TOrgXNtbAghTJKh9CNH8DeVlyEfI/a0B0Ij
         HalXSwuy9j1g8e1eXeNXvGCpIxVv2w2sMf1VPzB+Yz642+fOFUZxyKW8NCxjfgb+34vC
         3zmk+78kwbRUtaux52nU0kMowmsowpLgRLqjnX/hl6QhfLUqS05jsTRpSAQF0t11mwZ3
         Z5rxqwOkKcWgByrwt+7dffNDdiAXOk3HRPFKHoVpFoxouuJ09P5RCWBRXBQJ+rudMKhz
         3daIrWWgh0Gy/5wuwZjrI31Gg0obEyviE1J2wGUMGsxKSani6JBoHUF1Awn+Ba4DWbnK
         wxGg==
X-Gm-Message-State: ACgBeo0KqjAmgokrsM3EZvzybtrdGqGBPTgLMb5sjJlzahOAPeif6UUH
        5Gm0EbI33bi0tVOYrW83eriDhpMWx4DMaA==
X-Google-Smtp-Source: AA6agR718uvumHFVNubhZPRGrlmI5FgSngHQ2fDJffRT2DddwyX9WT4rpXSbf2O25s8c/sqWD274Dg==
X-Received: by 2002:a05:6214:2b0b:b0:497:30dc:4c33 with SMTP id jx11-20020a0562142b0b00b0049730dc4c33mr26547239qvb.80.1662066220840;
        Thu, 01 Sep 2022 14:03:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.12.27])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a404700b006a6ebde4799sm12592232qko.90.2022.09.01.14.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 14:03:40 -0700 (PDT)
Message-ID: <63111e2c.050a0220.9379d.aee3@mx.google.com>
Date:   Thu, 01 Sep 2022 14:03:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4071076239178692723=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mgmt-tester: Adds turning on Mesh Experimental feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220901200501.27858-1-brian.gix@intel.com>
References: <20220901200501.27858-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4071076239178692723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673378

---Test result---

Test Summary:
CheckPatch                    FAIL      1.59 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      27.08 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      8.70 seconds
Build - Make                  PASS      836.98 seconds
Make Check                    PASS      11.87 seconds
Make Check w/Valgrind         PASS      288.51 seconds
Make Distcheck                PASS      237.00 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      83.60 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      506.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] mgmt-tester: Adds turning on Mesh Experimental feature
WARNING:LONG_LINE: line length of 101 exceeds 80 columns
#132: FILE: tools/mgmt-tester.c:7424:
+			tester_warn("Invalid cmd response parameter size %d %d", length, expect_len);

/github/workspace/src/12963192.patch total: 0 errors, 1 warnings, 75 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12963192.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4071076239178692723==--
