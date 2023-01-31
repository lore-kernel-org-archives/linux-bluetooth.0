Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF649C38142
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 05:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjAaFji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 00:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAaFjh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 00:39:37 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0481C6A4B
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 21:39:36 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s4so12427280qtx.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 21:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a5KZP2OPvQcSdgqd+1PMkN5A2infpDdifw05vDaBYbQ=;
        b=Pgfu8MwR3FCd+RJp6iGxOYGRh5tFSvr20LACmk+FOFv9S7Y+Q3S5jtJfPjUczdkVf4
         K2hA9oPlhlFsLC4IliJRthLnI1hWIF1Hj8pJZKmzoQjI7seT1+mrj1TrxRUJt7tPm5yj
         lXUVta74/B69VH8hTpdr7scrccMaIb9XBTkZm6QKWTcSC2mXx76HRq7uqJIpkT0L66Ag
         3mVp5Y8uqJcsa+rOLrEfNnZICwibxW8ATR52YAfb9NQzB13nZI0nyZPIN5TnZ+XGNUOt
         lReLtkjznKawzC8r8he7exaPvSOVuYngJWIdeM4dGYu5vNGhCS0NT60HHKD8JOaRgI7B
         5Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5KZP2OPvQcSdgqd+1PMkN5A2infpDdifw05vDaBYbQ=;
        b=DiyV6akIgfbP9+nvc2QIYSw41v2f78Wh/VT7DmGckuio4XrdU4yyzb8U6GgTIjyamx
         b1qJs5kx7aEjKf6yndCKyCb2FOzZZ7GcCR8zq1V2WPKlMuCqkOi7NjPW0y7Yi2vMONbz
         bzVTOXFtIunAawz7h8SYky35tRyBS0MMyjJAdQnIwNf/ce1kYQFvXJ+20Rcxa77c54Tl
         VQ6IhB4VlapBlLSM4ueXEiTDdcyZwj+lyRcjpAgntYmKiD1rivXaAvN1teKKvpCPLQve
         8HJT6PvH2I7wNP/p8WzLZ0+sjLBSbS2Sojv3P4ZvbIN+jI6V1Rb5edV55hCfIxf0N90t
         4zGA==
X-Gm-Message-State: AO0yUKU6ra9T2B+Blzy+QaOUU0OBCRu3b2JrNHNFOdQm2mpD8wZtQbD8
        rcAICBm15oNN6CoJ8yujVfx62pzP+HcXzw==
X-Google-Smtp-Source: AK7set95z5DNWtD1Rejld65Dsm9xLd5aoRnTwzJTKIu45mAB8ztuE13qjL2nFBSUbDlaSm5lau0r9g==
X-Received: by 2002:a05:622a:13ca:b0:3b8:6d3a:5ec7 with SMTP id p10-20020a05622a13ca00b003b86d3a5ec7mr8045196qtk.22.1675143574862;
        Mon, 30 Jan 2023 21:39:34 -0800 (PST)
Received: from [172.17.0.2] ([172.176.145.225])
        by smtp.gmail.com with ESMTPSA id x64-20020a379543000000b007090f7a4f2asm8915332qkd.82.2023.01.30.21.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 21:39:34 -0800 (PST)
Message-ID: <63d8a996.370a0220.ec711.b3aa@mx.google.com>
Date:   Mon, 30 Jan 2023 21:39:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2092808647349173901=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: Mesh v1.1 additions
In-Reply-To: <20230130235210.94385-2-brian.gix@gmail.com>
References: <20230130235210.94385-2-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2092808647349173901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717162

---Test result---

Test Summary:
CheckPatch                    FAIL      10.36 seconds
GitLint                       FAIL      4.76 seconds
BuildEll                      PASS      25.93 seconds
BluezMake                     PASS      732.15 seconds
MakeCheck                     PASS      11.10 seconds
MakeDistcheck                 PASS      145.48 seconds
CheckValgrind                 PASS      236.70 seconds
CheckSmatch                   WARNING   318.22 seconds
bluezmakeextell               PASS      95.66 seconds
IncrementalBuild              PASS      8397.10 seconds
ScanBuild                     PASS      928.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v5,02/14] mesh: Add Remote Provisioning
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3300: FILE: mesh/remprv-server.c:238:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3509: FILE: mesh/remprv-server.c:447:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3513: FILE: mesh/remprv-server.c:451:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3791: FILE: mesh/remprv-server.c:729:
+		/* fall through */

/github/workspace/src/src/13122065.patch total: 0 errors, 4 warnings, 3735 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13122065.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v5,07/14] mesh: Add Mesh Private Beacon server
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#227: FILE: mesh/prvbeac-server.c:74:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#239: FILE: mesh/prvbeac-server.c:86:
+		/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#246: FILE: mesh/prvbeac-server.c:93:
+		/* fall through */

/github/workspace/src/src/13122058.patch total: 0 errors, 3 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13122058.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v5,01/14] doc/mesh: Add Remote Provisioning DBus APIs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B3 Line contains hard tab characters (\t): "	* Refresh Device Keys"
12: B3 Line contains hard tab characters (\t): "	* Reassign Node Addresses"
13: B3 Line contains hard tab characters (\t): "	* Refresh Node Composition"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/mesh-cfgtest.c:1453:17: warning: unknown escape sequence: '\%'


---
Regards,
Linux Bluetooth


--===============2092808647349173901==--
