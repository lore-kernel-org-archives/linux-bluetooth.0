Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB1C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 01:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A96613D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 01:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhEMBsA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 21:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhEMBsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 21:48:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AE5C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 18:46:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 33so1489104pgo.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 18:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=o+bGffa5ZmwVsjtgvUS4wfJljsV+bav/oqsk9q77+KU=;
        b=RRow3Cj86w6FyyaYNyIJY4Q45deeL0tSfuJ8sM9IXqn0+p3U8Y4cIPrbUDfYelraVw
         /BzdPdRhhvK1eIyW+jVHgRodP4kJB8fQkdZGV2BwN/hX9AKG+8RKDDcrC7vZVKzeHSPG
         +0b+X0ChSq2eO9M6Gk5HzDuxs9w8SUPWyW8qfFNzEt+go421Hw+54q7fyDrSN9m3v2DT
         PMP4v40aEaOt0a0xMIGDqvILhiNngtlQh22YtdtKw6AlpoRdIjC2JrrFUzSR2G38oN6T
         lBkWoLPYkZha3rVLKDdE8fIpZzlc1Y+7EvfFmKmHjawuTVMovLDN5SD2w9XRfkql36u4
         PnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=o+bGffa5ZmwVsjtgvUS4wfJljsV+bav/oqsk9q77+KU=;
        b=WalvokWEI0kHqeVa704zzwQXJBmVO/5CZ60PC1hq7thNF8qCQffUuHXKWbk40zwOor
         wgjQShU3YQg/j2IrS87ScPgGqQsMWkvRiFvzaryC0+b1yLt7gyOQU8nCjGoA1C/L+S+F
         FC86P/yxpfKmt8teRuwImoVXpLMvOvDhzo2uD9+Xm//j1VZL1U6yBjCIZneqSBBGjZ5E
         MPcbM0bIhPS+Rj9Y6SP9BSu+vHnDce53VMNDg8sddnQQdU9MRAC1CEGAi8gcp5u+u6z0
         YyiuoKsyWENXljwH8Mg6OhkXYZnt7xwpaei0tTShzO5a51bg803VJoBpN7rhgK4qfFFv
         rsbA==
X-Gm-Message-State: AOAM533eO+GJP1CM0/bMqFC/aAjqkESy+p+Yy/w6s8sfdixVc+MuzJTp
        jFBEZ2WqiHRaYNEoJysvvkoT2I7YQNw=
X-Google-Smtp-Source: ABdhPJzw/lGq3NcVNn8YgsXF5s3Ukz5YliiakTTqky0rInXBgrpsRUwpiCTRjfmhDvPYMPt7WsOerw==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr42947348pjr.12.1620870410789;
        Wed, 12 May 2021 18:46:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.244.139])
        by smtp.gmail.com with ESMTPSA id n206sm804327pfd.150.2021.05.12.18.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 18:46:50 -0700 (PDT)
Message-ID: <609c850a.1c69fb81.6aa5b.3d78@mx.google.com>
Date:   Wed, 12 May 2021 18:46:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8767013940883170815=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/advertising: Add support for setting min/max intervals
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210513003428.2576827-1-luiz.dentz@gmail.com>
References: <20210513003428.2576827-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8767013940883170815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=481575

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.15 seconds
Prep - Setup ELL              PASS      52.17 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.90 seconds
Build - Make                  PASS      223.46 seconds
Make Check                    PASS      9.53 seconds
Make Distcheck                PASS      261.17 seconds
Build w/ext ELL - Configure   PASS      9.00 seconds
Build w/ext ELL - Make        PASS      210.86 seconds

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


--===============8767013940883170815==--
