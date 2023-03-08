Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4466CC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 02:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCHCMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 21:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHCMc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 21:12:32 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8EA8A79
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 18:12:30 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bm20so11155644oib.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 18:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678241550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HCHLZYoionjWtioMjS0Xbt8wWhg0FwcOK6z37scE8Ps=;
        b=J4VrjZ+8HJuQv56mKeO1jugwXhqQ3ffaTatlJGcjbCaP46DXeu0+ZfxjxgFCNAYstG
         1V3qESRu9cfuf4geRIAeoPp3itrbX0MXs+9PJeOJwAzccdQqmKpJffFmvxvE2+Q/awMh
         2H9lcEKB+u/SHTMpWNBRVMl0XP1QnIV/Pi7DugezJYGA7jW71jmAw41+wXKbyanJkV2y
         kz/cAl0O0D4omTxV6Okd3EnoGipzA8CBYZ8qbq20ybzAcBQkNzfCuEeaxok40sCPmvGk
         3dPtmQwDSMGo5wv5NSlUhXoz+95IUNsNcELHNumtXQfyWmncwG/5jA6yOHgqDw2BaRYJ
         cIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678241550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCHLZYoionjWtioMjS0Xbt8wWhg0FwcOK6z37scE8Ps=;
        b=dRJ8faheZuiTYEAap7SLsUgNAklqS5Qyv2kR/zmaHkzVBcMb+LCJ+Hl1ZdFq8NPaKV
         N0ZpUkOmdMrBlMpKq0JcQMdCS8bUo31ON0pdjCQ0iEkwrtIOohWo/uCrS/861isMBmQr
         O4iHYXcxTvU5IVsLZF+y6TmqetyFyTOHgtsBUsMyT9lUTapMjMGTX0BlGBss7OEgaWoN
         p+OLO+gb5k0j6iVrjlPY+rVj4tdxywwlErZvwpsRn7fVqVAmp1PFgEC1HQy+FV9QJKmK
         XnkY4WNGb0XjumaqWX33hs+720hHcQTwS0QMw0y3hxziCxiNMNHVfRh4RkdKDU9KMKZ6
         0I5w==
X-Gm-Message-State: AO0yUKXwF61OjnMhADZq4Hd4YZRq7NfPuQk6F2sV315aaeknj15kMx+c
        JGIgCznWNP/cQTuo95UE9pFCy/CBkO8=
X-Google-Smtp-Source: AK7set90yo90YEcaHi21Lo41jTitNGoAs2aOgLT1G6tl1798ulUY/M5GSB5yxWxBfwFvmMfwRW/sfg==
X-Received: by 2002:a05:6808:3a1:b0:384:20c:88f2 with SMTP id n1-20020a05680803a100b00384020c88f2mr7822398oie.44.1678241549839;
        Tue, 07 Mar 2023 18:12:29 -0800 (PST)
Received: from [172.17.0.2] ([104.210.133.18])
        by smtp.gmail.com with ESMTPSA id j125-20020aca3c83000000b00383ce81c186sm5902869oia.32.2023.03.07.18.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:12:29 -0800 (PST)
Message-ID: <6407ef0d.ca0a0220.48442.afd4@mx.google.com>
Date:   Tue, 07 Mar 2023 18:12:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8310582963785080769=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8310582963785080769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727653

---Test result---

Test Summary:
CheckPatch                    FAIL      8.44 seconds
GitLint                       PASS      3.89 seconds
BuildEll                      PASS      32.44 seconds
BluezMake                     PASS      970.60 seconds
MakeCheck                     PASS      11.92 seconds
MakeDistcheck                 PASS      160.99 seconds
CheckValgrind                 PASS      263.34 seconds
CheckSmatch                   WARNING   363.40 seconds
bluezmakeextell               PASS      111.16 seconds
IncrementalBuild              PASS      9602.60 seconds
ScanBuild                     PASS      1222.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#84: 
 - Generate a hash (sirk) using vendor, product, version and source as input

/github/workspace/src/src/13164836.patch total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13164836.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,v2,07/12] main.conf: Add CSIP profile configurable options
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#145: FILE: src/main.c:153:
+static const char *csip_options[] = {

/github/workspace/src/src/13164842.patch total: 0 errors, 1 warnings, 217 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13164842.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,v2,08/12] shared/csip: Add initial code for handling CSIP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#998: FILE: src/shared/csip.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/src/13164843.patch total: 0 errors, 1 warnings, 940 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13164843.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.src/shared/crypto.c:271:21: warning: Variable length array is used.src/shared/crypto.c:272:23: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8310582963785080769==--
