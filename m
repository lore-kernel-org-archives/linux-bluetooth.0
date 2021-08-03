Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C13FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 23:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3043961037
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 23:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhHCXiF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhHCXiE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 19:38:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E3EC061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 16:37:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id s11so300896qvz.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tPFuzsW/Zu9H6oKmvCtjt0OAFGQkEmVZMytPnunrvSs=;
        b=Kt/TWLmShN0rnEKFnlAivFek9dqWetCixS3XPQqd+M/YsxEhwmDKAuXyCEyjvNyIQp
         uubej8scEDtzJwvSoqw5GG/rS8zqP2zQuSPyB2a2CgfZ1tk9CdHzVsmgffW1KZKmRBaw
         GxGWsvKwFD4warfcQ2DYkMhniUQ3g5C6tvs1ssRqUBaxMKhnvlvu6evD5tWg+MW2ChBF
         fsEZWykxemiUReNRSkHG5CZDERY//uQjhaOKUpw9gKkH579K7pseY+p/rlghF+9Fq1Ba
         SWUWijYVFf3Z2eA3pk3Au8/u+QIzgyIFvSMjA6eXPkmhRw/XK0TBYtr8OUGSi0Vy0Kt4
         3o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tPFuzsW/Zu9H6oKmvCtjt0OAFGQkEmVZMytPnunrvSs=;
        b=B2DW1O92dhpPmsP4ctSLzMDikcacjlWTXFZz+SW447jtik5ufiAuEoarwcZQM5kuFE
         RPlvIZq47nLWdkBlYOC0AMNbQ+q5e0WBtQMVKeEJ8TemDZcypwQwDBafsxi4gLl4T1ly
         0vhQvInDaYGH6MkLf1E4kYtRDT9O9UzmSgCfiDMOS8/L9YgngEh/+owjA1xWBYUBLGRn
         ROm8BG7aFizW1yeJ2JPlANBG7sMntR93M7YHaQKtCtXFVVT+7oTmGNyzqLGB7iE1jTeE
         Fa+RsgSs3HHjxX+b8u8ogdDFTt8t6P/ZAe3Tv1q4AACQ+TpPWvWK1WdtCJFp4AM+l1Nb
         0kHA==
X-Gm-Message-State: AOAM531BbQ1wtWbz1OH9zpi7wBTmLygdzbAnBzHs3oD4vXf1aH7lE3PG
        VZ5GhY1qz9CM3sGP6Tiol18uMo8wmQG0Tg==
X-Google-Smtp-Source: ABdhPJz3Awu1+48VZf2uP0fYZG1NJ0wRFL0Uf8I/gw885NrxrRJJ63sqKu0/6voeQ2epH0vjB8M64w==
X-Received: by 2002:a05:6214:e67:: with SMTP id jz7mr22037111qvb.0.1628033871020;
        Tue, 03 Aug 2021 16:37:51 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.141.249])
        by smtp.gmail.com with ESMTPSA id p188sm270003qka.114.2021.08.03.16.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:37:50 -0700 (PDT)
Message-ID: <6109d34e.1c69fb81.ac27d.18ec@mx.google.com>
Date:   Tue, 03 Aug 2021 16:37:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1536785068404057311=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] a2dp: Invalidate cache if SetConfiguration fails
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210803225050.95417-1-luiz.dentz@gmail.com>
References: <20210803225050.95417-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1536785068404057311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=525931

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      51.39 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      9.25 seconds
Build - Make                  PASS      220.91 seconds
Make Check                    PASS      9.38 seconds
Make Distcheck                PASS      261.96 seconds
Build w/ext ELL - Configure   PASS      9.37 seconds
Build w/ext ELL - Make        PASS      207.52 seconds

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


--===============1536785068404057311==--
