Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C686C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 13:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBKNpV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 08:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKNpU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 08:45:20 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532522A33
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 05:45:18 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id ch10so7750813qtb.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1fgusKIUyufGb4mnmJXeAgxdwxOwEVvknrXw0An0V60=;
        b=KklhsUIIS9A77hdrRl5orS2g8UG545vVzH3Nrs/3RBPTqYbN3ZLq8LlQ/PBaM9mW8I
         ozWJWHdmtqaWNalwIo70PiWDIHt7n0ATuVDnSU8hkp7NF2p9dWDmWE8hwKeTO0BCiE9H
         vnA3XxpGE9ANzh4fx9Rnk2UlQfbEtb1sIv+1h1o4wSCRna8JLGkvXxSTigXjoqB2KXdd
         zKT5dvvxSNbRiHX9HTYJzZ7C6GRsBp+e046ic1KbdLb5WLeitppkQ+ZMrlWeioGvTosp
         7bSj/mPgLx0DYAScGaN/yX76wR5GKmSxpV122QSgm/uiRcqw/CkEQ7BczNTdlEW87Du6
         mfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fgusKIUyufGb4mnmJXeAgxdwxOwEVvknrXw0An0V60=;
        b=h4AO49hXwLLxe3ZjWn7HW1yB6cZUplYCrmF2qgL2ZAsiwD7bSqqeyJ1a4334MKwWHn
         Qy5h606vCr8o/tYksoZABONlOtAmQbnV+SxQj7HFn+uaRnmP2AL27fgKonfbkVcpATLg
         VW1QPgS26/BUnA8NgnJEjzMXXqQNp2yoqqaI1mKH7WPpIPp1E4Mrmzby5l53IvblLbpv
         /JOd24tgIo5kL/M217dWak40mpcILz9Y9yesILVtnH80JIuYVxjNl74gdCqrakOjz4ha
         y72Z8qwKcRvQwfK0ypvx2HG4irInf6I4AEhxlKPln1h0rt7Cp6plFkpej4C3SWCZkO1j
         w6LA==
X-Gm-Message-State: AO0yUKWTXmd35Tnxe896s1WnFcAeu/7UMEcyjLyc46rcrr4Qaqab3vDV
        wuaojxkeZaNP2+lDaTjvs3UrSTxLIUQ=
X-Google-Smtp-Source: AK7set9FvRL0YhXh4y5U5Hr/B+BMLCRjC9M3FuP3VhnmHzA1aYl++6l5H+x7sLZByp0YDDXcKOeqgQ==
X-Received: by 2002:ac8:5955:0:b0:3b3:7d5:a752 with SMTP id 21-20020ac85955000000b003b307d5a752mr31764960qtz.50.1676123117617;
        Sat, 11 Feb 2023 05:45:17 -0800 (PST)
Received: from [172.17.0.2] ([172.176.229.20])
        by smtp.gmail.com with ESMTPSA id h19-20020ac87453000000b003b9a6d54b6csm5295159qtr.59.2023.02.11.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 05:45:17 -0800 (PST)
Message-ID: <63e79bed.c80a0220.ce7ec.0cd9@mx.google.com>
Date:   Sat, 11 Feb 2023 05:45:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6395576611812246262=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/9] doc: remove unimplemented Quality Report from MGMT settings
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6395576611812246262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=720945

---Test result---

Test Summary:
CheckPatch                    FAIL      4.60 seconds
GitLint                       FAIL      3.23 seconds
BuildEll                      PASS      26.90 seconds
BluezMake                     PASS      865.81 seconds
MakeCheck                     PASS      11.33 seconds
MakeDistcheck                 PASS      148.69 seconds
CheckValgrind                 PASS      244.11 seconds
CheckSmatch                   WARNING   328.31 seconds
bluezmakeextell               PASS      97.56 seconds
IncrementalBuild              PASS      6443.84 seconds
ScanBuild                     PASS      996.32 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/9] doc: remove unimplemented Quality Report from MGMT settings
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '0454e2d09570', maybe rebased or not pulled?
#48: 
commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),

/github/workspace/src/src/13136997.patch total: 0 errors, 1 warnings, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13136997.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,5/9] tools/btmgmt: add MGMT setting bit names for CIS feature support
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#56: 
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy configuration static-addr phy-configuration wide-band-speech cis-central cis-peripheral

/github/workspace/src/src/13137000.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13137000.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,3/9] lib: Add defines for MGMT setting bits for CIS feature support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B2 Line has trailing whitespace: "    "
[BlueZ,v2,5/9] tools/btmgmt: add MGMT setting bit names for CIS feature support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B3 Line contains hard tab characters (\t): "hci0:	Primary controller"
8: B3 Line contains hard tab characters (\t): "	addr XX:XX:XX:XX:XX:XX version 12 manufacturer 2 class 0x7c0104"
9: B1 Line exceeds max length (238>80): "	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy configuration static-addr phy-configuration wide-band-speech cis-central cis-peripheral"
9: B3 Line contains hard tab characters (\t): "	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy configuration static-addr phy-configuration wide-band-speech cis-central cis-peripheral"
10: B1 Line exceeds max length (88>80): "	current settings: powered bondable ssp br/edr le secure-conn cis-central cis-peripheral"
10: B3 Line contains hard tab characters (\t): "	current settings: powered bondable ssp br/edr le secure-conn cis-central cis-peripheral"
11: B3 Line contains hard tab characters (\t): "	name xxx"
12: B3 Line contains hard tab characters (\t): "	short name"
13: B3 Line contains hard tab characters (\t): "hci0:	Configuration options"
14: B3 Line contains hard tab characters (\t): "	supported options: public-address"
15: B3 Line contains hard tab characters (\t): "	missing options:"
[BlueZ,v2,6/9] adapter: add function for checking adapter features, add CIS features

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[BlueZ,v2,6/9] adapter: add function for checking adapter features, add CIS features"
[BlueZ,v2,8/9] shared/bap: support client-only case

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B2 Line has trailing whitespace: "    "
23: B2 Line has trailing whitespace: "    "
[BlueZ,v2,9/9] bap: handle adapters that are not CIS Central / Peripheral capable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v2,9/9] bap: handle adapters that are not CIS Central / Peripheral capable"
16: B2 Line has trailing whitespace: "    "
22: B2 Line has trailing whitespace: "    "
27: B2 Line has trailing whitespace: "    "
30: B2 Line has trailing whitespace: "    "
32: B2 Line has trailing whitespace: "    "
34: B2 Line has trailing whitespace: "    "
51: B3 Line contains hard tab characters (\t): "    	Name: xxx"
52: B3 Line contains hard tab characters (\t): "    	Alias: xxx"
53: B3 Line contains hard tab characters (\t): "    	Class: 0x00000000"
54: B3 Line contains hard tab characters (\t): "    	Powered: yes"
55: B3 Line contains hard tab characters (\t): "    	PowerState: on"
56: B3 Line contains hard tab characters (\t): "    	Discoverable: no"
57: B3 Line contains hard tab characters (\t): "    	DiscoverableTimeout: 0x000000b4"
58: B3 Line contains hard tab characters (\t): "    	Pairable: no"
59: B3 Line contains hard tab characters (\t): "    	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)"
60: B3 Line contains hard tab characters (\t): "    	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)"
61: B3 Line contains hard tab characters (\t): "    	UUID: Volume Control            (00001844-0000-1000-8000-00805f9b34fb)"
62: B3 Line contains hard tab characters (\t): "    	UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)"
63: B3 Line contains hard tab characters (\t): "    	UUID: Audio Stream Control      (0000184e-0000-1000-8000-00805f9b34fb)"
64: B3 Line contains hard tab characters (\t): "    	UUID: Published Audio Capabil.. (00001850-0000-1000-8000-00805f9b34fb)"
65: B3 Line contains hard tab characters (\t): "    	Modalias: usb:v1D6Bp0246d0542"
66: B3 Line contains hard tab characters (\t): "    	Discovering: no"
67: B3 Line contains hard tab characters (\t): "    	Roles: central"
68: B3 Line contains hard tab characters (\t): "    	Roles: peripheral"
69: B1 Line exceeds max length (91>80): "    	ExperimentalFeatures: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)"
69: B3 Line contains hard tab characters (\t): "    	ExperimentalFeatures: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)"
70: B1 Line exceeds max length (91>80): "    	ExperimentalFeatures: BlueZ Experimental Blue.. (330859bc-7506-492d-9370-9a6f0614037f)"
70: B3 Line contains hard tab characters (\t): "    	ExperimentalFeatures: BlueZ Experimental Blue.. (330859bc-7506-492d-9370-9a6f0614037f)"
71: B1 Line exceeds max length (91>80): "    	ExperimentalFeatures: BlueZ Experimental ISO... (6fbaf188-05e0-496a-9885-d6ddfdb4e03e)"
71: B3 Line contains hard tab characters (\t): "    	ExperimentalFeatures: BlueZ Experimental ISO... (6fbaf188-05e0-496a-9885-d6ddfdb4e03e)"
72: B2 Line has trailing whitespace: "    "
74: B2 Line has trailing whitespace: "    "
99: B1 Line exceeds max length (82>80): "            UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)"
100: B1 Line exceeds max length (82>80): "            UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)"
101: B1 Line exceeds max length (82>80): "            UUID: Volume Control            (00001844-0000-1000-8000-00805f9b34fb)"
102: B1 Line exceeds max length (82>80): "            UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)"
107: B1 Line exceeds max length (98>80): "            ExperimentalFeatures: BlueZ Experimental ISO... (6fbaf188-05e0-496a-9885-d6ddfdb4e03e)"
108: B2 Line has trailing whitespace: "    "
110: B2 Line has trailing whitespace: "    "
122: B1 Line exceeds max length (90>80): "        [server]# transport.acquire /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd12"
124: B1 Line exceeds max length (90>80): "        [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd13 State: active"
125: B1 Line exceeds max length (92>80): "        [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd12 State: active"
126: B2 Line has trailing whitespace: "    "
128: B2 Line has trailing whitespace: "    "
138: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1799:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============6395576611812246262==--
