Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1BEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 21:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiBRVVT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:21:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiBRVVS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 16:21:18 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9BF47
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:21:00 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id c14so17199230qvl.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZETaSsAJn2dCBaSbDtTvGv+OnbnTnPJ/e0+ae9torug=;
        b=caIU0SsGLgcWPYhPcjF02CUhcWf+G04O1v4AkgwM5j7IUtRDJ/KX01y9Uui7dTVSpo
         Gt0F4QI2ftjnD+fYJI9dbvHb9TZ986rivRQM+src/baIcnx4AaxVL9dp6bokPN9GilId
         dESUqBdSYmb+F+C/4bsvjLABp0UQHcxQppndZmOg0xrUjh07gPP3TMMKAFQ7ez33/1Ps
         nZHGa921Oze1Ud3tqgi0gCUx1h5YgzO2IhPSXKMhBt6UOin8fjBQlwrVzRD5ikTfGjpQ
         jO36NVMnAodPJuSb3mVRg+YlTadTEDD4z9EFTftYPnoSap/TagsdpaLcshBzB/RteaG/
         UY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZETaSsAJn2dCBaSbDtTvGv+OnbnTnPJ/e0+ae9torug=;
        b=cDt0DoHzqEbY4hhb/mKScRRd1nOOtIvsF8oB1SMfsG9cu0Yhb6xKCJlUEUGbBrckBJ
         IjcIMZ/y7zhGVZo5RMvCFl7hpyYg3gcTHh/h9Jb9MRACoSyHlbPEOQ8ZiQkJaKszRsTI
         1ZLY5jKsnIkw9aS3IEyUPwOx0iEO60KRHksnqe7Nl73Btq+o6Z9IDD7DW2Gc7QhsgvAH
         BXIG+rp/sanWequXAwnZZXnJU4sm4AiBzBNSS71NngtLBDvTlEW1uRL3eA7HlIscOx6K
         qMEk13hsWVzGi94+qMMLLn3zNnsP7IW3RZEXp0rnDQZipNGHVVe/m9k5CXDCS7UUwNiM
         tOOg==
X-Gm-Message-State: AOAM533n3WB9fmPVpsfsUGV3r9rGQ2636TUIQUAYAwHeaPQXnwQNpx8k
        jahJkdAmtntRXp7AhOjNNMeoWec/5l7bVw==
X-Google-Smtp-Source: ABdhPJwLagtIAknsS6o/A15SdQWSdD36auz8dI339+CmhSFNKdqm3t6rMOw9OJlBthvJQkd/TF6yCA==
X-Received: by 2002:a05:6214:e6e:b0:42c:47ae:3fc6 with SMTP id jz14-20020a0562140e6e00b0042c47ae3fc6mr7374294qvb.17.1645219259132;
        Fri, 18 Feb 2022 13:20:59 -0800 (PST)
Received: from [172.17.0.2] ([104.209.174.175])
        by smtp.gmail.com with ESMTPSA id h7sm25780212qtb.27.2022.02.18.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:20:57 -0800 (PST)
Message-ID: <62100db9.1c69fb81.64782.58c1@mx.google.com>
Date:   Fri, 18 Feb 2022 13:20:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7277573317405416820=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] gobex: Fix read from pointer after free
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220218194617.160812-1-hj.tedd.an@gmail.com>
References: <20220218194617.160812-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7277573317405416820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615864

---Test result---

Test Summary:
CheckPatch                    FAIL      1.51 seconds
GitLint                       PASS      1.03 seconds
Prep - Setup ELL              PASS      39.27 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.01 seconds
Build - Make                  PASS      1327.50 seconds
Make Check                    PASS      11.31 seconds
Make Check w/Valgrind         PASS      405.40 seconds
Make Distcheck                PASS      213.79 seconds
Build w/ext ELL - Configure   PASS      8.08 seconds
Build w/ext ELL - Make        PASS      1305.72 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] gobex: Fix read from pointer after free
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '7e7d826aa1db', maybe rebased or not pulled?
#84: 
Fixes: 7e7d826aa1db ("gobex: Print error if data cannot be written")

/github/workspace/src/12751809.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12751809.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7277573317405416820==--
