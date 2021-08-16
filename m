Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925EEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 14:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A22601FA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 14:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhHPOtT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhHPOtS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 10:49:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C455C0613C1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 07:48:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c4so4768527plh.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=egmDEdCnkX7XoVfwlejLjk7EaRxcLdepZF5JU0oVXxA=;
        b=OM88OoInLmZrzVXXq1LJ4T49p+EDNUW0Jpx/kn0ckNSacocvpOQA9HkBemzt4CUKLA
         y2Pj27cSKf63lkUqDA0e8o/KDkXN92ySMCIlRiaskHUb0FOcrt0hMfiC5DQ4PV/xOuCB
         +1RSPPR3mmx7L3EcZTnG9wZS6iQpIRMYrrAYI/FanDBjggkgk//N3kHJjRX+MV5YEV+F
         J5jNiJyKyZJWbXEotmHnAgtH3P/RY+nCzJgHQXRZyvQZCVEEDHcdKf/ItdQoxOf1MSSm
         fcqXSYgs333vZd9EJG5C33aSs0UhbiIcu/7ow35u2SStu/5cu/PlPR0zrewCnu3sySuF
         XrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=egmDEdCnkX7XoVfwlejLjk7EaRxcLdepZF5JU0oVXxA=;
        b=g8+lM1IB3PU3MBR34VJcHEXMq5Y4rjiNtuwIL3rgNi7DK01fMFjinnmjvaQlsRHsfE
         8kj19cem2CzMPA0yEoyuhBQae+uXxSesOrp68NaptX51ZKtFUgkJgJZUbyPtrCj8kpYQ
         WpEjUbv+PRWnbbNtnp3olrTFh+C+y81Rc1dQV9JSNMw2OGBvux3vGIRhjrHsXGO7chNs
         qVDFiL/kDJHm3K6VR0gQKZooFf2bpn0ipibJfAhN43P5UJ8sdCqP2Tr/+8R79cWPFdIO
         iSlwkYq7e7mxgVtWhxnCYu9YMY3AbxKDUNONYemyEoBoATRiqO5SePYjpraKTMRjkcxE
         9mVw==
X-Gm-Message-State: AOAM532gEe/rW6qFwpprQUtLcEMpr9K5YFqC/zwpu5ovFzGKwXaVgm/K
        oljDPUDBFevAIF0ubRV++l6jbuB0Fd8=
X-Google-Smtp-Source: ABdhPJyEdMabgMsVB6EWUaDr2iFldzj3ZrqNTmRIHUqjoMGrzXlTZcHOMZCpG5iO6yARYxYu8inRMg==
X-Received: by 2002:a62:7c4a:0:b029:3dd:a141:c932 with SMTP id x71-20020a627c4a0000b02903dda141c932mr7004271pfc.68.1629125325814;
        Mon, 16 Aug 2021 07:48:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.250.121.236])
        by smtp.gmail.com with ESMTPSA id h16sm11502841pfn.215.2021.08.16.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 07:48:45 -0700 (PDT)
Message-ID: <611a7acd.1c69fb81.5d9f9.e2b3@mx.google.com>
Date:   Mon, 16 Aug 2021 07:48:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1500905570603954212=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mariusz.skamra@codecoup.pl
Subject: RE: [1/2] monitor: Fix Maximum PDU type in CIS Test Param
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210816142956.1690272-1-mariusz.skamra@codecoup.pl>
References: <20210816142956.1690272-1-mariusz.skamra@codecoup.pl>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1500905570603954212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=532127

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.21 seconds
Prep - Setup ELL              PASS      40.89 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      7.25 seconds
Build - Make                  PASS      180.58 seconds
Make Check                    PASS      8.94 seconds
Make Distcheck                PASS      215.74 seconds
Build w/ext ELL - Configure   PASS      7.36 seconds
Build w/ext ELL - Make        PASS      170.85 seconds

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


--===============1500905570603954212==--
