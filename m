Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E9AC2FC0F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 00:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347299AbjHQAgR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 20:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347520AbjHQAgL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 20:36:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320530C7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 17:35:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc73a2b0easo48417235ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 17:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692232537; x=1692837337;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GIzzDEnZAJXIt/Dv/zadtPQQuCOUIKYD7xRR4sWCRxU=;
        b=mCYwGDSnGV4lIIVEpzZpVhDphzyfnG8y/WBs1BCVegwmE3hrhgzTIl+/6KOLDGo8Tw
         D7GerVF4bWPZ3/7W8nhJXJO8wat1FzGZcOljju4tWEmOZYFUnnEAT/kqvXn8AQngyQH+
         pMisi4AFO6BXnTBNnDnj1iEESuwD6+Smm0BupIWpppbNw8RUeEl92QQGl/YCGREkX4bv
         OusHFi58twA2SiKFufTeMDNsSJcTta8OHGmkykxulbd9b3rW75eBWwAMd5WoNbA3/eJa
         YGXqjhHKkHxditMypB8zn3TnIdFfGOjXPOB804bFHQVx6DtBK2qZdlLdXItu08oxf/PL
         ufMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692232537; x=1692837337;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIzzDEnZAJXIt/Dv/zadtPQQuCOUIKYD7xRR4sWCRxU=;
        b=GSB9DYmJL2ZUDvxkmgwTmH1tHECUgOBSprADD1vwkQhhw8Xnhc9PQJOM3eVSEg9l4o
         vLqywmp+H7/C3ThzsRL4z8sba81cc8ypH7ovt6wnhXGdsMJ2G9FCRh64x6FZTFgO6Eat
         NL6elY4aUbJjHeP9yFmL0PgWHFiQRSD2AuVEvW+G5FdUjTEgNNpl7JLnQKtcNEQ8FIdf
         Fda2jATqX8EbIXBvBKjvoImpzXTpYwiZw6TZi2ts8mIKwpq8jWQ/kcxMxhVRwWoZ/F9R
         JqxmJj8t2SlMIK2CERX/kwdtLl9y7D+JPqVaA8AMcSNAW4rZprw/G0Hgh/C+hWtUrmIR
         nhdQ==
X-Gm-Message-State: AOJu0YzncyMLULXcqNjytYl333vpQtVl5b+5EYFp3jHQvQeCRL3INeRy
        BMdzr5xy1AJKej2iRTdBw8WSrT9GaSg=
X-Google-Smtp-Source: AGHT+IET2DV+MjRiyjba3M9LmZ0WnhwGt77IGpvK8ek7t8y7vCfpo95uIcjA+X5kRaWTiSwOfGaK3A==
X-Received: by 2002:a17:903:283:b0:1bf:120a:a29e with SMTP id j3-20020a170903028300b001bf120aa29emr349304plr.10.1692232536612;
        Wed, 16 Aug 2023 17:35:36 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.14.128])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13774455plw.42.2023.08.16.17.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 17:35:36 -0700 (PDT)
Message-ID: <64dd6b58.170a0220.18a12.af73@mx.google.com>
Date:   Wed, 16 Aug 2023 17:35:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4414648061010128991=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor: Fix not printing latency information with -r
In-Reply-To: <20230816223147.2787284-1-luiz.dentz@gmail.com>
References: <20230816223147.2787284-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4414648061010128991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776802

---Test result---

Test Summary:
CheckPatch                    FAIL      1.15 seconds
GitLint                       PASS      0.50 seconds
BuildEll                      PASS      32.17 seconds
BluezMake                     PASS      999.21 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      186.01 seconds
CheckValgrind                 PASS      304.34 seconds
CheckSmatch                   WARNING   405.71 seconds
bluezmakeextell               PASS      123.19 seconds
IncrementalBuild              PASS      1632.94 seconds
ScanBuild                     PASS      1243.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] monitor: Fix not printing latency information with -r
WARNING:REPEATED_WORD: Possible repeated word: 'use'
#83: 
information so assign_handle can use use the parent (ACL) destination.

/github/workspace/src/src/13355745.patch total: 0 errors, 1 warnings, 85 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13355745.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1856:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4414648061010128991==--
