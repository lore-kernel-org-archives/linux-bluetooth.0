Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CE8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FF960F58
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhHCImx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbhHCImx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:42:53 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EDDC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:42:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z24so19167288qkz.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=acfCnHOPQA6HAQ3Nr29t3pXYywRMcfHQQp7kPxml568=;
        b=gWeTtCgv/I0KdaVBn4xVoCvVAnp5+Ul/uwy5OgBv/pUCdggyiZ+4QIsiOuL4exmY/0
         soxFTypiVtCrCW/hAQIjKgPc75avu/KjwdgGxIDRTh5wNHpCbUzn7DEt3dw/hIhuoHNB
         WCj4leAphrOf+DUITlx5bMO5dyNSoSFvG35sFmSKswDsmO1tCKLiJqa6imGqhoztE2BD
         +BYHqZzZdSaxpNMWEv7GoJ7ZUVGN0ZS3y8mQ8+on5Teg3I/GzDlqc94NNcDUM3eLXp8s
         ekalu4PDkK8wr6y74g8QrDaewoREcHm4fPq9G4sSOBIThivhZEHfMnyCrESWR7D6LFOa
         30Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=acfCnHOPQA6HAQ3Nr29t3pXYywRMcfHQQp7kPxml568=;
        b=QGgfsl8Z4zk54cMGIVjhCEdgW7qOpK8uFbCQybPEwJAfrNe3o52Pa4lhH20Lklp24k
         1OuBMJK3ovtEjC65fMo6tGGwNv3+MzCb8tzpDUN0+LvFLYX3EbEFWH6TPEHM9hUG5EzI
         a/H+bFEOFCq8DFSbLblkgLzE60LCCYcFRPCiJr3Ja0hmvGJU2RT34RSu8nKDWjHzG0u+
         DFmxS0+SufgxnV6oZ5xj0gf/0oXFyxJy1gTBYXZQkX7+bQTwHYP0L0BONRoggYnUQ297
         T3af2BatHA8n+Ucqape9rjBuKf5/ifyM8jr0wdWEdi7+0GnCUHReDw2A/wkMqjSLbE8a
         GgYw==
X-Gm-Message-State: AOAM5324uYEvsTMiZuF7BIs+6G54z9AJ+hRWblvL29I1HDs6LhBB5MBk
        pLx8Y0ig2lz6h2ng8cOnxuvgSEf4ylXKHg==
X-Google-Smtp-Source: ABdhPJyBBjYL6ZX+Jzu6czfBVxv8Im1xR4GIyZRwpLtgZVsz2EIOiu8nCvO0ogulyKPxlpmZ/9LmKA==
X-Received: by 2002:a37:ccb:: with SMTP id 194mr19877711qkm.369.1627980161689;
        Tue, 03 Aug 2021 01:42:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.81.63])
        by smtp.gmail.com with ESMTPSA id 18sm7684157qkv.118.2021.08.03.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 01:42:41 -0700 (PDT)
Message-ID: <61090181.1c69fb81.44f92.d1a0@mx.google.com>
Date:   Tue, 03 Aug 2021 01:42:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5875222100720029800=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: Admin policy series
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210803161319.Bluez.v8.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
References: <20210803161319.Bluez.v8.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5875222100720029800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=525459

---Test result---

Test Summary:
CheckPatch                    FAIL      3.11 seconds
GitLint                       FAIL      1.28 seconds
Prep - Setup ELL              PASS      38.33 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.68 seconds
Build - Make                  PASS      163.49 seconds
Make Check                    PASS      8.11 seconds
Make Distcheck                PASS      201.69 seconds
Build w/ext ELL - Configure   PASS      6.74 seconds
Build w/ext ELL - Make        PASS      153.94 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
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
#135: FILE: plugins/admin.c:260:
+	struct queue *uuid_list = NULL;
+	gchar **uuids = NULL;

- total: 0 errors, 1 warnings, 208 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin: persist policy settings" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
core: add device callbacks to adapter driver
5: B3 Line contains hard tab characters (\t): "device_added:	 called when a device is added to the adapter"
6: B3 Line contains hard tab characters (\t): "device_removed:	 called when a device is removed from the adapter"
8: B3 Line contains hard tab characters (\t): "				 resolved."


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


--===============5875222100720029800==--
