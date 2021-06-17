Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF5C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 01:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781EA601FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 01:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFQB1u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhFQB1r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 21:27:47 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3059C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 18:25:39 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g19so1538844qkk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hPMm7kXWCyN4Y2D2B6K9euQowxKBkVldmWmLghM3lzw=;
        b=c91/QSOh8Ezo6CLGP2JYY9QxQ4LqsvM0PCWGdp/uNgG84jikbmVrvaeisenB8UXReA
         QCvjitvhYZGQ+JOkRWaTpE7A51R4EJxuPr0ysQHiYkRJ1xW/2w1j4y7NnxbbnkwPrz3w
         2Pwkb1E6aftRK1BDv4DFdejk4A4S9rogbi57U/0nE5BCNDUjUMxPWRfDE8UzhpIpYx8p
         Wmuj/Et2r8JtBdplJXizRr+AM9b4g8fGIASbNGz1vrMUOKRaJcza5oGx1+DTUa1WpXLp
         bO37PXJEliCZnxPX99iDMb3G52S8sGK9LS3t6rpPcrSydjSjdrVBhGTaGe0N4SSPVv5p
         xSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hPMm7kXWCyN4Y2D2B6K9euQowxKBkVldmWmLghM3lzw=;
        b=Cs762/Xx59lNDiXPS63rcz+505gJ/CBjyL85DgmwiBoeYo9jXwOaUR/5UHw/8qVjCk
         TfuppmFMs70oPNx04SQ+ekDKQyehMQf0KJ+efJwCUyA5ybGl8xwpQcERn+OrPGkAnDyG
         trcy4mhHanJIY1b3jhxcuCm4NbYt/kPyZ1C+hoMivqnsFJ17RNxa+BY3mCCdg+0ofd4W
         +u2RUKD62v11DydiNEE39aglO1YY0gh9y9mMlVvbs7lTgAUL61G/PLzJ5HZlhV62Msw9
         FAhizxgFby5nbsOVdEw8KERaItNAhYu1RbH30EOxp3S4n17ZcFTfD9g0oGBkdzk13e+/
         67/g==
X-Gm-Message-State: AOAM531Nn3a2/40cfVTZC59IdWcq+cfcDgg4grVhlJDYeaplj7zf/yxN
        kKH+l3wSgdVqDBN9a4LVAFnarllOKhfYVA==
X-Google-Smtp-Source: ABdhPJzxWgNH732XqH+yJE89pMDzyBQFPRGi1AVRcHb8COE0Luo+z4Wb2A4VakROdmaUKdCG+hqXLw==
X-Received: by 2002:a37:a041:: with SMTP id j62mr1246156qke.155.1623893138751;
        Wed, 16 Jun 2021 18:25:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.111.82])
        by smtp.gmail.com with ESMTPSA id f130sm730608qke.37.2021.06.16.18.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 18:25:38 -0700 (PDT)
Message-ID: <60caa492.1c69fb81.29ed.5e49@mx.google.com>
Date:   Wed, 16 Jun 2021 18:25:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1142942205224273367=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] avdtp: Fix parsing capabilities
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210617085321.Bluez.1.Ibf5dbfc72abf7d12ffbf18219832e19d965ba024@changeid>
References: <20210617085321.Bluez.1.Ibf5dbfc72abf7d12ffbf18219832e19d965ba024@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1142942205224273367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=501973

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.84 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.94 seconds
Build - Make                  PASS      171.48 seconds
Make Check                    PASS      8.72 seconds
Make Distcheck                PASS      201.76 seconds
Build w/ext ELL - Configure   PASS      6.95 seconds
Build w/ext ELL - Make        PASS      161.26 seconds

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


--===============1142942205224273367==--
