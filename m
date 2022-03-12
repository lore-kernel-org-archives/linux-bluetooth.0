Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3930C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 00:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiCLAnn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiCLAnm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 19:43:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E61277009
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 16:42:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cx5so9617496pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 16:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UT3bsm4lfthJ+BW69My36JyR/F+/3oD4Enw+baIhxLk=;
        b=kIhI7PLTon43VipphNzpavcvedxVTfhETyurB4pG2QNFgeiSkFG1qUd9CeGJDWpJfg
         Rm7mYuK9/PJ23aAk8bJBmfK5L7uKijB3ZHsmoX7JwMKF3lXBaqzp5o78uWFPp9CquIFK
         k4ADHGTvauUcQHZ1RbfQeqq8SkeLd4yLyp2cMd5GnVhR+v1jtLexVd4X0PJ3AUQHhctu
         S6lgJtmkw8lWnhNdGR59TFLsd7vIm7G77LsrZq5zof3R8wbTGoxfefVJREfqJgbhT+iT
         Cpy0z1Vqqk/8TI2FxuAWRTbXEEBUoxCIEtIzhY/L8Wx9pfMNBNhdaz+Si3b+zlAbbIHE
         EoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UT3bsm4lfthJ+BW69My36JyR/F+/3oD4Enw+baIhxLk=;
        b=PbS5DUhAi7uXrWVzmyW9fPAe3OB84MbRwJMxHGIu5504ACUste7qc1eiWvNJGtTyvV
         rtpRLj1ZlguckOgqJanbWt2+a9q6//YgI8xwBQnd7Rb3h3loPE74Fv124rrw9QqGrOj7
         fUmXoMk+rxApq9YwCLQH2Ol7M/igpMC4ZqKEpqZ6vqm/mBTqDDIKBsotHlFhdtZCmtiH
         r2iESeOeKqfJ2ySXC1eZHq9iC8yuk2tPcYn8lij96TFvFX0xJrSk7msExvg82oJbxfT3
         DguSQkGZlEwURdcq0i84o1hdibzk7gdGHwHAm7aDPNHVQoPOcm7qKf0nVO9mePHrIRwb
         03/w==
X-Gm-Message-State: AOAM5332EYBJQfQ4hxFxSa8wenLutqnxHtYU4fY2tNLVob9IVk9huUwL
        2SR25G1NnRsvtvLJLDv8gYMCUIe09Hg=
X-Google-Smtp-Source: ABdhPJz/XCAP72bTkPiPEZyTpKaD/voaHEcMBhFnIOMMjSzvhuHl9Z/Mjea/GmJYHMO8yVxG+AmP0A==
X-Received: by 2002:a17:90a:4581:b0:1bc:d215:8722 with SMTP id v1-20020a17090a458100b001bcd2158722mr24186331pjg.149.1647045757455;
        Fri, 11 Mar 2022 16:42:37 -0800 (PST)
Received: from [172.17.0.2] ([40.78.107.166])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm12105104pfh.177.2022.03.11.16.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:42:37 -0800 (PST)
Message-ID: <622bec7d.1c69fb81.d8401.f523@mx.google.com>
Date:   Fri, 11 Mar 2022 16:42:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2322829266510640976=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] bthost: Add support for Create CIS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220311222817.3397739-1-luiz.dentz@gmail.com>
References: <20220311222817.3397739-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2322829266510640976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622793

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.47 seconds
Prep - Setup ELL              PASS      54.02 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      10.52 seconds
Build - Make                  PASS      1860.85 seconds
Make Check                    PASS      12.50 seconds
Make Check w/Valgrind         PASS      564.29 seconds
Make Distcheck                PASS      295.28 seconds
Build w/ext ELL - Configure   PASS      10.67 seconds
Build w/ext ELL - Make        PASS      1822.39 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2322829266510640976==--
