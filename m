Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CBEC636D3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 15:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBLPVS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 10:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBLPVR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 10:21:17 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29A113F4
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 07:21:15 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bh15so8357812oib.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WDmiL188WR7cv5RYe8Iy28P2Orb8kDTaEWk0V/rjOPA=;
        b=WTpflivdTPfVPefj4+l3Vzd+8MMrbYh8rFFKWuBF5L5RxROageQDDqzzzt+1hvST0i
         pneyxJrYyeU+rg8IpekSGy4dP1gA/1ctcmfaM0S9fhDrWrIi7WXHxO6K6icmwTOvyJss
         /+fimts/ajx5pb4WJz+nHCIhyZEchUuc0KUV/5VFCFAWxBRdUEHZNo1T3KIFvcMWWdIh
         WvT8oV+jmtNX6bcuCnJ0+473c4QcUkw8/+Yx0dhxAtbFKXKD6vBz8TGPGxD22kygjKVb
         ZG/V5xg1IDERDubA8hA5/8D7ok4OyPn9l4mMJPD4pYjjI3RbyKUT8A2piU9c4OsTNpa+
         kgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDmiL188WR7cv5RYe8Iy28P2Orb8kDTaEWk0V/rjOPA=;
        b=WMFNCnqMo68skFHnVwB4SS3MAcCnirnEx1tWdqTs9anEW5p2fPJcMh27plv1BWozCI
         /xRgzZZj+S9II2UqMkUFmu6ay4I7bDZnH7vEaJmWxzLOrsBKbMDIPIFCZgGkAeS3M7aN
         rw9VDcXO8DUNK/b7tKv9XOmHJu7FNzI+eINPeLsUXUH9JK7JXVq/kGw5P3ChgTbJGMig
         TtjgOFzmST90NDQKwcwF7DGYmDmoGFrnqhwq8LSePJL/luU1UN9Coom6IxT49TTL0Xup
         fwlYB5qci6afqkKIwI6mAjdXTdmMy9ht/4BV9vNGmsWYYiYZRPua9fhqSsEAyhrj/vhF
         PkhA==
X-Gm-Message-State: AO0yUKXr33aAxqZJXPwosoMGR0hIj2ggQTgJNBODFoxOWpe/O/v+q324
        Qe12O3+B96Lt5wp73emMLXUI4xfdANM=
X-Google-Smtp-Source: AK7set+mlImUhXbynCbe6TDOzP5t9iqqFQ7QSNzoT7D4AxXskblTr5uEEPr+Mq4gs00FHMbZ5oNjGA==
X-Received: by 2002:a05:6808:8cb:b0:364:d523:e138 with SMTP id k11-20020a05680808cb00b00364d523e138mr9384295oij.32.1676215274745;
        Sun, 12 Feb 2023 07:21:14 -0800 (PST)
Received: from [172.17.0.2] ([40.84.170.65])
        by smtp.gmail.com with ESMTPSA id q185-20020acac0c2000000b0035a9003b8edsm4127673oif.40.2023.02.12.07.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 07:21:14 -0800 (PST)
Message-ID: <63e903ea.ca0a0220.3083.0a33@mx.google.com>
Date:   Sun, 12 Feb 2023 07:21:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7848267044373812359=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3] media: clear the right transport when clearing BAP endpoint
In-Reply-To: <e15e60d7941eba174cf306b45c80bc53435554b0.1676210275.git.pav@iki.fi>
References: <e15e60d7941eba174cf306b45c80bc53435554b0.1676210275.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7848267044373812359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721072

---Test result---

Test Summary:
CheckPatch                    FAIL      0.76 seconds
GitLint                       FAIL      0.55 seconds
BuildEll                      PASS      32.68 seconds
BluezMake                     PASS      985.96 seconds
MakeCheck                     PASS      12.57 seconds
MakeDistcheck                 PASS      181.92 seconds
CheckValgrind                 PASS      297.79 seconds
CheckSmatch                   PASS      393.37 seconds
bluezmakeextell               PASS      119.15 seconds
IncrementalBuild              PASS      797.55 seconds
ScanBuild                     PASS      1244.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3] media: clear the right transport when clearing BAP endpoint
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#138: FILE: profiles/audio/transport.c:1492:
+	if (strcasecmp(uuid, PAC_SINK_UUID) && strcasecmp(uuid, PAC_SOURCE_UUID))

/github/workspace/src/src/13137447.patch total: 0 errors, 1 warnings, 66 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13137447.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3] media: clear the right transport when clearing BAP endpoint

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B2 Line has trailing whitespace: "    "
20: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============7848267044373812359==--
