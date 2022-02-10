Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBAFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 05:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiBJFfC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 00:35:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiBJFfA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 00:35:00 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6798810C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 21:35:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id r14so4092854qtt.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 21:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kHkFto8yKFG5UHWq/r2s14vIOfvBou+m0ilKJUTpxQw=;
        b=VMN0+HREkLTDuUBdQSIHYb4+pmXKu9/26Zw/NmtcSy0pl6j5pSd9VHi/tbvs6dHz8J
         ZNDzy8fdJTjygdFCel+K9Y/BhnYqjqtyjQ+K+W7Jk5ObkU2KfyLhSS60SV9Bhemd+x4n
         pDn0JQvqTsoQFQVWwEgwGxJKd/yhtQ87mOjtEh2BVn+doOacijNAtUPAjnc0S+hMfUIg
         0Xp0AzIngIAoXaE8Jz0rdq9xb9rQl1DlfbnQ96XAbWW39mKWNeTpSTC5FVTzjPTCOUvq
         NP+RiXsLA4z0RyiZz4ZlkTys46Oor4ufxGr2xJkzKbFlmBr532yJnIOiKtHT0UTZJk4C
         RJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kHkFto8yKFG5UHWq/r2s14vIOfvBou+m0ilKJUTpxQw=;
        b=Bxp2hq4WJbkKCuewMM+g6/oKsUX+17EMyNuJzCQSGS6iIRaT0EU8OpJVm2NOt1r8p4
         /3u/e/JCK7/F3DZz++mjedLUxwy029VEaxNcMZaLTvCmMpyz9UUII1qMNf43vms86pkk
         FdLVCNldqCosIWSNQi/cIczuI9AlmVUJmMg3GQXRszMEjGURmQ3MYbwmp2jywFqRpVo5
         HtkQrIaKeYscfyDiOgTrZQrJ/9XB/DOppDQdBDT10a0GWc0yMpw3M3ncaS6k6kNj9kOS
         Pppj2GdbLZQ4LBBSbVH11UBpmG8tkOcCjityTqY2mSYEEpHwaSgiQCTct+usaKDLEpKf
         rm/Q==
X-Gm-Message-State: AOAM532ExgHCqkuDlZ1Zw9akCMsB/XfoTv+D0SKvkJp0nP8h0NjLR1qH
        Jgljtl4CM3KDfIpBGowvvrLIQrfvzU1GYg==
X-Google-Smtp-Source: ABdhPJyUQ4eBYuaObfKE1OUdB2BZQ3722ZoXBGk9YaQzj5WR2zGwDFWiya6EBs6aOmnKtLY0UkJRnQ==
X-Received: by 2002:ac8:7d16:: with SMTP id g22mr3799313qtb.180.1644471300384;
        Wed, 09 Feb 2022 21:35:00 -0800 (PST)
Received: from [172.17.0.2] ([52.188.166.91])
        by smtp.gmail.com with ESMTPSA id 13sm10404424qtz.87.2022.02.09.21.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:34:59 -0800 (PST)
Message-ID: <6204a403.1c69fb81.eb5b9.84b7@mx.google.com>
Date:   Wed, 09 Feb 2022 21:34:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2422825529030431629=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] bthost: Fix not handling ACL fragmentation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220209235553.150294-1-luiz.dentz@gmail.com>
References: <20220209235553.150294-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2422825529030431629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612835

---Test result---

Test Summary:
CheckPatch                    FAIL      6.03 seconds
GitLint                       PASS      3.97 seconds
Prep - Setup ELL              PASS      52.60 seconds
Build - Prep                  PASS      0.90 seconds
Build - Configure             PASS      10.70 seconds
Build - Make                  PASS      1847.93 seconds
Make Check                    PASS      13.01 seconds
Make Check w/Valgrind         PASS      549.65 seconds
Make Distcheck                PASS      294.08 seconds
Build w/ext ELL - Configure   PASS      10.33 seconds
Build w/ext ELL - Make        PASS      1833.60 seconds
Incremental Build with patchesPASS      7382.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/4] bthost: Fix not handling ACL fragmentation
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#257: FILE: emulator/bthost.c:2560:
+		/* fall through */

/github/workspace/src/12741130.patch total: 0 errors, 1 warnings, 192 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12741130.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2422825529030431629==--
