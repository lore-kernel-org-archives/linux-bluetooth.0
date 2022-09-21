Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB48C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 09:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiIUJvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiIUJup (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 05:50:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F722BEE
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 02:48:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l65so5363401pfl.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=QP34WTTQqnhoS64vOWvA1eB/154Vjo3JBdwHk4cneTk=;
        b=WiJENX4uiPWaUlv8ZcGb15Ulfl/Xt/FPamV+KhyS1S5AL2LWdd86z8DrCI5rg7CQ+p
         bBts7xjS8MrPrC5BReiDivki3MeY073pWVrAsq54OnNlqdKRZ3DZEKMA9nB/nzhl2Udj
         Yicg55vsFGCJIMWQnTsueg1SMZgxDBhprUBk0TkWd1Hff1tsIgj3XnVANi72iV0aAauy
         Z1fEhimNAHTcIA92pKS0pv9+NepJrRJoHKyqtPgD2hi7OCEqG18HONvuREtOA4ohuSoK
         47yAPbSjIQfr4OzyQG4XkTiMN9kUbVzJ6pScNSAbJCrIV5pmvHwsJuO7fTqLJdUM2JXG
         qt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=QP34WTTQqnhoS64vOWvA1eB/154Vjo3JBdwHk4cneTk=;
        b=xJZ4qFJhb6KxUNA5hXluIy2fsluL3wI6S66nkFFCNIt/PqxyaDqAdQHXoT8TEJyo+F
         TK2svKzBtjKmwCCW1vzw/3NFLhWZWPtZoQgt+utfD1kRVyLFxwB+wKcwQAco6g3xPrhx
         4Y7FgjVp8xpS8xAO416NhnRr11k1nXkCusULnMCrSsnEHuQGuKJTSRBPhOKRJD/nmCiD
         1eFImZ3zmUvTQr53bZJlSmHlvo1sYYiVq0Iav3j3P82qXc9exIEhb4tJXFtKfu3xnumg
         f/DqTPlzSr095MA5vZ9n9zgGCzJXBqVT5vkRU8S2WG2295kncVP4Y2Y7waHZEppHv5jZ
         B6pg==
X-Gm-Message-State: ACrzQf2wKB1gNQpf3D9LQaUkbPKQ9OMovaJC6JWVQNtTswX1Go0mFjG7
        LOjuXGxzKsu5vkLNHO4bHhmu9r7oeoc=
X-Google-Smtp-Source: AMsMyM55iw38LQV15ymsLObw9j+HRQ3n9AJa37+qbxdndztneHv7DB01UQv8wS2i/4VBTfT3sJJsdA==
X-Received: by 2002:a63:4f06:0:b0:439:5e9:3901 with SMTP id d6-20020a634f06000000b0043905e93901mr23177389pgb.126.1663753642346;
        Wed, 21 Sep 2022 02:47:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.47.222])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001753cb9893csm1549558pln.187.2022.09.21.02.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:47:21 -0700 (PDT)
Message-ID: <632adda9.170a0220.8a03f.2f6e@mx.google.com>
Date:   Wed, 21 Sep 2022 02:47:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8603508686154098519=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@hotmail.com
Subject: RE: Mesh model publication fixes according to mesh profile
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <VI1PR09MB4239AE3033F3ACDF7CFFDAAFE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
References: <VI1PR09MB4239AE3033F3ACDF7CFFDAAFE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8603508686154098519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678944

---Test result---

Test Summary:
CheckPatch                    FAIL      1.97 seconds
GitLint                       PASS      1.36 seconds
Prep - Setup ELL              PASS      30.85 seconds
Build - Prep                  PASS      0.64 seconds
Build - Configure             PASS      9.68 seconds
Build - Make                  PASS      968.03 seconds
Make Check                    PASS      12.57 seconds
Make Check w/Valgrind         PASS      349.55 seconds
Make Distcheck                PASS      293.12 seconds
Build w/ext ELL - Configure   PASS      10.20 seconds
Build w/ext ELL - Make        PASS      102.21 seconds
Incremental Build w/ patches  PASS      361.13 seconds
Scan Build                    PASS      614.81 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/3] mesh: Do not accept publication for unbound appkey
WARNING:LONG_LINE: line length of 121 exceeds 80 columns
#112: FILE: mesh/model.c:1067:
+											!has_binding(mod->bindings, idx))

/github/workspace/src/12983376.patch total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12983376.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8603508686154098519==--
