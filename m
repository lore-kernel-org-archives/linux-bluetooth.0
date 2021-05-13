Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212FBC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 01:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FAE613CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 01:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhEMBo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 21:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhEMBoZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 21:44:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5365FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 18:43:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t20so14473864qtx.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DzUNqsv0Dh4eEuz/EwbTAR50KpI5hIJaaNaHOd2yitM=;
        b=mzk4gu/SGlQNrqfR1WO+s/p6tVNR2vrNCr0lQrbR0v4vziv/fnxrRHiuG68dBIN5JM
         0tenei3yPAgQEM7dRgp/29omwTJtoTln7+EMayXnsa1u/jQkDjQm4TVZZoRLDkYf41y6
         CIj78qjUvVYAjTTCPz69yCiBpaHt3ReTzaNMujYFGNf3NJridzBXKZX4Gkrh4vHWUnY5
         PuYWZYlOAbgxwOxlj2H575Jr3JIP7S7EXc3Wh9HUO22j1P6qBH9W/0yI6i8y3dyiY1SU
         uiO7YBTw64I96n7vnHq6B//OIrxeXAs3JvpC4s9YRiom6bdRvkzDyLw/cIcYq5E7Zd99
         6e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DzUNqsv0Dh4eEuz/EwbTAR50KpI5hIJaaNaHOd2yitM=;
        b=cH30X7ry5hkk24O9ZzHTthRQY1FAk93po28VVOSZ0KeOrPlxJ2r+m4aMzUvF1lD7jb
         VPc0DV18hnc/FW4d3L5CYDZcTovZSUJPsq+znAu+rl87XU8lLQZABL36SA16SQ4DsJEW
         IDrz5FtFo44MDCpK+Xt+pI1aVRarMLISRzw7z7Yf2pIrYw81g971B0f+vTxFsSx7UqO2
         ByAqm4P9MLUmNdhEd4NAG764g6O0Sh6cFP8TQzLR+9If7y/bt4/VMUP6L2iNZPwfRTTv
         arw0VWXbNl+61P3SeRtcouCL7F6HmUKEvCK4uWADMGfdAyFbbXDIvTstx1c2sFv1Sd/Q
         DkWA==
X-Gm-Message-State: AOAM531up0u3or0ZxGggLVq320CBYEaycT2h1Bptn1N2dFiCNNKj4vdG
        uoGWeS0LJ1U1E7zkYYGa2hykAkeQd8Sxfg==
X-Google-Smtp-Source: ABdhPJzPPdj5MhxLeAajb8QzIVsoobFgEYn9yFqv6raXNL3soRxCj768JVztsyqiY/5No7B2IIxlrw==
X-Received: by 2002:ac8:d03:: with SMTP id q3mr36021581qti.183.1620870194329;
        Wed, 12 May 2021 18:43:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.12.83])
        by smtp.gmail.com with ESMTPSA id 26sm1415042qtd.73.2021.05.12.18.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 18:43:13 -0700 (PDT)
Message-ID: <609c8431.1c69fb81.86c2a.adfc@mx.google.com>
Date:   Wed, 12 May 2021 18:43:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8019124968215615578=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] shared/shell: Print help info for individual commands
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210513003909.104379-1-inga.stotland@intel.com>
References: <20210513003909.104379-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8019124968215615578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=481581

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      40.14 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.03 seconds
Build - Make                  PASS      167.38 seconds
Make Check                    PASS      8.21 seconds
Make Distcheck                PASS      190.10 seconds
Build w/ext ELL - Configure   PASS      6.57 seconds
Build w/ext ELL - Make        PASS      148.17 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============8019124968215615578==--
