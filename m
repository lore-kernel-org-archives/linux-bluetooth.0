Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5D4ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiHaXRz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiHaXRy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:17:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A6A6AD5
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:17:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y127so15898879pfy.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=bUEHQJcauDadGHTubhll2v7o3uKYYJLbaQaw3xgrC3w=;
        b=FU5vp0bDUp3RBE8zBarVchv3Xt5sZ8uM7tgDRdew/Q0kxVEFkMgRwBswrwWU9mVgA8
         Yc7DYET7g9aSK0am/QPHL+deCCsIi2wxav6MiSIjA6k0LxBIYS30Ue8caYVpfUCXkYch
         NVvlqc2VOWsRMs30yiBsBet+7KynYeGQQfHY6X5/ZRbmAviAMVCO9VPXTiOa7TZ9OPFi
         Jj0Ubz8w/OfLMaKryy/V+ZOdWTWG0izwYQGTdKE3InYRQyk/tK2XoBu2FAFal29RbKP4
         4FCOIyOshzEqSBUEdkdXdAtOTYpn0f3T7GOveLmc64lwSvaZnF6OUVExyR1BPTTRp7Nz
         qfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bUEHQJcauDadGHTubhll2v7o3uKYYJLbaQaw3xgrC3w=;
        b=C8+uz1vLW/leG3nvNtikh5m6GSUp5zhN//E8LJFxQXwlv4Kx8klZsn1X8Th4h8DMTC
         AxpxGrJMvfdrDHDqqIDippQbl83jBSl07HlwpKzm3acs5SeWdCIldQPZEWzk5GG2dR3q
         6UfwcvCp0uFGFtTmEFuB5oxhBHry/2hCKQLnaqeqg3+UAeu3PwXkwOFNnWqMDa18eEva
         VHpcvt3aMGjUF3ZeNIYq5jncXEywHR5CWFvU6YnILaPkCP31soiqSeMGVcE4fWtjqkV6
         ixOo3aUl7ZtSkE75R+3tt6TC2fMQtIq65jYjO/QEFlQXnSTSUxtwqEMuUO+peae/vgWe
         mfiw==
X-Gm-Message-State: ACgBeo3vi10iVUQBUq0JFl5x/KpJQqni+2t4SDk5FIgNO41zEvTbzCbI
        tOXGba9y2cmoDOrpwjVAmJtp4mgCqZrbEA==
X-Google-Smtp-Source: AA6agR5OBZ5s+8rq2fnvfoScdbr8dh5bslYROHlqDyTktk2EuI3P6d6WhWHtaDX7mi1/v6/2+jOwIA==
X-Received: by 2002:a63:2b8e:0:b0:41d:6d37:b259 with SMTP id r136-20020a632b8e000000b0041d6d37b259mr23354043pgr.208.1661987865712;
        Wed, 31 Aug 2022 16:17:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.131.33])
        by smtp.gmail.com with ESMTPSA id n23-20020a17090aab9700b001fd66d5c42csm1838950pjq.49.2022.08.31.16.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:17:44 -0700 (PDT)
Message-ID: <630fec18.170a0220.c16d7.3d81@mx.google.com>
Date:   Wed, 31 Aug 2022 16:17:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2418267910548403855=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add mesh testing support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831214821.274797-2-brian.gix@intel.com>
References: <20220831214821.274797-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2418267910548403855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672980

---Test result---

Test Summary:
CheckPatch                    FAIL      2.87 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      31.96 seconds
Build - Prep                  PASS      0.66 seconds
Build - Configure             PASS      10.04 seconds
Build - Make                  PASS      981.55 seconds
Make Check                    PASS      12.52 seconds
Make Check w/Valgrind         PASS      347.96 seconds
Make Distcheck                PASS      292.35 seconds
Build w/ext ELL - Configure   PASS      10.16 seconds
Build w/ext ELL - Make        PASS      101.38 seconds
Incremental Build w/ patches  PASS      238.65 seconds
Scan Build                    PASS      784.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v3,2/2] tools: Add mesh-tester to test Kernel mesh support
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#362: FILE: tools/mesh-tester.c:252:
+			sizeof(set_exp_feat_param_mesh), set_exp_feat_param_mesh,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#502: FILE: tools/mesh-tester.c:392:
+			sizeof(set_exp_feat_param_debug), set_exp_feat_param_debug,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#592: FILE: tools/mesh-tester.c:482:
+					test_pre_setup, test_setup, func, NULL, \

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#593: FILE: tools/mesh-tester.c:483:
+					test_post_teardown, timeout, user, free); \

WARNING:BLOCK_COMMENT_STYLE: Block comments should align the * on each line
#728: FILE: tools/mesh-tester.c:618:
+/* Read HCI commands in the expect_hci_list and add it to the queue
+*/

ERROR:SWITCH_CASE_INDENT_LEVEL: switch and case should be at the same indent
#1040: FILE: tools/mesh-tester.c:930:
+	switch (opcode) {
+		case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+		case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+		case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
[...]
+		case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
[...]
+		default:

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#1249: FILE: tools/mesh-tester.c:1139:
+		 * for a callback. */

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1441: FILE: tools/mesh-tester.c:1331:
+			sizeof(set_exp_feat_param_mesh), set_exp_feat_param_mesh,

/github/workspace/src/12961464.patch total: 1 errors, 7 warnings, 1474 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12961464.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2418267910548403855==--
