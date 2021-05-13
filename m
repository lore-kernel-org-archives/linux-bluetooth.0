Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B1EC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 06:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C6461405
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 06:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhEMGun (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 02:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGun (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 02:50:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21BCC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 23:49:33 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q10so20479359qkc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 23:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ky+L01TKZw2K0LFY2Zb7v0MA3SmNbj3bdFYRJQUZCSE=;
        b=HKJ/jEcWftjK8Stlf9eBebjU2edWUry0Dh6TIeXAts4dlBMzgGNxylOgwA6UysS9lE
         cihAlahqpup7bA3N7ai3rXcw283lRojd0So4JMVjGNl9J5jzYxzq8xPBBrBbMnr+7Dnf
         CPJ/athaGiO5Q7p4Om3uwG2GJfv0pBvf8LRIfvIWQVWDl+xBSh4aqzwEd62AldHm1uMl
         /g+hL080Jl4RMK2LJzCNa9yl5Wy8rIaXBK/6gQYbNwoP9RBA0aHPN4Erl9KNv6cnOsak
         kqoX48Hy2djPokhhpej+y2SMbzMAg7lvVUtC/4ZXEYcuCsBy2iHhNmNZL4nM2my2j/S6
         NhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ky+L01TKZw2K0LFY2Zb7v0MA3SmNbj3bdFYRJQUZCSE=;
        b=uMY+Zb9xcXBRtG4AgnFTENZwzZnNUbDKdZs9E6+2CFojKYp7Rws23XKJ2CUdzv+1GG
         Ff8nxbal6hrawj/SOYujhgSDC0MbNNIFDUy7faewkCPBNyDKe7BY3tepqzWcHDLP9PVb
         GtPGoVmdEo+oZ9QVF1epunBj2sTByv/v01qgYDrn0o3FQVaxMATi04TDFoxfTBNwYfWz
         CT5NW/bYSfPtYEzlFfJkjdk0Nf8BQnJ/8rpU6Mb3lFz0J7S0n/oIJzQiL5GnSZr0lU0l
         3iCa3GC03Q7mjSJ1aJCsUE5hLBOjLMT0JAIzctzu9gknQQnBKefh59DrFkVGo1cp/VJd
         /Y+Q==
X-Gm-Message-State: AOAM533AFxELgH5RABfc3SV1nrjybhVy3gSd+2scSk6RBZEPjp18Au1V
        PbV9HhGbnVZ7+9wNetvOriZt4SDUYdbpCQ==
X-Google-Smtp-Source: ABdhPJzdWlK3+z9MopaXq1UayrxXqVbIUhlVEzyCLxE6Ifxhuk7YvclftkA6zd31AMVDtgVfu/qVbA==
X-Received: by 2002:a37:a604:: with SMTP id p4mr33014954qke.408.1620888572784;
        Wed, 12 May 2021 23:49:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.69.252.229])
        by smtp.gmail.com with ESMTPSA id t11sm1777075qkm.123.2021.05.12.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:49:32 -0700 (PDT)
Message-ID: <609ccbfc.1c69fb81.7a1cc.c9bc@mx.google.com>
Date:   Wed, 12 May 2021 23:49:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2231311713519181309=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Add missing "storage" option to help menu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210513061516.114889-1-inga.stotland@intel.com>
References: <20210513061516.114889-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2231311713519181309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=481661

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      41.27 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      7.08 seconds
Build - Make                  PASS      174.12 seconds
Make Check                    PASS      9.27 seconds
Make Distcheck                PASS      207.89 seconds
Build w/ext ELL - Configure   PASS      7.25 seconds
Build w/ext ELL - Make        PASS      164.20 seconds

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


--===============2231311713519181309==--
