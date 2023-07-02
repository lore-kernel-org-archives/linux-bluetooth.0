Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCFEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 20:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjGBURE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGBURD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 16:17:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3845AF
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 13:17:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765a5d31d0aso320569585a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jul 2023 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688329021; x=1690921021;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aCLHwTAWtUHWXlnufbxxTCln75ga/ZkeHRsg2t7pSpI=;
        b=YrPq70qm7eb5ltqukmzSZHGVQmxWHmTzlnAK1QzVyJSLKJ+oUDqtU1kZSqo+xehlyO
         h6OtBwdmRQzvBXgfxvsaMm3RsnDIwqZMB44hF8P3AMsjhKUkGGHfislM+7K/GlkBZ1NF
         OZGQSDk2unjcpbriCasQii5l7FH5z5bUDv6icA4GsfZ6z6gQxQAMb6WEGb91AZa2CR7R
         Nc370ZofpFF/JrJNsq56QNP2jOaaIw8ziu99GUMGOLSLiko6BzSNPIbusZ/mpEMLUrmP
         osXN5vVYFRf9zo9QM6Ql7imaZUTzTVz2cYBgnXmIMFYbySJUZqyQhaS/t61LXQ7Wu4pD
         x+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688329021; x=1690921021;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCLHwTAWtUHWXlnufbxxTCln75ga/ZkeHRsg2t7pSpI=;
        b=O6BXj+Bk+buHyu4LlieIUYwI24eqwXPllEcF7f5ycpcq/iJ5znlBJxZDJkTbdBWRvZ
         sgXRQRE23HfSARwWNK0FPFa3w+4S0sqzRWyljgZoG+xPJ8xXTqL+sYZS28vTj/EUgb0T
         YNBeB5mF+Rv8Keiwuh7Zd2lSdc2e/9wnNRRPvEq5P3RZSwxodPgF3c+KxxDI26VRqulx
         yyDzBd1GRmlmMYcmRb/oEhmtbw4USOTzzkfDHrKOGvm07TRJ+vKMEbtX7mszB66ZJFnp
         vPnE9SROYH/Zm85xo/047+E2nQ28fW6yLuHokcgxokca+H1jifQh2SkbRiq/KfOPQP9B
         wqlA==
X-Gm-Message-State: ABy/qLbdZ1Mje+s5kLiHQYE4bCaOpeQkZDDH3hgD7Xw0EMaOEAcRHb1u
        yZmi7a4jCjnw/wNU4OoC1XcT+18vBBY=
X-Google-Smtp-Source: APBJJlG30g5slFpTSPFgJ/DOYsyKKVbU5H6kf7nz/kEV+QgSvJg7xmVesbZ/lGpLI2Ey/W/b44eE2w==
X-Received: by 2002:a05:620a:440b:b0:765:7a1e:a456 with SMTP id v11-20020a05620a440b00b007657a1ea456mr11107050qkp.54.1688329020856;
        Sun, 02 Jul 2023 13:17:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.98.62])
        by smtp.gmail.com with ESMTPSA id k13-20020a05620a138d00b007671b599cf5sm5313731qki.40.2023.07.02.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:17:00 -0700 (PDT)
Message-ID: <64a1db3c.050a0220.ce4d7.d09e@mx.google.com>
Date:   Sun, 02 Jul 2023 13:17:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1252641661693719026=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] shared/bap: detach io for source ASEs only after Stop Ready
In-Reply-To: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
References: <09443d89e7486d890b346d47ebc5c6a8f5eb30af.1688323254.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1252641661693719026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761842

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       FAIL      0.88 seconds
BuildEll                      PASS      26.33 seconds
BluezMake                     PASS      754.04 seconds
MakeCheck                     PASS      11.14 seconds
MakeDistcheck                 PASS      152.44 seconds
CheckValgrind                 PASS      246.87 seconds
CheckSmatch                   PASS      331.78 seconds
bluezmakeextell               PASS      100.51 seconds
IncrementalBuild              PASS      1272.53 seconds
ScanBuild                     PASS      992.76 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] shared/bap: detach io for source ASEs only after Stop Ready

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
25: B2 Line has trailing whitespace: "    "
28: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============1252641661693719026==--
