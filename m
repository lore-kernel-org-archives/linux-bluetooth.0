Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AB7ECAAA3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 21:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiHYVXW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHYVXU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 17:23:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB72BB03F
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:23:16 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q8so16397104qvr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=JqCU7kAWyX0gsfz/Jecxdg+BUHkgxCSNHEN26eGDc8Q=;
        b=NgJ6WLWhlMD4BYmbmDWn3tc2sU0qu7BWBXooZjM/tOfkYgKBNwG6hOBBJpNfFQGRi2
         0sjIQEKSvple+RnpgM1LST5pD0BY7tpJQv9b3S+y4a//uhiEwIWk/DEr8665DRxczB2z
         GOS3fBFaSxfuiFRn61QzFmrkHhJYkbkVco0bMY6r/E1SeDdk2VhQBO0vTE63xiEOXLEc
         ooyWR7uOqS/1cLozFWKhZzLYA+So+5y2LZ+NQVpDkB3A9eenHlINUiDmtQ4z/Gui3M3m
         AOK0Gc7/gXVjz7pEDwZsdVenaGamsyKOLElcEmGC+ruYq3LUB/LFVeciMiRbqeKqJlEJ
         YTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=JqCU7kAWyX0gsfz/Jecxdg+BUHkgxCSNHEN26eGDc8Q=;
        b=LFttprpJ1VBFEZ5Xg4soeB0SZSsRIO3D0oLgTqGdJaJIzQrldTg+1QBB6FJ97Dy9vA
         z/GXmI8BXXeSjt3alxIny3B34ntwgc8lAc6k/FOiU6CTaV3xAxQbcpVU238JQFyjJJLq
         dpHl0kwjZ5dqut3ng61ykiQrrgFW7/p/HF32poItSUoqXIUO3z4FzMr92v8VfijFJ1E8
         +EwCCf5ZoFQhqeQLZX6YS/n30R0nihUMVlldZ2qPEzj6MDznUA0MA8YfoiiAJfnW/OZv
         mkVYNKOvyCtO6QCbze/2JCoQND6gKktgY+Fm/k4nnHpEar0nxyAjumFNoLX+hrYprf1x
         KaOg==
X-Gm-Message-State: ACgBeo0wMEJCUtIc+2uH5HoTTyU5TOHKZ7JK4S268VsqOwmawRXoWtf3
        nzj5jiq+muchnQygd8mXf+03kWEGjV8=
X-Google-Smtp-Source: AA6agR7nvpL4M/moAeCTtVj8ZQ7vm/UFMsTmasz7KK9sILBgwLqBOOp2GK0WEQQRP9Iz17xYASdvjg==
X-Received: by 2002:a05:6214:2424:b0:496:daea:e21c with SMTP id gy4-20020a056214242400b00496daeae21cmr5502996qvb.95.1661462595915;
        Thu, 25 Aug 2022 14:23:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.29.123])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a0f0b00b006b953a7929csm486123qkl.73.2022.08.25.14.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:23:15 -0700 (PDT)
Message-ID: <6307e843.050a0220.dbcf4.2946@mx.google.com>
Date:   Thu, 25 Aug 2022 14:23:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1183276441641927930=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: tools/btmgmt: add missing return statement
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220825203848.3499-1-ceggers@arri.de>
References: <20220825203848.3499-1-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1183276441641927930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=671218

---Test result---

Test Summary:
CheckPatch                    FAIL      1.41 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      27.43 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      8.80 seconds
Build - Make                  PASS      881.01 seconds
Make Check                    PASS      12.10 seconds
Make Check w/Valgrind         PASS      289.54 seconds
Make Distcheck                PASS      241.93 seconds
Build w/ext ELL - Configure   PASS      8.90 seconds
Build w/ext ELL - Make        PASS      83.18 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      519.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/btmgmt: add missing return statement
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'd70618e49461', maybe rebased or not pulled?
#109: 
Fixes: d70618e49461 ("tools/btmgmt: Add device flags commands")

/github/workspace/src/12955219.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12955219.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1183276441641927930==--
