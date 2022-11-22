Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD60C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 03:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKVDCH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKVDCF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 22:02:05 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07821D318
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 19:02:03 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m15so6555973ilq.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 19:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wiRTbDc+lJRcmx8eKb0o1XFGB3lh99xWGIvL5bohkaA=;
        b=RY4T1Z6LOvwJ5DhMNyHUkO41YIrxz+WYjDFzSbKKXgapCjn/WjriQOSzPzadp60NCI
         gJ9FJwmFlNd7sV/4/boMaBBWl7jwk9f4nUuR/TTXw/6sZD33bd7WKgzI42shaBgsQEuP
         7g7412nI6PDPyjlv39XfewIsDGfT+2GR5gt/CV+KL+qXLUzayKLdjo+kT1vwBa7G3E6g
         s0Z/OwjE13Tg85r5IorHJrUigRMq+mVqZUsqi7w87vL5jlRFkEpcbS44dwEn6WZca4XK
         IjvyXrwSYgbxCeLiAJnBwGSalp6VJF7lcXNMFOirWzCRHadk9sg0F2OKaQTTxkP4mCIr
         c0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiRTbDc+lJRcmx8eKb0o1XFGB3lh99xWGIvL5bohkaA=;
        b=tLw4bKmbRazZz+BRc8lEAOoMirqnrWuCx5eCylj9PkPMOftfXXWsD9pKTFOA56LaXv
         bL3fisU/2er248AhK9Cp897RvqpKsXeMBxS0Z+xOPbV1bEhogeYJ/2wziGD6SRnKr+mi
         Aml+fN8FbHaeAjpHqvdeoIE4q3TUSxQcVemfdZo8fCfR/b1VFb0bW3RJxONkGKkFZsri
         fXFvax7SCjxFEXVgRbFeKYLbIq2J/kNSxJ67f1fNMtttTDlrNdy1y38vNmG1MNgOi6w0
         wfhTcXKd5DlyN2D/cxZxDGuel3+PL1QGkEXFcmsWki7SJMraKwZioCWqa64ESQl3tcm1
         DVXA==
X-Gm-Message-State: ANoB5plUf4NRh+Hvc1fPH0tZSvPu17SgLuyqVOiX6JR1gddJqhoX2OxC
        4VCtTvO/Tmi20s8doXiEQQ4hHY89NxM=
X-Google-Smtp-Source: AA0mqf4mftjH8haK/6pZbbNtcpyLcG1LrA5jdWbKLNlvSq8mFwspyPaBGEoF3YXI0GLzgEQO/KKZYg==
X-Received: by 2002:a92:cc4a:0:b0:302:b6c0:70f7 with SMTP id t10-20020a92cc4a000000b00302b6c070f7mr1081961ilq.151.1669086122986;
        Mon, 21 Nov 2022 19:02:02 -0800 (PST)
Received: from [172.17.0.2] ([20.9.69.162])
        by smtp.gmail.com with ESMTPSA id u22-20020a02c056000000b003753b6452f9sm4823892jam.35.2022.11.21.19.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:02:02 -0800 (PST)
Message-ID: <637c3baa.020a0220.528ce.96a2@mx.google.com>
Date:   Mon, 21 Nov 2022 19:02:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5148288079036178744=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: CSIP - Client Role
In-Reply-To: <20221121234624.2961-2-sathish.narasimman@intel.com>
References: <20221121234624.2961-2-sathish.narasimman@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5148288079036178744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697847

---Test result---

Test Summary:
CheckPatch                    FAIL      3.33 seconds
GitLint                       PASS      1.63 seconds
BuildEll                      PASS      26.59 seconds
BluezMake                     PASS      760.57 seconds
MakeCheck                     PASS      10.81 seconds
MakeDistcheck                 PASS      146.48 seconds
CheckValgrind                 PASS      239.47 seconds
bluezmakeextell               PASS      94.21 seconds
IncrementalBuild              PASS      3722.53 seconds
ScanBuild                     WARNING   997.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/6] main.conf: Add CSIP profile configurable options
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#119: FILE: src/main.c:151:
+static const char *csip_options[] = {

/github/workspace/src/src/13051723.patch total: 0 errors, 1 warnings, 199 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13051723.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/6] shared/csip: Add initial code for handling CSIP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#668: FILE: src/shared/csip.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/src/13051726.patch total: 0 errors, 1 warnings, 605 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13051726.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/6] profiles: Add initial code for csip plugin
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#404: FILE: profiles/audio/csip.c:295:
+static unsigned int csip_id = 0;

/github/workspace/src/src/13051729.patch total: 1 errors, 0 warnings, 337 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13051729.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/main.c:209:2: warning: Undefined or garbage value returned to caller
        return val;
        ^~~~~~~~~~
1 warning generated.
tools/advtest.c:106:9: warning: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage
        rsi[5] &= 0x3f; /* Clear 2 msb */
        ~~~~~~ ^
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5148288079036178744==--
