Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 21:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42AF6103B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhG1Vfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhG1Vft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 17:35:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69326C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 14:35:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b20so3778372qkj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Dp6TVaPpsiCDWKxxhIbtcRZula8tPVI2ThsyC1DlzX4=;
        b=JZ9PF+jBbr6Og7jNjSFOlTuzXIPF9yTvXcBk767W0yYV5I02SSByus24UFpwUBYo/h
         I4XCfezrmZjije3ENKSgDibi4e8HWnBZajJ06LAkmW6/VPv6aE3EpEM8cpiPBtZo1GoJ
         Q7xasXvy9DSnaYQ35rO7XRamL8iPLg7Q7FX6EGBZosL1v6bBRkplZ7Z28S8rpxGY8i4L
         7vPX8FM4zXeykN22yrnfDyIrK05uB2Hg5cQ8+DGgzXMAEsdUzXlxS2fPknVSD/6pEceK
         1eX18hqMhUh0R8xBPxrl9jOSZIQ8JC3JLze+zEtH3h/oSJgv62Rr1N0NFtLOUOC0K3ir
         eNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Dp6TVaPpsiCDWKxxhIbtcRZula8tPVI2ThsyC1DlzX4=;
        b=QtajGvDcU2V7jZdyGzgRc4WQP0xmQcBQyhDLdkfc7BuQeVfaBsvZWdnyhckJQ1gVB7
         FoJThTGMgUbyRD+DgqeV8up38cEWmOgry7YRrgzYhGypZeL++x/UxFgYX4bRB8yHEald
         cpCoMk+V+pbwWOWWL75QGvclZTWxIAunSNfomICkmmHk0BXzsZwHaZaO1KxKsUV5TwjH
         QAtLyOevjY0pZyip73PL+DgOAlE6gqdpDPQNjOOtK2pS2LPTnuwgK2FZesklcbzpOr0r
         nDQ/E/DEdL2yMVqlxLI2vQxoJ5KEz8ztoWvxhhcRSnKYFvjUTFYS5rdb581WL9ZQJ8jZ
         qv7w==
X-Gm-Message-State: AOAM533eZstsuOP/oZ4t+pNH5TriinSl5ow2ZfPZnkAcsA+OE+wuZ5nI
        kjngFhxYHxOYt1lh2V/5WGtlPcJoJoQ=
X-Google-Smtp-Source: ABdhPJzh5lBv+qH64921OghqitdgTwRtqPWVElWmVJJZmNpGbyifk6Uolo3vaXDqq2FEDTep4zkUJg==
X-Received: by 2002:a05:620a:7d3:: with SMTP id 19mr1816824qkb.351.1627508146475;
        Wed, 28 Jul 2021 14:35:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.127.29])
        by smtp.gmail.com with ESMTPSA id o186sm657497qke.44.2021.07.28.14.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 14:35:46 -0700 (PDT)
Message-ID: <6101cdb2.1c69fb81.9e653.5a33@mx.google.com>
Date:   Wed, 28 Jul 2021 14:35:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0553598397860063147=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] gatt: Add support for Central Address Resolution characteristic
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210728204800.2205665-1-luiz.dentz@gmail.com>
References: <20210728204800.2205665-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0553598397860063147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=522925

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.70 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.96 seconds
Build - Make                  PASS      172.16 seconds
Make Check                    PASS      9.09 seconds
Make Distcheck                PASS      201.97 seconds
Build w/ext ELL - Configure   PASS      6.97 seconds
Build w/ext ELL - Make        PASS      161.60 seconds

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


--===============0553598397860063147==--
