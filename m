Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF3C4361A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D7661106
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhEKHmk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhEKHmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 03:42:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DADAC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:41:29 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a22so17324513qkl.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2RhjeWCRlOVlT1skiGojYZIFThuHeJKGzAcIkMc5xKo=;
        b=sIQhSVgVifqDF+46UPBVJBXsZtN3HreK8lfs1htM4jbgHIlcjMA+k4YFCn5wI37ltG
         CBzkPqh3sYqdgWEoa+oPDMD7KqrPOjF3uRiJIppEJe/fKwiaDkQqwc7zCanp/jfNQalF
         9C2vOvmYTF4LRUW18nBfHRBxx3/bdxbhtB3eX6Xl2SCERiWG5lYgywF7GQjyZL5ZGFz/
         1F6mVYcb9/zLOmKQQWcAxa6zzcOjTT+BRFoNxSfDv69Jr+klCpvT8hqwe2Wnyn7sQrH3
         WnKJQKFYRlz3zD05XdUTZaAp0gCW8tT5DVaVs4vo/y+SEflUKjGkd4KDF+opOzdZpv36
         fwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2RhjeWCRlOVlT1skiGojYZIFThuHeJKGzAcIkMc5xKo=;
        b=XnpqL4Kr7ZI1aXlEL/SJ8jE1eb2GV7XjuG6QTPSjx3s4Z4IISLUPlNdrlPsCbkjqmr
         nqOwaMNHSUVCV8Z23fAK+3gLwDCypED2gZjY1YhHwd+p0P56NMbJ83Wq6tsUMvxBkwBq
         6yarSs6AuF8tD6BVh1TQ8mXV0c/ph+K88l/B6Pfp4wP6i/ekugnK054csbAlIRLDc57e
         461VtVz93yOOSdsPHf1XhFwzqLeZQZ8f5AqraCTeBFcuaIAaV3vpZbutPMu7Gctj6Ku+
         Q5PTjMcQAk6Ob8SMx7KYlI+uoEu2TWzYxKgdX3LxEJkxV8i7j4ZgbcLOsPalrIAqBk1H
         cqSQ==
X-Gm-Message-State: AOAM533kKoMtGhWoQXFyE+2ZuO/Lbp7ag7NrrW6d+jmPi+AJh916aHfC
        xg1p7fZN0GMvz1gdok7Qj8IXwpULtnRVPw==
X-Google-Smtp-Source: ABdhPJxPFxWFK1qnCvxt/22rIAfRlusReNdheNy3+zppCldfsvivRp/Org4SFBP0rBqoh7Jicty15Q==
X-Received: by 2002:ae9:d60f:: with SMTP id r15mr26944602qkk.20.1620718888490;
        Tue, 11 May 2021 00:41:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.195.38])
        by smtp.gmail.com with ESMTPSA id n15sm13423633qti.51.2021.05.11.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:41:28 -0700 (PDT)
Message-ID: <609a3528.1c69fb81.be1d6.e4de@mx.google.com>
Date:   Tue, 11 May 2021 00:41:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4773386509461083154=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] core: Add RSSI sampling period in system parameter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210511152320.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
References: <20210511152320.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4773386509461083154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480039

---Test result---

Test Summary:
CheckPatch                    FAIL      0.64 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      48.69 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      210.10 seconds
Make Check                    PASS      8.80 seconds
Make Dist                     PASS      12.42 seconds
Make Dist - Configure         PASS      5.25 seconds
Make Dist - Make              PASS      84.75 seconds
Build w/ext ELL - Configure   PASS      8.56 seconds
Build w/ext ELL - Make        PASS      198.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
core: Add RSSI sampling period in system parameter
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#74: FILE: src/main.c:148:
+static const char *advmon_options[] = {

- total: 0 errors, 1 warnings, 93 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] core: Add RSSI sampling period in system parameter" has style problems, please review.

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


--===============4773386509461083154==--
