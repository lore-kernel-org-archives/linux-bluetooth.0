Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5DEC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 04:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665F6611BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 04:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhETEy4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 00:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhETEy4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 00:54:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4DC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 21:53:35 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i5so7786265qkf.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 21:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6d9/IQcz99NF8hs6v4m8wP4rDI0GKgj1cJW//YjciKg=;
        b=o51MuX09Q9rlt7fUd+qkvYn2Yvo0fFP2L2we9fNNHVc1zT16u/RCdf9BNT4BGsifiC
         Cwad90kB+Ie52eNWierAL+qkHeTIWOgqYirymH5N4T6FFoUZ3EtV6vDuR/bTNpFhYhrK
         X+avHydAapYZpUxTTb+hCZHL7Ygrz26YKds7UVZ7EatWleHsN9Aza7kFEebUR0mMYX9q
         /NCXy4OH83N1qYQZqyHYDBiZ8zraR2HTKQUF9xbP0Ec0S924OsS2Xr0AZ6zMvErJ+q6p
         vbueHnxOl1su477+2X6uw0ohnLqo3I+wDWKy+q7qVwcI5eJ9MbQ4o6ydJ4TX8WhB5msk
         381Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6d9/IQcz99NF8hs6v4m8wP4rDI0GKgj1cJW//YjciKg=;
        b=IG70o5QRFfjy2Q8tUiP+Bm28lFARqdSwBu5sspKGaZQvZomQKe+u/F91UbGSASFfgB
         Z1I1BJVli0nDE8abFQ1I3JAzrE125/K+ZkA/TihBUWtdM+fhxRKDsSXzmjYzl6Vpqrmu
         KYurDmxUNhOgNefw43SLW+WqnZqgMeTSFLVC8U3mRM6ckOmFh+KycRVO6Gk9QnInk4H6
         UiwQCwrzC2Y+RaN5xibzxSJPAT/rtuBEPluuLNmNLpIjHQDb0Bl2ZVZyB3c0zBu2zJuV
         omF5xNgFL7OT4rJcr1d/PCxLXN3nEt0qdb7YIXl6ygl+XMR2xoKjm9tvnaRV5UzNSNgg
         PFrQ==
X-Gm-Message-State: AOAM532wrMX2iMXm/2p9Oepb6xjOf86dSGgyoU7U4D/yZNI/4SoyxwEn
        4zbDARqsrrIx/dqblUfLNx/KjODasNkU0w==
X-Google-Smtp-Source: ABdhPJz+lBr/ABbnCaMbzdwtNMmnWc+1rKGyvU9F1kLzR4UhbFNMT1ikthj5AiFI75XvxMazdm91nw==
X-Received: by 2002:a05:620a:1036:: with SMTP id a22mr3173443qkk.186.1621486414369;
        Wed, 19 May 2021 21:53:34 -0700 (PDT)
Received: from [172.17.0.2] ([137.135.64.34])
        by smtp.gmail.com with ESMTPSA id w189sm1359031qkb.39.2021.05.19.21.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 21:53:33 -0700 (PDT)
Message-ID: <60a5eb4d.1c69fb81.28053.a5ff@mx.google.com>
Date:   Wed, 19 May 2021 21:53:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6563406913898818364=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, eh5@sokka.cn
Subject: RE: [BlueZ,v2] avrcp: Fix unregister AVRCP player
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210520041142.332534-1-eh5@sokka.cn>
References: <20210520041142.332534-1-eh5@sokka.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6563406913898818364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=485461

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.41 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.40 seconds
Build - Make                  PASS      206.91 seconds
Make Check                    PASS      9.50 seconds
Make Distcheck                PASS      220.80 seconds
Build w/ext ELL - Configure   PASS      7.70 seconds
Build w/ext ELL - Make        PASS      172.24 seconds

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


--===============6563406913898818364==--
