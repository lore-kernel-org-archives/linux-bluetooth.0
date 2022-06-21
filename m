Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 22:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354787AbiFUWoz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354574AbiFUWoy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 18:44:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411631DE3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 15:44:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f16so12956005pjj.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bKHACVXIFtdB3STW2PakBcJYhyXM+9UIqdBfEUhdye8=;
        b=Et10tJYPJFp4jTDx+smGZKwCHa/Nzu/nCTwxLzj1as6JA2nUKRn11Om5Sx8HWaDA5T
         PbC+U3W63cmlvao9iTfc/aF8ERRjeofgLCtaHl92E2JnRpAPuSJGf/G3lJBe938URM4f
         F3bQ3Yx/wojNamvWvMQw7pKfD4YHd8XSTcoMGQNZRMU96zljnpbGaqQ/K81ff+1iM8nM
         H8N7+CIavatcCZgNZJjOvTVIYCSg2XsjpTxLrtFxaMqjC8ZI19pVjarbFxVi1S00GQf7
         iJ5Y/k75TaJ4UovcSPQ/LnLViV4BcGssNlaPTTv7/i+oB4u9D21G3WNzZ4at0GIK5t3v
         Ggbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bKHACVXIFtdB3STW2PakBcJYhyXM+9UIqdBfEUhdye8=;
        b=J4mRdMvPLHgTn4AfS13mPCzjU/aFMHzixn36lXuMt6gpdQ8amZIvuRvOcmes2jfCdk
         JlGzd1S8roZeJX6vdpgoeOr8HeYUP/999BxM53aswrgEGMdkbyT+j+PWSPlswYfqpxnX
         cWXNGPQApks9a9uzA0r6OZsVtWKs9kK7vPjAJQpFGXphWQ5nFxixs67QL8CBVtPmrKwH
         p3zpepwz/RerP5oHUEx1/wweA7JWHQhBBDZa16IZ5DJ2JQ8E3T7gsDcdpaF2YHQM60vV
         VRVYzd+usJe04mMwJggOhlKLs9M001n4xSv4zvAVzaiUswm6bHBZjrMPLE3exB49ehP3
         f8wQ==
X-Gm-Message-State: AJIora8+iRXLrQPYQekukQcPUleRiufX1gEwiq5F2Nkp8Y5+0xBqNruv
        /qAqSaKkPM+IZtmXExXzMolH5KFJJMM=
X-Google-Smtp-Source: AGRyM1so2vgsbVn/aWmcCuHPblFIE9D44DIPLuwUSii8ZZ/2DMwo+8P3iasLsF9L0VC1G3ZJNGVVVg==
X-Received: by 2002:a17:90b:4d8b:b0:1e3:31df:c98a with SMTP id oj11-20020a17090b4d8b00b001e331dfc98amr46087846pjb.175.1655851492199;
        Tue, 21 Jun 2022 15:44:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.139.60])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0016a087cfad8sm8810254plb.264.2022.06.21.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:44:51 -0700 (PDT)
Message-ID: <62b249e3.1c69fb81.30094.c3a1@mx.google.com>
Date:   Tue, 21 Jun 2022 15:44:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0564716482051998011=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Enable acquiring multiple transports
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220621211221.2382613-1-luiz.dentz@gmail.com>
References: <20220621211221.2382613-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0564716482051998011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652512

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       PASS      0.55 seconds
Prep - Setup ELL              PASS      44.75 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  PASS      1393.59 seconds
Make Check                    PASS      10.92 seconds
Make Check w/Valgrind         PASS      466.88 seconds
Make Distcheck                PASS      251.43 seconds
Build w/ext ELL - Configure   PASS      8.76 seconds
Build w/ext ELL - Make        PASS      1379.13 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] client/player: Enable acquiring multiple transports
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#94: FILE: client/player.c:80:
+static struct queue *ios = NULL;

/github/workspace/src/12889833.patch total: 1 errors, 0 warnings, 401 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12889833.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0564716482051998011==--
