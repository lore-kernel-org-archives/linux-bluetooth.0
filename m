Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3DEC2B9F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B080613F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhEZFrF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 01:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhEZFrF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 01:47:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E440C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:45:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t17so108248qta.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=K+Mwam+OfE57UrcX5aLrwQ2oH0a+PekK1/FEy8L+fdk=;
        b=czFQLPZJy5RufN9IuB4ZVzU2L8sydb3Mj0rPEqtUrECQCcg1R+0dw3yripKJ2BZ9mJ
         f6iJRcpR29E/vHf+/a/I72P37rbUgTqiqpntpXlSe6HUY81CehsnX0ziMsEQE/1iOzZf
         RknkjCZ54HbbbEUuTmPeFvd9hGI6SLfSYRY68LEVCdzuPrIKn0iFSeW6bpPffAA/0PXR
         H7x826HKLAfgui47teitepYJ0zNhuZ4/HSUVUQy2QkcYFcpdbMS44uuWZWFasdJaBxWo
         q2UZa9DH6+B2khth/r7WcHxd3WucYvm6KXXxPD0iQParZHIsG5ngHjvKTdODr2AmypqQ
         3SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=K+Mwam+OfE57UrcX5aLrwQ2oH0a+PekK1/FEy8L+fdk=;
        b=C1zS6/7/ZGLIMG94rUUaoc31Jeza1Q/6PxASw3ZCh73OmgIInu5WRy95XLx/Q2cDZw
         phgzhopuLdI5AybCjMI1y0cpgW4r3rOaFXTe53g7wT2qY+hlTctNU65hQAX/g6R7f/pG
         +bHdLMKmb/2DIYF9fwFwK0b5iMW9UDWDvOgiOwOiIiCEn+k/ONCRgiGHQkG+jKKYZ40M
         X27khFyI5ML+wmtnGesLjEzOxXQZY6ayRdAtVN+3dRasR5b9W01N6F+y7hYF5jfOewIw
         pd6nWzB5ZKkCh1OWHTqaFcSqzxRF8GtgyMhboybNPL/DQPdwhEu06aRPXwIy6khaxFjX
         m+8w==
X-Gm-Message-State: AOAM5334lap8iGNymrMKZBXZNrvH52tWoSEl56kBocJLiO987HGEbqzd
        l/6tiwsNHPjm2J0wQ3Yl4fFK6+opP6PRKw==
X-Google-Smtp-Source: ABdhPJy5I+BJh9jieTQndYtvuLMvcLwniJ8NKAjTu1J8il3R5n2wPsyKBtvg42pqjbR3CqqYPqijEw==
X-Received: by 2002:a05:622a:2cb:: with SMTP id a11mr35237271qtx.12.1622007932272;
        Tue, 25 May 2021 22:45:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.149.162.100])
        by smtp.gmail.com with ESMTPSA id b4sm869600qti.43.2021.05.25.22.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:45:32 -0700 (PDT)
Message-ID: <60ade07c.1c69fb81.bcbe3.616e@mx.google.com>
Date:   Tue, 25 May 2021 22:45:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3337800607270776932=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] tools/mgmt-tester: Fix expected HCI command accounting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210525053905.53138-1-inga.stotland@intel.com>
References: <20210525053905.53138-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3337800607270776932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=487877

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      47.26 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      8.34 seconds
Build - Make                  PASS      203.51 seconds
Make Check                    PASS      9.15 seconds
Make Distcheck                PASS      241.56 seconds
Build w/ext ELL - Configure   PASS      8.39 seconds
Build w/ext ELL - Make        PASS      192.19 seconds

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


--===============3337800607270776932==--
