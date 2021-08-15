Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279BBC4320A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 01:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA4E60F51
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 01:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhHOB1B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhHOB07 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 21:26:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017CAC061764
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Aug 2021 18:26:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z24so11462063qtn.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Aug 2021 18:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+jovgmx4vWjvqryxMjsVzQZT+GHt17/KIw+o/3XRJsg=;
        b=tuJByrSk9HbqD+OtfkLHm9lpYunlv61REdvC848F77jyUPUHJAJMoEmtd2MntF0yRa
         EAJl23sreOyBihGJHC0VJw/AXCmQFVnBHUB9DYAQUAi3MvqaR3swkFKWFbDw5AHM750D
         T/lqMEN84InPT2V6v4UR6tamVusGvVYEsm02zPsHaLTL8waNniZsUwr2sI2ATcVeSQW5
         oWLAgSA4n/gUoXVOWaZq344jy/qUVYYe0ZLyMkZ8Hw+Yg2wT9W//HYRyceTWaC4h2A+n
         Q8MGAS2EOLEtJ2NYEz57zXxwL8+WBJkucCtyAk+105U1mcNOMT2fXCVFffpwP8M0t4PO
         wNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+jovgmx4vWjvqryxMjsVzQZT+GHt17/KIw+o/3XRJsg=;
        b=hOp4u07rjJM9geCQC07PkQBSKpNAW/ftVaqi7gnkKbLtxgtgPEaM2eIvpuvFE2JDl2
         Svo8MxPW65Rga7ST7eedDXouzBOen6UJhagvWqESWVvFCXgOy60hsYE69dI8wO+IOk9I
         YNOg0brU8lG10O6sugPYVLzSy74K8/viJcBE/9eeulJz72fbU9kmNQUfMbjGyswXb3ku
         zAxM4TPo6mK99vtYoO8zjRXiniqpPhpldgEdIMgfbcVlXtZPbZPKfWZ+GgqJ6suIcjy2
         ZOxfXQV/HdxfiD4s9WIWsrY922fFQKtOKnKLFyYmzg2Ks5H7w7UWLN7T71Np4H/jMatX
         irtA==
X-Gm-Message-State: AOAM533T1uL5tn94ebuun6dFwfeCmlUpo0i2R0MMW29rkMVUylL6SFU5
        w/Y6asrV0jwwAyzIcfBtzU8ZO6JBZhIEmg==
X-Google-Smtp-Source: ABdhPJzg6CbdSAGeItpwkPzE3dSwxVmvIluMjNzq3pMtv/zHTSwKuMrcDwxO039ZdIYvaoDa4TTnNA==
X-Received: by 2002:aed:3167:: with SMTP id 94mr8018124qtg.15.1628990788823;
        Sat, 14 Aug 2021 18:26:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.117.243])
        by smtp.gmail.com with ESMTPSA id g131sm3781735qke.122.2021.08.14.18.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 18:26:28 -0700 (PDT)
Message-ID: <61186d44.1c69fb81.b18a.85e6@mx.google.com>
Date:   Sat, 14 Aug 2021 18:26:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0768571410606203852=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: mgmt: Set offload codec mgmt feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210815001550.24643-1-kiran.k@intel.com>
References: <20210815001550.24643-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0768571410606203852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=531599

---Test result---

Test Summary:
CheckPatch                    FAIL      0.33 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      49.03 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.66 seconds
Build - Make                  PASS      212.24 seconds
Make Check                    PASS      9.79 seconds
Make Distcheck                PASS      250.51 seconds
Build w/ext ELL - Configure   PASS      8.76 seconds
Build w/ext ELL - Make        PASS      199.76 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
mgmt: Set offload codec mgmt feature
WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#20: FILE: tools/btmgmt.c:2561:
+		error("Set offload codec feature failed with status 0x%02x (%s)",

- total: 0 errors, 1 warnings, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mgmt: Set offload codec mgmt feature" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


--===============0768571410606203852==--
