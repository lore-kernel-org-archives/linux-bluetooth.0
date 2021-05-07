Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F5C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 04:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5711C613E8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 04:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhEGEuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 00:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGEuK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 00:50:10 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 21:49:11 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o27so7316447qkj.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 May 2021 21:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3bY4gp9OVJc0qUdjOxfG0FKcaCFZEtmdvSKoys9Q6aY=;
        b=OeFVAuiLdMHDessTnFJK/ZvjsL18Q3/TGPNnwi4Sm/ezKwzsXorYybC3Uo6zw6L0FO
         0/zpCAimxO2Z4LtEDAsfmVANLCoEBkO5x3a/ehRE8243JOUNcbZ9VoaCK2YS7WsMwYJe
         ofSXSPS36+giyFhCQR6YbDDaHIphafVYGtW1oVUnFLNUZGvDHIHRZdOICWSRKpQbYmcJ
         5lxzMtBE5qcpx0bMn7oZfp2jRCpw/3VDAZiamPEqcZvKpicodTU3uPGc1g9XfIJ/uXms
         cawrCP23nZ3oc2rIisVvLRWbeAIns0OHmYuJclhFKdE2bRJ2UBVyR/z4aaHjOfckzO/L
         W4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3bY4gp9OVJc0qUdjOxfG0FKcaCFZEtmdvSKoys9Q6aY=;
        b=AGc/qKK1Drlq1I0T6oKHv8KMp+noH33YnP7SVls3ksMVwhORo0folIXAY+ldpo22AI
         bqHflaCrymHgXrWInjJDbLXM2cfgrWXbz6a0V7IKfOQqDHMB0Va67fTyEQVTnUZNPAH0
         V8Rp2tN2bfmryiiFRsxRf/yP32ylPjQLYNVGOqRDe9DB3kmwDoJg249vVQ/mu8lR4nKj
         v2nPZJRPvLnPdBDQdK8DWL2vUYMgb7vVLWOn97EesQVKa3JqUsOK5QPpdrcrfaT2XRRA
         WC8J0NrJWKOgb0zWqFmdpa1A2pRTWH0r73j2HDhBejBl9tiIcSf1yN1i6EI/aJwVYn+T
         lkrg==
X-Gm-Message-State: AOAM532aS2aTNuVIZQ1yOAsD/+812mZ2nv+NLx+H1OinPZ4DqVeq1FCT
        b5EfPT/6/OvPsSHpuD2lOw/klxFeIJb3EA==
X-Google-Smtp-Source: ABdhPJzdEL/6SRvECxhfS5gg7xSjTHwE34cUSI3ZW1zY49PcPQwHPwzsVsAcHNmEpImHNHpK/bLTZg==
X-Received: by 2002:a37:bbc4:: with SMTP id l187mr7556280qkf.153.1620362950248;
        Thu, 06 May 2021 21:49:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.31.97])
        by smtp.gmail.com with ESMTPSA id f26sm4061037qtg.17.2021.05.06.21.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 21:49:09 -0700 (PDT)
Message-ID: <6094c6c5.1c69fb81.14b93.8c78@mx.google.com>
Date:   Thu, 06 May 2021 21:49:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4009480725326316874=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] core: Fix loading AVDTP options
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210507123246.Bluez.v1.1.I15d73dd47b94af906daa3f5a25d4fc5db8cc5b29@changeid>
References: <20210507123246.Bluez.v1.1.I15d73dd47b94af906daa3f5a25d4fc5db8cc5b29@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4009480725326316874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=478213

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      45.60 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.95 seconds
Build - Make                  PASS      193.97 seconds
Make Check                    PASS      9.40 seconds
Make Dist                     PASS      12.46 seconds
Make Dist - Configure         PASS      4.88 seconds
Make Dist - Make              PASS      80.65 seconds
Build w/ext ELL - Configure   PASS      8.34 seconds
Build w/ext ELL - Make        PASS      188.95 seconds

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============4009480725326316874==--
