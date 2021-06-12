Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401D3C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1522661073
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jun 2021 10:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFLKpZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Jun 2021 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLKpY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Jun 2021 06:45:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34162C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jun 2021 03:43:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e3so4706790qte.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jun 2021 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nDAaRexlZmvtNvvV96v/1WNa/GE60yj272iwqeZ/6dA=;
        b=gxEQcjtJRCXjff4JRSQjydTke6euOkze4/PGL3X0sHBta3odsZKBbCDNF6Bw7ut+9Z
         JUQ92TrNeXU3XftbGYb6zESymoFsyJfl6/NSqNS/8mTQp5cBhBQtCMcncgU3McH08Cfj
         6tbSdWBjG1lvW78gkzLPuNZtC+X5lOY5tLQhQ1CXz/6AUkYqdl34Fx9dCkHTqU5Bk2uk
         PMH54zbGIzFXtz9/PufSFY99unJ6hd+NmrfO0sVWt8eEwfxU+7SLEU9hm+VgGbctvSJc
         H84qdQFZ7c9+8E29PUUCnEkIYDaDlvb52oGTB/SihcdobDCaGvkWKovxxOgSL1atzmbP
         kvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nDAaRexlZmvtNvvV96v/1WNa/GE60yj272iwqeZ/6dA=;
        b=ccyilMdeDA92HXxhsItwqTJ6fE+XtPEpPsS7x0wOvwusx5XlcPa6gSAUsA119LlBe0
         jUAnADKCx8lsUanOwqU8GV8iXk4wa++r8oTCx6X94xlRN1DFizMvdxv4ZqGnjL15rUW8
         qQu0YHEFAGM2iT4/W2yYHemvMkh8RRuWzqw8ee8Cjq3yAapSzOXsESqmqqqY21CqX7RC
         sAwgICRQQ41NhTRvFgXPu9njSEJHllO5Mm7ecvqS5SZ6UwIBtlTab6bSXAwdxHN/hTgb
         aQueOdYnChHtK0D++luQDsTukyCKPVmwD8lFEJZqmiiwD6+St9cj9ls9acLnT2mHebI1
         vfOQ==
X-Gm-Message-State: AOAM531Zch34GIRu86UVjt/LkECVNt3I9q8mcKmnC5ZZdXRjnhKhdDKX
        pZ5YLd1nB2LNtpYxB5y4dXI/Bpgxpeb0eg==
X-Google-Smtp-Source: ABdhPJzfBrFRdxI4i2o8r6h+i/vgA0sqSjRkyR58h8Ty2dDSWAgkWb9176NS5YMMcE433cusOqM61A==
X-Received: by 2002:ac8:5ed5:: with SMTP id s21mr8011671qtx.87.1623494604258;
        Sat, 12 Jun 2021 03:43:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.41.60])
        by smtp.gmail.com with ESMTPSA id s20sm2139312qtc.94.2021.06.12.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 03:43:23 -0700 (PDT)
Message-ID: <60c48fcb.1c69fb81.54cad.fb66@mx.google.com>
Date:   Sat, 12 Jun 2021 03:43:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8357858524974278271=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [BlueZ] gatt-database: No multiple calls to AcquireWrite
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210612095601.7654-1-surban@surban.net>
References: <20210612095601.7654-1-surban@surban.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8357858524974278271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=499305

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      47.67 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.35 seconds
Build - Make                  PASS      219.52 seconds
Make Check                    PASS      9.72 seconds
Make Distcheck                PASS      256.97 seconds
Build w/ext ELL - Configure   PASS      8.54 seconds
Build w/ext ELL - Make        PASS      203.08 seconds

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


--===============8357858524974278271==--
