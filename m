Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BABC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 03:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiCCDSE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 22:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiCCDSE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 22:18:04 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8D22BF7
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 19:17:19 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v3so3523713qta.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 19:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=J4wI0PT9tFasLBrWJEQM5BvXkT2il420Kgueai11nFA=;
        b=q7HaBotshsJL4YE2Dnbq81+0Sdm/MBBIECw41quvBKuWNSfPwG0TZMzHkNMl0XPmt/
         mIZRklIOaZ0ATl56AN8aLZNut9uclYOKIErKBgn7PPDwL4q4hvYjeMoKlTGNGvFD+cVt
         HoKjJE71SJIMdLGA6i0GyAT3j9C8DrsN7a+UDwbv9tAF5GG0Y7PZkDu3iQjuxG1xXJhu
         9UUh6k8eruBiKAWPy9QioIhfFVf1CnMpbDvvwhafM88cS2DC0Z74CDQnjSxmcvfV6u2U
         HgfTymRfOtzp4iMNhuppUGepdQN+DHiXmuK0NyRRMAH6hEjTc3+t2Hara0xDpBPNqLFw
         OFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=J4wI0PT9tFasLBrWJEQM5BvXkT2il420Kgueai11nFA=;
        b=kIuLS3zyVXJ5AXTaia9GGsws7f9uNhEGOkOL8Ofj1hqkeFkdyYm2lD1T43+kf73RjI
         Tt+4mKhRDpmLQhA1PguvYbhz4DLX4pY1egqG1GKg2e4mo4pFP2yiEcp+sylrwm3k1PcG
         gDLTt+6z/rYzZi1hfFLAaXOW2ijCyKHPaiIxqWCXZXiv5e17S0CAOJwRBZRyfWSZjsHF
         zIWfjP/6FXh5rIIUJ58TYo+0W/oac07rT01AZLyL9kVPY/QbMW/zRwovjx5cTbp6TCr4
         wwsQxFmd+l4D6RflkaoMb5WVLNL2BeAlKcQMTGAbZK+sJTaUhSUXAl2C4+1Q4JOohMVg
         FK0A==
X-Gm-Message-State: AOAM531/6GQXPu2WCioUapkDCS/U58yAsk3/4VhYngkk5cezwP/rDvt3
        MxzQXPCvWlq9Girmi3uOJfKL5rmLhLK5WQ==
X-Google-Smtp-Source: ABdhPJwbUGWQXFNcTRCi3KKehi3Ieae7TStkw2D7t341j0WBwE3ZbcPdGYyD+Aj6/gLlqUFYU82CuA==
X-Received: by 2002:a05:622a:2c8:b0:2de:8904:e42 with SMTP id a8-20020a05622a02c800b002de89040e42mr25545640qtx.631.1646277438133;
        Wed, 02 Mar 2022 19:17:18 -0800 (PST)
Received: from [172.17.0.2] ([52.252.52.103])
        by smtp.gmail.com with ESMTPSA id r14-20020a05622a034e00b002de72634a7asm620831qtw.37.2022.03.02.19.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 19:17:17 -0800 (PST)
Message-ID: <6220333d.1c69fb81.59e13.3197@mx.google.com>
Date:   Wed, 02 Mar 2022 19:17:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7988935219056761578=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client: Add support for scan <le/bredr>
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220303003136.4882-1-luiz.dentz@gmail.com>
References: <20220303003136.4882-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7988935219056761578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619734

---Test result---

Test Summary:
CheckPatch                    FAIL      1.60 seconds
GitLint                       PASS      1.09 seconds
Prep - Setup ELL              PASS      50.66 seconds
Build - Prep                  PASS      0.92 seconds
Build - Configure             PASS      10.27 seconds
Build - Make                  PASS      1761.16 seconds
Make Check                    PASS      13.30 seconds
Make Check w/Valgrind         PASS      532.70 seconds
Make Distcheck                PASS      280.62 seconds
Build w/ext ELL - Configure   PASS      10.33 seconds
Build w/ext ELL - Make        PASS      1735.38 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] client: Add support for scan <le/bredr>
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#102: FILE: client/main.c:1419:
+static const char *scan_arguments[] = {

/github/workspace/src/12766921.patch total: 0 errors, 1 warnings, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12766921.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7988935219056761578==--
