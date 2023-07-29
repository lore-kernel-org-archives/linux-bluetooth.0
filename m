Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532AAEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 03:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjG2DgY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 23:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjG2DgX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 23:36:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5091BD1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 20:36:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9b89627c3so2280203a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 20:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690601780; x=1691206580;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2cMldluqtOKsXCfkRkgX+5QWOckkA+p6tyvBFznBogY=;
        b=ZxYEUYrYg5BBKuLqcQZbJHB+yy9EAY6P1W+9QxBxxEAK7UuDrkLDjTxcMfbjk3+vpH
         L7R8T2WKq2T4WOuOSZdkEUztw4lKAYThqNmWRTsjy+lxwe5ely/UqTpFEkpIepf4Ad3K
         BI4CFCS0uzHo+Bmzkgfa1LNGmwTSTyZPz+a5AvAWMpfbFbEKxvUJR4n7GMORJ2jhyaqL
         EsV2odvQgKy7IF9o1xBjcogpJ12Se+7F5tCwHEBifngzS53EsG4mI82QdWN8uECqpkAA
         ruOe4Nw6NHTJ6UmUzRkrN/5TEs9CWHc+mGZj69tEokUspSv4thdohkIfbJom1jG6FVgI
         ikmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690601780; x=1691206580;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cMldluqtOKsXCfkRkgX+5QWOckkA+p6tyvBFznBogY=;
        b=RnRxRjEB+/A+MH6mZe55itUfmNqo5Mp4XjSzkfgdui1YMu2uGOJu1yEBoMj7xbFUKI
         SVZFJwGG1iJIAwpVDmuxwwIkgjY0jKXxpjCDSvzD/ncVGvyOJ/ATAfU5Job7xV7GWtqT
         68LrkaVtfSMzHUsVmBzmY5vNIgCgAabOsPMVM3cpJbtzs/Yuy98vYYX5lsGlKbvqOb1H
         UWmr/5LMemKJVvKn8CXH+jBjp1XZ+SIGUMuguACRZz3hS3w3duOvVRxZZRmGcPwDL0kW
         6I1CwEefQgSY0IGclUOdhmCfZbtzHBWloVBZ0JwvaDjafOPvA2VLYLPywdbwOGI6tlIa
         VT8Q==
X-Gm-Message-State: ABy/qLY4naAvF4s4o8QYO05MqtTyv1cWP5ZW9OtHqpwaV6kSpce+Gp7P
        Hv280PSxk9XMsLTQXtN0d/RI3kQYOqI=
X-Google-Smtp-Source: APBJJlEEkHNFYT3LPn4t37NRyLzr4yrOy8lM17vsOse1uURP+OS1MMfvc/peTm+seaWskUOLdG111Q==
X-Received: by 2002:a05:6808:1290:b0:3a1:de77:2cc2 with SMTP id a16-20020a056808129000b003a1de772cc2mr6153364oiw.20.1690601780188;
        Fri, 28 Jul 2023 20:36:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.72])
        by smtp.gmail.com with ESMTPSA id i12-20020aca2b0c000000b003a1f359ba4esm2280691oik.14.2023.07.28.20.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 20:36:19 -0700 (PDT)
Message-ID: <64c48933.ca0a0220.be97a.0429@mx.google.com>
Date:   Fri, 28 Jul 2023 20:36:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5565865873904763875=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lukasz.rymanowski@codecoup.pl
Subject: RE: Couple of improvements to btmon
In-Reply-To: <20230729004552.1422547-2-lukasz.rymanowski@codecoup.pl>
References: <20230729004552.1422547-2-lukasz.rymanowski@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5565865873904763875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770766

---Test result---

Test Summary:
CheckPatch                    FAIL      2.82 seconds
GitLint                       FAIL      1.85 seconds
BuildEll                      PASS      34.16 seconds
BluezMake                     PASS      1217.85 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      199.29 seconds
CheckValgrind                 PASS      313.32 seconds
CheckSmatch                   WARNING   452.23 seconds
bluezmakeextell               PASS      133.58 seconds
IncrementalBuild              PASS      5272.12 seconds
ScanBuild                     WARNING   1463.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/5] monitor: Fix decoding Command Complete for Remove ISO Data path
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#88: 
< HCI Command: LE Remove Isochronous Data Path (0x08|0x006f) plen 3                                                        #1061 139.246292

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#122: FILE: monitor/bt.h:2868:
+} __attribute__ ((packed));

/github/workspace/src/src/13332856.patch total: 0 errors, 2 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13332856.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/5] monitor/ll: Add support for connection parameter command.
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#141: FILE: monitor/bt.h:111:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#157: FILE: monitor/bt.h:127:
+} __attribute__ ((packed));

/github/workspace/src/src/13332857.patch total: 0 errors, 2 warnings, 110 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13332857.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/5] monitor: Add support to decode le read ISO link quality
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#88: 
    > HCI Event: Command Complete (0x0e) plen 34                                                                              #14 24.982811

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#116: FILE: monitor/bt.h:2921:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#128: FILE: monitor/bt.h:2933:
+} __attribute__ ((packed));

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#141: FILE: monitor/packet.c:8949:
+static void le_read_iso_link_quality_cmd(uint16_t index, const void *data, uint8_t size)

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#148: FILE: monitor/packet.c:8956:
+static void status_le_read_iso_link_quality_rsp(uint16_t index,  const void *data, uint8_t size)

/github/workspace/src/src/13332858.patch total: 0 errors, 5 warnings, 74 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13332858.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/5] monitor: Fix decoding Command Complete for Remove ISO Data path

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B1 Line exceeds max length (139>80): "< HCI Command: LE Remove Isochronous Data Path (0x08|0x006f) plen 3                                                        #1061 139.246292"
8: B1 Line exceeds max length (139>80): "> HCI Event: Command Complete (0x0e) plen 6                                                                                #1062 139.246954"
15: B1 Line exceeds max length (139>80): "< HCI Command: LE Remove Isochronous Data Path (0x08|0x006f) plen 3                                                        #1061 139.246292"
19: B1 Line exceeds max length (139>80): "> HCI Event: Command Complete (0x0e) plen 6                                                                                #1062 139.246954"
[BlueZ,3/5] monitor/ll: Add support for connection parameter command.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,3/5] monitor/ll: Add support for connection parameter command."
[BlueZ,4/5] monitor: Add support to decode le read ISO link quality

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B1 Line exceeds max length (139>80): "    > HCI Event: Command Complete (0x0e) plen 34                                                                              #14 24.982811"
[BlueZ,5/5] monitor: Add parsing Service Data of UUID 128

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B3 Line contains hard tab characters (\t): "	Unknown EIR field 0x21: 3a048f2ba97ea6ae1b49c619e973a4a701480d130d"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3602:52: warning: array of flexible structuresmonitor/bt.h:3590:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3602:52: warning: array of flexible structuresmonitor/bt.h:3590:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3602:52: warning: array of flexible structuresmonitor/bt.h:3590:40: warning: array of flexible structuresmonitor/pac
 ket.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3602:52: warning: array of flexible structuresmonitor/bt.h:3590:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/packet.c:12426:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5565865873904763875==--
