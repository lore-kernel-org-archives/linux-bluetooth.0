Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050EECAAA2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbiHYVVb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbiHYVVa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 17:21:30 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D7BB03F
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:21:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id w18so16226205qki.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=pgOBw/H/rI7z116kfoTQFjftoxqzYeh95MZKyH29bEU=;
        b=iZwYH8V/1z607iNh+OOVv9X+XQIGLJer5IsFSrfjr6h+2l1XPW0pVfIpG5L7vyVYqS
         s3ets5xtwp2dcblCcZJroojUZarwHbkWN4/JSpNG4iij8QVO4qlbmFx98ehZPuCDcx2d
         Oh+KEO3h7jTKW1em/Mmo+oD5Q4QJr9UtXTEUlYfFnfTuEmZBwgmOyX7bH/EbKFNxTZ9B
         g4KsBfE0wgag582tTaiHhNo1A5H2hNmWXXmYCjHXqyKs8aFxXs73can9s7YPeGKorT4Q
         ynsiVEisCpJh0HvBFa9Iu9xO7WHyLwmxhkzPz1czN8F+mpKA4xidV/+KETQtILM3YKul
         IARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=pgOBw/H/rI7z116kfoTQFjftoxqzYeh95MZKyH29bEU=;
        b=JkLkd5me6LbJjW9DtfbYFCUhlqwNiBunrzlGk29/qGDpztAPvhxpzElIYYyC58yDOa
         IkDupBROCGRVUe2Q+tV9m1HQoKFO9+LWJ9yA0/MYxk8J4D9NM9oqPRXhF8vCYQyOdgDX
         M7Ajg8MIale3YI+Msnz685zuXkzx8hGVT90t6CbiXVYyPbOcX12I/EPHLRXGOeMuY0im
         dBmn+7srvd6I29JLljDv85JtbrtpWJtt25J9WuVAWJbEefEjKx9lqCG3jgNIJ5apsoGh
         iJQAI/LaHd3BNsYjpoDvr7BqZNwUdUz3SQC9gwOTuFpYE+yzpw5e0G0m7BmPsz8QDT79
         PWsA==
X-Gm-Message-State: ACgBeo0bIhhmPtIbC5hbEgtgaciZnbX/SxeX/DOU3D1WGT1gsw6L4RDz
        JMO3f+rP+KMeZP3zrczPKLsaYqIzdBM=
X-Google-Smtp-Source: AA6agR49hnd8Cse1Au+dqjkSqIDUZMN8xPVRvCuM2DzsfQ60gCwsylAtFRjaxZ65y97QJA2jMQJ4og==
X-Received: by 2002:a05:620a:24d6:b0:6bb:1dca:92be with SMTP id m22-20020a05620a24d600b006bb1dca92bemr4316641qkn.323.1661462487051;
        Thu, 25 Aug 2022 14:21:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.198.23])
        by smtp.gmail.com with ESMTPSA id y24-20020ac87c98000000b003434d3b5938sm52761qtv.2.2022.08.25.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:21:26 -0700 (PDT)
Message-ID: <6307e7d6.c80a0220.36192.0293@mx.google.com>
Date:   Thu, 25 Aug 2022 14:21:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7590730712047103559=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: client/advertising: Fix typos: *_exits --> *_exists
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220825203828.3380-1-ceggers@arri.de>
References: <20220825203828.3380-1-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7590730712047103559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=671217

---Test result---

Test Summary:
CheckPatch                    FAIL      1.46 seconds
GitLint                       FAIL      0.99 seconds
Prep - Setup ELL              PASS      26.56 seconds
Build - Prep                  PASS      0.84 seconds
Build - Configure             PASS      8.48 seconds
Build - Make                  PASS      830.25 seconds
Make Check                    PASS      11.36 seconds
Make Check w/Valgrind         PASS      289.57 seconds
Make Distcheck                PASS      234.18 seconds
Build w/ext ELL - Configure   PASS      8.60 seconds
Build w/ext ELL - Make        PASS      80.76 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      482.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
client/advertising: Fix typos: *_exits --> *_exists
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'bd0808bf01eb', maybe rebased or not pulled?
#106: 
Fixes: bd0808bf01eb ("client: Add advertise.secondary command")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '4e7780d0eb94', maybe rebased or not pulled?
#107: 
Fixes: 4e7780d0eb94 ("client/advertising: Add support for setting min/max intervals")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '068e0ba214b9', maybe rebased or not pulled?
#108: 
Fixes: 068e0ba214b9 ("client: Add set-advertise-{duration, timeout}")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '5c3a39e642d5', maybe rebased or not pulled?
#109: 
Fixes: 5c3a39e642d5 ("client: Enable set-advertise-appearance to set Appearance")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '177eccc14523', maybe rebased or not pulled?
#110: 
Fixes: 177eccc14523 ("client: Enable set-advertise-name to set LocalName")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '806276fe54fa', maybe rebased or not pulled?
#111: 
Fixes: 806276fe54fa ("client: Add advertise.discoverable-timeout command")

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#126: FILE: client/advertising.c:332:
+static gboolean local_name_exists(const GDBusPropertyTable *property, void *data)

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#135: FILE: client/advertising.c:345:
+static gboolean appearance_exists(const GDBusPropertyTable *property, void *data)

/github/workspace/src/12955218.patch total: 0 errors, 8 warnings, 87 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12955218.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
client/advertising: Fix typos: *_exits --> *_exists
4: B1 Line exceeds max length (85>80): "Fixes: 4e7780d0eb94 ("client/advertising: Add support for setting min/max intervals")"
6: B1 Line exceeds max length (81>80): "Fixes: 5c3a39e642d5 ("client: Enable set-advertise-appearance to set Appearance")"




---
Regards,
Linux Bluetooth


--===============7590730712047103559==--
