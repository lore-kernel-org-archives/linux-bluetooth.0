Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B899CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 22:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378493AbiFPWtQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378725AbiFPWtO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 18:49:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985A62215
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 15:49:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bd16so3513497oib.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=j9kWMqqCGKd/SHlDQ0kz3dNxQWQQpXdiaDIDkPwu2Rw=;
        b=CWHSOl/1aT+n9vbh6vwbWK8q0jcN7F3U4srnKuPkHayrUGtOrVErg3qX0l+g3mxAWb
         MujTm0cCnZcpPWYMRPoH5w3M+Iop/1n4Y7cNfs85nhAQAkv/UhZ7oL6Yog/EWTAGGn0+
         pgFoNSsmqhVIJ9KAQ+Vxusnel3S5lsUZvrhWAq77Ma//v5ft+/1NbsYdJz8Vs4XDCH0e
         5rabBr1ZINNvUHFPhnT7T7Swv71nd8ClKHW3YcD0KRM4fdzZb4ggeXTTqj8ozNzoqBzL
         /qYD+g50dv2u4CIQohuw6TwhsvRiTJMYYM4GOkKrYX6E/nbjoHXmDJfFrNcdBMk/3EF4
         k88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=j9kWMqqCGKd/SHlDQ0kz3dNxQWQQpXdiaDIDkPwu2Rw=;
        b=YVMwS+IY67sExB7xsb+e/9SEHpPUUMr5GR5vhZhkwbUSu4lXN+RH8gZrw0R0dc+xlZ
         VQ3iohnLcBgI9BnXTRR2OB0Xwzj3ILRoBeHrwwssoTNG44pij8G2IKrlrIXCAMeEhoS4
         +6Ga8JKR5XRtZZaKLlR746+cCyqBmuE8YnrilaF5/R9GsONCyzJIa55WyOJlt4VYMm2s
         /d4NwaWVN1I4/PuKXEpyq0MUUcT5fy0b5779CH7H3hjI+sceFeCxGfj2sK5VgDUp82Jn
         bMWXo+WJErMngo6y6vS7HPcD85d3Kl9A+pSWzzKinj3OvOY0mGUvalqYw7xh5WzcIhxg
         yuFw==
X-Gm-Message-State: AJIora8Sq+y79CrjPtNjmX0dY+hYSvo5TLKMJiZcx8eTDUdXQzSoxVrx
        ye8RSlxFTIXOXi1h9BxJEfGqvOHpXm71lA==
X-Google-Smtp-Source: AGRyM1tcTRBc06lvdGJLFlkCF0iQ2OnzkAZcPiyN+8oGx/lzrUe4geycfP5u23nbGEBiyn+iJFHbuA==
X-Received: by 2002:a05:6808:1b2b:b0:32f:19f4:88a4 with SMTP id bx43-20020a0568081b2b00b0032f19f488a4mr3781770oib.112.1655419750843;
        Thu, 16 Jun 2022 15:49:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.62.212])
        by smtp.gmail.com with ESMTPSA id x3-20020a9d4583000000b0060c237c6355sm1440213ote.71.2022.06.16.15.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 15:49:10 -0700 (PDT)
Message-ID: <62abb366.1c69fb81.23d0a.3b86@mx.google.com>
Date:   Thu, 16 Jun 2022 15:49:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0034983131006871757=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/3] doc/mgmt-api: Update for Add Extended Advertisement Command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220616195803.99346-1-hj.tedd.an@gmail.com>
References: <20220616195803.99346-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0034983131006871757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=651141

---Test result---

Test Summary:
CheckPatch                    FAIL      3.59 seconds
GitLint                       FAIL      2.34 seconds
Prep - Setup ELL              PASS      51.57 seconds
Build - Prep                  PASS      0.63 seconds
Build - Configure             PASS      10.34 seconds
Build - Make                  PASS      1503.91 seconds
Make Check                    PASS      12.39 seconds
Make Check w/Valgrind         PASS      540.37 seconds
Make Distcheck                PASS      282.70 seconds
Build w/ext ELL - Configure   PASS      10.49 seconds
Build w/ext ELL - Make        PASS      1443.36 seconds
Incremental Build with patchesPASS      4517.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,3/3] tools/btmgmt: Add support Add Ext Adv command
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#233: FILE: tools/btmgmt.c:5031:
+			/* fall through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#405: FILE: tools/btmgmt.c:5203:
+			/* fall through */

/github/workspace/src/12884720.patch total: 0 errors, 2 warnings, 389 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12884720.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,2/3] monitor: Update flag information for Extended Advertismement
11: B3 Line contains hard tab characters (\t): "	..."
13: B3 Line contains hard tab characters (\t): "	..."




---
Regards,
Linux Bluetooth


--===============0034983131006871757==--
