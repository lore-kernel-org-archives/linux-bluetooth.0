Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731FCC001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 03:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjHBDVJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 23:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjHBDVI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 23:21:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673891723
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 20:21:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc0d39b52cso18706325ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 20:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690946465; x=1691551265;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AN9x+TMPkEzptao6stcpncTtykK2wV0dleElB0UYCT8=;
        b=Cno0mjJQUhwb57ViBaSN1P5M1BMrnGd8Jp47E8UeBnsNMo1dOXGNxuCknXPnv+YECI
         x14l0OKjhHYg76Z3ytr3w9016v0jLz2j4q4pxDDCvALutta/wbwMZAKEKQxKljXaH+oh
         1y/1bhHGTXVB2ZvLcin7kz8GKjr9tGnMOSCNzyjIXOyd/yVDjbJk5gF7UNLZvLQHl6/j
         13pY8uvNAnron7ID5SoXOBEOxqy7Aa2pnhG6JZW2fAk5BudVTA2PDh2HTANS4IytlD1G
         sxqZqVtKHbl6l9DyYhitVhea+x1P/Ih9fT2Xi9Z5BV0ZcklERkYbbe3jfDYF4SXqKCk5
         migA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690946465; x=1691551265;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN9x+TMPkEzptao6stcpncTtykK2wV0dleElB0UYCT8=;
        b=dpj0I5bs23FOvosvSNzs1dcbUuJWvj1GJXH+09AESOzePhQ49L7BeItdWRDoiSs83F
         tPukkFS2A87Dg3dR4ERypLOYjWZpQVXeKBHa2fYLZwBiqleCmUb4iZDmM8ue1hjg5ZPh
         Bmi1Kd7NuWYPZ3iHuhK43cH8RfIUHyZiHJg+o1cURExkroMZPl+YNv09SXGF0Zh2aASn
         GM49Rt0/nx5mXMttHodzgwbi9NKfyD1eW3Bz9t26ik75jSKlHQZTdQyzU+p5v3PeASL0
         mlU2bdy/CSXKjibnb5B+pqJKP2jxuLgtjsvllq8SQ+VYEwaaaXgVi87JL7PpLZvRNY+3
         EyAw==
X-Gm-Message-State: ABy/qLb2lrsMki8ECRbzoos7ZE4rp4cCnBxAVH9bQbncl39YuwONWppU
        yTGnraItvE0jYohSW4JY9Qhv/htn6PM=
X-Google-Smtp-Source: APBJJlGJ4qBqj61KMaoP839lqRaM6W9R3dX8eyXZs6dolax/FjVRGF63iyNBBy4u1XWddNl6J0udTA==
X-Received: by 2002:a17:903:22c6:b0:1b8:41d4:89f with SMTP id y6-20020a17090322c600b001b841d4089fmr16222412plg.4.1690946465462;
        Tue, 01 Aug 2023 20:21:05 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.243.30])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001bc18e579aesm4110923plc.101.2023.08.01.20.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 20:21:05 -0700 (PDT)
Message-ID: <64c9cba1.170a0220.f573e.95ab@mx.google.com>
Date:   Tue, 01 Aug 2023 20:21:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4752363289852577924=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/5] monitor: Add TX frame number and speed estimation
In-Reply-To: <20230801233135.537864-1-luiz.dentz@gmail.com>
References: <20230801233135.537864-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4752363289852577924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771876

---Test result---

Test Summary:
CheckPatch                    FAIL      2.29 seconds
GitLint                       PASS      1.16 seconds
BuildEll                      PASS      31.35 seconds
BluezMake                     PASS      1114.06 seconds
MakeCheck                     PASS      12.21 seconds
MakeDistcheck                 PASS      173.74 seconds
CheckValgrind                 PASS      279.47 seconds
CheckSmatch                   WARNING   410.45 seconds
bluezmakeextell               PASS      122.44 seconds
IncrementalBuild              PASS      4864.81 seconds
ScanBuild                     PASS      1312.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,3/5] monitor: Print channel latency information with -a/--analyze
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
  10000 +-+----------------------------------------------------------------+

/github/workspace/src/src/13337398.patch total: 0 errors, 1 warnings, 255 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13337398.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3602:52: warning: array of flexible structuresmonitor/bt.h:3590:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4752363289852577924==--
