Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B4260F46
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhG2DCc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhG2DCc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:02:32 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20312C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:02:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 184so4531508qkh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZNL6lcc/nOMUzPGjowdnbUqNg0jvT2TjwELCZpCsQNE=;
        b=bEbLfoAEVbCE84xsJuZmCS+2T2hB5SQ8K/d5bzaKRb452JhBZbgnTKXpX7VjzXPAy/
         kD/oCwtFIYZkqXQXGASnqbUynMAP25hDVxuQVV0NxRRBq8upvDECbv4Q3sXjyrgY4mJ8
         Z6nnh7F8QCO6tFjrwSPlPctDEekfY2dComeRaymN3LKe0E75lwquOV05aosHsJVhOlU9
         Rqc9x/YEAytof1RdXn/JoZquc9RDbmnKt/PBHu1FNfbNYYdON56hpMsGyNjEhkAVHMcF
         XXU099kxtUMNbsKM7IM02V5tvpHqKWwui2Ljic2NY9M1jZ58tiwYqHs/0NXubBosGH2l
         igog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZNL6lcc/nOMUzPGjowdnbUqNg0jvT2TjwELCZpCsQNE=;
        b=PKNzlqTlHHDDnj16oajxCeZnGgZlxinoXNXRIc19YKEk2Y2yHc5JR4N3X6d3qYOX5T
         DizcA6pj/rwk7qTn38h5Si8vDh0PUvztrP9/68zkAweWGNujNPAPTxr7ZO6MGFRTUkV1
         iIQAYZ8EVt33GCoeaCDNKZ5dOIu0g6sYJ78ukl3ibaD0gjCLFgCEJb3bfNt5T+XA1Hb+
         7Yo+2J2lKaPKHJ8imMjBAj2FRXi59fGDdqPtsY9/L85hTr6tuuqeN6feyJpx0pYTChJT
         N2jhT7IchWoK9xuzrdKmfEWNoN6O7OiqJYgZZh6WwdjB+4AI/cnFsU2YEuFd60Dy0XvH
         z8Dw==
X-Gm-Message-State: AOAM533SbQEoiVYGSex0GonXzcUXx4anG7oHXxd61EId0UWObMj3y6lD
        radtLV2uub8C/3faq739CzRsoxayd6g=
X-Google-Smtp-Source: ABdhPJy0s4fuDbN2bhFLKyG+4pbq2Erqgdd2nxr+rTho/wfenWY6/Sbe6IMoD7kv7MVmXxacr3Emrg==
X-Received: by 2002:a05:620a:171e:: with SMTP id az30mr3080166qkb.325.1627527747259;
        Wed, 28 Jul 2021 20:02:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.249.191.131])
        by smtp.gmail.com with ESMTPSA id i67sm1085227qkd.90.2021.07.28.20.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:02:26 -0700 (PDT)
Message-ID: <61021a42.1c69fb81.51984.89ba@mx.google.com>
Date:   Wed, 28 Jul 2021 20:02:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6571291574972645908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [v2] monitor: Add support for tlv based version format for Intel vendor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210729021504.189617-1-hj.tedd.an@gmail.com>
References: <20210729021504.189617-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6571291574972645908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=523077

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      45.92 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      8.04 seconds
Build - Make                  PASS      200.08 seconds
Make Check                    PASS      9.15 seconds
Make Distcheck                PASS      235.97 seconds
Build w/ext ELL - Configure   PASS      8.29 seconds
Build w/ext ELL - Make        PASS      187.90 seconds

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


--===============6571291574972645908==--
