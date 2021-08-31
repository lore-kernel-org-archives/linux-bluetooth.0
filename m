Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07424C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA51460231
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 06:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhHaGku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhHaGkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 02:40:49 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CAC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:39:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t9so13783347qtp.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8VSrlIf21/kTFojdPr91Q+bEn8f9n164McVmXCIZnPk=;
        b=WudSCMHppQww0w1pK3+LmZFh7CbQz8d9vn/63NTUOeAitOlrsKghpMsDYCbAT0oUuB
         VHnr1olRlg4Pan7783/+Db4VWPqG6ZDUr10WYd6wapHqQxExRXvK6GVk2pMRarexA0kp
         Seawyyegz70Dk/vlGlLotlVa5R9ICRDWnWCOA5ZpOJ9yigOuq97DdQfQYBS37eRTgfs3
         Exc1JQbgRo0JAM+EsWrAMYMegv39F/EcrQeOXqvuth6lwkBWYT9GODLBeNLw8iD8oOTw
         eAYEA70FSr+R0JYHkCV97VQixTspzzW328bcsPfCNVtz2pIs0td6vDAUOlZmh4NZeGel
         Z76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8VSrlIf21/kTFojdPr91Q+bEn8f9n164McVmXCIZnPk=;
        b=AUiVI25YaPf2bohW5y5wjj2YPquRpFhdO8q4Hby2jKuS2UugAxkcFTMVp3zYGcoBiD
         V7EB5eYZ65WUK0paLnp/DOAEzvvHa7yAcPwUxp4R9QKdiI6tNW1kYnO2UUuK8oe+hPuK
         nAGOJ37S69miWW1CmxG6xr13zoNuwXI0G/QxyveNMNllsT1XY1W8XOhG2CZTrEDhv7WJ
         07xK/Ok8BOHsNuBRLMS8BlTl3D0e3mqxiETIgsn41f2xLt6TcPu9Fto3XncwyZirvktg
         ZjVQi8Wcv/+3vNq7HhcrmEofiV/iyQV7IjlDM/kSgGbFYaw0Lwi6RIvE/6jtXuu/RiDu
         ViuA==
X-Gm-Message-State: AOAM530Unvy5FBPE/I9oQhN3stxUbVkHktnOz4Qn2IYTAdsv6UNvZt6B
        W1KQghIQhgbioHQXS1DTgoZtGRAuRPQ=
X-Google-Smtp-Source: ABdhPJxGhOQoghET/V+rOyr7Sb2Gvn+EPhWFPfcLOGs6Ed3IhsGPz2G+HHJxQkh4DXY0aqjx1qBRKA==
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr1283020qtp.227.1630391993825;
        Mon, 30 Aug 2021 23:39:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.60.181])
        by smtp.gmail.com with ESMTPSA id g7sm9939134qtj.28.2021.08.30.23.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:39:53 -0700 (PDT)
Message-ID: <612dceb9.1c69fb81.a1bb9.46e1@mx.google.com>
Date:   Mon, 30 Aug 2021 23:39:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7958258703249584200=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] btmgmt: add non-interactive quit on read-sysconfig
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210831134420.Bluez.v1.1.Iea4821c4c33d0a0f1986b97a1f6cd885427348a8@changeid>
References: <20210831134420.Bluez.v1.1.Iea4821c4c33d0a0f1986b97a1f6cd885427348a8@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7958258703249584200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=539559

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      37.75 seconds
Build - Prep                  PASS      0.08 seconds
Build - Configure             PASS      6.52 seconds
Build - Make                  PASS      172.74 seconds
Make Check                    PASS      8.58 seconds
Make Distcheck                PASS      195.39 seconds
Build w/ext ELL - Configure   PASS      6.38 seconds
Build w/ext ELL - Make        PASS      153.97 seconds

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


--===============7958258703249584200==--
