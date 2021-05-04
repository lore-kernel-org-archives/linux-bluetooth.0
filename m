Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA990C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 08:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C99611AD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 08:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEDIpO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 04:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhEDIpN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 04:45:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319E3C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 01:44:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 197so7487286qkl.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rz1Lu4nHAfnQaIXyLedFXxjwRNoDFBit05NVfxSHj44=;
        b=c9naxNXEmKk/spHlYC4OWbxQiv8M9daCnxFBvp22iMgdo3U5hFTumckzK8YrIUHAsA
         beKqgKsSPp9s0q7RzewENl+R4mqKGqJiiMGp21LhAqFTXK2y5BzOexL2dl8NTk+Vjh01
         uLHsGUB68KCu9ClU3VUjDeZ6Gk26QTlRMS8o3NHxr/e2vMQN0J8QEJpf51OpoAbvULGe
         OFWhaPo2yDxzcEBRPgEolJas6+DWlXumEgEYDjuo/XxDne1kON+tXE8hT9mpnYCEVr6x
         nZEK6Pb+bYjqh7B0JOkQe4XLOpSg5B5vlYYbcEN4q1bN41X5m6n+Ck9bn3qx9g2dbpSr
         4btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rz1Lu4nHAfnQaIXyLedFXxjwRNoDFBit05NVfxSHj44=;
        b=JCbvWz7rFaSpinrn0IjLyUZkZQZk0SpC3qBgFwA806CPtZKZu+HYU+mH6MSGpTxme+
         ctWeIna+lMmg7E/CW11bE/7+4hiE2PfzAa6DQnw5lYQM0T6ttNyep0snGnos00bp5syk
         +qsX0gSPhSRBO2pYFu1Qudy2++XJjpRCCWYQxXZmI5Kti+9Sh7q5u8gS8X20GtcsiZS3
         y1G5FWCJIJI5rRd4eCAk04yQzrGS7A0txUMYCdMMrIgDiFEOuBMi9Z4HdFVh/oOirYpG
         3QuaNvi2aesEzGRUF6mk03n+/0gt7CEkA4MbFElOq1HFimrXBhVGYqFWROCLpreHVAx0
         3NKw==
X-Gm-Message-State: AOAM532WQPgIAG5iMMnChl9F4sDuAj3bt1yhM3Mm2Lw+tBXWAgz17mef
        kyngY5MMdWSg6APojJfn0Sg8gnLyJwOhug==
X-Google-Smtp-Source: ABdhPJy2N6dhSxRBiHlZpkaj6Z4evyB4NdO3BsJ8EsJBa4m6p9OLWFlThJ43OcHlYRgRj8PMNcwQ8A==
X-Received: by 2002:a05:620a:49c:: with SMTP id 28mr23972066qkr.39.1620117858109;
        Tue, 04 May 2021 01:44:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.84.121])
        by smtp.gmail.com with ESMTPSA id w67sm10771161qkc.79.2021.05.04.01.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 01:44:17 -0700 (PDT)
Message-ID: <60910961.1c69fb81.d76ca.db48@mx.google.com>
Date:   Tue, 04 May 2021 01:44:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7801120354917415417=="
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

--===============7801120354917415417==
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
CheckPatch                    FAIL      1.09 seconds
GitLint                       PASS      0.49 seconds
Prep - Setup ELL              PASS      48.06 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      205.97 seconds
Make Check                    PASS      9.56 seconds
Make Dist                     PASS      13.28 seconds
Make Dist - Configure         PASS      5.14 seconds
Make Dist - Make              PASS      82.48 seconds
Build w/ext ELL - Configure   PASS      8.44 seconds
Build w/ext ELL - Make        PASS      191.12 seconds

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
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

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
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============7801120354917415417==--
