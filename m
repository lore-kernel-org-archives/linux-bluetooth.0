Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB157C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jul 2022 07:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiGHHGL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jul 2022 03:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiGHHGK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jul 2022 03:06:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A374174DD0
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jul 2022 00:06:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bf13so8579867pgb.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jul 2022 00:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Hnjcy2N8aix+AlvW2g9z1HVGswGEarzxsZIH3ouX3gY=;
        b=p9heR/N+nS9zHVjAOD16TwUKoKSBG5W1gZOGyw2ybFppRGAb/C3/MlUy5C2J2pvl2d
         vFu1UmEXAWitvGI7+u2Xvw5/ZDan+FB51cmmh6peZgljffPmJrgv238gJnQMvZXqoEYr
         OX3L7/AZd+Mpw6IuCtQaK8oEqCIAUsqTEpx36hMZBmIKcdcPV5Snmtp5nJZnjHL2wPYo
         NhzDYa/pHhvbe7TzTBBHDe5Zh7r8JqdurTBp7u3/eCIqJ8N5fakJyhFPB7VRiskD3zz2
         pRWa4zavkNN+SCUbcpDMEXIhtK50k//DqztmZ2X2L1ZHTkGBG0k3iLUXxtdrW+dALoCE
         tbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Hnjcy2N8aix+AlvW2g9z1HVGswGEarzxsZIH3ouX3gY=;
        b=G4ziUih/rfcQC2AubFnrtSlqc/NqaCX2XmgbK6Gum1zvPaaCFkgwSu7CkiaJXWy5EG
         9tworJTSeBP+zxLsaTk4SHKHGsawB89iLXG/5WYntmwtds1bqXpZ0gaan4XljreNfK5k
         A/YUQ3CHj0TXgdfNh3HHgyMm90G3f8O/Gt7Z16cAHxE5goCLw2K8jDosWT9yK/4SFLxE
         /MR8740aSecy+Tcft41nIx0UcGJ7S7sR+u6VRDrMZyWKZw8GH9phG9s2cUGrTDPLx4yM
         ENAITid+iV1JvJZktDh66U+2nRc6Mi7Pkk95xnxRh2MA750ZUtYMTXaP22SCcreS3iEZ
         gyoQ==
X-Gm-Message-State: AJIora9gqgCA3LKBDJcmNdPgOJtmycWldho169e0SXdjo0D2vH78+CYv
        Dwol3+Vx9WTm1WDxWvmxx27uPW55Nms=
X-Google-Smtp-Source: AGRyM1un5x/IO5AH+2Qz0eUSStAQ4toAqDZFistnu2ct8s8amQ0IUWUP3I+N5BhxGoAX2n+WJNXdhw==
X-Received: by 2002:a05:6a00:1908:b0:525:5dad:cb1c with SMTP id y8-20020a056a00190800b005255dadcb1cmr2462950pfi.47.1657263967731;
        Fri, 08 Jul 2022 00:06:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.185.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b0016c0593876csm4381593plk.157.2022.07.08.00.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 00:06:07 -0700 (PDT)
Message-ID: <62c7d75f.1c69fb81.a941b.6e8d@mx.google.com>
Date:   Fri, 08 Jul 2022 00:06:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1621323939862982803=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: fix crashed after cancel the on-going transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220708062548.31167-1-wangyouwan@uniontech.com>
References: <20220708062548.31167-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1621323939862982803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=657710

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.51 seconds
Prep - Setup ELL              PASS      25.86 seconds
Build - Prep                  PASS      0.57 seconds
Build - Configure             PASS      7.95 seconds
Build - Make                  PASS      733.51 seconds
Make Check                    PASS      11.12 seconds
Make Check w/Valgrind         PASS      280.38 seconds
Make Distcheck                PASS      230.86 seconds
Build w/ext ELL - Configure   PASS      8.03 seconds
Build w/ext ELL - Make        PASS      79.35 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   483.63 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
gobex/gobex-transfer.c:425:7: warning: Use of memory after it is freed
        if (!g_slist_find(transfers, transfer))
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============1621323939862982803==--
