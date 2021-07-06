Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB91C07E96
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 05:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0516197F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 05:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGFFKF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhGFFKF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jul 2021 01:10:05 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657CAC061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jul 2021 22:07:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q190so19040690qkd.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jul 2021 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3KLYJ6zVscFHZ4c4HPMozetffQ9GSgiIffMwPDweFzY=;
        b=Pytfo07qq/bNtTC0rna6XXXIGcDv+/nQ2lD+798iY5G7MOCdbuIskgjrMrMR7zsE8e
         r8oknHuJ3gw9zkIfH7oBZH+PpjnsgTM8RDDKHxZEGrisFShJ/OY4nlE/y6kZn5837+eq
         43vqhzQP9TB57ae95T0sHM0+3gydvEvRZPULPc6j3UT5iUHSlIIkzVBDf+dylfAeNszp
         6QcgQCKSmoqstZwKIxazQJTbKg5D95B4MpPN1BNOfgRz2hasBkLw/rj4861qzwPeZwkz
         LyVkBCu62C0aRtI65iqnUtrS80SQqe3WRUBCv/YOehvxWDYiVLQlJGkCnZv64zIg912b
         Porw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3KLYJ6zVscFHZ4c4HPMozetffQ9GSgiIffMwPDweFzY=;
        b=I6Jg2GzmkilKRKqXh5ElGtrsA0kec+2FQltgL7fUCskE4Dg/FphWX22zQohVvWGaVQ
         xy/T/mBPiAA3QCMzGhnfYH2izWmywnTfNiQlpHH893mRDKXVmk+DGfue9ign6F/ldXWU
         3blmuptfJ5aSamC3wKfvzvu1nACgPfmYfSTMqZKFx/QXAcHxLM+eNXReVmNQQwjVlo+E
         K79hTyS1VV6QZ76mzbtQXSeuA8HtnuZBDBoNwhq6pOlKngQDHnGdnEQUlUUUYz0Jju1T
         aJKkpoVAL+aJcm2/WgxwLH+pqEb76aNUI2HEAu3qT7qlFfacr4ub/Kxa3ld5tFY2YCyT
         o7PA==
X-Gm-Message-State: AOAM532Hw5qNQlzryY00BK7dnlzFrNUuHoHPw5FE8ilL0ree3UMNeGey
        HnILOBX/V6k106L7r0zvySX+KXFTygoM8w==
X-Google-Smtp-Source: ABdhPJy1q6syn8IwgXCqscXA+rsYfUKUyZyxUfYmKYyayCnMSvYlTYMWa6pw9mW+fkH5+YEMKQz/lw==
X-Received: by 2002:a05:620a:150c:: with SMTP id i12mr17514070qkk.458.1625548046417;
        Mon, 05 Jul 2021 22:07:26 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.78.192])
        by smtp.gmail.com with ESMTPSA id m3sm1949228qke.37.2021.07.05.22.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 22:07:26 -0700 (PDT)
Message-ID: <60e3e50e.1c69fb81.4d406.c2ab@mx.google.com>
Date:   Mon, 05 Jul 2021 22:07:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6633302763668370273=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v5,1/2] emulator/btdev: Update the white list and resolving list size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210706043205.171122-1-hj.tedd.an@gmail.com>
References: <20210706043205.171122-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6633302763668370273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=511147

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      0.25 seconds
Prep - Setup ELL              PASS      50.22 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.40 seconds
Build - Make                  PASS      222.51 seconds
Make Check                    PASS      8.93 seconds
Make Distcheck                PASS      269.38 seconds
Build w/ext ELL - Configure   PASS      9.37 seconds
Build w/ext ELL - Make        PASS      214.46 seconds

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


--===============6633302763668370273==--
