Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A420EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 23:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1FA60E52
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 23:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhHIXi1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 19:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbhHIXi0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 19:38:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC2C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 16:38:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u16so18466566ple.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JDmfQKFpENgQAH2MN0rFw2KZZHFwx+BjjVi+Ee0fSmM=;
        b=fDYEu4um4GCF+22IXFNSNATLW6GOInxU4GhZRp6zswXfoMV57kc6/mZYzkbmZHjLyx
         MO4WCkS2//iXKyXp4WbJaKpOe5M9vZ31k04kyrTYxdcDCLNEYhHqWNVEz3UEGlTIrmlv
         lgWd79YuC180/mXAkETehiVsBcdJeZFlLNhm8AWcB3/aj+GWV1PmMEVo1e6Q437n5Kqt
         iM+Yt+8VcFFOgSO2zTwcY5ZNCIEVTNIPNOF9+wLsThKv93aoLKG7QHvZJCYSqAEIhLBU
         h6LALMX1Tw8yNbqar2gHHboeRe+UqUl05ZqKiyeBDtGDWwjrcIV040fhyzLyBgBxT+BQ
         QxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JDmfQKFpENgQAH2MN0rFw2KZZHFwx+BjjVi+Ee0fSmM=;
        b=CXXv7gVxQHBxARVNb4CFKVx7A2KndUatSWkCLnSKt3Jxnx27VgYHB8B1uSY7UhKw9C
         T4LgsM7PwxX3+CAqpkH1fAz94KhO72SMdJpn8UYmemNWKo9JGGJhSTNbHOPXu8CCokTS
         u9KIwDXSGsdlsOXURMWa2dINwEo8K/uckh2lT7qceUBUt2s7hVTLvIWqLGDUmjdrToan
         jGBnZEoJKMWnDYjbF/ZYzuxSF8r1RpY1aXOLHQzu7el8ZtxXhdlp7B6Pvs4zMKvRrcNq
         de9Nzlj3YuOpi89C91KxFTbjZ9MBpf1dHvw4Zh7ksFtVLku8PTJ+LhkbqTW32qB9RfEk
         KxCA==
X-Gm-Message-State: AOAM530g2j8bDDgvzAXOHjv2qve0KNRvg96vBBnZPvk1useGXHa1ZgMw
        uYFJ4Z6hXjZ1NskA/Zbu2vwuBQHrGPk=
X-Google-Smtp-Source: ABdhPJw0HuinhLdppyuRtdZBnGHMYBTxgejHPzRGF/dtuUMZO4Cfl+SVoRZ9lOQCMCiSwoMwCpovAw==
X-Received: by 2002:a17:90a:b303:: with SMTP id d3mr28167420pjr.199.1628552285216;
        Mon, 09 Aug 2021 16:38:05 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.160.76])
        by smtp.gmail.com with ESMTPSA id f6sm21216940pfe.10.2021.08.09.16.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 16:38:04 -0700 (PDT)
Message-ID: <6111bc5c.1c69fb81.fec76.f926@mx.google.com>
Date:   Mon, 09 Aug 2021 16:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6538836197339111096=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] monitor: Fix median packet size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210809224942.225915-1-luiz.dentz@gmail.com>
References: <20210809224942.225915-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6538836197339111096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=528765

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      0.65 seconds
Prep - Setup ELL              PASS      50.18 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.71 seconds
Build - Make                  PASS      221.35 seconds
Make Check                    PASS      9.39 seconds
Make Distcheck                PASS      260.28 seconds
Build w/ext ELL - Configure   PASS      8.99 seconds
Build w/ext ELL - Make        PASS      210.04 seconds

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


--===============6538836197339111096==--
