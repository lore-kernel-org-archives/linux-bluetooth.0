Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A7C48BD1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A6F613B8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFKM45 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 08:56:57 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:39833 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKM45 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 08:56:57 -0400
Received: by mail-qk1-f180.google.com with SMTP id j184so30775049qkd.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jun 2021 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6gnab8jQaRsg39N7vGGuZGwLqDGyDHnKg3oCznvXvoI=;
        b=AdvQgjYsnTDvLUEw29NaNI4r2kKHB29yfV/1skD+Nugaj3AEf2yarEZDBkcaL6UZV2
         /3Ze6b8FhMmekqLoz215q9SOXRYLxf6w1A9JauqryMmYUcadrjVDO7f/C9p8y8IzqjBF
         wAelpixwjUUMP65ymghEDh8OpRqaY2dGxGw/fumu8XcOcsOwjn386MfQowK6o29GFsNg
         lrWLYDh4YXp/UTev01vYaQGreikJU1wQJRfkTNCQvPIy0vAAMa/TXwE6jT86isw2igKt
         YPOYouyYwRxTDkmOZ3hCMFYlrfqR4oUfGPUVbbPyowmorFWVSBFQlDHUZqufvFX5abG+
         Q/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6gnab8jQaRsg39N7vGGuZGwLqDGyDHnKg3oCznvXvoI=;
        b=IVlpaoGLwYkOXe2VhW0SGb/qjJ6n36hYHODWV7vxdRrT1z1UIBzpFCJstQKjoVcyFy
         VgUk1e4lZ835kXQqo9UvGEo6yhfvpSfo7rVgCrcX6spyjd9xxhk8lO5ap50oJKKHF9Vs
         5v85GmrKLqm3mPbhVQOGIkCWCYOPJ3/uwoHumrsJbX+cJA2RTKw2E6zfBuZxdl059nWA
         fb7EBBnAKtZM51erL30gU0bV7gdQhEU+4OQCk7nPZoQesBy+Zb73kCPuGyTfQs3++mqL
         KAizM1Om/B56lqvc6CJSxe99oB052WKQEeSCAmiY78TucXHK7+vSyhObHHQl1ED+60M9
         2lxw==
X-Gm-Message-State: AOAM531Qc23xc5GPBdcCvm/yp1bWTxP+grHxjUVFdjQ8BqgyV1Tn6fDs
        ojcfC8QJWxKdvy4ZfiYzE+O951ObtTE=
X-Google-Smtp-Source: ABdhPJzxPnn5B6UGyoWHiAqEZd/gB9/r29vpJd3wyIpR7QbRECj1Qgqsmi78NYjnfFNvlipwT/Y40A==
X-Received: by 2002:a37:66d0:: with SMTP id a199mr3673719qkc.238.1623416025382;
        Fri, 11 Jun 2021 05:53:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.214.164])
        by smtp.gmail.com with ESMTPSA id e12sm4316824qtj.48.2021.06.11.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:53:45 -0700 (PDT)
Message-ID: <60c35cd9.1c69fb81.d97da.f624@mx.google.com>
Date:   Fri, 11 Jun 2021 05:53:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9085192159411151144=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [BlueZ] gatt-database: No multiple calls to AcquireWrite
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210611123042.21288-1-surban@surban.net>
References: <20210611123042.21288-1-surban@surban.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9085192159411151144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=498861

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      48.91 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      8.62 seconds
Build - Make                  PASS      211.88 seconds
Make Check                    PASS      9.74 seconds
Make Distcheck                PASS      251.91 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      203.92 seconds

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


--===============9085192159411151144==--
