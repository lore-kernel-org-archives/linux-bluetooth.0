Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE70DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiCaUKs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiCaUKr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 16:10:47 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8E719C83D
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 13:08:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ke15so431971qvb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1dvgJl7XKgTW9Ktvy6C62V1Dtwu/ie7Z2gkyO1Aad18=;
        b=qTk5/NA9V1nyln3nkmJVZT6RyVJwILXzSc07qf8HEosvEuAFJLp803v2i11BdIu5yi
         8vkIyoE/KoB8aNEap2HZSXmVa7MOdn6gSNtZ4+GjllK4lIgi8VT0N9wxmXtkHRv5v7aV
         tZYLbtyNGK+N/iGSDX0db2wqAZQo2hLsFRC7Zi6h+T0ImICG+QWJIBdpikyK+Q5udryV
         yXXJIawPZbueq1aBJqewKP7SNmQw8dNBGOYrmwfP6xr18eDeXg8lUhH3SiyrRt6YhQjW
         Pq4XTtNavfMztQCfIZ6MeZ3qHqV0/XoX8OsK369gZvI1eSm4rJkii7eNuEFwNEz9FGmG
         hLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1dvgJl7XKgTW9Ktvy6C62V1Dtwu/ie7Z2gkyO1Aad18=;
        b=8ItwaSCvzKW2/IYK6rwJWRjVxh+YHWEgodbqIATYonaRiDOE+3kR3ybzfiu8SEsF+5
         iCXRyj/ZBSAAZZAnwyd/UHX8bIYgqC6n/X+6+rh+hthj2HW36YYJDVVeYJEJeP/xmerv
         DqeLyxaoNW0v/nNmWUtRmhMC55muv2fHziNNY/fLWh9hTbZ6cLLK62nqBqFFgGeAarGl
         lrYT8nNUh2SIGPqqB4SORD6wXseOdxUZx+sHOykhMFW2TNFA7Lk0/8f50xUl6RhMcuUq
         cBlqjoMGB4E7YHT6ZZT6zy47NEAq5z/nJ55+pybQxxOnjh24mGb9r3MxzRIDX8+t3B+F
         rBvw==
X-Gm-Message-State: AOAM5327xModfv6OdmxTDQy2K9KMeDitWi8RMvYFL1vqV6HoHKJHOQ/R
        NezT9DI11AIpC1Lj45dKJtP5bw3POELh2g==
X-Google-Smtp-Source: ABdhPJz3m0bm778nSOCdanAvWowR/vUiBc+V1eJ/lp5VRb82wb7So7b0LBNIzAPHqkpPx0vCmiyWKQ==
X-Received: by 2002:a05:6214:2683:b0:441:1481:c38f with SMTP id gm3-20020a056214268300b004411481c38fmr36766786qvb.21.1648757336850;
        Thu, 31 Mar 2022 13:08:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.61.159])
        by smtp.gmail.com with ESMTPSA id m14-20020a05622a054e00b002e2072cffe6sm270932qtx.5.2022.03.31.13.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:08:56 -0700 (PDT)
Message-ID: <62460a58.1c69fb81.258d1.23e0@mx.google.com>
Date:   Thu, 31 Mar 2022 13:08:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2526956933244554523=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,1/2] docs: Add support for Mesh Scanning and Sending
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220331182653.465828-1-brian.gix@intel.com>
References: <20220331182653.465828-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2526956933244554523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627939

---Test result---

Test Summary:
CheckPatch                    FAIL      2.90 seconds
GitLint                       FAIL      2.06 seconds
Prep - Setup ELL              PASS      42.82 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.63 seconds
Build - Make                  PASS      1251.02 seconds
Make Check                    PASS      11.29 seconds
Make Check w/Valgrind         PASS      429.57 seconds
Make Distcheck                PASS      222.48 seconds
Build w/ext ELL - Configure   PASS      8.50 seconds
Build w/ext ELL - Make        PASS      1240.28 seconds
Incremental Build with patchesPASS      2598.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] mgmt-tester: Adds turning on Mesh Experimental feature
WARNING:LONG_LINE: line length of 101 exceeds 80 columns
#135: FILE: tools/mgmt-tester.c:7358:
+			tester_warn("Invalid cmd response parameter size %d %d", length, expect_len);

/github/workspace/src/12797546.patch total: 0 errors, 1 warnings, 77 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12797546.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/2] docs: Add support for Mesh Scanning and Sending
4: B3 Line contains hard tab characters (\t): "	- MESH_RECEIVER - Enable Mesh Receiver with Passive scanning"
5: B3 Line contains hard tab characters (\t): "	  with a list of AD Types (Mesh and/or Extended Mesh)."
7: B3 Line contains hard tab characters (\t): "	- MESH_FEATURES - Requests information on how many simultaneous"
8: B3 Line contains hard tab characters (\t): "	  outbound  mesh packets can be pending at one time."
10: B3 Line contains hard tab characters (\t): "	- MESH_TX_PACKET - Send a requested Mesh Packet, perhaps with a"
11: B3 Line contains hard tab characters (\t): "	  specific fine-timed delay."
13: B3 Line contains hard tab characters (\t): "	- MESH_TX_CANCEL - Cancel a prior Mesh TX request that has not"
14: B3 Line contains hard tab characters (\t): "	  yet completed."
17: B3 Line contains hard tab characters (\t): "	- MESH_DEVICE_FOUND - Returned when Mesh is enabled, and one of"
18: B3 Line contains hard tab characters (\t): "	  the requested AD Types is detected in an incoming"
19: B3 Line contains hard tab characters (\t): "	  Advertisement."
21: B3 Line contains hard tab characters (\t): "	- MESH_TX_COMPLETE - Reports that a prior requested transmission"
22: B3 Line contains hard tab characters (\t): "	  has completed and no longer consumes one of the available"
23: B3 Line contains hard tab characters (\t): "	  outbound slots."




---
Regards,
Linux Bluetooth


--===============2526956933244554523==--
