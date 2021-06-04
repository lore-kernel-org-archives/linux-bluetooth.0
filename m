Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095FC4743C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5067613AA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFDS3W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDS3W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 14:29:22 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9EC061766
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jun 2021 11:27:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id k19so7716932qta.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=stl9O7L9AEHz3g04E+x3e3KG/PFHW/VG/9agcb4RYzc=;
        b=p1zv+x4wF3zAe//usBPTZGEl0QiZE/wILJY/vBCW0TDMrGBGTA3bzlhT1yqMUP/fOG
         zGWndo4qoh4BLQTJn0fi1oQbQPN5JMdevckPoEsAFtvs8SWRJ4NDstWXSowKybvO38EI
         ye3JLwA6fjRn5SlMozSZHXHS//gKNcGp3m/B/SD6pNO/5QTb9KD1mS1tYT0s9fEUL64s
         rYov8u2IB2D5PcQtyaCTugHHWHQoA6FIwsf3rxYr34gSoA8pTFihaEhigWdUAHAoDjHJ
         8oVnWZb3XWkXkb1KgJSdbVQxFdUTVHqa+7XLa5GpGcFf4j/fpnzXDymWt2ROxPSZsE5L
         CujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=stl9O7L9AEHz3g04E+x3e3KG/PFHW/VG/9agcb4RYzc=;
        b=LEMywEcenuBHVJgQrUQdSgmPAV1ng3UpryAwEeJETXyBWPAyXK3hnQ0c3KSJlikVkN
         gYi4wx11SR3Wq7GHykP1xMHrDmHSEnxo3btMaVdPgsVCG3VdGrXqK2r1qFQRBPfTM23q
         NPGcIwsAvoGqifW8fUNTFu3uiJMx7C9czZhQSzCH20O0aH+V5k73heKebLSD7EL5HNsz
         nyvuImwFEMjKwFEU7dnw03/B+/vGIxSE5IeS07wkoJsM6VQzxAScFbKLHrD4sTwMhHZx
         MbkJg4v1gY+jgIq15/huI5MIaH4RpoeiHz7/rqxuvWKS9ulLfPEIcNut4xLOXTaayat0
         Jk4Q==
X-Gm-Message-State: AOAM5323l/rDamIdRh6vEE1ObiuTeJ5w4yXgYW/ogw1OZW+7TL0ShU8V
        e2QzZVEX91P2Cdo0Mrcuuh375mC8PGZMVA==
X-Google-Smtp-Source: ABdhPJwkNyu1XcFOr2Bfw/bKB4K2sIwumQK2194urzvgQ5vvoFMNbrd4lNabN7RB+zt/wr1Qw+Xhfg==
X-Received: by 2002:ac8:5bc7:: with SMTP id b7mr5896708qtb.274.1622831254792;
        Fri, 04 Jun 2021 11:27:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.0.113])
        by smtp.gmail.com with ESMTPSA id m10sm4056447qtq.62.2021.06.04.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:27:34 -0700 (PDT)
Message-ID: <60ba7096.1c69fb81.c1479.c9ab@mx.google.com>
Date:   Fri, 04 Jun 2021 11:27:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4754236924662580997=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v2] tools/mgmt-tester: Fix expected HCI command accounting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210604175913.256979-1-inga.stotland@intel.com>
References: <20210604175913.256979-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4754236924662580997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=494317

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      44.81 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      7.89 seconds
Build - Make                  PASS      193.07 seconds
Make Check                    PASS      9.48 seconds
Make Distcheck                PASS      230.13 seconds
Build w/ext ELL - Configure   PASS      7.87 seconds
Build w/ext ELL - Make        PASS      180.65 seconds

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


--===============4754236924662580997==--
