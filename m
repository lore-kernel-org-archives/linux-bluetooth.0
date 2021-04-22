Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576AEC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4626141C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 19:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbhDVTlR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 15:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhDVTlQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 15:41:16 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FAFC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Apr 2021 12:40:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id h3so21873690qve.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Apr 2021 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=h8w0/kLYl5TTDK3ltIa79+gWHzzBDgmr51GvhLiadOQ=;
        b=bjCB/7onkFjDAByox+WLiweYsByofqqSGifZfR+FxkjJQtrJ+I9wHSCoK3SxS1WfYw
         qsAG6ExqKn5v7mfBx+3KEbXVuEtPOrAtRn+zTNDOu6aHH5PTFobpwurzRmyG+Jj4HRZx
         11Idsvm5mZneia9KDZV5KAti73h54nq18vkfoexVafafMRAaDZBBtzR5k0IbBT1k4k7+
         uw7igdHdJE/+5OjLEHdA74hSC+1rFu0PnclAsAn7hrcRABvTBfq9chAeW64WSKqRxrdm
         C+ohT+F7WtThB7HBoBoJpa51kk8Z7Kh95I7gbyn+BbJMZdrTnibV8fb0P6qxlUOCr1VY
         Mclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=h8w0/kLYl5TTDK3ltIa79+gWHzzBDgmr51GvhLiadOQ=;
        b=RzR625ER3FSjgGZXRE2tnGnmpa4lgh0htk8zzgp5Fohu/T2ptHkPmn8UF9dg46l56F
         L1+2szffVzBiTxFbDBiCIhd3rjRlZAvBOPeocpkX8b9QN4xDyHK4YLZBTmQtceLg0SNk
         L9LAMR0nzXxI8xqCL19I9IaL3m7evx1H2Foo58RyfcePp8B/d6J62gz1jLnyo/E6LsQ+
         ouSJTrw91hkSZBMGR8FzOeA6AiFh4hxkfPrOWSokrNlVBztECsyOnTtXpLfJ3EeS9KLe
         858MbQvCqatuKnqHF5KcSxM7gjLosGoHZtpc12WHJznoYamCFgm+xB6CKJnVQ0nmEXnC
         AE/Q==
X-Gm-Message-State: AOAM5309KZn/G4k+TeAyCtpcqcfnP8DzBPU7VrGujp+CBUjnkLM9MRB5
        27vWH6tRwNrzj7t6q/0UuTum2d4ci9XX2A==
X-Google-Smtp-Source: ABdhPJy40sadezatddfa2Qsb+wRLK5aCSfUVficelAjbRoiwVXt+WtkgV+epE1ln6NEd57xN+U+Rwg==
X-Received: by 2002:a0c:a045:: with SMTP id b63mr505476qva.19.1619120440592;
        Thu, 22 Apr 2021 12:40:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.72.218])
        by smtp.gmail.com with ESMTPSA id u190sm3069447qkc.18.2021.04.22.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 12:40:40 -0700 (PDT)
Message-ID: <6081d138.1c69fb81.dcb01.318c@mx.google.com>
Date:   Thu, 22 Apr 2021 12:40:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9108830567510398723=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijns95@gmail.com
Subject: RE: [BlueZ] audio/avrcp: Determine Absolute Volume support from feature category 2
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210422192253.553048-1-marijns95@gmail.com>
References: <20210422192253.553048-1-marijns95@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9108830567510398723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=471799

---Test result---

Test Summary:
CheckPatch                    FAIL      0.28 seconds
GitLint                       FAIL      0.12 seconds
Prep - Setup ELL              PASS      48.51 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.34 seconds
Build - Make                  PASS      199.90 seconds
Make Check                    PASS      9.19 seconds
Make Dist                     PASS      12.99 seconds
Make Dist - Configure         PASS      5.25 seconds
Make Dist - Make              PASS      82.25 seconds
Build w/ext ELL - Configure   PASS      8.39 seconds
Build w/ext ELL - Make        PASS      189.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
audio/avrcp: Determine Absolute Volume support from feature category 2
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#22: 
[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761

- total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] audio/avrcp: Determine Absolute Volume support from feature" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
audio/avrcp: Determine Absolute Volume support from feature category 2
18: B1 Line exceeds max length (103>80): "[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761"


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


--===============9108830567510398723==--
