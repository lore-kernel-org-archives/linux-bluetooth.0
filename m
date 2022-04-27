Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA02EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 02:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354611AbiD0CVN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243969AbiD0CVN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 22:21:13 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB960068
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 19:18:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x9so254305qts.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 19:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JKCVKbLgqVFgldfIMeP/+aObC9RsFH5OD8It93d2uh4=;
        b=lqFQCRsRrkQTs3ykVA5qcyJwu83Ii5vuN9P3El0pIGXhcR5GdK1sBN5iVWC/PohYSo
         HeM5S1INIhlvQzt6/JB6CQzD/2aVVeS8Yt/Cejke1z1nP8EUOPZwXzczXfJva2CPI/ev
         a+Md9dsGZLMaBu3PNZt3DXuMT6SzHjapKhINDj7cvhJ1lrhXZwW1VsFZcJG7YJTiXU3k
         Fb8123ToXaK21553E0519Md+mHxcbkzTtL9Vmf+/OQvZp2XWtlwVCOgirkKPln1X8PZz
         O/DAV9C+jSGbi+B6glrbBYZzj2HPfCUcxDdFuCnz9Kxw+5hbtcRiQ2eJdDLnRD7kAbLR
         JmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JKCVKbLgqVFgldfIMeP/+aObC9RsFH5OD8It93d2uh4=;
        b=QKVgBPFT31qTayDun0ExGczQjf0AUfc2IISV7YvhR+pq/nhOGVigQFxiZX85QxjRRM
         UUG9uxUAWXvrS07Cgdn7ytOx4h/gbrXKAKQljvqFieDdDpQRl09vwPPE9PHE2IAD4v0W
         MMZfAHXJkY7bZMQGVDCPEvM4earex/8IuZVM9tUTcvQVToenXEOq7v33skkNqF1NQnos
         BCf3MsUMXoU6koIZ76iSLwtw8nz42poHbKWNnWoDi4kHW/x6pyDTdCvNotBP2R1SPyt5
         N2H3tXmjXjBTzj7Q1ePlgWiV9GInLUYKFyHM8cn/GTu1Aa8Mup5lqC5NblPNjYNE7ysJ
         5q9w==
X-Gm-Message-State: AOAM533GZ4EoWtGd7cumc2AgAVkNgGZkqhZ97oTrIiViDz8m2EpkDWDU
        dPQ6tYjnh8EGcG5UeXqdS/7GbKYK278GNQ==
X-Google-Smtp-Source: ABdhPJwekzauW/bqU73y7mtJYUrNI/vj6cP6CoyLNqa9unrEYFHRb8zMUTj1Thk2Yz5I+ejdUmvYEw==
X-Received: by 2002:a05:622a:1394:b0:2f3:4383:bf0 with SMTP id o20-20020a05622a139400b002f343830bf0mr17702758qtk.80.1651025880986;
        Tue, 26 Apr 2022 19:18:00 -0700 (PDT)
Received: from [172.17.0.2] ([40.112.53.243])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a179300b002e1ceeb21d0sm9126906qtk.97.2022.04.26.19.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 19:18:00 -0700 (PDT)
Message-ID: <6268a7d8.1c69fb81.288c.4fa8@mx.google.com>
Date:   Tue, 26 Apr 2022 19:18:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4170559158846685989=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] btmon: Add proper decoding to Service Data UUID
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220426230347.857783-1-luiz.dentz@gmail.com>
References: <20220426230347.857783-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4170559158846685989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=635945

---Test result---

Test Summary:
CheckPatch                    FAIL      6.08 seconds
GitLint                       PASS      4.09 seconds
Prep - Setup ELL              PASS      49.83 seconds
Build - Prep                  PASS      0.77 seconds
Build - Configure             PASS      10.00 seconds
Build - Make                  PASS      1440.82 seconds
Make Check                    PASS      12.56 seconds
Make Check w/Valgrind         PASS      517.26 seconds
Make Distcheck                PASS      269.46 seconds
Build w/ext ELL - Configure   PASS      10.86 seconds
Build w/ext ELL - Make        PASS      1541.46 seconds
Incremental Build with patchesPASS      6355.82 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,3/4] btmon: Add support for decoding Basic Audio Annoucements
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#123: FILE: monitor/bt.h:3524:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#128: FILE: monitor/bt.h:3529:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#133: FILE: monitor/bt.h:3534:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#139: FILE: monitor/bt.h:3540:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#145: FILE: monitor/bt.h:3546:
+} __attribute__ ((packed));

/github/workspace/src/12828051.patch total: 0 errors, 5 warnings, 152 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12828051.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4170559158846685989==--
