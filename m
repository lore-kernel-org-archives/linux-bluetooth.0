Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E1EE7FED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 12:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjIHMq3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 08:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbjIHMq2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 08:46:28 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D011FEB
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 05:46:13 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a4efcdab54so703242241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Sep 2023 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694177173; x=1694781973; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VUTy39sVS9j+F2cplcvaaA4JXZjCghHo6EucajImLw8=;
        b=Ty0V5QF3CI4O/Uyv4V1soFQ8kZvgUlj/58+O3iBPtGo1sTOkAHhUyI+WJ6KKypCoAf
         sdQMoi25Ai2B4NtY36Yc2VTZ6vkZx2XyWt3S0ws8OHNpT8fznd1h3rxDBfBSbf5SDmeS
         beAvE9IfBm6sY0cYE+0j/gRZaQUGwmmxW8JwBdRDut359s/SPrVYaMrtScA1IRqPEsfi
         h8zdCyE9/4mnih3WGLiWhDpLTZ69+XnPvnkgVloV2SCGELQ+o2/wXfJw7Fa7p9Mrd+pj
         pJMLMUS+ZDliOjjx9bo6RSgKrNJNLFJua9aneLxiBCmjqBM3k6aEzr2eO/U7uTUdgME8
         17+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694177173; x=1694781973;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUTy39sVS9j+F2cplcvaaA4JXZjCghHo6EucajImLw8=;
        b=pTZr1d0lSmAJPEuMmumadQQC3oRodT9NGxkMSF/qp85ACG0XNZ6VTs8odDrRO3ifUy
         nODT9DA7ohYCP/DmNx1wFA8S/3NV/jhXuSznexT9Y7ITcLXu0wRCBtJT3+MeTyZr/rDs
         TJOgxtwxuQDr4K1AqaKQkgKCev5zzHVap64oC6cgdvEiDtxeLEOT17hEVrppNXH8yhuL
         BiPw+xfWRmmHgge6taGefssB9qEcxIplhqLoac0B5a6ZkjnZ1GleOGk8M6K8pqXUAa5P
         0hVLCjoFeLYdm5U9l1P4dMawFl3UXxCf5PaKoMMj2tR9olYdmhTvVFx8CUTCNZYx7d0N
         8MSw==
X-Gm-Message-State: AOJu0YzOMEjHRCrt9D8ao76aNIKJNY7KSCEbbbzJRFjclpNSuHULI3W4
        /XYkLR4tweHBwN0xu+4WIwosjwhkWGU=
X-Google-Smtp-Source: AGHT+IE8d8wkb7A9JYa5wMr3iqT/ImpLPMZhGH6kE5bQS42kn3Cf7LllMW3mcZV5bRCBC/gHnAssHg==
X-Received: by 2002:a67:f557:0:b0:44e:9afe:c5b9 with SMTP id z23-20020a67f557000000b0044e9afec5b9mr2359955vsn.23.1694177172669;
        Fri, 08 Sep 2023 05:46:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.155.208])
        by smtp.gmail.com with ESMTPSA id n3-20020a0ce543000000b006262de12a8csm664526qvm.65.2023.09.08.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 05:46:12 -0700 (PDT)
Message-ID: <64fb1794.0c0a0220.94906.1f57@mx.google.com>
Date:   Fri, 08 Sep 2023 05:46:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1338604991024709928=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Use defer setup when syncing to a BIS source
In-Reply-To: <20230908111208.121996-2-vlad.pruteanu@nxp.com>
References: <20230908111208.121996-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1338604991024709928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782484

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       PASS      0.40 seconds
BuildEll                      PASS      33.31 seconds
BluezMake                     PASS      980.29 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      190.89 seconds
CheckValgrind                 PASS      311.09 seconds
CheckSmatch                   PASS      411.43 seconds
bluezmakeextell               PASS      126.22 seconds
IncrementalBuild              PASS      804.16 seconds
ScanBuild                     PASS      1273.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] bap: Use defer setup when syncing to a BIS source
WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#118: FILE: profiles/audio/bap.c:847:
+	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb, user_data, NULL, &err)) {

/github/workspace/src/src/13377364.patch total: 0 errors, 1 warnings, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13377364.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1338604991024709928==--
