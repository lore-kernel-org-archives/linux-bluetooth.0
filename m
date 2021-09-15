Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F12C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 09:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1C461178
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 09:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhIOJB5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbhIOJB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 05:01:56 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F8C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 02:00:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cf2so1420152qvb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dPrIGsGgMwv2W/SAZc5Qfr8PfAtpWM3B7aJD67/GPAA=;
        b=H2U0UwHxZUp3TYQpdQnA9CE54zKvw77SkF+8mbYmz5JSTX1J4ex4YdgP8u4WKjfAop
         DV49DCApdwmqkt4kO6q5vA/Et+ba2vABnSBATwVZ5dXH19jHRcjgHH0CowmTi8TcRlna
         uJy+t4loqy5gJFbMBXrlVh+j2z6a1Dtwy0+31L7Ku6mF8O8pRMfysYnYnsEncz/hYHU1
         dlSU9wGj6dxcnQqCiPDkkgjsjcE2la2ouGnWt7QDOCV07f/1KWAspK08sD+xHaU0Q+JQ
         1dHJFT5Vpo6TgRF3BPAHky0rPKcwUxR2MwXQIfdjaFI4YhowRomo7PJib8mOXL65guuv
         YDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dPrIGsGgMwv2W/SAZc5Qfr8PfAtpWM3B7aJD67/GPAA=;
        b=MhwpDHDEfMTmc1uAeWJHBE9A1jDoFLRGLJrNBjrCDQCiuVvUzGSrnLib539XIcAeed
         6GyuIKgv/qZo3wmrhTQLox5DOp16p0+ctZptf+b+zBlzH/zS7nrqttp0mystOyXLDGLH
         RAEXeFwWwEKibe3ZQrR9KL8L40y77vTWw7bLS98AmJ2O7+q9CsBJYj3U+cMH82iIFb9z
         0idKOe0lJApN3Gi+rke2pLl/ClrkGosz9e2c85N2BKSi1yCMAWhwMyUa5U5bDWCQh2Wm
         dcf6TBzqTTp5oKEBieCJ5jeQV6ZMNiFAUKQZi7rBcrU4mbSXh6Tcl3V+NIFQug5A3qO8
         iwDg==
X-Gm-Message-State: AOAM531AOhwmwMX6ZaQ3fe3wTbomk0YB1h7Kv2Hl+v4PRKA6y0q2jJyV
        +AZEc1DgotdmQ0YTkNi0157FMwhLY+zj7A==
X-Google-Smtp-Source: ABdhPJzUeYoOukdRExosalWvLDh0lJXCRle9sf1tlFTJiFca0COBPCkr7/2ePocU4VxbSFLasmZrDQ==
X-Received: by 2002:a05:6214:23cc:: with SMTP id hr12mr10083257qvb.56.1631696437117;
        Wed, 15 Sep 2021 02:00:37 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.164.167])
        by smtp.gmail.com with ESMTPSA id w18sm7514644qto.91.2021.09.15.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:00:36 -0700 (PDT)
Message-ID: <6141b634.1c69fb81.a2cd.0a6d@mx.google.com>
Date:   Wed, 15 Sep 2021 02:00:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3268846463632050170=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Inclusive language changes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210915162843.Bluez.v5.1.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
References: <20210915162843.Bluez.v5.1.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3268846463632050170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=547147

---Test result---

Test Summary:
CheckPatch                    FAIL      22.27 seconds
GitLint                       FAIL      12.71 seconds
Prep - Setup ELL              PASS      52.59 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      9.67 seconds
Build - Make                  PASS      231.49 seconds
Make Check                    PASS      9.99 seconds
Make Distcheck                PASS      272.14 seconds
Build w/ext ELL - Configure   PASS      9.71 seconds
Build w/ext ELL - Make        PASS      217.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[Bluez,v5,05/13] tools: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#97: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#808: FILE: tools/l2test.c:113:
+static int central = 0;

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#2096: FILE: tools/rctest.c:79:
+static int central = 0;

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#2221: FILE: tools/rfcomm.c:40:
+static int central = 0;

/github/workspace/src/12495737.patch total: 3 errors, 1 warnings, 1905 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12495737.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[Bluez,v5,08/13] profiles: Inclusive language changes
WARNING:LONG_LINE_COMMENT: line length of 100 exceeds 80 columns
#218: FILE: profiles/health/mcap.h:273:
+	mcap_info_ind_event_cb	mcl_sync_infoind_cb;	/* (CSP Central) Received info indication */

/github/workspace/src/12495743.patch total: 0 errors, 1 warnings, 87 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12495743.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[Bluez,v5,09/13] src: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#97: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#141: FILE: src/adapter.c:155:
+static struct mgmt *mgmt_primary = NULL;

/github/workspace/src/12495749.patch total: 1 errors, 1 warnings, 478 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12495749.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[Bluez,v5,11/13] mesh: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#95: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#124: FILE: mesh/net-keys.c:56:
+static uint32_t last_flooding_id = 0;

/github/workspace/src/12495747.patch total: 1 errors, 1 warnings, 146 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12495747.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[Bluez,v5,12/13] unit/mesh: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#94: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

/github/workspace/src/12495751.patch total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12495751.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[Bluez,v5,05/13] tools: Inclusive language changes
7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"

[Bluez,v5,09/13] src: Inclusive language changes
7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"

[Bluez,v5,11/13] mesh: Inclusive language changes
4: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"

[Bluez,v5,12/13] unit/mesh: Inclusive language changes
4: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"


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


--===============3268846463632050170==--
