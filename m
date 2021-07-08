Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA8C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9992161C94
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGHGi5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhGHGi4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:38:56 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0ECC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:36:14 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x6so2322253qvx.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=17vkLAJUEF2UFW5t0NbQleaT/JAgt77Qm/9LQ8YqFCg=;
        b=oMVrutPDbWww9PSFDRb8bWs6j0h9e6zyTqIoGwT4MD8kDXPR6Ik3vhHHVycSPwZHs3
         1vVl1JgPHDHHITybraP48sH+wBtC5X2sbRCYhWyiNe7co7jt/SIA7tf8atzO0V7JytD2
         Q05OTClWlBU3r31ucnxaKFazMe8FZ3tm9/SdNXXwRw+T92vzez5XmnzmWiA3PQ+WdS1O
         Y5ckcOGPxIEseuvyZhU2iF5DWlci4kdQyKU2L6hNEab0+36iYrDMyMVW0VVxp3vRJrz/
         qaDPbKZUdsjKs1UcSDyPrRddP95X6l9NKHlvf73/VkLVo9gSk1MyZPo4APSN5WUNELsb
         sxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=17vkLAJUEF2UFW5t0NbQleaT/JAgt77Qm/9LQ8YqFCg=;
        b=AqOMkJoSmlFKjsM5i/qDECQ13aTZWn+KsSKGRreEp1BT4O+v0jTQnrcsr5WT1/SadY
         ghtwpFzBV/KN4/rq2yGiQnu+KdyI0xa8Tt2QeXksa4l0ptE3NkvlBzo/iMy8tSjs7oi0
         ZTZ1O1Z+Wf2Wq1g4QxXr5b1Cf0Z2D0IPoRjVuRHpmgjVG3yUHEHAtYbGZMMeaHOsyeU6
         5CAUazQ1EoW32MgPPmFlc3YQXIPjOHYmh5gT/XRnTWXEnhh0NilKBzX8vsghPjPKbmLq
         1/uA2SJdEtAQmlcNasC+dMRdyqBhiQ/bMJIOrNgnYeCDeCnbTl429xUxU0eM+wIniyIH
         Slqw==
X-Gm-Message-State: AOAM531tObdcBu5vkt3JMBTnZJLqsBz6PN76YY++urVAxil4XaVK+bE1
        OtEWnjVpoUJ3EyqUIygcc200tDZVDttbWA==
X-Google-Smtp-Source: ABdhPJx23uY3miTARiGzlUowmvy/ap+f12dpgYr3hB83psln8m0j1rHv87I4vlcWgbh/w/d8E9gdHQ==
X-Received: by 2002:a05:6214:1921:: with SMTP id es1mr28438004qvb.61.1625726173238;
        Wed, 07 Jul 2021 23:36:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.230.160])
        by smtp.gmail.com with ESMTPSA id n191sm622171qke.10.2021.07.07.23.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 23:36:12 -0700 (PDT)
Message-ID: <60e69cdc.1c69fb81.8ec65.3e89@mx.google.com>
Date:   Wed, 07 Jul 2021 23:36:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5133820772035609123=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1,01/14] lib: add hash functions for bt_uuid_t
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210708142059.Bluez.v1.1.I69278fab3bf86adb578c5cba0a39e5bcf7f9581e@changeid>
References: <20210708142059.Bluez.v1.1.I69278fab3bf86adb578c5cba0a39e5bcf7f9581e@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5133820772035609123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=512335

---Test result---

Test Summary:
CheckPatch                    FAIL      3.75 seconds
GitLint                       PASS      1.46 seconds
Prep - Setup ELL              PASS      40.49 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.11 seconds
Build - Make                  FAIL      65.27 seconds
Make Check                    FAIL      0.32 seconds
Make Distcheck                FAIL      84.18 seconds
Build w/ext ELL - Configure   PASS      7.17 seconds
Build w/ext ELL - Make        FAIL      54.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
plugins/admin_policy: add ServiceAllowList property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#62: FILE: plugins/admin_policy.c:185:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 81 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin_policy: add ServiceAllowList property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin_policy: add AffectedByPolicy property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#65: FILE: plugins/admin_policy.c:294:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 133 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin_policy: add AffectedByPolicy property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin_policy: persist policy settings
WARNING:LINE_SPACING: Missing a blank line after declarations
#153: FILE: plugins/admin_policy.c:334:
+	struct queue *uuid_list = NULL;
+	gchar **uuids = NULL;

- total: 0 errors, 1 warnings, 207 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin_policy: persist policy settings" has style problems, please review.

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
Test: Build - Make - FAIL
Desc: Build the BlueZ source tree
Output:
/usr/bin/ld: lib/.libs/libbluetooth-internal.a(uuid.o): in function `bt_uuid_hash':
/github/workspace/src/lib/uuid.c:136: undefined reference to `g_int64_hash'
/usr/bin/ld: /github/workspace/src/lib/uuid.c:136: undefined reference to `g_int64_hash'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5351: peripheral/btsensor] Error 1
make: *** [Makefile:4140: all] Error 2


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
/usr/bin/ld: lib/.libs/libbluetooth-internal.a(uuid.o): in function `bt_uuid_hash':
/github/workspace/src/lib/uuid.c:136: undefined reference to `g_int64_hash'
/usr/bin/ld: /github/workspace/src/lib/uuid.c:136: undefined reference to `g_int64_hash'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5351: peripheral/btsensor] Error 1
make: *** [Makefile:10429: check] Error 2


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
/usr/bin/ld: lib/.libs/libbluetooth-internal.a(uuid.o): in function `bt_uuid_hash':
/github/workspace/src/bluez-5.60/_build/sub/../../lib/uuid.c:136: undefined reference to `g_int64_hash'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../lib/uuid.c:136: undefined reference to `g_int64_hash'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile:5692: tools/btgatt-client] Error 1
make[1]: *** [Makefile:4140: all] Error 2
make: *** [Makefile:10350: distcheck] Error 1


##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - FAIL
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
/usr/bin/ld: lib/.libs/libbluetooth-internal.a(uuid.o): in function `bt_uuid_hash':
/github/workspace/src2/lib/uuid.c:136: undefined reference to `g_int64_hash'
/usr/bin/ld: /github/workspace/src2/lib/uuid.c:136: undefined reference to `g_int64_hash'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5351: peripheral/btsensor] Error 1
make: *** [Makefile:4140: all] Error 2




---
Regards,
Linux Bluetooth


--===============5133820772035609123==--
