Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CE3C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7826610A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhHYVec (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhHYVeb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 17:34:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD8EC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:33:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x4so1015100pgh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YeMzRud0kNFGPmJL1mTIkKfiAU4mdr5yNX2+pCdfQyM=;
        b=vK4jyfsu6Rgm8eUA1idu25e4E2iiDiP/TOBg0tk+saWQ5FA15hc8ss3MeKVAy2JZiD
         n+QfeKPt7C+5Sqqs4l1SXyyN+Rdia3J7MnYe/1mxwOZzm4LQCxaYcD7fkn/KINZdT5jn
         UVvaKG+7l35qUda9POgvdWfURHU6f2HIFz4wN95T303xfZVoEyj235yCHyg4iEI5yVJZ
         KBznstTsuVitYOd5ZsfguWq+/mFVxqW414AlDARxN6f88v0BndLCcf0W9iQOkvHS6StH
         JXNJmUY+q8AwHPz/a7l4nCxFHPbLn1q0DpJDHZZm1pR4JllkrjEHktuN4kJjWPVVWMMt
         Gtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YeMzRud0kNFGPmJL1mTIkKfiAU4mdr5yNX2+pCdfQyM=;
        b=Mq98CK6g2PAsaiVpyucUdZfevxMUsYTylvi2L4k/1MIVyUh+ioGU2614+iuL/Bj9q0
         cRCv3XS/lwTJPMEqou7pF0vlxAQJcd63mP4CO+emNnGTkIwKkfZzkrw5o/3KkCyNDoNa
         pm2ECI58EazmhxzBsl25Ono2pVnka4gx1rO/NvqlhAswDOd0sG3v9qe6sX0wPEU0I91R
         TLaeWVHM+uc2Lp+u4/yyVkFt8wwogE/6imp2PnKKLfCIxzLRImuxQJ9oBKL3O9DPwp/e
         DcAJ4XSzZiAmcDja5PE+X79Qer1mxfpILdtmRoh1Lok7sDqyELGTntn/etUMJQM6srXs
         RX5Q==
X-Gm-Message-State: AOAM532zT0EXWSVONOpvtIckl/9UZVuzqkEGfJADil5UGWYDjrsh3ZIu
        JPL+YLhk5T3PPAs1QJC3QxyUxJsqOXE=
X-Google-Smtp-Source: ABdhPJyX3XYk8wcZInbpBR132VJRmBcz1ZIKb03wA50FTYAe9Rtpj7HvJq5GpHgMsRqYP7T7mUSJeQ==
X-Received: by 2002:a63:5c51:: with SMTP id n17mr229750pgm.376.1629927224867;
        Wed, 25 Aug 2021 14:33:44 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.98.90])
        by smtp.gmail.com with ESMTPSA id y8sm630554pfe.162.2021.08.25.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:33:44 -0700 (PDT)
Message-ID: <6126b738.1c69fb81.1b41f.2a00@mx.google.com>
Date:   Wed, 25 Aug 2021 14:33:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9037338995080926846=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] shared/att: Fix accepting Exchange MTU on EATT bearer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210825211415.1057804-1-luiz.dentz@gmail.com>
References: <20210825211415.1057804-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9037338995080926846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=537355

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.32 seconds
Prep - Setup ELL              PASS      42.62 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      7.72 seconds
Build - Make                  PASS      190.27 seconds
Make Check                    PASS      9.03 seconds
Make Distcheck                PASS      224.50 seconds
Build w/ext ELL - Configure   PASS      7.65 seconds
Build w/ext ELL - Make        PASS      178.82 seconds

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


--===============9037338995080926846==--
