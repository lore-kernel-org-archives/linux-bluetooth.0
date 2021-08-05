Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099BEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 01:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14C8610CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 01:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhHEBY6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHEBY5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 21:24:57 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3486C061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 18:24:42 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id s11so2129431qvz.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iT75VrIN4bcJK4TfH0h/eQO0G/P9qILcb/Akds+ssIY=;
        b=JBnDEhV1VXl5JYK0Nb64xrMb2SWXAanoQzRWc4oDojU+cED/QYFhbfwD9N7NzCn9zT
         I0NHSkH96tDepiVXLQ0GAOxOTsJwiaSkR2D0gDqAZIIdfmSeQVDslBs7JGGR+yv8aq08
         19PZKw9bXwidDUhvJ6bF46Qjha+dcbGYfZb74RI67ybGg0luF7Z1bWNb3mv3YXZ5cBqa
         LWpj4i0ll/UiYGniVIaq/OWUWbtu1qUnRDKv2zxPTWpxNo0rjSUetgqvO2KDjxboc/VH
         tvSne88ejSTJitBNft/Tvbwf4hLKZVa2ZEpUhkLd/jatYWgzMEsNRnpIuGtYH+J4yNNV
         Pc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iT75VrIN4bcJK4TfH0h/eQO0G/P9qILcb/Akds+ssIY=;
        b=n0WgDoprPkc0N9YsnkUQkxLBaF/jnuClM2PUzJoza4g284vN1IsmkBKs7czewTa10W
         WSojNifgqJ8rpTLDazZXmwurRqvTdKWfuzvOCVgA06t4h+9bFayRIRWo8rQU1htFQOSl
         6l19stc+DkEZ6mjcjhtft6BtdyZxBa4uY3UNpiguC2stjpeAGEKOHwzf4yMZ0MtBefTr
         vMekxu249Cw9XwPYzbZmcX3gEN9yGhPmJDiZCIpwFogBkAyLowZpFRf7//XhXhcgTiMe
         Y/r3AlW0evxq0pddZdBX2OnNLkJeECeHfeccB2FN4M3fnzMRVd0qpcDyQ/mqI3dWrGia
         Vc+g==
X-Gm-Message-State: AOAM531gZ9rZL/PXBuwhyL9RqXvddUZegkrJYEYAIimbNbSbtpqOT3NH
        ZfTwfxc7ubHr6nF7IQq7e4QKh5tyEmI=
X-Google-Smtp-Source: ABdhPJzZ+SY0jTZPY+b8nSX8GnvLSvZE0NkhZJT0aapC6lJaXi96SjHmBaub8f1P7qygpfFtgxG/oQ==
X-Received: by 2002:ad4:5f09:: with SMTP id fo9mr2540600qvb.35.1628126681685;
        Wed, 04 Aug 2021 18:24:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.162.145])
        by smtp.gmail.com with ESMTPSA id c16sm1654327qtv.32.2021.08.04.18.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:24:41 -0700 (PDT)
Message-ID: <610b3dd9.1c69fb81.d8c60.a8ce@mx.google.com>
Date:   Wed, 04 Aug 2021 18:24:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2854994150693389569=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] doc: Add a doc for Intel hardware variants
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210805002123.22339-1-hj.tedd.an@gmail.com>
References: <20210805002123.22339-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2854994150693389569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=526619

---Test result---

Test Summary:
CheckPatch                    PASS      0.25 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.04 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.99 seconds
Build - Make                  PASS      173.77 seconds
Make Check                    PASS      9.04 seconds
Make Distcheck                PASS      204.70 seconds
Build w/ext ELL - Configure   PASS      7.09 seconds
Build w/ext ELL - Make        PASS      165.18 seconds

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


--===============2854994150693389569==--
