Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B77C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 02:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiCXCu5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 22:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiCXCu4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 22:50:56 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448E12774
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 19:49:25 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 10so2838584qtz.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kg24zO5aC7146AyTVYOLVk6FV7Oa2wUpHQtnvnBvRIk=;
        b=NcRSc9Y3DAx0nNhkuTVDVnjBldauTfh3h5A+DsTlqjnBq7j2q2fVna6vlzSJT79VY+
         e7qj8GzUGfI6b9M9/dWsoBp91Du1+QDeE2/sYWD1YE729k2pgpqfmTUgtZ5qsCjE6XS2
         3S2OoM+XrbZQVTtnWhsw3HTwRkS3aHEw32piGc+4c8efqtEgqD4w6R1ebTIZ1P2xJ0ed
         Vn1aM0rYclP7woPZivIfbPPXCcQT/hcaLWFKicZM1Vg+ivziwK0pX5kb3OG+njGkwQZs
         u2BcjDSVqW8pg1gsshwZl1+CT1de+7XfSt5zxP05V5IQKeEInXr3TVsmT8TWKBPduGvt
         HDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kg24zO5aC7146AyTVYOLVk6FV7Oa2wUpHQtnvnBvRIk=;
        b=fZEORghnyV6ud9glD8GBKLvTiTByUheN32BcC4lz7/CavNdHGvhSkLdg96pdHz2d8H
         OTKj2U4Y7/N1kZ29ET7ZLzakFyyzONpv37VzPLinbGaWgbH7lJIefG+rYFhxok39aC2U
         ULfyxN5eKi+gsy2RuGaJ9T+s5TjPE4kQRSSDd+r5D6fcmc7RnihqdUvYjuPN2pYQ+C4s
         Ix7QTcOtFi5/DAU6N2udRHunfwCtiXr/PgaBkTGLTahiDJerhEaBUvEz9Shcw5CXqnee
         TTKh4IXsS9WBzDq9yJ6ItzntxGAQA69iHF0JsXn6KGLVZwJwwiW97lQHLy+jUwAUB8Ao
         lrvw==
X-Gm-Message-State: AOAM533r9cwjjL2Otjropq7LgJpnhFU/yjZ8/qTslvwrQt6xP89sUB7A
        R7vYinVLg6sKM+rqEGCWKqjEjNDL+JTjeQ==
X-Google-Smtp-Source: ABdhPJxUk1yaGYFJIG5Kr81yDEbq/E0HB4VooBOHkfuptbrNxt1BAuIvca6jDK7Ti3ROtDbEG+LwNw==
X-Received: by 2002:ac8:5b51:0:b0:2e1:e3e9:d98d with SMTP id n17-20020ac85b51000000b002e1e3e9d98dmr2584532qtw.55.1648090164364;
        Wed, 23 Mar 2022 19:49:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.33.71])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002e1d5505fb6sm1589346qtp.63.2022.03.23.19.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 19:49:24 -0700 (PDT)
Message-ID: <623bdc34.1c69fb81.f148c.b9cf@mx.google.com>
Date:   Wed, 23 Mar 2022 19:49:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2642083953858404633=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] adapter: Introduce BTD_ADAPTER_DBG
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2642083953858404633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625872

---Test result---

Test Summary:
CheckPatch                    FAIL      12.99 seconds
GitLint                       PASS      8.66 seconds
Prep - Setup ELL              PASS      40.22 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.17 seconds
Build - Make                  PASS      1211.61 seconds
Make Check                    PASS      10.97 seconds
Make Check w/Valgrind         PASS      417.60 seconds
Make Distcheck                PASS      222.33 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      1243.22 seconds
Incremental Build with patchesPASS      11501.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[RFC,BlueZ] adapter: Introduce BTD_ADAPTER_DBG
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#99: FILE: src/adapter.h:28:
+							__func__ , ## arg)
 							         ^

ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#114: FILE: src/device.h:16:
+							__func__ , ## arg)
 							         ^

/github/workspace/src/12790172.patch total: 2 errors, 0 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12790172.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,v4,3/9] mgmt: Introduce mgmt_set_verbose
WARNING:REPEATED_WORD: Possible repeated word: 'the'
#83: 
the the likes hexdump of packets, by default it is disabled since in

/github/workspace/src/12790175.patch total: 0 errors, 1 warnings, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12790175.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2642083953858404633==--
