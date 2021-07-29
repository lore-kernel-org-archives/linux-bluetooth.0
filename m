Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C13C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F506103A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhG2D7f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhG2D7f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:59:35 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A4C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:59:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w10so3039595qtj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DUXzOYIPInncqtFUfIBj6qfFds6cQOe0yZYpCB+84DY=;
        b=TfT+e0b5nL4AOYk9OzH/GLrG9rjAQ0kxHIJ6f3tCffQznkSRJeaKTA4EjmZJixmix7
         jv49FKkxoCKLxuJ8XB2k6kAXiw9VVaE/m5OSTLsygM+5Uid+qx2zSA5LgfOuUYCz5Lzx
         frdd4lzqSr+ZKDdQlLIYG+3gqDXztx15L1a9lTAjG+aZs/Sj6qiycY+rbdwo+eURIDsH
         1YkT9oMMOeHfETWKN8EEvlIBkrAxaknvi4NYpnvx90iJtthgIR5k9bezO+sznWLFLGss
         Gi+3V/6qAns8Z1G5V71jctcYya2/D2WoWBpuo/w8n3R/8EpI18X2b7EX9gbrQttV23+s
         3bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DUXzOYIPInncqtFUfIBj6qfFds6cQOe0yZYpCB+84DY=;
        b=rvsUW4TEYlZ66KstS8B6RedGGfuWtdrqevygVHNuvMXn3eU6gXMqSPYO/Iy/ZIXFQO
         PDZv3f4qVtdAFmhWHYldIotU7bjEu+7hawHPiDumoOVcfHh3ckwrzse4X4c2vUy3X4MM
         oi5HK+UkhX2dOywIwsAbfiVGFK7lEb5rDVcviqKVM96hhw/0uTmFsNOFPxKh1QjkYQV2
         6SxfY9+0h6bwfDOc39rlBbE+PwVSoYAolqkaGGaKvqdOqDzkzm3ijMg9YQC/p9NX8X6M
         OcKdf7ueSgRgvDcSxggEzo8gOCvfq2PNhu9CiiQi1uVBqIcpIh7sCFqx4K4qbocGQ2QJ
         xT+A==
X-Gm-Message-State: AOAM532dyWIqOpASZRQ/EeCiAJ0DPx7Ts5pFEEULmKSYmnG5ZiV9HjNY
        Am2OHQzObcG+9bJJBZIQd6Pzzbdv1V8=
X-Google-Smtp-Source: ABdhPJwb7zK2ys6+TgEjPeOUKBxEWND/CgKFtbPBabd1JCjB1rh3b/1aNYqxNN0MhJB0xZ3rPDZhHg==
X-Received: by 2002:ac8:4986:: with SMTP id f6mr2609334qtq.125.1627531170754;
        Wed, 28 Jul 2021 20:59:30 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.37.117])
        by smtp.gmail.com with ESMTPSA id y67sm1161166qkd.58.2021.07.28.20.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:59:30 -0700 (PDT)
Message-ID: <610227a2.1c69fb81.dd48c.8d63@mx.google.com>
Date:   Wed, 28 Jul 2021 20:59:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5260016449804084731=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v3] gatt-db: remove redundant check in foreach range
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210729113552.Bluez.v3.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
References: <20210729113552.Bluez.v3.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5260016449804084731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=523097

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.58 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.89 seconds
Build - Make                  PASS      171.30 seconds
Make Check                    PASS      8.78 seconds
Make Distcheck                PASS      201.72 seconds
Build w/ext ELL - Configure   PASS      6.94 seconds
Build w/ext ELL - Make        PASS      161.29 seconds

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


--===============5260016449804084731==--
