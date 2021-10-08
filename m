Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC06C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5563D60F9E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhJHTeQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJHTeP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:34:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2FEC061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:32:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k26so9027265pfi.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jVBvEl6biwxUuLeVRzLNfwbPFCEwzofV1E0kp0IheLA=;
        b=l0UVun+Om1iOglLYJk+i5odcwSSe7Die/Is7ELMmEmp3HrSZNQCFmMCb2i6G291mT/
         9jkg8OQyRLpqKF+Vgmd2Rngqo7z64J75e/7ZoXAjdDMYXQERfybcp1vSxYIw7lASWWFb
         gFzTm7mm+0z4Mvb3I1M13+sNpyV9Wyiw0/8X1PyVqsXhmHMqmjo+CEQxENxus+2fFqST
         jtytICJrlx7ZvYhcR4JjG20sq4ogX6a+Hz1cTQfxOyrqqe5xPJWXareP+hXbp+6x9J9c
         dsAPIJvAfGOgACzFubTU4NKnv1pz/CdlIDiHukT5Tt5KXttFPFvhQpkps0U4sTTS6B7c
         DXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jVBvEl6biwxUuLeVRzLNfwbPFCEwzofV1E0kp0IheLA=;
        b=VfceTZ3KpL2cZ9u4KMcEuAncsvc3NskdLWSVOvDe0PXvmx9Ajvd5lM9P/8hX5XO2nB
         caMuAgJ1N2IDLMEN4swZCBdfIL1JcjQOaUgXOt1NuN3V9U1PKi3UKXLFGM4swm10EccM
         ge7U4p3qhUBu5lNS6rhFlDmzI9NPOQ4uGohSy/Su3xUqn7f+VirKxXaU7en3Mfs8rpfj
         9n0tkR6Ecb01HnNxo/NQjHgzDkrPllfQxefqXvuNwNnY/tvT3N5qH5jZww8BjNVqxGC2
         cHjoOFJItWw4llYyZTHWOv1kJONw7Ifo7D69zeFbIwgQoiDX02AV3Ku8wKqF5gaqCqNW
         dAYA==
X-Gm-Message-State: AOAM533H/gR1iQDZX7hCDZAD+SysjjWvSnpDW1BymMxYvjoZIIuU9sd5
        2INDrsKlsltI3ejvkWOW5ZEHUrCcY6M=
X-Google-Smtp-Source: ABdhPJwnZSFo7gwkDLnv9QOdIc8uMxYBsKcgFuD01bHYUF42janBT3z+wx6cvalVjI+V6gjrE5iZlA==
X-Received: by 2002:aa7:9287:0:b0:44c:767e:4e71 with SMTP id j7-20020aa79287000000b0044c767e4e71mr11814278pfa.76.1633721539440;
        Fri, 08 Oct 2021 12:32:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.69.96.110])
        by smtp.gmail.com with ESMTPSA id q10sm139613pgn.31.2021.10.08.12.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:32:19 -0700 (PDT)
Message-ID: <61609cc3.1c69fb81.45cab.09e9@mx.google.com>
Date:   Fri, 08 Oct 2021 12:32:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1495897623685807058=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bernie@allthenticate.net
Subject: RE: [BlueZ,v2] gatt: more fixes with cleanup on disconnect/timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211008190023.15462-1-bernie@allthenticate.net>
References: <20211008190023.15462-1-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1495897623685807058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=560135

---Test result---

Test Summary:
CheckPatch                    FAIL      0.53 seconds
GitLint                       PASS      0.32 seconds
Prep - Setup ELL              PASS      49.68 seconds
Build - Prep                  PASS      0.19 seconds
Build - Configure             PASS      8.87 seconds
Build - Make                  PASS      214.13 seconds
Make Check                    PASS      9.88 seconds
Make Distcheck                PASS      253.34 seconds
Build w/ext ELL - Configure   PASS      9.03 seconds
Build w/ext ELL - Make        PASS      202.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2] gatt: more fixes with cleanup on disconnect/timeout
ERROR:CODE_INDENT: code indent should use tabs where possible
#191: FILE: src/shared/gatt-db.c:1923:
+^I^I^I^I     ^Ipending_read_cb, p, NULL);$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#191: FILE: src/shared/gatt-db.c:1923:
+^I^I^I^I     ^Ipending_read_cb, p, NULL);$

/github/workspace/src/12546199.patch total: 1 errors, 1 warnings, 109 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12546199.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1495897623685807058==--
