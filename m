Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17173C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE37461050
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhHBGuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhHBGuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:50:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF74C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:50:14 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a12so11037385qtb.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RvY5xyERrsZfnLby0GqgV33Y2/sRHfDbOFi5W4JY53M=;
        b=EyIo/bDMFGIyBWO0Siha+jeSeVav62J+ylzu3hGGh+MKLUl8fLKxzhxtoB3wr0UpNa
         D4STgb0jNfbLqrMd69SvnuL5G8pUlOcEO0qntwu68iClvZG5fB46kKy8QIzYA1kcskxS
         O/R3eOoIQznNLQvFdLjCRJKHNV0xktEPjGZ3FstrMT4Pqev4VXsqNqRtaa8NdRmBVMVj
         e8iFCsKxiOcu5l4XsjtlINtCdvjUn2d1n+t5MA9xV3tbRJUcxzL5KKMnsh+LDQbbGnc/
         9lr3hqm+6C2P25faIHzPap0snVzJvEjCNq8kzfI1Jzi5NOMeDUAknM46FZLK2CwgmfpV
         B+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RvY5xyERrsZfnLby0GqgV33Y2/sRHfDbOFi5W4JY53M=;
        b=CS70+jP3blS6KwwdeaibdpdMRl+STai751HmI2oUl+k1Fck1m5zbZJvJ6E83lhYFV2
         6GdR1Zx1i22sbm5AMkYSgK6wzAxOclef03q4EGcfks/PcNEhMr/W9xjpp8FLUO79O/dR
         PwDky+b3kBgVomU/NL29+19e8oF+zEfmaHb/PehjI/50M++Er2iHROZg5FA2FSSKdBvl
         UJBxrM22V9mz4Wc5OpUwuAteyathtXLhoACCDicItIjSct+4Y4TNn02Y2TsMn7nrofcu
         94d3uKeEdKmZBNDAUhr/V4UO08k+Yn6cfW/UIlMHqnoAmJ1QnQ80N3MoUZ3zcp4Y2Nep
         egYg==
X-Gm-Message-State: AOAM533EQDs2sxwuq5iEVQXiC/bU/z7czkiQjkZ1rBbIaxmH1Qacx1GX
        G8yh2uy/w/wH3jiDTN89MEe5jC42NRUQrw==
X-Google-Smtp-Source: ABdhPJzuQgACU4Fyo04rqrAsSvMxThs102lnEfUwmVg//sx+tV95pGmn32EgaCF5mOwXwjKgYa0TpA==
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr12971478qtp.148.1627887013001;
        Sun, 01 Aug 2021 23:50:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.121.54.37])
        by smtp.gmail.com with ESMTPSA id s3sm5502753qke.85.2021.08.01.23.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 23:50:12 -0700 (PDT)
Message-ID: <610795a4.1c69fb81.ba1e3.fd2d@mx.google.com>
Date:   Sun, 01 Aug 2021 23:50:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8332372526469909477=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: Admin policy series
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210802141140.Bluez.v7.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
References: <20210802141140.Bluez.v7.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8332372526469909477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=524779

---Test result---

Test Summary:
CheckPatch                    FAIL      5.01 seconds
GitLint                       PASS      1.80 seconds
Prep - Setup ELL              PASS      51.29 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      9.29 seconds
Build - Make                  PASS      230.56 seconds
Make Check                    PASS      9.10 seconds
Make Distcheck                PASS      268.60 seconds
Build w/ext ELL - Configure   PASS      9.11 seconds
Build w/ext ELL - Make        PASS      220.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
mcap: add adapter authorization
WARNING:NEW_TYPEDEFS: do not add new typedefs
#160: FILE: profiles/health/mcap.h:255:
+typedef guint (* mcap_authorize_cb) (const bdaddr_t *src, const bdaddr_t *dst,

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#171: FILE: profiles/health/mcap.h:281:
+	mcap_authorize_cb	authorize_cb;		/* Method to request authorization */

- total: 0 errors, 2 warnings, 148 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mcap: add adapter authorization" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

core: add device_added and device_removed to adapter driver
WARNING:SPACING: Unnecessary space before function pointer arguments
#130: FILE: src/adapter.h:114:
+	void (*device_added) (struct btd_adapter *adapter,

WARNING:SPACING: Unnecessary space before function pointer arguments
#132: FILE: src/adapter.h:116:
+	void (*device_removed) (struct btd_adapter *adapter,

- total: 0 errors, 2 warnings, 112 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] core: add device_added and device_removed to adapter driver" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin: add ServiceAllowList property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#63: FILE: plugins/admin.c:186:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 82 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin: add ServiceAllowList property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin: add AffectedByPolicy property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#65: FILE: plugins/admin.c:254:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 120 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin: add AffectedByPolicy property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin: persist policy settings
WARNING:LINE_SPACING: Missing a blank line after declarations
#164: FILE: plugins/admin.c:340:
+	struct queue *uuid_list = NULL;
+	gchar **uuids = NULL;

- total: 0 errors, 1 warnings, 216 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin: persist policy settings" has style problems, please review.

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


--===============8332372526469909477==--
