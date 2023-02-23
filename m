Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C915BC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBWSk4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 13:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBWSkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 13:40:55 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0438B58
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 10:40:51 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id n27-20020a4ad63b000000b005252709efdbso187288oon.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BKVP7BgGyuSpWK/SnGlGtvGkbdlvwoofSGl4hBVLoLo=;
        b=JsZuUlBF9dGxqpPbArPvXuty+uET3uwj9V/AbCHqAPPOBxUrspfHkteBtmz3jJrJ00
         1/GVhd+xPmkPZ63WF0/lh3IsEYegqp+23uDux1g9nJoJSDaBL5jZh91VhxTbMxONc9uB
         gM6FX3LWXxg0X+GE1S4rqoG6fw1BxkemIP53db0445Ltu/30Ns5acW3YMr7RTFPjRymc
         tPTI0/qgEziA5aGg7xBcYJM26GeC6SKXNb0bwq3SHmdf0r911v5qrJXrhtgm73lf1BTn
         TyIGABxmk8xI3jKnaJ7bEadeUspFfslyv4uG5F3JAxUBSJ8FW8s+bO64beNzdYRj49Jc
         yrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKVP7BgGyuSpWK/SnGlGtvGkbdlvwoofSGl4hBVLoLo=;
        b=G/a58RXPvvCqfBk5T9PYI+zE1tpx+JIarEgZCzmqwQdMQ+BhYCpWEBCgNtSZMdPYFy
         t0nvxRCTty+I+iJny03iys50uNm+JnbdYbALeoMNV7SKmiQXYf8PZITS/IcSw9KnhTCg
         S5CZ6vAxFp4vF9SD9rPZSPz35q4d86lGgDK2/QWMvDdbjlGHwo4TLT8XqXddTOR/XAdd
         QvT61hw87raadbzLJaWCqZNAsTr5GNSTcLM9XpeyLkIweoNP+V+ze6jq2pNi7JYL4TrV
         SXLC0X1b5IET+xpHYdBZHDlm/f56duMeCYdzZXJ7LZe0fVX8y3KPpOSVC6YxySIQZrWL
         FouQ==
X-Gm-Message-State: AO0yUKUquS1mqSDMpFACwDRoAyHx8muo7XokSKkoGtKaYDzGtbvr5HZM
        nm82YVjuBCgWf2OMlR6isy9lp8tQC8I=
X-Google-Smtp-Source: AK7set8b2IH3QExBDzjnZoy3YQj5L1rMSQLFZ11pqhfB05V6RgwuhL/WNmj7eOex8IUOx2Z/l6JoGQ==
X-Received: by 2002:a4a:dd0a:0:b0:51f:fc96:a75b with SMTP id m10-20020a4add0a000000b0051ffc96a75bmr5806101oou.7.1677177650721;
        Thu, 23 Feb 2023 10:40:50 -0800 (PST)
Received: from [172.17.0.2] ([70.37.167.50])
        by smtp.gmail.com with ESMTPSA id n17-20020a4a9551000000b005252b4793dcsm511585ooi.40.2023.02.23.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 10:40:50 -0800 (PST)
Message-ID: <63f7b332.4a0a0220.f20a6.2f77@mx.google.com>
Date:   Thu, 23 Feb 2023 10:40:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8493492978542353625=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND,BlueZ] shared/bap: fix crash unregistering media endpoint while streaming
In-Reply-To: <52b90e261de4afaabcec561122c0880b3bc7b608.1677172391.git.pav@iki.fi>
References: <52b90e261de4afaabcec561122c0880b3bc7b608.1677172391.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8493492978542353625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724414

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       FAIL      0.60 seconds
BuildEll                      PASS      27.17 seconds
BluezMake                     PASS      983.76 seconds
MakeCheck                     PASS      11.49 seconds
MakeDistcheck                 PASS      149.49 seconds
CheckValgrind                 PASS      246.57 seconds
CheckSmatch                   PASS      328.45 seconds
bluezmakeextell               PASS      98.42 seconds
IncrementalBuild              PASS      830.64 seconds
ScanBuild                     PASS      1027.50 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RESEND,BlueZ] shared/bap: fix crash unregistering media endpoint while streaming
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#60: 
    #0 0x7f93b12b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)

/github/workspace/src/src/13150608.patch total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13150608.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND,BlueZ] shared/bap: fix crash unregistering media endpoint while streaming

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[RESEND,BlueZ] shared/bap: fix crash unregistering media endpoint while streaming"
42: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============8493492978542353625==--
