Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897D4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6949C60F25
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhIOXiS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhIOXiR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:38:17 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D44C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:57 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p4so5522165qki.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2BfCbu0DdHl4CkXyysAv88sQ5EVZyqO9Ye6GNy/B6I0=;
        b=BRWcskHOrefHdihc4q2NedTS1TBUI0i5PsYid+ozjZgz0dbzTVlbbcJ95xB8xekkrd
         uRqWCAcnnQNJrGWlbTRlx8y0+HxnNLn9dYBXG+tf2BiDHC0yltc6YyB5x4wVb6kuv0m/
         OR1uxQtnNlyCe/Bk9p/NbNvyyDJbu3xnbmKFqBlmRsrJ4PDcYxDP7Ytx6+mAQY+soG58
         VRZkTrJFJpWTtuxcBHTk2Ss0RXTvdfJVqo7Y2dJh0KTp8AD48Ns0tUm1e3nPr4Mq3vLt
         xix0cWOQKlUvu2A/3pPuHAHG6LYh9eQoyU6Sy8ODsoYR6iCKO/67m2cbgHyxXMhZQUM7
         Oh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2BfCbu0DdHl4CkXyysAv88sQ5EVZyqO9Ye6GNy/B6I0=;
        b=Kt6aoXkKL8R68X4FhMJf/+d0sPa5uyc7EmsvoYNdDpmxccx4ZpU1gj31TDRBj9JFx1
         SMKrCc2kxG7YzsFXjyYRwx0TzxnV4IzGatCAMs9BWXvoUTebJvS+HD7gpZGRHlbniEeP
         nJJiMOGvSVUSQzGhRI+sjtX/G3X5RXjLAc0Q04QwurOyrvE93WHrCPVaYPKhVmy0sy8l
         xCxTMLtbULReMe3pvvXZtqn0xMIGtXTAwcldDkYEn7AMmG9oARUGwGuOrmkRRayH1ytz
         Vr1e/2Hps/f/SsZf7koIw6Rc+4zg0tTdHwTWagaOscC2fOFJjOyPBIavB6G+20Hx+Y8X
         OaXg==
X-Gm-Message-State: AOAM5323KI3NQoYoAxR1mKSG8G7PoFt8Vi94Sjzgalylc/7agpFwEuMB
        DHc9arnc7JxR+y/62lzvCUO0RrXVugcdhA==
X-Google-Smtp-Source: ABdhPJweQy103b+/6zhMVPMnk5rYhfplDhBu/oPLFVH6+ONQDP4jEsbjmLKl0GSAFYZ9B7zkB5HazQ==
X-Received: by 2002:ae9:f44c:: with SMTP id z12mr2498239qkl.433.1631749016503;
        Wed, 15 Sep 2021 16:36:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.108.30])
        by smtp.gmail.com with ESMTPSA id h66sm358834qkc.5.2021.09.15.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:36:56 -0700 (PDT)
Message-ID: <61428398.1c69fb81.835d3.2a9a@mx.google.com>
Date:   Wed, 15 Sep 2021 16:36:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8679596074026736454=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] sco-tester: Add tests for sending data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210915230156.4107466-1-luiz.dentz@gmail.com>
References: <20210915230156.4107466-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8679596074026736454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=547625

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      0.88 seconds
Prep - Setup ELL              PASS      48.09 seconds
Build - Prep                  PASS      0.48 seconds
Build - Configure             PASS      8.66 seconds
Build - Make                  PASS      207.03 seconds
Make Check                    PASS      9.95 seconds
Make Distcheck                PASS      244.27 seconds
Build w/ext ELL - Configure   PASS      8.75 seconds
Build w/ext ELL - Make        PASS      195.58 seconds

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


--===============8679596074026736454==--
