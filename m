Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F382C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9C7611EE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhEDFmN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 01:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhEDFmN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 01:42:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E2C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 22:41:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k127so7483770qkc.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 22:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QXldqrtXEdptQ9JJTgiOrmMHGGv1SMhEofdqHtKN8HU=;
        b=ZHSSnBB2Y8MHxamwxpHN8WqlMyaox8MRqhCq0xfzjCKrJvDX5NhQQPDEtmgHt88/XQ
         8eSWuuGF/m0DgwpYoUSt4NmEYX88CuPngexFcwaA6ni/lFpeccGT5rgmyXtwfqiRvpSr
         TiXfbsBnI7xby3sQENZyYmrj/D+QeHtIivkhB91snBXsDOSXsU+WcPcpx0Q/w0bYtIO3
         qZ2aSGnnZcyx8A6kevXI0MozZCdK9W303nFyHIdojkrJO4WrTDYsvkQgfdyKSzpAgjXS
         8NmssnW4NZq47bdxvnQaUMXPEAts3AFxatXEigOMLHSbLoRpyyDNxXe/8vNih3mk0OGE
         Q3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QXldqrtXEdptQ9JJTgiOrmMHGGv1SMhEofdqHtKN8HU=;
        b=hTDX8CC1TXowqZg+sMsaJZOnACgvyrYzzh/MGr5y5UPjRVddbk5wzG87g1eoZk0Vt/
         HUFgHWpjgQ2+ZQSvsII3CGI63ZYxFUL4laBmO1TJtByCBNPgQ0RjrlC9KCQSfforv8Mm
         5T7zVjfYmNtaIaF5eActR/xpnr3SFX5KcubUduLFBfY7gMK20h/ibrsWM4HLE4kxD+ny
         +sBJJP7st1jjQMLNsCqpW10KN7C/Hu+ReAb2Y9hGKwL1aEkwkUA91/fgU9ud2uAfyNpi
         Ts3TFpgt6N7ygsFLGhkubWv0pJK+9Z/55X/cRzdp2e8L4OSXntuZz9IGv0PzJmOpRVAC
         b34w==
X-Gm-Message-State: AOAM532liIp3xc7RxPr9gFPt9wOz6LOWuwj/uoyK3KwhPg60DS/DYjZ3
        DRbPaVtRpg7VkkyxMQYatrZPfVj+zPvrxg==
X-Google-Smtp-Source: ABdhPJxjNQSJUPruGz9ZB8XjdexYMTfIcXIKfRhAHJlg1xp8djIdgtxREmfLu0//I13VNKt/nDWbzw==
X-Received: by 2002:a05:620a:21db:: with SMTP id h27mr22695244qka.26.1620106878303;
        Mon, 03 May 2021 22:41:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.192.193])
        by smtp.gmail.com with ESMTPSA id i2sm1749807qtg.0.2021.05.03.22.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 22:41:17 -0700 (PDT)
Message-ID: <6090de7d.1c69fb81.a58e3.ba68@mx.google.com>
Date:   Mon, 03 May 2021 22:41:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8824847232094337258=="
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

--===============8824847232094337258==
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
CheckPatch                    FAIL      1.19 seconds
GitLint                       PASS      0.49 seconds
Prep - Setup ELL              PASS      46.57 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.98 seconds
Build - Make                  FAIL      195.74 seconds
Make Check                    FAIL      0.65 seconds
Make Dist                     PASS      12.38 seconds
Make Dist - Configure         PASS      4.97 seconds
Make Dist - Make              PASS      79.32 seconds
Build w/ext ELL - Configure   PASS      8.11 seconds
Build w/ext ELL - Make        FAIL      184.19 seconds

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


--===============8824847232094337258==--
