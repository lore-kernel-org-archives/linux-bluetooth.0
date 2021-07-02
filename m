Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D2C11F68
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jul 2021 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07C1613CB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jul 2021 15:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhGBPqw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhGBPqw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jul 2021 11:46:52 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D0EC061762
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jul 2021 08:44:18 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id w5so4833721qvu.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jul 2021 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YaasqdqDbWojsdk/X2AE2NvqYqTBAxfNKfmJ9W5xjEY=;
        b=QPjvAJ29gAY2E1Uf1fE2gIGTMssJCFSjjAoEjO78//qI+ndnk2CZc5MSeGvR7yuC2Z
         kqFzwzzH7D0g+TRiIXZ+1uGoN18p/3Mmjs4X8Qe1eSNMLi2rY0CwRfM8nmiwTkW04DcU
         MWKb2DVWRc7fGOPSBrGsRm8CZhDM6/kqFXHklHXzBMxoXzg9OIXyBwGVytP3xOmlkJ8O
         ieDpM9d6aJJuoGsccfqa/DEgzp7lIh1we6jGQ1i4EsLVzRTjK48C07/SQdRHX05RRzAS
         pF7vRpm6Ts1mZI/9DJNexNDmFsGbAyRl3CHSChDG2gBxtX9yRKFje8lDFl2ufgMb0JeH
         eezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YaasqdqDbWojsdk/X2AE2NvqYqTBAxfNKfmJ9W5xjEY=;
        b=HAVS2Z9JAb9TXchYOQcfZ8o0V63vvEtMZGcFyG2YCYq8CGNEYnFlS1+bYZDXALESOZ
         qh7VGmofaWyoObnd9NWvaN53s8EBYN+yJqezLbMJbjqxJztjZa67RtNtDYQwahtHdLeI
         LfYM8Bbil94/8cJ4cxPyKWmBCUK9kLyzE2uPt8mbQ52+zPCawxDbCWSEsWhedFxWmpYm
         689smqrgQPHGrNs9rmB3aPjPs85nxInNrxDjTmeUGAASOnGN5UMX/rJvCNV8ky7rBmlL
         A3yGsj1EZCIs/9aMuMSjdcM2HrWgx+ZTkyw0KwLPwUwffwJOM8uMx0WKC1iEYg+0SXp9
         4xCw==
X-Gm-Message-State: AOAM532fN/OG3TLtHa4C5JbEu8m8X6cR1I/lqefvEXwSB8hf3DXE/h82
        1m2Zp2JJPY3F0neooc+TaDYTOWVLCU0g3A==
X-Google-Smtp-Source: ABdhPJxaBQ0znKde49/SE+HoY2rDEytkMPIYfCNXJX7dqiUsp2KeqyMaf2GwgXWuY40bmjtTEOx3NA==
X-Received: by 2002:a0c:f78a:: with SMTP id s10mr28379qvn.61.1625240657821;
        Fri, 02 Jul 2021 08:44:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.41.13.141])
        by smtp.gmail.com with ESMTPSA id s77sm516746qke.85.2021.07.02.08.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 08:44:17 -0700 (PDT)
Message-ID: <60df3451.1c69fb81.90838.36c8@mx.google.com>
Date:   Fri, 02 Jul 2021 08:44:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3995512284351686540=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederik.carlier@quamotion.mobi
Subject: RE: `SimAccessTest1.CardStatus`: Mark status as `uint`
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <AM8PR05MB8292DD484EF2EE569F04BF2DEA1F9@AM8PR05MB8292.eurprd05.prod.outlook.com>
References: <AM8PR05MB8292DD484EF2EE569F04BF2DEA1F9@AM8PR05MB8292.eurprd05.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3995512284351686540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=510177

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      52.51 seconds
Build - Prep                  PASS      0.16 seconds
Build - Configure             PASS      9.36 seconds
Build - Make                  PASS      231.65 seconds
Make Check                    PASS      9.36 seconds
Make Distcheck                PASS      277.56 seconds
Build w/ext ELL - Configure   PASS      9.14 seconds
Build w/ext ELL - Make        PASS      221.35 seconds

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


--===============3995512284351686540==--
