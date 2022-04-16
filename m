Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Apr 2022 02:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiDPC61 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDPC60 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 22:58:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DDEE4DF
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 19:55:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id cp8so3934051qtb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4KUeOinPLGbMmLaCiDx3bTkLE7vZwNy3pnc7pu3+hwQ=;
        b=b1zCuLmni/ArjhW4we+EajdWUBuM+5z2HJ/hb5MUoqpNqhqz8ck7BQzKiqE3wKawpA
         XAMtd+taSHnu8E2WyscFaYjpX10v0YyahbpUI+M3iYwhuFztu8aDbhgApC+/s0JJnQzj
         Qr6wItxy6H6lurgX2XdNoFhfZzD2pbmYo5PZibuCgFcs8/JQuZNRZqqQDe8iXs9nu7Zl
         fhzPYo+M+SB7jhGCVFrORSd3lMC4gKtL0iswt9ivLb9EjJlaehhSczn19hM2+58LAPuK
         Ryue9i5SfQHI2WGkCxnBTXwKZrqWmx3jCtp/shDpDhArePLJXyu+jIIPEmazuBSJCa+q
         4MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4KUeOinPLGbMmLaCiDx3bTkLE7vZwNy3pnc7pu3+hwQ=;
        b=VHX6qBPLg5pZ2nT4lieCIDHlUEGFEU5r1dH0DcGsLzTrMBELp6534Ch5juk9x3Uwqy
         +12KrtKtWh2uf1EYcvMNsWISlr//6HWoN5YW4i2bY8nBNiRGxzkmlO2kgxR4jZ34FABy
         RwpsRlpJ8IEZ5zAN+hORAiTpeyko4mDPxnjNwKKJXyi55Ze5iVXHql4W5tdoCBj3Dtf6
         7HfgpvwNPi+L/bW8KKo+v7ewzfCYpMjzteotDUfkYRmfK8jK33efxkC6+WOz5CARdO4o
         ktv3YpBHYchbTX/mz3PnDAnxezJKIXqfAa7xhCpEKhv0Wh2lbd40u4tQkgPb9XR3oJTf
         E2qQ==
X-Gm-Message-State: AOAM533zpDbC0ODpdzq6gieyQZcP9Z7cu6mMAGkU7C+ExStiMPglWxTs
        H5kbZU0asHS9UeAxuGtfMuDjUxaXcJ1dxg==
X-Google-Smtp-Source: ABdhPJwM/8fOqMLY/Nf0xUfW5trAR8wRfxwW/lK6EUShcjQyt4uISaQr+UxbcXpfxM6B05XKg1GVvQ==
X-Received: by 2002:ac8:7c51:0:b0:2f1:f3d5:4157 with SMTP id o17-20020ac87c51000000b002f1f3d54157mr798389qtv.562.1650077754513;
        Fri, 15 Apr 2022 19:55:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.62.106])
        by smtp.gmail.com with ESMTPSA id az9-20020a05620a170900b00680aeaac936sm3258273qkb.136.2022.04.15.19.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:55:54 -0700 (PDT)
Message-ID: <625a303a.1c69fb81.3d61a.2dd4@mx.google.com>
Date:   Fri, 15 Apr 2022 19:55:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4619898274124572234=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] test-runner: Add dedicated option to start D-Bus
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220416001853.1240822-1-luiz.dentz@gmail.com>
References: <20220416001853.1240822-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4619898274124572234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632702

---Test result---

Test Summary:
CheckPatch                    FAIL      1.43 seconds
GitLint                       PASS      1.05 seconds
Prep - Setup ELL              PASS      53.24 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.54 seconds
Build - Make                  PASS      1475.39 seconds
Make Check                    PASS      12.56 seconds
Make Check w/Valgrind         PASS      542.53 seconds
Make Distcheck                PASS      286.35 seconds
Build w/ext ELL - Configure   PASS      10.83 seconds
Build w/ext ELL - Make        PASS      1446.60 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] test-runner: Add dedicated option to start D-Bus
ERROR:INITIALISED_STATIC: do not initialise statics to false
#95: FILE: tools/test-runner.c:50:
+static bool start_daemon = false;

WARNING:MISSING_SPACE: break quoted strings at a space character
#108: FILE: tools/test-runner.c:253:
 				"bluetooth.enable_ecred=1"
+				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "

/github/workspace/src/12815530.patch total: 1 errors, 1 warnings, 91 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12815530.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4619898274124572234==--
