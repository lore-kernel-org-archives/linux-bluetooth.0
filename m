Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D2EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 07:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8436139A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 07:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEDHkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhEDHkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 03:40:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389B8C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 00:39:26 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j3so3970023qvs.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5Ecg1MawOjFVQZn/mjsEz0MzXbIoPmCoCOFTz5XxaM8=;
        b=h0NvjOtg3BQEoUVvDGWHlrQ+xPSzgzu+lA/2Ini1zTGWA6f0IABqpG8cZdsxuqnnKV
         fLZS9mhmfAavpalP03AUMzSU6a+CMgd/dtsDdcUZ2kBrtoyI0W6RugsXBnGT/21DjLsd
         4UiroXngFfZE1ZWlF/cqCrY9uZs797JGvfbmUEFgSmM7FxsX7v01oPNBfL2IRNGSUi35
         gR+br8yLa2GfyNmxvcYxuWOGFO/4i64GBe/S5LNXMAedH1kPSxC6UmpUisrywEHAWGUB
         OSdqh4IBuGbupWssvs07xjtv0fILfdiBsBgrSNC5XaZZmRtOBLjEhqPrqfTdbJSumnFk
         LTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5Ecg1MawOjFVQZn/mjsEz0MzXbIoPmCoCOFTz5XxaM8=;
        b=b6OVja4/OTMbcBZ78gi+ctQkaju2IC+fj3UwJHS0KSQl81eCdtibc4YAxw3mYuwF68
         euEhYdCLnsIJT8u/D67iPGjBKvxRo1fOju2ryN5FQOVb4U/rcs1jaIyQ3PHwVVogfGFr
         I+9dE5l1sQ05CMBdUtRF3f9JK8J0HPTS/Kv4KyNqO1jBaiMKY/MgsqG2oeER7PuXl8xY
         nB5FXudgKw1K3zoChRAYed8rO0M/yCP17kHOsl1NnqjccVWBlUAJabboi3pB9k86aa6y
         aHutMnjA6eCEtYX2kfKQNcI0sSYba+dktWcCCuHS7iWBbewGwWVGxmI2PFlUQfXNEZjR
         PR1Q==
X-Gm-Message-State: AOAM530om1uaI2CnTL98ZsT7kkcxN4TrHfUeTshSWzsMDQO/yMkXPVRq
        Aa+tv4+PCHk/p1hQBZvVSEanw24ph+Mzuw==
X-Google-Smtp-Source: ABdhPJzCML/E0JvXZGloB9rxHBYaHQR2yfIZOOHoqbExsJuumr5AEDXi7n1GFmMZYD7KBEinNxCZbQ==
X-Received: by 2002:a0c:e50e:: with SMTP id l14mr24010934qvm.52.1620113965248;
        Tue, 04 May 2021 00:39:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.19.254])
        by smtp.gmail.com with ESMTPSA id e15sm10311691qkm.129.2021.05.04.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 00:39:24 -0700 (PDT)
Message-ID: <6090fa2c.1c69fb81.53808.b1fb@mx.google.com>
Date:   Tue, 04 May 2021 00:39:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5616846020578563290=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: Convert manpages to rst format
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210504050207.841261-2-hj.tedd.an@gmail.com>
References: <20210504050207.841261-2-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5616846020578563290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476657

---Test result---

Test Summary:
CheckPatch                    FAIL      1.29 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      47.22 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  FAIL      200.01 seconds
Make Check                    FAIL      0.61 seconds
Make Dist                     PASS      11.75 seconds
Make Dist - Configure         PASS      5.09 seconds
Make Dist - Make              PASS      82.63 seconds
Build w/ext ELL - Configure   PASS      8.37 seconds
Build w/ext ELL - Make        FAIL      185.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
monitor: Convert manpage to rst format
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#125: FILE: monitor/btmon.rst:1:
+=====

- total: 0 errors, 1 warnings, 224 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Convert manpage to rst format" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

tools: Convert manpages to rst format
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#111: FILE: tools/bdaddr.rst:1:
+======

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#252: FILE: tools/btattach.rst:1:
+========

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#411: FILE: tools/ciptool.rst:1:
+========

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#652: FILE: tools/hciattach.rst:1:
+=========

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#1102: FILE: tools/hciconfig.rst:1:
+=========

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#1503: FILE: tools/hcidump.rst:1:
+=======

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#1889: FILE: tools/hcitool.rst:1:
+=======

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#2160: FILE: tools/hid2hci.rst:1:
+========

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#2298: FILE: tools/l2ping.rst:1:
+======

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#2469: FILE: tools/rctest.rst:1:
+======

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#2675: FILE: tools/rfcomm.rst:1:
+======

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#2919: FILE: tools/sdptool.rst:1:
+=======

- total: 0 errors, 12 warnings, 1414 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools: Convert manpages to rst format" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

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
monitor/btmon.rst:151: (WARNING/2) Cannot analyze code. Pygments package not found.
Exiting due to level-2 (WARNING) system message.
make[1]: *** [Makefile:11711: monitor/btmon.1] Error 1
make: *** [Makefile:4083: all] Error 2


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
monitor/btmon.rst:151: (WARNING/2) Cannot analyze code. Pygments package not found.
Exiting due to level-2 (WARNING) system message.
make[1]: *** [Makefile:11711: monitor/btmon.1] Error 1
make: *** [Makefile:10353: check] Error 2


##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - FAIL
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
monitor/btmon.rst:151: (WARNING/2) Cannot analyze code. Pygments package not found.
Exiting due to level-2 (WARNING) system message.
make[1]: *** [Makefile:11711: monitor/btmon.1] Error 1
make: *** [Makefile:4083: all] Error 2




---
Regards,
Linux Bluetooth


--===============5616846020578563290==--
