Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC9CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 23:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED7661175
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 23:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhINXhq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhINXhn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Sep 2021 19:37:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FABC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 16:36:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u4so729733qta.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tLtqmqwa4D/DVyieEw4qHbc7hW1JbwXm7nRIBfMEJx0=;
        b=ZZIVr6mh6qrZ9uRWQipe30htlgj+AxUNq/MjcgdsLL7Gd7HNtC/7Z6FahWRCz1jxx1
         zrCiox+XgxLW5txnd2voUt3hRat/bXMmX8v3t9wFpOqz2RAYXtJG45luEmN6/DMFLPx2
         QPQVLu63NLg8bTRCZCJAiTb5bftAsdttUbyxHTZvEHcJuDXynWYVN6bkEjM9UH7O13/3
         b5Aed9KwFwTZH9EeqBr5AiQvkikqkExZfEPzmRfoWDUjfXtaAHZuAq0VE/wD2C8RNAAq
         oB1LDtJiRX/cDL9lWTVIAQaVg9xDTTTgLRbB0s3NrMvA4m3xpVfuIFR0ZROmy0DLNYDQ
         z7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tLtqmqwa4D/DVyieEw4qHbc7hW1JbwXm7nRIBfMEJx0=;
        b=rOMdjvWzUXV5fe5IYYs9zMeDpi66r5o31uYiVouQroynDxb3CVKv/9OEw4bn4eoljQ
         JvQWYiCTCEfynKl2bb7ErM/Wb0TwIbN3OOYeydi6Qxo2gavA8xQQugjUanQ65D1XJPTI
         LRdYocr2VCjsS5RC3bG883W699j6HPwEXgBhi+W8VwdQINYlBOonmuW7YZ4BOiy2UdR2
         81repiw2psfRqyEY4FiPJcQcwgsSTHQMfpM1i7KfBDuRVTtuGkQho4PhEZHuifszCkDm
         gONCg9pVNMK4PHJRZoT0X7WazM+yeIHKif6OWbeYT1o00wIwznZcxVJD5SZFpLWUj4uz
         e1aA==
X-Gm-Message-State: AOAM5334qAD3xkoWfP46oU2nInG2OdIzmzh3p/GbECLZuuRk7zoT2mz8
        JrXQ/xc+rISPsKBG1a/XJZwAMKfIjhJOEA==
X-Google-Smtp-Source: ABdhPJw2+qjU34+Qk845+hgNV/RCzUIMuZqBteIEGYPFiRaSvoAznNJbUaTIDzp8xaJHs1BjNb34JA==
X-Received: by 2002:ac8:4159:: with SMTP id e25mr7449549qtm.69.1631662583915;
        Tue, 14 Sep 2021 16:36:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.170.192.168])
        by smtp.gmail.com with ESMTPSA id z12sm6962882qti.58.2021.09.14.16.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:36:23 -0700 (PDT)
Message-ID: <614131f7.1c69fb81.92c81.d368@mx.google.com>
Date:   Tue, 14 Sep 2021 16:36:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3595698577793821326=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Update exp feature testcase
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210914223907.353433-1-hj.tedd.an@gmail.com>
References: <20210914223907.353433-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3595698577793821326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=546975

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.93 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.25 seconds
Build - Make                  PASS      204.24 seconds
Make Check                    PASS      9.00 seconds
Make Distcheck                PASS      240.80 seconds
Build w/ext ELL - Configure   PASS      8.29 seconds
Build w/ext ELL - Make        PASS      193.27 seconds

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


--===============3595698577793821326==--
