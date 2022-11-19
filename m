Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AEAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 02:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiKSCZA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiKSCXS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 21:23:18 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA37DCB2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 18:15:30 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z17so4694566qki.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 18:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hrjKCTcRiJOLkMRdASTCnh+rVhcxZk66hpYuMiOVMM4=;
        b=B8/+CaX0ZR3BhthEuaUqPoFDNEDj+DWsuBVL7WwDTNn5E0D51rJGOnjuIW0QYGb2GT
         4/xG1ZjskbBp2Q+YVRolD/FXrjaC8xMSUr235sHubuLAe20uVUOjo5j2d5zQTvWZn9EW
         iEnvrV3exwCC++LttX+1x9UibIN0bCFyDPkMUTLdwABL3psBimPmomY6WmfDzFqfei0b
         nRpw2bxDmAXSwDf22hVgKheM5tEvzWzV0bLIEGV4Y0xglUfspMHFaNbd0fTosJ0W7WUt
         rfH2SyJ7NycDdFdmsMuLFaVAC5RA3R09z0dU2sJMi36t5elraKj7i2p7QOFaTz2Zw5NO
         ONcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrjKCTcRiJOLkMRdASTCnh+rVhcxZk66hpYuMiOVMM4=;
        b=LHlzVHKZXGvhMw5ACISO1vMygcEV5RbT6Y0kKp6VoCEcRPIgqeB/w+bf4ACeaLGLN6
         H4JQSGP/fU/VHWxLBNMk7LRleBLPYJHYrS3VMhf9jE+GlKY1+aanKeKdLDrgN1Sf3c7g
         X4ONuEESr+ZQwwlquswST239s5tnhqOUz/AKOy/3382c4EVTdKQJXIN0JqlSQn8xzSmj
         cxaAqx4JveLq5SwjW9BfFiEz7hsvDXOF0MxJDjKcgS6NnZbWzZgQXvcT9PrdAE4NT6wW
         tYPNcX/mp6NGrqeTsiPtB+kquj6R1zt9Js/9hNe0XBvfn//D6wxcSiIMglCv7NwJ/lzD
         XaCQ==
X-Gm-Message-State: ANoB5pleLZiMEKrYF63xpquZ90oRTAOGePOY6ndEyfTvAQn0w6HOV3iC
        zWtlIWOwZyPAXhVdCPwySBHC0sJDS0poJA==
X-Google-Smtp-Source: AA0mqf7YrtJMKpKckX3x7sI1wV5vFsYRjntO6HRSydVDdJIk12H3yasX6E0J4g/Vt/KZUvmtRS6X1g==
X-Received: by 2002:ae9:e110:0:b0:6e0:2272:22ff with SMTP id g16-20020ae9e110000000b006e0227222ffmr8250975qkm.448.1668824129213;
        Fri, 18 Nov 2022 18:15:29 -0800 (PST)
Received: from [172.17.0.2] ([20.119.199.52])
        by smtp.gmail.com with ESMTPSA id i5-20020a05622a08c500b003431446588fsm3096571qte.5.2022.11.18.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 18:15:28 -0800 (PST)
Message-ID: <63783c40.050a0220.26689.e578@mx.google.com>
Date:   Fri, 18 Nov 2022 18:15:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9174002930867973631=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] main.conf: Add SecureConnections option
In-Reply-To: <20221118052610.36133-1-simon.mikuda@streamunlimited.com>
References: <20221118052610.36133-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9174002930867973631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696767

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      27.34 seconds
BluezMake                     PASS      924.14 seconds
MakeCheck                     PASS      11.33 seconds
MakeDistcheck                 PASS      145.52 seconds
CheckValgrind                 PASS      230.75 seconds
bluezmakeextell               PASS      92.12 seconds
IncrementalBuild              PASS      812.66 seconds
ScanBuild                     PASS      1013.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] main.conf: Add SecureConnections option
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#98: FILE: src/adapter.c:10149:
+		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, btd_opts.secure_conn);

/github/workspace/src/src/13047733.patch total: 0 errors, 1 warnings, 77 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13047733.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============9174002930867973631==--
