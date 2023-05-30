Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A15C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 16:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjE3Q1E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 12:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjE3Q0R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 12:26:17 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C866BE51
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 09:25:45 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19f31d6b661so2969940fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463945; x=1688055945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f60cL7tTdx9HV3zN7CRPt+uKkYHDLrViLcInFTj9jkU=;
        b=kj056RO9f+G5g2eHqm/Yh7n8x9D1tM9plWyez6jG4egx8jaEfTwjoKSFqOUJ9QE2c9
         0vTLTCzsoGxZ4A/imegI3rYcJYZ2cD26t40+CGiev8EYdQEGV+oBYd9QglrG23ysF/KW
         mlHnFVhOkhumMP4lHL3mut8/pbUxLdry2cBPP3u9hdXwqxXMNxtIwoZ8Uuqpm1cFrV1d
         UOsKk/HxTsN/KohbmW2qVoFvIZDwJf1rGPgU+B1bJStlgsovUktXYv+ZA+02nWpEkawW
         uLGIuZ4yBJH+wlB+TuvoDepF0EWNdOmojjhzkD9eBeFQ0MwzD5gwvUOautA4zE8FttGE
         HKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463945; x=1688055945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f60cL7tTdx9HV3zN7CRPt+uKkYHDLrViLcInFTj9jkU=;
        b=DUBU0AyOjVQcqGlozE1ByoSaiBjqmK0MmBN+RC666KxOGN0KQ/b825sjzd4zuWqICt
         GyG4BZ0KFS6fXpOa+y7sEvYzx8CDCwA8PHqc/wvfJkUz17aYuZ4PEq/cxSXTqKxs5i6z
         2WN5T71AUaUC2tuJPkhh783yQ6+yymhx3qoACWkTYAKpcXaXS4BBwq8g+iUQneXZPcTy
         us1uvk13s37N5HvLsV+DSU6Jt6QbykBP1qDO3bj3+5d/AxjCAXqCqWPMNGGvgUgZ0xsJ
         XG2PWHeStj5pGSsNT4W/XtKPCkci+6k/6rqNKsLNAbIrOCImF4d5YeMuz+6ru9jSdbDU
         E/Iw==
X-Gm-Message-State: AC+VfDxSVrrBsXQOrlXAz0ktExPrOkZFOM2ccEZva/ILOykY430G5/ll
        MeIzYmKZqgWYhQtKZg11yGIzWUFDMrM=
X-Google-Smtp-Source: ACHHUZ4c42YHUZiJlX+F1Y6Xi/c6fneE5/dvGXPqpfdl65RIuovC1gNrl3m6fhT7YjXp/0V4DLBC0Q==
X-Received: by 2002:a05:6870:d452:b0:19a:1341:e8d4 with SMTP id j18-20020a056870d45200b0019a1341e8d4mr1192674oag.49.1685463944751;
        Tue, 30 May 2023 09:25:44 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.166.244])
        by smtp.gmail.com with ESMTPSA id v52-20020a056870957400b001968dd2e1fesm5964261oal.3.2023.05.30.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:25:44 -0700 (PDT)
Message-ID: <64762388.050a0220.860bd.bc38@mx.google.com>
Date:   Tue, 30 May 2023 09:25:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6642741698336364263=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add initial support for BAP broadcast source
In-Reply-To: <20230530141339.100733-2-silviu.barbulescu@nxp.com>
References: <20230530141339.100733-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6642741698336364263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752257

---Test result---

Test Summary:
CheckPatch                    FAIL      3.69 seconds
GitLint                       FAIL      1.58 seconds
BuildEll                      PASS      31.72 seconds
BluezMake                     PASS      988.14 seconds
MakeCheck                     PASS      12.89 seconds
MakeDistcheck                 PASS      176.46 seconds
CheckValgrind                 PASS      292.44 seconds
CheckSmatch                   PASS      390.18 seconds
bluezmakeextell               PASS      118.95 seconds
IncrementalBuild              PASS      3260.03 seconds
ScanBuild                     PASS      1198.85 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/4] Update bluetoothctl with support for broadcast source
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#99: 
To test the current implementation use bluetoothctl with the following commands:

WARNING:LONG_LINE_STRING: line length of 86 exceeds 80 columns
#471: FILE: client/player.c:3769:
+			bt_shell_printf("Transport %s already in acquiring process\n",

WARNING:LONG_LINE_STRING: line length of 89 exceeds 80 columns
#483: FILE: client/player.c:3781:
+				bt_shell_printf("Link %s already in acquiring process\n",

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#485: FILE: client/player.c:3783:
+				return bt_shell_noninteractive_quit(EXIT_FAILURE);

/github/workspace/src/src/13260177.patch total: 0 errors, 4 warnings, 364 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13260177.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,4/4] Update BAP plugin with broadcast source support
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#431: FILE: profiles/audio/bap.c:1170:
+			iso_qos.bcast.sync_interval = ep->qos.bcast.sync_interval;

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#440: FILE: profiles/audio/bap.c:1179:
+			iso_qos.bcast.sync_cte_type = ep->qos.bcast.sync_cte_type;

/github/workspace/src/src/13260180.patch total: 0 errors, 2 warnings, 832 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13260180.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,2/4] Update bluetoothctl with support for broadcast source

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (84>80): "  transport.send /org/bluez/hci0/dev_00_00_00_00_00_00/pac_broadcast0/fd0 <file.wav>"


---
Regards,
Linux Bluetooth


--===============6642741698336364263==--
