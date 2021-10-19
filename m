Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B57C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E7461057
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 09:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhJSJke (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhJSJk3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 05:40:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E4C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 02:38:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f21so13290462plb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=R4XL4iQ8ch3rIJgdA+AhpYCD/LmbUR8FtGdzd2zk/Rk=;
        b=GF6KufuIOFcW71SRXi+M0V+5RUI57s/VoDy6dktx/gSf6k3h7yjce1hcRKBiolusoO
         xs96bA49+8+gKjQpu/gtW8VP/QAqLpPYedEIfVmQQzK/d6Bcm3Bln/xcJAC0PZtw1V2Q
         fZCEdVTyAG7yJlgAhxILvFqfv9bmBUsWNaojWPLtAqIUnSlpiCARfvvi+08OTAykUIT6
         zSBTrNfBkCdg2NdLcxenfBL2S3hKSm/jmH8bqwrFRSHx1iKoVUFQxIpvBZuW6ZaF+12q
         CRa+MLMKET7PO+AUFzC+Uyg/OsckaTFM/QchbEVyOiLJ+FFW2qBT7shUiuoWRVUyvXry
         9MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=R4XL4iQ8ch3rIJgdA+AhpYCD/LmbUR8FtGdzd2zk/Rk=;
        b=S3vQhMZ28JJNhDJfOAmT2IJPh3ulcTG88/e+EzSQ/ILpHcMCTRzB4qpMuSx8nDdIR1
         8C3VK5ZPZVQWSL15ylnEOrTlrv2wQ7/QAx5txCkKWUrGzit5zteKCb3ZtYLYO8tWfwiY
         PAHrc5mB4nxVLN3/xSaaJpnmyNF6Oh5IGfQq8khupZCRgfSs+26rPbU+zsErkqtzn8U/
         NPsbYVmGHzggrEoY4UwHismsl+Uk5iOnvQKB2kE8xXU2kf7f3X78/YRxq5wQjJ43cVJq
         pIVgzTyBtYX3ojPfAV4TsS8zhJQ00ol+kmN01HV/ArDoWY6h3QClWe+4OJHxXsVoTHsh
         KnPA==
X-Gm-Message-State: AOAM531pzDJtSEI6TSSE15D3LLzzHAvWOla/XPBGNAakdH1FajeJ4coU
        NYurv71PD1hXdnWHLTD/G0S7BbSsBj0=
X-Google-Smtp-Source: ABdhPJwXu2hjs5ces/Io3RYcOZRWCrHFwzCR4aPq6+y0EKW/NEWp9+XSx1haFkUBDYlx+64iakm4vg==
X-Received: by 2002:a17:90b:1d04:: with SMTP id on4mr5370839pjb.68.1634636296746;
        Tue, 19 Oct 2021 02:38:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.43.24])
        by smtp.gmail.com with ESMTPSA id w17sm16511557pff.191.2021.10.19.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:38:16 -0700 (PDT)
Message-ID: <616e9208.1c69fb81.24e25.d7dd@mx.google.com>
Date:   Tue, 19 Oct 2021 02:38:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0271320983067262353=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijn.suijten@somainline.org
Subject: RE: [BlueZ,v2] audio/avrcp: Determine Absolute Volume support from feature category 2
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211019091648.120910-1-marijn.suijten@somainline.org>
References: <20211019091648.120910-1-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0271320983067262353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=566149

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       FAIL      0.33 seconds
Prep - Setup ELL              PASS      52.40 seconds
Build - Prep                  PASS      0.23 seconds
Build - Configure             PASS      9.09 seconds
Build - Make                  PASS      218.92 seconds
Make Check                    PASS      9.54 seconds
Make Distcheck                PASS      260.01 seconds
Build w/ext ELL - Configure   PASS      9.32 seconds
Build w/ext ELL - Make        PASS      203.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2] audio/avrcp: Determine Absolute Volume support from feature category 2
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#71: 
[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761

/github/workspace/src/12569213.patch total: 0 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12569213.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v2] audio/avrcp: Determine Absolute Volume support from feature category 2
1: T1 Title exceeds max length (81>80): "[BlueZ,v2] audio/avrcp: Determine Absolute Volume support from feature category 2"
18: B1 Line exceeds max length (103>80): "[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761"




---
Regards,
Linux Bluetooth


--===============0271320983067262353==--
