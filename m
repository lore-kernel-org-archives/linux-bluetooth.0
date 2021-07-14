Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C91C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 09:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF416120A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 09:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhGNJjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhGNJjl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 05:39:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C18C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 02:36:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k3so1403666qtq.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vTK+Fdx7B7M2zZD0lzKPAu8Lks2vnbQsGc3xfMKCiEY=;
        b=i+GPgNOHuab9brdmbI3TAzaQDvgJR3K9MkMsm7sXS3oiePfBY9ljudhpzQmJa0g2HF
         KJbfmo8Cjb6/9t6WnoMQjlE9xUVtHjVcYzW+sD9PwU8C3ba5lCi+dO5fUZ5PkzsNj59Y
         lwSTfhQ069tuxsGq3nkZq/CN1743PMc+XSbPo9swxMO2uWRNUvAnDsgPiaBRhAOSI4xP
         VJ15ZygzltXVC/xmVHHLDsFKu/VuONqtl1k0JlEp2aBs1DMXeYNU60zjkg71jdZH86N0
         DaPBxrX/4Y4gFLDACgm1Lf6JqFnseUwgPVqX4Bj7Egx59HrZto+6H1XolNz2DkSv6EEK
         h/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vTK+Fdx7B7M2zZD0lzKPAu8Lks2vnbQsGc3xfMKCiEY=;
        b=jFQ1cBYIu8F7mGhtPv9Huhqkui/HdQ3ff5bx2P2fHcNvZE28SygWMfagxxZxgP+4Rp
         xsHRyuEdiLkIUswWg7r37QUvF4VqaRLI5CCqeIvCvZFJ9VcreLa34G/rXanUNrb8js69
         kCM5YfMboVQao2dHIogkcjU32/+Xu+EfoFYusCwcPlvh4ikaxvAHMSUFbDgYrEB/qBc6
         rT39hWXkKiQZx7zF0VY7TnUDh9aZWVBtcFYy8PU+DsbdSORvBp3n/vhBjjmtDrE2ZDDP
         DjOND8wmLV9cj81KZgFiF/6FooZw8W/Hjp9K6OsoQjKJTpak4pYy8lRUY6f6FTWvgBpg
         XMYg==
X-Gm-Message-State: AOAM533ZKG5nuhm/aymD1J69yNjp+NcVryjmLhHjwpkv3diyQG+Z7pua
        G9SBZZv0e1Z1Fu+3AKdoI0C5xkXRRbXlTA==
X-Google-Smtp-Source: ABdhPJwzP0R3WXjWxw0haUXhaIRg23Uij5qIYXK8sPncmrTo8gjGD5iLwued82JRyoiR68Q4EIJuLQ==
X-Received: by 2002:aed:206b:: with SMTP id 98mr8432674qta.47.1626255409237;
        Wed, 14 Jul 2021 02:36:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.57.105])
        by smtp.gmail.com with ESMTPSA id j65sm826099qkd.17.2021.07.14.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:36:48 -0700 (PDT)
Message-ID: <60eeb030.1c69fb81.805d9.5088@mx.google.com>
Date:   Wed, 14 Jul 2021 02:36:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5290871343509307535=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v4] a2dp: Fix crash in channel_free while waiting cmd resp
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210714170153.Bluez.v4.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
References: <20210714170153.Bluez.v4.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5290871343509307535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515283

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       FAIL      0.09 seconds
Prep - Setup ELL              PASS      37.99 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.53 seconds
Build - Make                  PASS      165.22 seconds
Make Check                    PASS      9.22 seconds
Make Distcheck                PASS      193.33 seconds
Build w/ext ELL - Configure   PASS      6.37 seconds
Build w/ext ELL - Make        PASS      153.23 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
a2dp: Fix crash in channel_free while waiting cmd resp
14: B3 Line contains hard tab characters (\t): "0x000059f01943e688	(bluetoothd -avdtp.c:3690)"
16: B3 Line contains hard tab characters (\t): "0x000059f01943928a	(bluetoothd -a2dp.c:3069)"
18: B3 Line contains hard tab characters (\t): "0x000059f0194377fa	(bluetoothd -sink.c:324)"
20: B3 Line contains hard tab characters (\t): "0x000059f01948715a	(bluetoothd -service.c:177)"
22: B3 Line contains hard tab characters (\t): "0x000059f01948d77c	(bluetoothd -device.c:5346)"
24: B3 Line contains hard tab characters (\t): "0x000059f019476d14	(bluetoothd -adapter.c:7202)"
26: B3 Line contains hard tab characters (\t): "0x000059f019476c3e	(bluetoothd -adapter.c:10827)"
28: B3 Line contains hard tab characters (\t): "0x000059f01949d8d7	(bluetoothd -main.c:1114)		main"
29: B3 Line contains hard tab characters (\t): "0x0000787b36185d74	(libc.so.6 -libc-start.c:308)"
31: B3 Line contains hard tab characters (\t): "0x000059f019433e39	(bluetoothd + 0x00026e39)		_start"


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


--===============5290871343509307535==--
