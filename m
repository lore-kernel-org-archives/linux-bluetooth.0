Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBD9C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 01:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCKBtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 20:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCKBtJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 20:49:09 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77B10BA72
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 17:49:04 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l13so7857269qtv.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 17:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678499343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaSxclbh2KLYAoeqv5HctcrOsfdGUp7hepyY/3gkEQc=;
        b=X/Xx9oUQ3gObkaAbTBvLy3Ej8Iek9uMVT03YRVnF69uvHzY7rY0r6mR+a4T4o3kFvx
         z8I0CDRaECme6rqF7byQ2jHUBNbZ0m8UAIFqVe6hin600PRV/ZqFeJrm0xxaH7sEuCzi
         fuvpYe5V9e0gSJCfxatJ7lb6NaqRZUrk/n3Vwnr1mF+CfOsurrisLR+PqO7LOiq00/5V
         l/A4CalpLszY2oISCdGnB/xNN9BW/zXebNyCJKoeFedb+EVykN/3N+uNfeDOOP5jtfMZ
         fvyNlE35ZnFwobyXqnTwbueaVB6eh9d8L5Qu3pKSiaryExFu5S6Ju/t+GpijacuFs6cz
         LyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678499343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaSxclbh2KLYAoeqv5HctcrOsfdGUp7hepyY/3gkEQc=;
        b=ShgNiQjNxCGuEKorzDx8twxrzQ7gAC1A90ALjX7Tt0tkhHi0GsFvkwDomPTCs25/GN
         N5jLFpt7JIXFq3kmTrydERdw2btJ15OdrYjvkZC2+4ooX6Sq+QDYJx7/hzo0twhDAV83
         PzLpCMFyo7Ca0mhhsZnSV0EI/Hunx50l6p1pxa48CSZydL5LtRwVZTuUNeLvaZSdmzvg
         a06I9F0jt7Iha/+5Kfovpe6FonBmeH3MM8mQokCfaSrfr8NH0S8Z3RrfQflHgBnkZvQs
         TMG3Qu+fKkdvx7NEzr3gUK7P5j9kYqWvac058Jgn8cpyJtsS7YsyiOv04uy8h4TS85lj
         r+fg==
X-Gm-Message-State: AO0yUKWXDiYNtj27DDVWXsnJOLVugn83fQDjTiDKtrElXioUjIPeYpTR
        QZ19iAZybJtvDOKtq71PR227l60Q5No=
X-Google-Smtp-Source: AK7set8dpfYA+hhbiHYlJV7X0NDoXnNOg6/JSQhVA6++WdpyXrteA0brfum5K/BL0P7gt7q6R+HthQ==
X-Received: by 2002:ac8:5755:0:b0:3bf:bbb9:a301 with SMTP id 21-20020ac85755000000b003bfbbb9a301mr7046831qtx.14.1678499343388;
        Fri, 10 Mar 2023 17:49:03 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.168])
        by smtp.gmail.com with ESMTPSA id v24-20020a05622a189800b003bfb0ea8094sm978313qtc.83.2023.03.10.17.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:49:03 -0800 (PST)
Message-ID: <640bde0f.050a0220.6638.4336@mx.google.com>
Date:   Fri, 10 Mar 2023 17:49:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3127762313027427274=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijn.suijten@somainline.org
Subject: RE: audio/avrcp: Determine Absolute Volume support from feature category 2
In-Reply-To: <20230311003826.454858-2-marijn.suijten@somainline.org>
References: <20230311003826.454858-2-marijn.suijten@somainline.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3127762313027427274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728983

---Test result---

Test Summary:
CheckPatch                    FAIL      1.93 seconds
GitLint                       FAIL      1.27 seconds
BuildEll                      PASS      26.70 seconds
BluezMake                     PASS      851.96 seconds
MakeCheck                     PASS      11.17 seconds
MakeDistcheck                 PASS      150.52 seconds
CheckValgrind                 PASS      245.93 seconds
CheckSmatch                   PASS      329.03 seconds
bluezmakeextell               PASS      97.94 seconds
IncrementalBuild              FAIL      0.31 seconds
ScanBuild                     PASS      1013.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '179ccb936', maybe rebased or not pulled?
#55: 
Commit 179ccb936 ("avrcp: Set volume if volume changed event is

WARNING:REPEATED_WORD: Possible repeated word: 'to'
#63: 
starts out by introducing a new [AVRCP] category to to it that will

WARNING:PREFER_LORE_ARCHIVE: Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html
#66: 
[1]: https://marc.info/?l=linux-bluetooth&m=163519566912788&w=2

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#98: FILE: profiles/audio/avrcp.c:4586:
+		if (!session->controller || session->controller->version < 0x0104)

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#135: FILE: src/main.c:155:
+static const char *avrcp_options[] = {

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#156: FILE: src/main.c:985:
+						"SetAbsoluteVolumeWithoutTarget", &err);

/github/workspace/src/src/13170561.patch total: 0 errors, 6 warnings, 84 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13170561.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers
WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#74: FILE: profiles/audio/avrcp.c:1761:
+	 * The controller on the remote end is only allowed to call SetAbsoluteVolume

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#78: FILE: profiles/audio/avrcp.c:1765:
+			!(session->target->features & AVRCP_FEATURE_CATEGORY_2)) {

WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#79: FILE: profiles/audio/avrcp.c:1766:
+		error("Remote SetAbsoluteVolume rejected from non-category-2 peer");

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#91: FILE: profiles/audio/avrcp.c:3742:
+	 * The target on the remote end is only allowed to reply to EVENT_VOLUME_CHANGED

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#92: FILE: profiles/audio/avrcp.c:3743:
+	 * on our controller if it's at least version 1.4 and a category-2 device.

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#95: FILE: profiles/audio/avrcp.c:3746:
+			!(session->controller->features & AVRCP_FEATURE_CATEGORY_2)) {

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#96: FILE: profiles/audio/avrcp.c:3747:
+		error("Remote EVENT_VOLUME_CHANGED rejected from non-category-2 peer");

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#134: FILE: profiles/audio/avrcp.c:4599:
+				!(session->target->features & AVRCP_FEATURE_CATEGORY_2)) {

WARNING:LONG_LINE_STRING: line length of 88 exceeds 80 columns
#135: FILE: profiles/audio/avrcp.c:4600:
+			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 peer");

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#146: FILE: profiles/audio/avrcp.c:4612:
+		if (!session->controller || session->controller->version < 0x0104 ||

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#147: FILE: profiles/audio/avrcp.c:4613:
+				!(session->controller->features & AVRCP_FEATURE_CATEGORY_2)) {

WARNING:LONG_LINE_STRING: line length of 85 exceeds 80 columns
#148: FILE: profiles/audio/avrcp.c:4614:
+			error("Can't send SetAbsoluteVolume to non-category-2 peer");

/github/workspace/src/src/13170562.patch total: 0 errors, 12 warnings, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13170562.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,3/3] audio/avrcp: Determine Absolute Volume support from feature category 2
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761

WARNING:PREFER_LORE_ARCHIVE: Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html
#78: 
[2]: https://marc.info/?l=linux-bluetooth&m=163463497503113&w=2

WARNING:LONG_LINE: line length of 116 exceeds 80 columns
#96: FILE: profiles/audio/avrcp.c:1765:
+			(session->target->version < 0x0104 && !btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct) ||

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#109: FILE: profiles/audio/avrcp.c:4176:
+	if ((target->version >= 0x0104 || btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct) &&

WARNING:LONG_LINE: line length of 124 exceeds 80 columns
#126: FILE: profiles/audio/avrcp.c:4602:
+				(session->target->version < 0x0104 && !btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct) ||

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#159: FILE: src/main.c:993:
+						"AllowVolumeChangedOnPre1_4Controller", &err);

/github/workspace/src/src/13170563.patch total: 0 errors, 6 warnings, 76 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13170563.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[BlueZ,v3,1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value"
[BlueZ,v3,2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v3,2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers"
[BlueZ,v3,3/3] audio/avrcp: Determine Absolute Volume support from feature category 2

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v3,3/3] audio/avrcp: Determine Absolute Volume support from feature category 2"
23: B1 Line exceeds max length (103>80): "[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761"
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: patch failed: src/main.c:167
error: src/main.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


---
Regards,
Linux Bluetooth


--===============3127762313027427274==--
