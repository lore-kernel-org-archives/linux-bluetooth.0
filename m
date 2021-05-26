Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B45C2B9F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC4C613D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhEZFq0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 01:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhEZFqZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 01:46:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD3DC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:44:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o27so32872213qkj.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=U9R4ZXVmW/bfbw7HmrlY1WQbvdp3Vt9tkdeD3xk7ogQ=;
        b=LfE35BPa9JA2nrLDDMyASvOG81OKvTM9pR1XMTZe7TKtZWUvQyKoOoNgsyGkETX6Vx
         PzI+MI0PsnjVZVPTp/i7Uz+veU2Bat7mlywf1QGUguqdELVoCU9EBaJtTvxTKgrJDi5P
         39FuHceVUCGdmDCeZuRouN4oe/Tnm9UfbsqyByktebUPeLHvY2VwyQ17Q59qbX9goYoS
         D0Vab+k0CVpONqlzONiSulBEzMOFmqoDnAFUSoiO/iwNmf/c4bXTr8/EWVOpZl4ze4X0
         u3Fe1jah7NMGOOgnnKHqjBUpHDEosMD/QWoN7UDmurFTBKqgBGUIOWSpzVnvllF6PWMZ
         WAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=U9R4ZXVmW/bfbw7HmrlY1WQbvdp3Vt9tkdeD3xk7ogQ=;
        b=eF29q8z3dEROSs4aazTG039Z2z4kvlK0zo2YUTJCzJHJeDPd1sAipoBtd5g9FUG7f5
         P5ElM30vTu3nmtMywCe8bBGdOed/FvD3ZvMiuoYFmI7IFaQk3My93nm0eLdsPvIzliEA
         4M+off0fKqabgo4xFwuOl9bGebC79kVyuJS8080+WDbFwvbUmKoZEaOuHIi5Gu40aNnM
         otD/FxPn+n4LtSmoZbKMovIyZXDqXGj+V7aKCzNQFx0t8jniQYXtR9T7WG5C2Ej7Jl7S
         v5/9vFRCZZuo2J4BEiU8uv4M3vcM/KdIpXkRHma5GDmcrP9aXpdq9UC9GY8wob/9Lkzk
         1afA==
X-Gm-Message-State: AOAM532ENvgab1M4983VjUmOSUBT70oe2TAxn8WXD1lSz0EAEfqdQtfH
        DGp9xiFuszKFbYRzVX6akn/nEj++es5nrQ==
X-Google-Smtp-Source: ABdhPJz3t4fl15ywVX1VcrL9bK0HSkq5q+yPr9EBCx2eiSgWJkpZwQzzWTh0I1s1Y91geFxLxzpQFQ==
X-Received: by 2002:a05:620a:4486:: with SMTP id x6mr39855541qkp.229.1622007892855;
        Tue, 25 May 2021 22:44:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.199.79])
        by smtp.gmail.com with ESMTPSA id h10sm999464qka.26.2021.05.25.22.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:44:52 -0700 (PDT)
Message-ID: <60ade054.1c69fb81.4789d.704b@mx.google.com>
Date:   Tue, 25 May 2021 22:44:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1938214601508044016=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [V2,1/4] tools/btmgmt: Add device flags commands
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210526051310.423630-1-hj.tedd.an@gmail.com>
References: <20210526051310.423630-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1938214601508044016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=488567

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      45.66 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.83 seconds
Build - Make                  PASS      190.51 seconds
Make Check                    PASS      9.47 seconds
Make Distcheck                PASS      225.24 seconds
Build w/ext ELL - Configure   PASS      7.66 seconds
Build w/ext ELL - Make        PASS      177.05 seconds

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


--===============1938214601508044016==--
