Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D099C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6806B619A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 10:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhHPKBq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbhHPKBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 06:01:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614F7C06179A
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 03:01:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso31482581pjb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4tFGsDi1xWgsaRaHnNECVz0vuq8O507wsc2XrecaS4s=;
        b=aqX23wbTbeQBBFpQCeceRVTF49fORfxWHGkViFPxLNkaPlNzmFpuzS51nxGp87/RzD
         flTQij3y0JgLJXDGTV7jGTSOxuxji8vVkR62EYhMNK/0kBmzq8gTmgI67KDMCiMp/xtg
         ntwgqqt7m2YF3Min0OXJ2A4XsD/hdIsTR0ihwBr2wtUlBpGvSiNgyARYZ/hjvvcLgXUN
         Kb489VlhCMUFWXT/I3TjUlCgI0SIVh7MRQsgFGBDmFvzIKzm9UytI1KULy67ClxNWokN
         Ysc4uxVgy3LVcKztt/ZsxJi3D6MeKPhx00EoSRojwdPwjSfj/wyo3ac0sUZzAm1jqZie
         GHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4tFGsDi1xWgsaRaHnNECVz0vuq8O507wsc2XrecaS4s=;
        b=sgSZ1ZLRugbCvye3YOBYiM6mmz9OZhFzOeAwC2n02LkCPQM1LCkBJJjVunyXPxyWN4
         4fNVJqEIGpI+n18Dfscfd+2ikhvh1DtI0vDRjzx+ofKJVQvWfobS6LjYuSEE66SE0kwv
         ths4GQZ6JDzvuoUO0ep4HFeJAD43abEho5c/UNOsZYJPTKPh2wfZbi87InGFE4HciZGE
         2w91vviaG3d5AsDATPbY66fiBxLCxUTUxzxgxdRc61eHjM+syiwhSd+J6Nt0Z7HmaPnU
         zYZM0pucXtafbDkk/u4coLLZ/AvaMr3XvQ2IbxoL5knwWcmcnDEVX9X/i992U4XVWTZq
         iY4Q==
X-Gm-Message-State: AOAM531vXGQ4qPt1+sTyP829UDOBUrgUAZE8uRWTGvffgYxaqcsDBZ4i
        YY43CbSbG6OPunxB3oyrVqeFMLOLM9E=
X-Google-Smtp-Source: ABdhPJwFUm2FSVeK8wFnbD2etlx13G41WiLg3I0rcdQM944AHvpF8DpbGvl0cPAuVtCzxtgvSp32Ag==
X-Received: by 2002:a63:de56:: with SMTP id y22mr13171536pgi.157.1629108067761;
        Mon, 16 Aug 2021 03:01:07 -0700 (PDT)
Received: from [172.17.0.2] ([51.143.42.147])
        by smtp.gmail.com with ESMTPSA id a4sm11294057pfk.0.2021.08.16.03.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 03:01:07 -0700 (PDT)
Message-ID: <611a3763.1c69fb81.cf7eb.d067@mx.google.com>
Date:   Mon, 16 Aug 2021 03:01:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6367330051161833261=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] emulator: Add support enhanced SCO connection
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210816092950.22959-1-kiran.k@intel.com>
References: <20210816092950.22959-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6367330051161833261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=531911

---Test result---

Test Summary:
CheckPatch                    FAIL      0.47 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      55.09 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      9.60 seconds
Build - Make                  PASS      246.45 seconds
Make Check                    PASS      9.43 seconds
Make Distcheck                PASS      288.04 seconds
Build w/ext ELL - Configure   PASS      9.75 seconds
Build w/ext ELL - Make        PASS      226.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
emulator: Add support enhanced SCO connection
WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#90: FILE: emulator/btdev.c:2977:
+	btdev->commands[29] |= 0x08;	/* Enhanced Setup Synchronous Connection */

- total: 0 errors, 1 warnings, 76 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] emulator: Add support enhanced SCO connection" has style problems, please review.

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


--===============6367330051161833261==--
