Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C60EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 20:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjG0UKj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjG0UKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 16:10:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C84D9
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 13:10:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7658430eb5dso126018785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 13:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488635; x=1691093435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp0PSY6+AkFTgpSjFmKqVQPpo0//zm1EUHc8MyDOYE4=;
        b=PFDs2fWDOIY2ynd1doUpAAt460J5kq1IjChitZ1uBQXQYzk2vf3I5nb9qB0B0+oZtP
         621EdJTLNS/4yhK80riHDwj7uj7ZdD9Z6O9tamGirEIb2rKczNP/84XpAwPzfj5u4jXP
         +SZVTyvXEl60wtD7qFojp9JSPJgFTQ7okX1OOpigccUedAWC+fLoGModUkVX/VIBDfJd
         MLY6eHbxcbZEOJbW+GoQdq0qG0zyawRfd2UN3fIvMImrCuNHMEKyd++N1xrxlUJRdoG9
         SULbVoQvhb2Luk1MDc0YqeQiwz2hHkaMYeR0IAyBNcL3V1uiizMgKdDYKK27R9bT0Qt5
         JStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488635; x=1691093435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fp0PSY6+AkFTgpSjFmKqVQPpo0//zm1EUHc8MyDOYE4=;
        b=MlnqwSsXA8kjfQodrN3Z4rFzTBKTCCu0a2+D1cT48lzCkd2bV9QRQxeQh01nesLOUc
         J6a1JDZSn2kf3JVmNzFcme2BhUYkXwVYICTxgSnMzH0lugRSWq76dy82kXAXvm3Fv2/v
         T7xQR+2qERpczhFjtIMF1hSqRyHJ2J6Bo9hxoeAOtWlyniW0FvXD12ATGnCYQewxGosn
         UMWoI8wpFpXgDoAf8tgdfDlvlNW8nT84IvsJNquRLTeFkk+OLqlmkMSSn6Yrs9w/upxh
         2w2EYvGneKlsd1npyP+WM5F/D4sBDYrIU/w/0fFbpX44jQlr8EvXZBECTnodOw5Zb5Zw
         nFKQ==
X-Gm-Message-State: ABy/qLbALmtddDPynwNIT/OEoDAr9EviXHQ9ppaUQB3WYTyEAjgb25Nb
        ySQz3+ptjg/xi3Nb+Y7XSjYBBQUwbsQ=
X-Google-Smtp-Source: APBJJlGm6erKwlNwPR0Nby454klfQH8456zDnIbBgnR/BRV6O1jZZp4uI+l7Ktn3tAFKZQQJ8kUK/Q==
X-Received: by 2002:a05:620a:462a:b0:765:a633:43f2 with SMTP id br42-20020a05620a462a00b00765a63343f2mr597415qkb.12.1690488635542;
        Thu, 27 Jul 2023 13:10:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.71])
        by smtp.gmail.com with ESMTPSA id cx20-20020a05620a51d400b0076c7222b90fsm525200qkb.113.2023.07.27.13.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:10:35 -0700 (PDT)
Message-ID: <64c2cf3b.050a0220.77395.2ed9@mx.google.com>
Date:   Thu, 27 Jul 2023 13:10:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3894590200409855827=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] monitor: Use gnuplot to plot graph of Latency-Packets
In-Reply-To: <20230727183717.1026331-1-luiz.dentz@gmail.com>
References: <20230727183717.1026331-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3894590200409855827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770246

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.40 seconds
BluezMake                     PASS      866.61 seconds
MakeCheck                     PASS      12.07 seconds
MakeDistcheck                 PASS      156.80 seconds
CheckValgrind                 PASS      258.34 seconds
CheckSmatch                   PASS      344.06 seconds
bluezmakeextell               PASS      103.98 seconds
IncrementalBuild              PASS      719.12 seconds
ScanBuild                     PASS      1071.82 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] monitor: Use gnuplot to plot graph of Latency-Packets
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
        Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Products Inc)

/github/workspace/src/src/13330555.patch total: 0 errors, 1 warnings, 131 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13330555.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3894590200409855827==--
