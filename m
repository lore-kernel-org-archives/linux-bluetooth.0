Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CD0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 00:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbiBKAXO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346305AbiBKAXO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 19:23:14 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6B5590
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:23:14 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id c14so6856571qvl.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rs6ew4hz1Z+Gtg016b45X5LEaaMi/Z1G4+JQsv1PSAw=;
        b=IsDwXXFWZf8ACM1jhK7qV0k2RmxdoqHeJkWYxAGFphwNUl8ypBk7PdiKlvFx0ZWhYx
         743SilNK+kbeu8GqpeSiDV8keKcBJ2ow1BdSlJuJUKrGRML+Pfub/dioyavvR5rsrOqx
         3bkKYamO1ieOmDH3oIRG/yiHgToMRNzDxysDWZhgvQNOkXIeqo6KjQEBEsmuKEsfdxpO
         XE6KBbsCowYaWkTWX65Ix8XO8/0zZd/h09fFFDvbdmr55/yt1Pk9KxOwB9GauYl2wMzI
         8BNDoiDwLKa8x3taWlAbnqWzNZpyieBV6uIeOTnLtu7aQYCyMgeo4q1LwDeLWOy9azBj
         6Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rs6ew4hz1Z+Gtg016b45X5LEaaMi/Z1G4+JQsv1PSAw=;
        b=2MgZ5Iipl4hUXVF3WDkbNFg7dCUJyD4Wkhkx69o8IXk6LYjr6EqAKL8s6hwV2mp4tC
         pDMI6svTaFdsepksLxubs0tAAIavl6SaTPFtktWk8X1osXyCTCMB2YVw8HsqXX0SVzrZ
         gjSSflcvpSHH8VF6a6wg9XfHFuOYd4fywDfhz9UDmdQws+WmgriujUEpGcjNMhRbw1WC
         eSV1POyBZuKvuxj1gcyW3dw1AGUPbT7pqU4FoqA8SxhdVD3SYKvacvV+DHMwPIaOfmwv
         /fGJGs2PUqkMX5C6ouhgd1Vm4FAgnNovw6R/MchQ7dPtGO4bbNLaEVvC3tk01rXUDtYv
         0r4Q==
X-Gm-Message-State: AOAM531RVIaKBEFbS3L4D5lZ0yWTXfpVmqOtMgxXiF+a8V8js1LPYB1g
        j9cbMukj8ZfHlL8Zz2hr0VIuXZA9lNcd+w==
X-Google-Smtp-Source: ABdhPJypyn5IuY9VjiQ5ZaN8lP+uFMliMgeGluJYRhC4XysX0IgIY4SAZThvVSjlEAK6dSrqnOCRqA==
X-Received: by 2002:ad4:5bac:: with SMTP id 12mr7132659qvq.34.1644538993124;
        Thu, 10 Feb 2022 16:23:13 -0800 (PST)
Received: from [172.17.0.2] ([40.79.19.193])
        by smtp.gmail.com with ESMTPSA id g24sm10597729qkk.76.2022.02.10.16.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:23:12 -0800 (PST)
Message-ID: <6205ac70.1c69fb81.e6be8.b6a2@mx.google.com>
Date:   Thu, 10 Feb 2022 16:23:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0511214545989372590=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] device: Fix crash when removing device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220210225552.573320-1-luiz.dentz@gmail.com>
References: <20220210225552.573320-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0511214545989372590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613256

---Test result---

Test Summary:
CheckPatch                    FAIL      1.46 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      41.27 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      8.25 seconds
Build - Make                  PASS      1386.15 seconds
Make Check                    PASS      11.95 seconds
Make Check w/Valgrind         PASS      440.83 seconds
Make Distcheck                PASS      230.47 seconds
Build w/ext ELL - Configure   PASS      8.17 seconds
Build w/ext ELL - Make        PASS      1374.80 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2] device: Fix crash when removing device
WARNING:TYPO_SPELLING: 'immediatelly' may be misspelled - perhaps 'immediately'?
#81: 
cause a crash, so instead of removing it immediatelly this set a the
                                         ^^^^^^^^^^^^

/github/workspace/src/12742555.patch total: 0 errors, 1 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12742555.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0511214545989372590==--
