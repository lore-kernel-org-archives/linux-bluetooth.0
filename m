Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEDC7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 01:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjDFBgc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 21:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjDFBgb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 21:36:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8477DB0
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 18:36:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id op26so2376042qvb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 18:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680744987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D4d2PTRViSPCF3hegh2GKOAxF1lqU3FftdhTjUDvm4w=;
        b=gxzrVwyNl6MYND2Dg/Gl0zj8uRYftvrFy6HiSefPefwxBo8j/3yzx/5nynOjWwqL9P
         /mZGnow9c7kp62dVcZl4LOQvqMNb4JMsLVy/rWppXemO2T08sgVn7F74OaDvRRrXhr11
         bOSW0kUJ9ovi9cJFChr/EhyroiDPSJDtAAo1SOK5FBADaH5gcS3doipoqHCw9XvGEDB0
         g5+6Cj2KTUzoTSIw6HiU8CL9jYQ80fSEmDTHACtFW1RPf65UalVx48tul0FQOsKHrfGk
         5A9dn1d2ejn/VcuMqynVppYTsOJk0HdKx69RYT0jGnIlQqZRccm9x0ZL1k/dsqNt58V2
         zxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680744987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4d2PTRViSPCF3hegh2GKOAxF1lqU3FftdhTjUDvm4w=;
        b=T3M0gZpy75zjgvGIgxHlUR2XZV+kkyEPTb/2xW0L2SsFC1OOz9fmmxXsbEM3KKMuEa
         RCofofxINeFRXH45YQtUSkMzfZNPaCCoiFmlRma/+7nd79/BVhKgiFUEn37lyZ7AnUrr
         l+vF5Q1C3DB8wGOBDrBJbFUPhQI1QY02lJGYON2FNezffzQsXghrB8WM+aAR5T6ykCMB
         F9NKh/3jitZhr3j01IA2qw/ArBdABL6xR+ztoJZ/ASwPUG5p54bW4/3M1nK3mY+8GgdT
         /AddELqCRT9zn9Pgh5TdIWb7Wo3Ukvrl90Sd/NNxRK+xz7cSVxe8+M9MdEMF4PFUfjgz
         wj5A==
X-Gm-Message-State: AAQBX9ex2ftX7OcDh1WOWA6lWUpOYmgbEnRRQgnMxiMQIREBs21GIwvP
        kviXHjJ84ImJJgMJjEjnYE2T5dWjSkRjwA==
X-Google-Smtp-Source: AKy350ZDAlepIKhBfj6AA49afCB5dvzDxEE21PAxAGSOG/IZh02ImuD0Q/XPqyjiyJ2UCJAn7pRY1Q==
X-Received: by 2002:ad4:5762:0:b0:5bf:370e:f446 with SMTP id r2-20020ad45762000000b005bf370ef446mr2504162qvx.17.1680744987422;
        Wed, 05 Apr 2023 18:36:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.155.149])
        by smtp.gmail.com with ESMTPSA id kv4-20020a056214534400b005e5b2c560d0sm151131qvb.7.2023.04.05.18.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:36:26 -0700 (PDT)
Message-ID: <642e221a.050a0220.aca67.0900@mx.google.com>
Date:   Wed, 05 Apr 2023 18:36:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5757278556449577675=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] main.conf: Fix parsing of CSIS group
In-Reply-To: <20230405231111.2636523-1-luiz.dentz@gmail.com>
References: <20230405231111.2636523-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5757278556449577675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=737372

---Test result---

Test Summary:
CheckPatch                    FAIL      2.88 seconds
GitLint                       FAIL      1.96 seconds
BuildEll                      PASS      27.21 seconds
BluezMake                     PASS      987.72 seconds
MakeCheck                     PASS      11.55 seconds
MakeDistcheck                 PASS      149.73 seconds
CheckValgrind                 PASS      247.03 seconds
CheckSmatch                   PASS      333.73 seconds
bluezmakeextell               PASS      99.93 seconds
IncrementalBuild              PASS      4208.79 seconds
ScanBuild                     WARNING   1059.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,4/5] advertising: Add support for rsi as Includes
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#170: FILE: src/advertising.c:507:
+	{ 0 , "rsi", set_rsi },
 	    ^

/github/workspace/src/src/13202645.patch total: 1 errors, 0 warnings, 83 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13202645.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,5/5] client/advertising: Add support for advertise.rsi command
ERROR:SPACING: spaces required around that ':' (ctx:VxW)
#129: FILE: client/advertising.c:181:
+	bt_shell_printf("RSI: %s\n", ad.rsi ? "on": "off");
 	                                          ^

/github/workspace/src/src/13202647.patch total: 1 errors, 0 warnings, 91 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13202647.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,5/5] client/advertising: Add support for advertise.rsi command

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B3 Line contains hard tab characters (\t): "	 rsi [on/off]"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/advertising.c:942:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5757278556449577675==--
