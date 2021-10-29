Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C32C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE97860F58
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhJ2R7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2R7M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 13:59:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44CC061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 10:56:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id f1so9831108qto.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Nxm9JRj30xoKc3yc3F289wBWPo4RgnG9EAG+xd1VEZU=;
        b=VNhIClFd90WpFQ6vvw7Ta2QsKHgsIY9W0dUVjClk7YKkoidkYMxaSliaHJud1ov45d
         AJc/CZ9Q3OyPEngnXnLAbT2uPEEi6uFQHvbMPAgDdrlRB5Ox9djb6ssmLSmSxjzhk89E
         zjNgdku+T1TKw8Tv0BPQR5ns2VXC6m3PPxJ1GUtRNu4YjFzbUOrSyOjwaAenWOjmQuiL
         uRDYzl0lxcSbPjO+c5mhm3Dm5hvi3uDq77ctEgS9F354hwNY0hB7/yD1YO5j1mHT8bZW
         jnMxtaR5Tv+GulQ9QQlSrs5L7DCDIRkP6ur54UWKm46a5hmVtC3amaExHnUGt2O/w/RA
         NrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Nxm9JRj30xoKc3yc3F289wBWPo4RgnG9EAG+xd1VEZU=;
        b=AtVAcfPJQtXmioXqOQYDiRg5UfalE6FLF3fvqHo9yv2D4qomX03IgrFAN3NADsrRcx
         XdYYdMqCAW820C5uQ2r0veBBDx3mHveSbVnvThgGqdqXBzvj8XCO3CrtdnaesVPS7BDD
         QaeIqvAlcyt64eFUjtRJ72s33rsfoKlydgtExI+r6cwgujapAc+i0xPpdYH3gba3ZEU1
         4Rl7k/nLD991yf54cjjwGVRO1gbx1W3Q5ryRfEssLoGfwwekmZpvrrGfC5Vb92TZrlUX
         6u9Obx/ykBxT5vTe+/+JCP+GxApZ4Rz88ylusJ6pU/JQ91TBMVkO1PdqLO4XybXUK39c
         3G0g==
X-Gm-Message-State: AOAM532cLPyUMuUWyIb9eH8Ice01NtHnjw03XOHR0ljZLVAoRxV6JuAL
        I6v2dZj7P16WwLeFpVBWkzpOOB/up5mt4g==
X-Google-Smtp-Source: ABdhPJwBZOxG5REQmjbxoc/dFbcH7TFetssCJ+Bd3bWsJn9TnrUDB6pybMNew7RAUhWEI2T4B5pwVw==
X-Received: by 2002:a05:622a:1049:: with SMTP id f9mr13639288qte.349.1635530202887;
        Fri, 29 Oct 2021 10:56:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.93.190])
        by smtp.gmail.com with ESMTPSA id l14sm3803422qkp.56.2021.10.29.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 10:56:42 -0700 (PDT)
Message-ID: <617c35da.1c69fb81.bce89.a414@mx.google.com>
Date:   Fri, 29 Oct 2021 10:56:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0795124293135132838=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v15,1/2] tools/mgmt-tester: Update the expected manufacturer of emulator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211029172328.703752-1-hj.tedd.an@gmail.com>
References: <20211029172328.703752-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0795124293135132838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=572685

---Test result---

Test Summary:
CheckPatch                    FAIL      5.19 seconds
GitLint                       PASS      2.22 seconds
Prep - Setup ELL              PASS      41.41 seconds
Build - Prep                  PASS      0.44 seconds
Build - Configure             PASS      7.65 seconds
Build - Make                  PASS      176.82 seconds
Make Check                    PASS      9.51 seconds
Make Distcheck                PASS      209.38 seconds
Build w/ext ELL - Configure   PASS      7.77 seconds
Build w/ext ELL - Make        PASS      168.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v15,2/2] tools/mgmt-tester: Add LL Privacy test cases
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#760: FILE: tools/mgmt-tester.c:10115:
+					MGMT_OP_SET_EXP_FEATURE , 0 };
 					                        ^

/github/workspace/src/12593165.patch total: 1 errors, 0 warnings, 2810 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12593165.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0795124293135132838==--
