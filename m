Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D567CC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 16:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiFBQiF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiFBQiE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 12:38:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94413C1F0
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 09:38:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s68so5189669pgs.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=w+jv8oPGBNY9cpHAQk/bnRbA7JH4x0ycdZOTPV4+LHI=;
        b=f+S0lmneseDVnTW2HGlg6lQaOp4Kz1+j0UhoYDm356ySBxozDC+cnX/+BcLAEOyJR+
         n6WK9w3kKE5HH5dLhWPSf323RaZX5yl2Cv/27aL1lOZL3DPACiGVrd3e+FGeD7OnysX6
         NKvLAshU+m9AGEdTKfabutwbyfgTcjI3ZMR8AxRaGMCiULZ8DKim6+1Iq78xg4Mk6ldT
         K9GbQd5etOAB2qdLyzHn/Oy/YTaAx55emHbRz7LgKJz7leKFpwQPz89VuhrTlszIUs6q
         LVM+rSOUMU0l5tJ60Shl60C+SMT0CB7wY391OnDzXPI0nc2zyyHk4np6hvvNuyDtqp6Y
         Ehjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=w+jv8oPGBNY9cpHAQk/bnRbA7JH4x0ycdZOTPV4+LHI=;
        b=msX0VE9KEUINhub3wj0Gxo4/xu6C+Qzz9HmeM9sr+gyI2lnrpr58fASRwiIhQ46KAX
         hfFUvN77upCLYPbjoaWYJdr+XQNjfcyt8YdLh3a0x0DeMjnAJl8cIR0gnjgtToSx8kbU
         jsRTr/ATW1Kycd0TfO1CmyxnqqsY2SIn7qfhs/RUSnRUc7wRG+V6KLoW38lpQmj6tpP/
         ZP1/IdmrzW2SnRlP4jd0wvaDsDL78Aj7Rvqz/psPqC9dMYCFumqgJapEseoMOuP8ir26
         gi1OHC+LxsJOkucAMbF9tc/SNXBsP0Q0Wlv8Qivm5MCWPUihfBl57PaSXJaWkh5BnYhx
         uVRg==
X-Gm-Message-State: AOAM530oliCaaDtOXG9Xh/fp7qD2Dhb0ShSo2mHwjErC/Zrc15cbls0V
        7ZcXfoDZMpOo6ljuf77tFSAB16tMiBs=
X-Google-Smtp-Source: ABdhPJzXWmjI91gCQumJ87bGSdgjrWCSJnWQDmACSTNdXzA/vKBCPivp3QDCA1bWbVHsuQpRyX/bFg==
X-Received: by 2002:a63:fb0f:0:b0:3fa:f1d2:140 with SMTP id o15-20020a63fb0f000000b003faf1d20140mr4911643pgh.487.1654187882458;
        Thu, 02 Jun 2022 09:38:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.174.105])
        by smtp.gmail.com with ESMTPSA id u11-20020a62ed0b000000b00518c68872b9sm3738725pfh.216.2022.06.02.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 09:38:02 -0700 (PDT)
Message-ID: <6298e76a.1c69fb81.3f6bc.811a@mx.google.com>
Date:   Thu, 02 Jun 2022 09:38:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3784627382475173900=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: btproxy: Allow to select multiple BT controllers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220602152613.79718-1-frederic.danis@collabora.com>
References: <20220602152613.79718-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3784627382475173900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646928

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      55.27 seconds
Build - Prep                  PASS      0.53 seconds
Build - Configure             PASS      10.18 seconds
Build - Make                  PASS      1540.95 seconds
Make Check                    PASS      13.17 seconds
Make Check w/Valgrind         PASS      531.99 seconds
Make Distcheck                PASS      284.86 seconds
Build w/ext ELL - Configure   PASS      10.16 seconds
Build w/ext ELL - Make        PASS      1504.60 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
btproxy: Allow to select multiple BT controllers
ERROR:SPACING: spaces required around that '>=' (ctx:WxV)
#114: FILE: tools/btproxy.c:581:
+		if (index >=0 &&
 		          ^

/github/workspace/src/12867964.patch total: 1 errors, 0 warnings, 95 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12867964.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3784627382475173900==--
