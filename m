Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 23:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8761101
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 23:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhHXXfw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Aug 2021 19:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbhHXXfv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Aug 2021 19:35:51 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57469C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 16:35:06 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gf5so1145823qvb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4pyAnRtB6BusjsxkdhbESMaZuodcjo7FNj0d8D/xHys=;
        b=O/3Jw6Vyy5KfePuoP1dDErpafk8H0P3GEQnQMn8EXPA1wzd6tuP7G1XDnHCtWDv1GW
         nh5K+0Jt+rYRYdETws/3hwcc66VWNlw8/c1IOC8LPBBrRGwctk+ariUGGkchGQcZt9Xd
         OYAJQbEwtoEQNryO5qps3EbeJXtqvJwLu5JSWbo+cBrcqtPtXhPDxrJMHIK72XsDwOJh
         bB4ibpAuHIVeDMed+/SKUdTW214OVi+xPVB6Jpb3dBX1MkJ1+rsUAz2MgpwRfRrJkkmV
         SOCo7TnrcyXsRQG25EPIudmq72SBH5ce0gMnPQlD35/WFOm8x2A1d2GlhLTbNh8gDPUw
         R06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4pyAnRtB6BusjsxkdhbESMaZuodcjo7FNj0d8D/xHys=;
        b=jXp1DQOPSYrfB/jx864M3z+/uuP6/1vCyZhSKx3hbJR5pof0TznmKSHYF3AKXAM4cb
         0BLB3zxIeW0rp/06FvXqdZOT+Y5QFH/vOYafkRxbYwkEPbH+tTlaFeCQg2ViLsA6lFUP
         5h9QSQd/9Wm4HVxyAka4qOeM7IFAHdOwcyrSsYEIJ7Y9OQFcfWoe0tnJL22sFc3F9kHW
         sAwDqRZ3VUNfLm+opBulMXsfjV6MeTAfjnPpV7338BTrG4Gp8BCgL5mFxzShKmo5SI7C
         y29LexY1HcFcWO9d11Rl3zKAVfX/LIy2PfBYF8MDfVmyp1EAFT+Mo9pJZ5Fbyxcuma/l
         SlaQ==
X-Gm-Message-State: AOAM530qrWCrJ+OBRGGJqO4/9tHDxTLIGA8Shole0yRtBrijEMkAuWNs
        dout7pynyi+9wMeidKivLetf+ZBxELOVWA==
X-Google-Smtp-Source: ABdhPJwlag7MmOLZ0VKaiwyknYh/XoxdGfnQLLCsL8mmCNqpNGGsli8IzaH4D2RGxxc/MozImaoQKA==
X-Received: by 2002:a05:6214:a02:: with SMTP id dw2mr41441419qvb.61.1629848105339;
        Tue, 24 Aug 2021 16:35:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.85.52])
        by smtp.gmail.com with ESMTPSA id o23sm9150418qtq.7.2021.08.24.16.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 16:35:05 -0700 (PDT)
Message-ID: <61258229.1c69fb81.8af0c.f2e0@mx.google.com>
Date:   Tue, 24 Aug 2021 16:35:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4341210861556060948=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Remove GATT Attribute when device is removed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210824225202.826941-1-luiz.dentz@gmail.com>
References: <20210824225202.826941-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4341210861556060948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=536773

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.79 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.95 seconds
Build - Make                  PASS      173.06 seconds
Make Check                    PASS      8.48 seconds
Make Distcheck                PASS      204.33 seconds
Build w/ext ELL - Configure   PASS      7.06 seconds
Build w/ext ELL - Make        PASS      163.01 seconds

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


--===============4341210861556060948==--
