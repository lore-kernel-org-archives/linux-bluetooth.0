Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 01:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE6D611C7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 01:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbhHFB1O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 21:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbhHFB1N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 21:27:13 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D2C061798
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 18:26:58 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t66so8407799qkb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=z3VkiE6U+cUEztBhiU+EdzVU2YeWFMz8eT/8bUWFxKQ=;
        b=hzh+y6hySLIXX8sXaUGIExN3jvRmUARbCUEtEQn/NrcBRQc0ghaeWROexvj07Bx01M
         VdffBn+A/C5emMutKIZP/FSuqVjap+gY6d9U17McMfNIg9LqMjdaZUf0+Xz87SBguOU+
         EbMpLOmXDpG8cRDuTU53X4Qn1/j06epQQab5pR97XBvnsToaGtFiuXUAUjEiPFUMtNTO
         GTHbOOCDW0RxqHBfpZtVaneTsL2jOcycHfAo63BvFKrR6a3dZHF5vG8cRgN2F1nGmicQ
         eDsIo6gT6oWTRHq6EJ775akc3/R5fyQSiYpcYYFaYV+6ZyX1ZF1UOTKErWWLyzCdun/E
         JYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=z3VkiE6U+cUEztBhiU+EdzVU2YeWFMz8eT/8bUWFxKQ=;
        b=OZH+JOSwbKp+4sYi8ZqsqZb4bbcWo4/15T33hufuqHksXET7Cj7XdFnIo08qMZud7d
         EfHY19Qe2SC1HdKtDNXIGcZOELjolb93HTOwgUG/upSMNi0CZoBeJ3zWgqFNJwrRrOKo
         RAwtj7KIT/2cn/b2njcx8prZyi6Oi8NsGfFsk+ynqjuaADfP6qu2sSTc7KbWuTGJh/kX
         PSeg4ZbNkyTPIn+KewUGMbfc5X1y4aSxsOjouxUx+p+kf3mfqU/m6rPvNxQ/AKWQmAx9
         a5ROG7gy1VfkBkxAMNbDKNIVlbmnZnLVxFRFn61XPo/x844LmI67TR57HTQqmCFb6F/B
         CXeg==
X-Gm-Message-State: AOAM5307ATA++o9u/I9IdSZ6rEHhY02KkWr0thg8yYsXhK7gLE5t3R78
        dK1PxOLhskuCkhJU186meM8Z8ZznNx8L0w==
X-Google-Smtp-Source: ABdhPJwItSEVCNHGEWrdNp9mDbKkxFn2VtLkz+5dPXOa24hvaaEljn5RA+Uy2P7UlfFutSXjD1T9gA==
X-Received: by 2002:a05:620a:129a:: with SMTP id w26mr4971084qki.330.1628213217621;
        Thu, 05 Aug 2021 18:26:57 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.235.214])
        by smtp.gmail.com with ESMTPSA id i15sm1520970qke.98.2021.08.05.18.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 18:26:57 -0700 (PDT)
Message-ID: <610c8fe1.1c69fb81.25a8f.ae7f@mx.google.com>
Date:   Thu, 05 Aug 2021 18:26:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0440079688346365261=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RESEND,v2] monitor: Add support for tlv based version format for Intel vendor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210806004304.53880-1-hj.tedd.an@gmail.com>
References: <20210806004304.53880-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0440079688346365261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=527249

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      38.94 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.07 seconds
Build - Make                  PASS      175.32 seconds
Make Check                    PASS      9.00 seconds
Make Distcheck                PASS      199.29 seconds
Build w/ext ELL - Configure   PASS      6.75 seconds
Build w/ext ELL - Make        PASS      153.08 seconds

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


--===============0440079688346365261==--
