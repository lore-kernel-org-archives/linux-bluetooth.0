Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5FCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8B260E94
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhIFIkG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbhIFIkF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:40:05 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E68EC061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:39:01 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id a5so3629819qvq.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yfDRXw6R9Jp3gU836CocmruD00ciV9lL3PfJRYYQEeM=;
        b=fjH5FQEiBS9c0ifC2PP9WsuZeTGuL45LHMR1kM4GAwvlMiXd/pcucRpHzsl0x0QbXQ
         +/3TbJZ58cghc3ODmn/eSXfsxSQefTVBSxPGrJVh+1da++zp8jb9fp5m81HLFmrAIfk7
         nkj7OPK6PRP32/jut0eFEFC5F7PKxCzYK835l2YTcdu3PKujcEZh/8prByA1IwpmHUf6
         VciSj5rE42GuyM3aT2r9nD8h5pzcuHrqOu95JsKQo+4xRIVX1kwkYSUtr0KSBDJuKT6r
         vcK55b57gfDlpR57MdmInaYYew2IVI4A7GmeTEWfx9rJ5TDoq3vHoo1AI1Wimrikbma9
         5hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yfDRXw6R9Jp3gU836CocmruD00ciV9lL3PfJRYYQEeM=;
        b=VsRqcAAgDV351QAFHECoTM13Oc7o1hDzx0EAXLaW7fHKPR635Fyhyuyf/+UJnyv6UY
         pe81tHSJvLvTT6NI7RCPrcKVU6XWpyWdf4DV4k7LHQrKQ/JlybuPOLwzI0p2YRj1k9Kb
         v9Kohrm8VHZvwXtJc5wjfDlULqE/iPIWhG1U5qPf6AlpoajlI9LvJpLMUbAsuJuksEjY
         LebxHayIM+NQEHdR4cJCIlZbq0J8c3E6ofX2NJmk0RMyxCMCoN21/tWIivCn0lgn7ZOd
         bz0td0+xeFGYT+5g8ToFt17BxPeeNrKwpXNtpY+zIEi2FTs29s0rGb2HQFbhXdVDul5C
         7a7A==
X-Gm-Message-State: AOAM5302sDcfyTIsmUi3wsYdRHet+5GBFnK3sbZhff0yX/2deum10Ctz
        DGvqf3ZBQp4FDEa7ov6YShm0bfq7y9HDDg==
X-Google-Smtp-Source: ABdhPJzFcZLz0w4urIbx10bUYN8PIyTP1XnidHmmElVVQDJowlVI1UrxkHwA4TobKZqX3hQ4ypA+eQ==
X-Received: by 2002:a05:6214:332:: with SMTP id j18mr10742997qvu.12.1630917540047;
        Mon, 06 Sep 2021 01:39:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.123.226])
        by smtp.gmail.com with ESMTPSA id d20sm5980015qkl.13.2021.09.06.01.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 01:38:59 -0700 (PDT)
Message-ID: <6135d3a3.1c69fb81.fd258.f33c@mx.google.com>
Date:   Mon, 06 Sep 2021 01:38:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4592171304734531728=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Inclusive language changes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210906160340.Bluez.v4.1.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
References: <20210906160340.Bluez.v4.1.I2169032b03520f33b73ca4dc7f2ae7ab0a901da3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4592171304734531728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=542379

---Test result---

Test Summary:
CheckPatch                    FAIL      4.00 seconds
GitLint                       FAIL      1.20 seconds
Prep - Setup ELL              PASS      39.57 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.17 seconds
Build - Make                  PASS      167.55 seconds
Make Check                    PASS      8.70 seconds
Make Distcheck                PASS      202.81 seconds
Build w/ext ELL - Configure   PASS      7.12 seconds
Build w/ext ELL - Make        PASS      158.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#10: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#985: FILE: tools/l2test.c:113:
+static int central = 0;

WARNING:MISSING_SPACE: break quoted strings at a space character
#1030: FILE: tools/l2test.c:1340:
 	while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
+		"AB:CD:EF:GH:I:J:K:L:M:N:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#2331: FILE: tools/rctest.c:79:
+static int central = 0;

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#2483: FILE: tools/rfcomm.c:40:
+static int central = 0;

- total: 3 errors, 2 warnings, 2296 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools: Inclusive language changes" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

profiles: Inclusive language changes
WARNING:LONG_LINE_COMMENT: line length of 100 exceeds 80 columns
#116: FILE: profiles/health/mcap.h:273:
+	mcap_info_ind_event_cb	mcl_sync_infoind_cb;	/* (CSP Central) Received info indication */

- total: 0 errors, 1 warnings, 87 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] profiles: Inclusive language changes" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

src: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#10: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#36: FILE: src/adapter.c:115:
+static struct mgmt *mgmt_primary = NULL;

- total: 1 errors, 1 warnings, 478 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] src: Inclusive language changes" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

mesh: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#28: FILE: mesh/net-keys.c:56:
+static uint32_t last_flooding_id = 0;

- total: 1 errors, 1 warnings, 146 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mesh: Inclusive language changes" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

unit/mesh: Inclusive language changes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

- total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] unit/mesh: Inclusive language changes" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
tools: Inclusive language changes
7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"

src: Inclusive language changes
7: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"

mesh: Inclusive language changes
4: B1 Line exceeds max length (95>80): "https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf"

unit/mesh: Inclusive language changes
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


--===============4592171304734531728==--
