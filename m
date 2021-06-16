Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D7C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 13:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDBD6128C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 13:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhFPNtB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhFPNtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 09:49:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2FC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 06:46:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u18so2246795pfk.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FGl6qIr88IAwEau0LgmTgGmd+JGGnL9u58oKXaE27E4=;
        b=sqP976KDby1oAtY3jWMlGkx6taYzrw3t/5lBhMIKF3zBYZZovEshFF4b6txpeNlte4
         qWTXH9KtvCgv1XDRXpk1btmQDL2426JQihs+rq7DFHYAxVTGOz5kgH7ZhzV2kqj/jEeW
         1nvBxyantimqQC5AeblxxsOeBWMWe++8dvrEVkVdZyTmUnS/EEk96tQTSwM6TkaRhrfP
         T8vGVkCT3NjKhzBJQOHzJdmKPgpKVZGIkSQyhHNyW4Mz+kEbwIIJwEBnUU1mXpi4kfZ1
         xKkzkKrncD8Nga85912P6mjHyL4tQlSZOl6CwrRU9zP6ANJxHgpMPB9HKjsLxAGD8pxV
         35tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FGl6qIr88IAwEau0LgmTgGmd+JGGnL9u58oKXaE27E4=;
        b=mS1J+X1RSylBrq3ebu9kW3MfcTwRqHk659qd4vtveSeqT5xuCk087DEdw5Blpz/kus
         yLvZGQIy/LOwHkD28pebOpXcWF/LWzZyurz2nATg3ZVBe6hj1cImtpJ6hpfQjOPk3qr6
         x6X2KSxE8Mn1Y0n+aI/2oqWQXrgbahc0M/0sxuHs5ZkOn2McbO5MtruhpeWZwzYUymtt
         UXmSwTs3iox+FJ1AOc7b9s71JpISMKdieFuIe+Bbrq5cqQczQv7IcvUFlxWApvT9p1BZ
         NUKLjNvkj4G6Bi5Xf5XzxqZMnj4st3q5y3fIF3KJbDCfxZk7UMfIvywl6WpKtDoXu7eb
         BoIw==
X-Gm-Message-State: AOAM531drdwcBXJtrBmXuMudWvL4hvcJa9ej+wUskuEGpQfpdFre4Pdy
        wGbbRKm0nlTkB/nXP23rIReyYVjIdFc=
X-Google-Smtp-Source: ABdhPJwpV3F2uODyn4oLAv9QZK5BWOg/8LM0ZnuCtwyXZ43jI4JuHLpYpI3XKZWzBG7LCLz3TRUt3A==
X-Received: by 2002:aa7:96d0:0:b029:2e9:fea1:c9c1 with SMTP id h16-20020aa796d00000b02902e9fea1c9c1mr9567694pfq.67.1623851213342;
        Wed, 16 Jun 2021 06:46:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.57.79])
        by smtp.gmail.com with ESMTPSA id j19sm2514321pgm.44.2021.06.16.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 06:46:52 -0700 (PDT)
Message-ID: <60ca00cc.1c69fb81.e64fd.6a86@mx.google.com>
Date:   Wed, 16 Jun 2021 06:46:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5848867979077263688=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [Bluez,v2] monitor: Adding missing device found flag in the parser
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210616124229.1059905-1-alainm@chromium.org>
References: <20210616124229.1059905-1-alainm@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5848867979077263688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=501559

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.09 seconds
Prep - Setup ELL              PASS      38.67 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.50 seconds
Build - Make                  PASS      161.00 seconds
Make Check                    PASS      8.75 seconds
Make Distcheck                PASS      189.81 seconds
Build w/ext ELL - Configure   PASS      6.51 seconds
Build w/ext ELL - Make        PASS      150.88 seconds

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


--===============5848867979077263688==--
