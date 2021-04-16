Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C88C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E67613CE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhDPUkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344121AbhDPUkJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 16:40:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C8AC061761
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 13:39:44 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id d1so2531346qvy.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=x/5DA65IClzkqgZESepEkOP9e0Ldx5A5TYZDLBI80eM=;
        b=PDD3rIbmHyfU0E4AB/rEeyMXGDY0Hu5ObvBe/PUhcVlVM1B9SrvCCIBgyVJsKRajTy
         v7RX70loNhgDyWJnGrkRfLKLBAsdZZcsa6fRxKbbx7xy1CmR0W+oFXKA+61kdETdCkD7
         0qetaxDxSeBO7hKhRW2L8GE04i+Yrk/biqUjzfu+3KrOtGOVA6IM8kndMBdzErn211s8
         IJz4pVIH4xBedVjSnv4wgYgwsvlFesR4wpcPCS9siuLMpaGNJhJV+78g/O7809dbMG0t
         Sbfef0c0xMUd//C6imJJTI/0RbWX+/CaeePQomtrrM7E2iVuDO07EC/9bPbW8kcHcsIs
         uRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=x/5DA65IClzkqgZESepEkOP9e0Ldx5A5TYZDLBI80eM=;
        b=cHI6rZpAxU36VTV41oNgcISv/QAYarlSpiXLSVoM1/4AKGinqSrw738+QR5ncH/Y9H
         rM1We70lhTPBtQIS16ynvvKd0LpsOpIvkbnyRXCjXaVyWJNO6FRQA1XoZM0Al5TfSlk8
         vQAXTZ1G9uCxn7PFOC4hcYt57hXnDdSDK0xSfCX8jBFFiyFyKNgzWi9Zu9zJxud7AZ4E
         /ToCKATvfmxqR42XYmaZ8pLo7HKMxFHRMESjoz2Fm1bLe7TakxDqEWpjxlUhSvZrlafv
         zZMYR8+pqqHsF6YnR0jGVPJpm1mEG4tA4cSJRiHMfuC+UNZZOO3TIXKaNQ9CA+D1UaND
         L8SQ==
X-Gm-Message-State: AOAM5322jfgKzBxocG5mbu83zMth2xoGAHHLbWc7CixipKd358fDChQG
        R/hraHNIm+6sc8Hej8rClY5+s0LaCCqNQz4z
X-Google-Smtp-Source: ABdhPJx5iqLlIFJUcyqPdTNiEdCtu43Q1lKnMp61D6/aMveFla5sv6dHCuniEpZI7bEMuM2a7BxeFg==
X-Received: by 2002:a0c:d40a:: with SMTP id t10mr592783qvh.19.1618605582854;
        Fri, 16 Apr 2021 13:39:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.81.71])
        by smtp.gmail.com with ESMTPSA id f2sm1742058qkh.76.2021.04.16.13.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:39:42 -0700 (PDT)
Message-ID: <6079f60e.1c69fb81.7873f.c883@mx.google.com>
Date:   Fri, 16 Apr 2021 13:39:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0169396341120464301=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] monitor: Add Intel read supported VS features command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210416200632.621635-1-hj.tedd.an@gmail.com>
References: <20210416200632.621635-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0169396341120464301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=468819

---Test result---

Test Summary:
CheckPatch                    FAIL      0.38 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      48.88 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.45 seconds
Build - Make                  PASS      205.84 seconds
Make Check                    PASS      9.07 seconds
Make Dist                     PASS      11.93 seconds
Make Dist - Configure         PASS      5.23 seconds
Make Dist - Make              PASS      83.00 seconds
Build w/ext ELL - Configure   PASS      8.24 seconds
Build w/ext ELL - Make        PASS      194.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
monitor: Add Intel read supported VS features command
WARNING:LINE_SPACING: Missing a blank line after declarations
#27: FILE: monitor/intel.c:477:
+	uint8_t page = get_u8(data);
+	print_field("Page: 0x%2.2x", page);

- total: 0 errors, 1 warnings, 35 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Add Intel read supported VS features command" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

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


--===============0169396341120464301==--
