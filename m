Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A1EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Apr 2021 01:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AEB610A6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Apr 2021 01:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhDQBbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQBbD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 21:31:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F5C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 18:30:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s5so22037278qkj.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 18:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=31AVuTSBBwduItlYJCoVrDPhRs+n5TQRclZdhOhh0wY=;
        b=XyvvM6YcAZPCjRpGKzdfWhdmqw55yP5vxKGQB8+BWt9G//op2cmAlRCw61nnpnS/pe
         FB6+OsOh6glGUiOrXo7kIG0q13t+9hshUP4amv6Zpd0ROSlQciSvPkKyZGvImRIGlxcL
         A9e52iktSFz6gKnD5VxcNvMjJPJ0norrX5EQHkSWImC41bUVKcsVa+fmpWNtnYdAmkEx
         xHMqgA3Hw96byekpQ9+KOVgN+EguQF7ZrW8bxR+OBuLyRKVUX1CZpjy//GV6Ig1JUPC3
         LtdLD7b+DczhdZR0SNMdQEoR9H8g4GssHLbOIbaPjC46tD8n+FKWjnoUE5kDGhIgEAYH
         a3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=31AVuTSBBwduItlYJCoVrDPhRs+n5TQRclZdhOhh0wY=;
        b=UM430rbBa1FMmemcOpS+AJe/dI3CN70YeIvWbnLc2D7Ekn9skNbyo7pr1eN97esx8W
         xoRXsiHbYPRnSJjuE+4s0sTnZnmnqLgA7jKNaN14JfCcVE/2BngFezHAazGWVJv6EaYT
         uI8qLVPxtxWqOLixfcRWqr0f8YaNr6xR2tyOJBpfPb+q60gffsYJZrIYEfpuTwvOuZTO
         5Cz4fXV/vvP7HjAtcewiv/eTnH15JTOzr7N+Qab67nxYKlDKz/BYEFr8opReoE3QDUjA
         LCfMeBdAYz+tkb7iGThL6OBf7WJBdZFx9ILSa9TWZfjuvDFH6WgnytoJk7DgRAN2XJAw
         aKMA==
X-Gm-Message-State: AOAM532nytLG9KAb8XcEK4H/oaG84OXGSi9P5zwr0TO5ah2k/K3Iadg7
        +8t96oadyC3giqhIRafTPOoDgTuqbLiZz49c
X-Google-Smtp-Source: ABdhPJzeaMTloj8TgUO8pK28YmD7T/nGCgHM4XN4qQup37vE5kThTcWiemP4nyKheMDKZSeChJOS7g==
X-Received: by 2002:a37:e213:: with SMTP id g19mr2067813qki.260.1618623035358;
        Fri, 16 Apr 2021 18:30:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.238.244])
        by smtp.gmail.com with ESMTPSA id i12sm5309978qkl.49.2021.04.16.18.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 18:30:34 -0700 (PDT)
Message-ID: <607a3a3a.1c69fb81.45b05.5b64@mx.google.com>
Date:   Fri, 16 Apr 2021 18:30:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2776807910068289893=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] monitor: Add Intel read supported VS features command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210417003446.628078-1-hj.tedd.an@gmail.com>
References: <20210417003446.628078-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2776807910068289893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=468919

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      51.15 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.88 seconds
Build - Make                  PASS      224.08 seconds
Make Check                    PASS      9.67 seconds
Make Dist                     PASS      13.41 seconds
Make Dist - Configure         PASS      5.66 seconds
Make Dist - Make              PASS      91.53 seconds
Build w/ext ELL - Configure   PASS      9.04 seconds
Build w/ext ELL - Make        PASS      208.59 seconds

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============2776807910068289893==--
