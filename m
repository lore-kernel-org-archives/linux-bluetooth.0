Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C7C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 04:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjCCEa2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 23:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCCEa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 23:30:27 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F1C22006
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 20:30:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id l2so1003226ilg.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 20:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677817825;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3X3sv3cwtIPTn5FjGFBJtbBbEJdDmOJ6aIEGyQFTR+M=;
        b=KDquQM3wo33PmMRF/t/YujzhcrjaYrt3khg3BG2S0J0gCuYDyXKJZS70cDsiWxo6x3
         UqihcMWoWgPubSh9mlLWOjE6NAIRIZaN+UnAnO4omhjsnPy36KttMQiM0cIXJNVz2fBP
         6H8cBMJRyLc2esfzvDGrr2oQ/vjQFDwVhDXGFG0v/MPmv+eTC/Y9tRZjnesqguffM07M
         K67z8mJHBiTTtfHSTLPPm+v7rE3cIeaQjp8dOQpicax2uvq/PGvvfcBu/x0FDGlCID+d
         XzasC0jUQQgSnXDPz8t114uMtiamjuXTPqZwlsUEvZEqn5/KCJ2KazEYtIgJtPMFV3Df
         VxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677817825;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3X3sv3cwtIPTn5FjGFBJtbBbEJdDmOJ6aIEGyQFTR+M=;
        b=XoPnjICcl+X1z6f/OziqqakNMiyvn0XWaLDQk5ThQ3wUTusUZ53lKUwYbo/FsqYKzY
         xnYgvkevx6jsbUxqVfx6v0D9d0b1rCmGwylFEhQN3On03ujJ05vPJO4tir9DKI/F5m/S
         gtNLq4kq8l7mFCWBgP3BFQU2YaoIp+i80yitubir55LgecW3IM2UEM3Ea42ztAzY2fpb
         E4Iq6pQ89b4dSzIgNEwc0CY0ElLBI6W8OxwKxs0VsMI9cLkt35EpAjQRbuYFxVgLzk1o
         KARZYcb4S3/rboXjfFJmvD6gs2tca1n+zv3m1aQQ/zwmqrg/PFatNnIRDoKHJAJnT8Ek
         TkWQ==
X-Gm-Message-State: AO0yUKW597ExG/xUV+RUlsh57xO+cmuvnDKU50YVbSJHnHLVTgBSbz6r
        m6h25azrLfZljNEH2QG3thogCoe8MUU=
X-Google-Smtp-Source: AK7set/jqpuvjbeFE5jt1zVqCV3Blo7oJBxuP3YxCbGCaR5IOfd974RuKQOobQ2QpM44lMdsRa/uEw==
X-Received: by 2002:a05:6e02:1e06:b0:315:5467:4a3f with SMTP id g6-20020a056e021e0600b0031554674a3fmr730362ila.30.1677817824713;
        Thu, 02 Mar 2023 20:30:24 -0800 (PST)
Received: from [172.17.0.2] ([40.86.28.132])
        by smtp.gmail.com with ESMTPSA id t12-20020a056e02010c00b00317a2fed5b6sm330941ilm.45.2023.03.02.20.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 20:30:24 -0800 (PST)
Message-ID: <640177e0.050a0220.237b8.0bdd@mx.google.com>
Date:   Thu, 02 Mar 2023 20:30:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4682311922190521327=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,1/9] shared/crypto: Add bt_crypto_sirk
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4682311922190521327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726293

---Test result---

Test Summary:
CheckPatch                    FAIL      5.05 seconds
GitLint                       PASS      2.30 seconds
BuildEll                      PASS      26.19 seconds
BluezMake                     PASS      751.94 seconds
MakeCheck                     PASS      11.07 seconds
MakeDistcheck                 PASS      147.73 seconds
CheckValgrind                 PASS      240.16 seconds
CheckSmatch                   WARNING   321.92 seconds
bluezmakeextell               PASS      97.20 seconds
IncrementalBuild              PASS      5482.90 seconds
ScanBuild                     PASS      953.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,1/9] shared/crypto: Add bt_crypto_sirk
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#84: 
 - Generate a hash (sirk) using vendor, product, version and source as input

/github/workspace/src/src/13158198.patch total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13158198.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,6/9] main.conf: Add CSIP profile configurable options
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#145: FILE: src/main.c:153:
+static const char *csip_options[] = {

/github/workspace/src/src/13158203.patch total: 0 errors, 1 warnings, 217 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13158203.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,7/9] shared/csip: Add initial code for handling CSIP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#998: FILE: src/shared/csip.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/src/13158205.patch total: 0 errors, 1 warnings, 940 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13158205.patch has style problems, please review.

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


--===============4682311922190521327==--
