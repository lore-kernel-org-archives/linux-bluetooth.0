Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A9FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DAF60F9E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 14:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhHHOy0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Aug 2021 10:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhHHOyZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Aug 2021 10:54:25 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B0C061760
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 Aug 2021 07:54:05 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kk23so7056705qvb.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Aug 2021 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=p5oOJkNK1pAjwaMFMi/9778bapBLzRtW2FiSaNQSXYU=;
        b=AKitqxS7mbHsENmgdoIegi1mPo0vKJVMOgtI9mRJoOT2C5/KfI7i/sH/RZvXD35WwO
         hgWa6QD3LUqaDxAWtlBcq0czK1d1wqB3OLX6r/6FldHk25ZpWJamgpHQtonxyWQkzQ+l
         M27fTUm3j4Tn9YxnH3/PeR4ZJAEF3EOrUlqo1NdsacJ5uSezTNII+Yix+0VKDF0HTLdg
         vlWRWtrq5Xy9UdA7qM2exwMKfQFmluP+RTauwkNCHgqCT38zeQ/ZVv47GIMBaK6xAv73
         s8UO/Bf1AX9T+M96syED6zLtQY+qif2yih8b5EKHfVOda3YgA5OGmcYITo+twXBttdka
         7rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=p5oOJkNK1pAjwaMFMi/9778bapBLzRtW2FiSaNQSXYU=;
        b=ffLNl2eBYmZXTIRNXwAJ7rZhfB6BSTr/nczE2olDMYN5fj2sbFs7/IfUOvwiu7p18b
         1Wcqp+e4LqhmQG3W39P9t2p+WFxLcjZ4TPcxW+Z6bANZLTfRabisfTldqzD1yVYtdDas
         Aootn31ILbzTLgoCIQ5r8SS8RUdoPyCx/zeuPHS+/Fe8rmmh5slPeZmNfrbk8WMXlBaW
         0VyzUvEQNT6OpFhoHZku2oahwumr1llvhBbZq8hmFcMdoqZvyjGBLVI8ULLiG4HdQtdM
         gztfOeQ0srXjQNah92CBtvD1RyOC5lVRP9S14NqIuy7G4hbbNEor/WuAloaCiSDnOWyo
         caKg==
X-Gm-Message-State: AOAM5315SrFquJ2rwzc0DNxf1kjdBrDPMY5HbFyp1SqgPGIiYwCaoGg4
        BbhjWokDhDWtRdEa6Th0EMEGBZn/WvVbFg==
X-Google-Smtp-Source: ABdhPJwYF+4UTY/tB5kaY4Wmx4sD6GSUbIClkUYa9sybkfFB/ASRXDWTiFP4BdrbL8ueBzxfnUNCkQ==
X-Received: by 2002:ad4:5ccc:: with SMTP id iu12mr8776047qvb.47.1628434445059;
        Sun, 08 Aug 2021 07:54:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.244.204])
        by smtp.gmail.com with ESMTPSA id p19sm5468853qtx.10.2021.08.08.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 07:54:04 -0700 (PDT)
Message-ID: <610ff00c.1c69fb81.2609d.3915@mx.google.com>
Date:   Sun, 08 Aug 2021 07:54:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7111087252601904032=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijn.suijten@somainline.org
Subject: RE: [BlueZ] audio/transport: Only store volume when also emitting DBus prop change
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210808143555.100258-1-marijn.suijten@somainline.org>
References: <20210808143555.100258-1-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7111087252601904032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=528101

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      42.87 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.32 seconds
Build - Make                  PASS      182.65 seconds
Make Check                    PASS      9.08 seconds
Make Distcheck                PASS      208.43 seconds
Build w/ext ELL - Configure   PASS      7.70 seconds
Build w/ext ELL - Make        PASS      175.34 seconds

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


--===============7111087252601904032==--
