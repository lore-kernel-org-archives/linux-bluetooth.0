Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8197C4708F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B524D613AE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 21:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhFAVND (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVND (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 17:13:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A34C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 14:11:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id u30so270189qke.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TfWVe0OrdPg0wBiMFnwL7mJUNGJrTuN+BG9OV0hrFx8=;
        b=rcHaOLHQDWMlf/lF5duB5bvE+w0Z0GmggaS2Blvqy01fTZoBUGc3ojiARzkaIbJJ2O
         wfyEWlCNe06R/o4LYxM+QRgwNQyu8gFdmtW0r1naST5QOrVN2zm8KMN/qko3eVulX9ju
         Kb5CPMREoudz8hrSmVSYaJUT4ZPNTduVU+Xoeft/29O3t6tZP+Sq54TL/ac3R0NR4QAJ
         lSTnYW+uxOs5SD43Ncm0fkDcpXAbe3Qq14GiJpuxM+iUu1t7yNhm727FsGZNcKBKtcga
         QPvoxipbuKOJmc+Ln1OBQt7d64/EW+NaLiks7bGhm4vRzkZCSdOvvw8QUrw6e6NPiLRZ
         EOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TfWVe0OrdPg0wBiMFnwL7mJUNGJrTuN+BG9OV0hrFx8=;
        b=CLZenP0ceVPJ/U/UTeLXH4QO/eJe0SXSHDZMy52nTGIePnDZV9DotCeft66CihSjOu
         iN0YfYzxesi6SF9hu7Xi9cu4E5M1QktNJnipjGv3lo4I5AX0zoatzvZRNeSuGvAmtX4N
         ea158767OHSC64YB5RVuhjTDVg+7w2JGr9lOjlisyPYD9tEEvLcf6v00TboPQCGfg08r
         WksmCF9CLZ0z5VPKS192mqFgdiyLc6sChjGXzWD9hGWrUiS643IawGcko6XqcDCHAjaG
         6LsIMzgSdo3ysAbEGqw4wFcShiAjrhEIWhDudFCnvsQZkuOeIFcMnIJ9anmI+KogVFb7
         stEg==
X-Gm-Message-State: AOAM533i2hY3F8NsodotUrnHUNdQsDJmii2IOllGpkvcQelnmranKZJ7
        +jswzgl1tFPvIfj8KldEcylPQvthvgnVVg==
X-Google-Smtp-Source: ABdhPJxN+yrunPlJxD5IPTF3pNYaxN6dzs5Mm9eMueKpYwtC5Y/sGhwDt1jOzJ+G+BON8ujZYMzxOQ==
X-Received: by 2002:ae9:d60f:: with SMTP id r15mr24644141qkk.20.1622581880326;
        Tue, 01 Jun 2021 14:11:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.113.181])
        by smtp.gmail.com with ESMTPSA id d16sm10757015qtw.23.2021.06.01.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 14:11:19 -0700 (PDT)
Message-ID: <60b6a277.1c69fb81.9560f.bce0@mx.google.com>
Date:   Tue, 01 Jun 2021 14:11:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8211481811869830953=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/3] emulator/btdev: Enable LE Privacy feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210601201923.899950-1-hj.tedd.an@gmail.com>
References: <20210601201923.899950-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8211481811869830953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=492055

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
GitLint                       PASS      0.32 seconds
Prep - Setup ELL              PASS      41.00 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.22 seconds
Build - Make                  PASS      176.73 seconds
Make Check                    PASS      9.25 seconds
Make Distcheck                PASS      208.95 seconds
Build w/ext ELL - Configure   PASS      7.20 seconds
Build w/ext ELL - Make        PASS      165.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/mgmt-tester: Add tests for experimental feature command
WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#17: FILE: tools/mgmt-tester.c:6840:
+			tester_warn("Invalid cmd response parameter size: %d", length);

- total: 0 errors, 1 warnings, 156 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/mgmt-tester: Add tests for experimental feature command" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

tools/mgmt-tester: Add tests for whitelist and resolving list
WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#163: FILE: tools/mgmt-tester.c:6988:
+		tester_warn("Invalid parameter size for HCI command (%d)", length);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#172: FILE: tools/mgmt-tester.c:7021:
+		tester_warn("Invalid parameter size for HCI command (%d)", length);

ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#240: FILE: tools/mgmt-tester.c:9396:
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE , data->mgmt_index,
 	                                              ^

ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#298: FILE: tools/mgmt-tester.c:9454:
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE , data->mgmt_index,
 	                                              ^

ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#358: FILE: tools/mgmt-tester.c:9514:
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE , data->mgmt_index,
 	                                              ^

- total: 3 errors, 2 warnings, 420 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/mgmt-tester: Add tests for whitelist and resolving list" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============8211481811869830953==--
