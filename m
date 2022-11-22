Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE4AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 05:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKVFu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 00:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKVFu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 00:50:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A724F39
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 21:50:23 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l15so8705017qtv.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 21:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vHCqSIlRLSAxXLM3RPWEvS8uxdZA3PQnxNDfnhH7MLY=;
        b=Z05ZnprlLlBA77SQkRkdalwfeR/K4fVMPY7vmEA2t54EzHx7fXdu1Giqg2MWjwGIe2
         +S69o9ugUiH+8CkRvYiJtPkVnhA+rMt/naCPhQQsp4QG2R8qYMNg9Dr5XVeIyzFnQmVl
         MDOiur+emDY1RbGLPFFglqK4hbmwQsIScVXNxKZiPudOaFKzFXMeo5S6PaChKq6eZDMv
         spHvfRD87kbMskBW/HoYfCXVmBXrBHOg+IWOhOaIRBcO1zQw9h/mNWqiB1PfJB+Z2S1q
         LuAzRqG0hQPzPUgNzz9Czv4+e7vFyzB0eeFqsCsgP89tteu1Jnu+i8ix0elvCzA6Sv4W
         FzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHCqSIlRLSAxXLM3RPWEvS8uxdZA3PQnxNDfnhH7MLY=;
        b=67/UGOSIOo+hTMbf9gwZAw7AIrgZL9VqFypBKlL7pRS3a9OQOhUQVEkBnqaFDtu54K
         2UygaSIjsBTxaoGa4bghj8wqLuVd6K79MNbAByuzOHEt1dSsN0kB6GyJTRWDQsZAeQn9
         EtmSoN2J1ceiGGqQq1BGBQN8GhTzTs1zNeC3eHmKTzQWQ+cC650c9YL9yZSu+cs/DNqn
         Xsmsb9sFWubPGaCeFZdpAJrwghNouKuwZavExVQTCmWJmbqMR4ryXr6zvu7HgtYxUdwA
         dWbvStq0ZU2gVoBbOkn/1khFg4AxF16Nck7gpTz/l5aGc+g9q21QqSJGVGGqS6PEsbFp
         0pkg==
X-Gm-Message-State: ANoB5pkC6NnQNj8bXzCqjJk9mMXq+YkNShjFqqiH+50WzXLxsBggCtOs
        3IBLLcAmxzDDFxFb9zHoV4lJ+euy2FCUPA==
X-Google-Smtp-Source: AA0mqf7U06vT9xnC8VYza+i4ERbHWkLsh8bdZs6lTI1KfuX1SRwjXZC1N8TNv8xO+TYmIIWJXmJlqw==
X-Received: by 2002:ac8:480c:0:b0:3a4:f1c1:49a9 with SMTP id g12-20020ac8480c000000b003a4f1c149a9mr4694515qtq.464.1669096222904;
        Mon, 21 Nov 2022 21:50:22 -0800 (PST)
Received: from [172.17.0.2] ([52.255.185.18])
        by smtp.gmail.com with ESMTPSA id v9-20020ac873c9000000b003a54a19c550sm7688432qtp.57.2022.11.21.21.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 21:50:22 -0800 (PST)
Message-ID: <637c631e.c80a0220.299ce.9ec3@mx.google.com>
Date:   Mon, 21 Nov 2022 21:50:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8189719817230684125=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: V2 of CSIP client role
In-Reply-To: <20221122032530.3842-2-sathish.narasimman@intel.com>
References: <20221122032530.3842-2-sathish.narasimman@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8189719817230684125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697909

---Test result---

Test Summary:
CheckPatch                    FAIL      4.52 seconds
GitLint                       PASS      2.28 seconds
BuildEll                      PASS      32.57 seconds
BluezMake                     PASS      972.94 seconds
MakeCheck                     PASS      12.35 seconds
MakeDistcheck                 PASS      174.27 seconds
CheckValgrind                 PASS      284.50 seconds
bluezmakeextell               PASS      111.44 seconds
IncrementalBuild              PASS      4761.00 seconds
ScanBuild                     WARNING   1165.50 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,V2,2/6] main.conf: Add CSIP profile configurable options
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#119: FILE: src/main.c:151:
+static const char *csip_options[] = {

/github/workspace/src/src/13051896.patch total: 0 errors, 1 warnings, 199 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13051896.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,V2,3/6] shared/csip: Add initial code for handling CSIP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#668: FILE: src/shared/csip.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/src/13051897.patch total: 0 errors, 1 warnings, 605 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13051897.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,V2,4/6] profiles: Add initial code for csip plugin
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#404: FILE: profiles/audio/csip.c:295:
+static unsigned int csip_id = 0;

/github/workspace/src/src/13051901.patch total: 1 errors, 0 warnings, 337 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13051901.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/advtest.c:106:9: warning: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage
        rsi[5] &= 0x3f; /* Clear 2 msb */
        ~~~~~~ ^
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8189719817230684125==--
