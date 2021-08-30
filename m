Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C1C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 19:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A717660724
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 19:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhH3TyI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhH3TyI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 15:54:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A8DC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 12:53:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f22so17013522qkm.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=eKFux4joinQEtBLBNxzIcvbVB4Kpbd3+nHV5TfGpu8M=;
        b=d+4oC6gneYcsUyp5DyZorQICEmUq65WciKiVQ0zWM0Gxljlc4UPVceBGZ1HtbygNI0
         3SXK+afAqcetjn5tWoxPbBQ9lwLdz3/STotDyanelIG9V6no+7yFaDCafOCixYy0q3IP
         d+tKQC1uhW/a0rhRFB8XtBUv63IsFpY8WdRfmH9NpIhmIs0SZnVdifGcfupIu47Enmtb
         io0JYufgmYV1ruTbLLLEL4cyzas/akX5QGRWILThZlKmfxtiapgXCzamNh8KJe6Fx9By
         sdTNQPUOTZ9bnoqaSzvNgMHcZFHHHPmV/X6pnLWjGvINvpIrWUMbb480qcN3f8JtiYI3
         ZGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=eKFux4joinQEtBLBNxzIcvbVB4Kpbd3+nHV5TfGpu8M=;
        b=TmopBgIuQIAs/BRwjn+uFJ+TS78RH5iqBU6EpUu0p+kxVuvO+cfWNegnsDMZz/4wFg
         1Z6oSa3it/ojK0qybHvc8wWRJ53hThs1hvXPbk1DdQKtU52vlDR5LRkxN/kHSKT20zbc
         baQJcI7zWtaQoUY3twEUCisGTzTRMNUPFWtoi7hgfEC0dw5Si/UN9HaYnPgAufwrHgr6
         isfc6p/+YEUm0PPkMbCZdgagJ/1R26p3PD33rY4cJJmTL6/7AHpUsKIziRa71OqyCGag
         8xAij/goRWqxUxSF8TOVArUeY1ob9hLhmtWKjoLBD6CKvrL1rC1mFD1l+sKFswpi/CE9
         XiVw==
X-Gm-Message-State: AOAM531pU+51B/uw0zx5jHw5pVRATqyoCUzxLj7GYHf9nuHnuIjCb2Wj
        ift2pBfP9Vfe0RQ6f4OE8T+aZkvVp34=
X-Google-Smtp-Source: ABdhPJz/3QcQTsfIoaSxKbrceDk+PlW2v+UVHaic4FTRZ+n28WwUJmi7SDAo52eGVblA5hCxQbMQJA==
X-Received: by 2002:a37:b56:: with SMTP id 83mr23974005qkl.360.1630353193166;
        Mon, 30 Aug 2021 12:53:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.29.82])
        by smtp.gmail.com with ESMTPSA id h70sm12199264qke.54.2021.08.30.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 12:53:12 -0700 (PDT)
Message-ID: <612d3728.1c69fb81.243c2.3e2b@mx.google.com>
Date:   Mon, 30 Aug 2021 12:53:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7098125356660989749=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, benpicco@googlemail.com
Subject: RE: sixaxis: Fall back to matching VID/PID for unknown devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210830213655.16e6c37a@rechenknecht2k11>
References: <20210830213655.16e6c37a@rechenknecht2k11>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7098125356660989749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=539421

---Test result---

Test Summary:
CheckPatch                    FAIL      0.27 seconds
GitLint                       FAIL      0.10 seconds
Prep - Setup ELL              PASS      38.50 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.47 seconds
Build - Make                  PASS      165.30 seconds
Make Check                    PASS      8.34 seconds
Make Distcheck                PASS      191.86 seconds
Build w/ext ELL - Configure   PASS      7.05 seconds
Build w/ext ELL - Make        PASS      157.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
sixaxis: Fall back to matching VID/PID for unknown devices
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '61745d2bb', maybe rebased or not pulled?
#6: 
Commit 61745d2bb made device matching stricter.

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#19: 
[0] https://www.reddit.com/r/archlinux/comments/pdvdfd/a_dirty_fix_for_ps3_controller_bluetooth/

- total: 0 errors, 2 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] sixaxis: Fall back to matching VID/PID for unknown devices" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
sixaxis: Fall back to matching VID/PID for unknown devices
16: B1 Line exceeds max length (96>80): "[0] https://www.reddit.com/r/archlinux/comments/pdvdfd/a_dirty_fix_for_ps3_controller_bluetooth/"


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


--===============7098125356660989749==--
