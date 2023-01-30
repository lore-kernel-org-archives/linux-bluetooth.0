Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5DBC54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 20:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjA3UNy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 15:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA3UNt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 15:13:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCCF34C27
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 12:13:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4334921pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 12:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngvkp4XPvAk8cYdxDzGQsNUDHWTDQu90l18M9I/4zYA=;
        b=bUT1gylYp5WCC/5uX/cuNcdcdbw/eDBhGyrzxIxDT5f6P6A9gQ7Ruzt7RgPqWcVJu8
         i5vRKOR/RkZIeN5HMTDDYiHBcSK5oo6YyCIya+ECc1mKOJSEoOlAv7c/2LF+RXB5qLfJ
         oZy9A2tvmYf7gNnMWvQCPRz5eXZmrve1/pXoOizyhbPD+7K0878AoFQoX8CDJg3Zv4Ks
         oJm+izsgf6oqdpw3oD2pNrTvTb4c6PwTtPYEz1cDk0ZYDXDn8alA3QDxEZsMtNxV2drp
         PQdD2qf+MQa02I/yIZ+dJKB2ucmA+F+eKPeH5fBL4CsXyNLeZB2WOeC1Fr6ZApOlY6Pd
         +UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ngvkp4XPvAk8cYdxDzGQsNUDHWTDQu90l18M9I/4zYA=;
        b=F9Tqkom/fEGdicwgL5v4O/mMgTGhomeZV8TzXlr7jga+n5ygUhA4uPr+YD9F/l2XdF
         XXtHUr52EusCBQbOPvFSF6nHV8fECc4o55Ut6FyM94H3F+qoXpBa2SkOaDf3uWo8nSVx
         G0fHVHhTZdYJNIZkmV4V8XrmjIdjd9IcWtIOQSe2dGMENgxrxOXMh8LIlt199l2kUoVs
         nXB6OWtPb/htTL5Ae55/aguc4vm7joN2zDapZ2vPXKFJICbU257hXX5ohkJGOHrFfUYA
         KIAlfrEbroirmjwXvXR8zR1nJcjzV5FCdPrt52cfGZ470dja6C//Ve0AWNma1NoQwzdF
         UNJQ==
X-Gm-Message-State: AFqh2kpMXcRxvH33UbQ7H41pxylR7XV/6jT3jssMunv0uP4LA+m7C3sU
        A+1rI2p8M9sUVS2LXnHrWfhRwgsEfbA=
X-Google-Smtp-Source: AMrXdXvDW9wvbMToLCitRn3VwlblvI9UnQg7soTpjX+/vakVtRlMlFVFrfQI1Z42n9C0nhhTi/cdUw==
X-Received: by 2002:a17:902:e88d:b0:195:f401:26b9 with SMTP id w13-20020a170902e88d00b00195f40126b9mr43206475plg.26.1675109627160;
        Mon, 30 Jan 2023 12:13:47 -0800 (PST)
Received: from [172.17.0.2] ([20.171.63.114])
        by smtp.gmail.com with ESMTPSA id p25-20020aa78619000000b00592d16e9a12sm6329257pfn.135.2023.01.30.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:13:46 -0800 (PST)
Message-ID: <63d824fa.a70a0220.17484.a766@mx.google.com>
Date:   Mon, 30 Jan 2023 12:13:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4054595936541905323=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/8] doc: add MGMT setting for CIS features, remove Quality Report
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
References: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4054595936541905323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717083

---Test result---

Test Summary:
CheckPatch                    FAIL      2.20 seconds
GitLint                       FAIL      1.53 seconds
BuildEll                      PASS      27.04 seconds
BluezMake                     PASS      745.55 seconds
MakeCheck                     PASS      11.00 seconds
MakeDistcheck                 PASS      146.65 seconds
CheckValgrind                 PASS      238.51 seconds
CheckSmatch                   WARNING   317.34 seconds
bluezmakeextell               PASS      95.56 seconds
IncrementalBuild              PASS      3050.31 seconds
ScanBuild                     PASS      938.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/8] doc: add MGMT setting for CIS features, remove Quality Report
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '0454e2d09570', maybe rebased or not pulled?
#99: 
commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),

/github/workspace/src/src/13121669.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13121669.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/8] doc: add MGMT setting for CIS features, remove Quality Report

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B2 Line has trailing whitespace: "    "
[BlueZ,4/8] tools/btmgmt: add names for MGMT setting bits for CIS feature support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,4/8] tools/btmgmt: add names for MGMT setting bits for CIS feature support"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1799:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4054595936541905323==--
