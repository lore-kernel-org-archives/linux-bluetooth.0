Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D33C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jun 2022 09:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiF1Jie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245734AbiF1Jia (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jun 2022 05:38:30 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2210BB
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 02:38:22 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id o43so19173406qvo.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fIQEqArhMTa5DhDz31Bmp16FTzyQJ6gwcvcM6vxzCNg=;
        b=gZ+xzrauKSb8GmiwH3yv/NF1dAdXa+BU6BMrVSeGlnLG3jk9SIYN2M/HZEGWOIQYIi
         mb6Fb+5/7MHlf6vR43PLK8jiwCgwcZ1PqUOOozStlegmBLgvtTd77AwtWacrdv1kKp3h
         HMDiZKZykiJgs1jtqOHJkqFu2inYpor5/oGspRWETrxyeeG1ZmIWOQapmBk99/N0aUAE
         cF4NZMQXSAC6rQNNTugD3/OgUatQYkmKeuPRay6lRoH2FSE023gC0hTlllijUwHWTxJW
         AtlnRe5lAMUFKVHs+mW/cpqzVi+hBA2Bbb03fBfw/KSt+NQoRgZhdK8tLsInCS8Fb97f
         uu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fIQEqArhMTa5DhDz31Bmp16FTzyQJ6gwcvcM6vxzCNg=;
        b=3p9J5F/nC+8TQgvSXO4LRiT29qZpjgRMnAVTWAg6kuPbGcQ3OwjOFSc9wIVOW+9xx4
         TJS00Z1iQT/iGqy429/GshkEo9O/vm/oypg2q3WSHR6oCwWid3At518Gpnf1V8qZFXr1
         X1m8/qUh0Bg7+ULVwcxwqAEmMkDKpSz/gtdDcdA2X0XtBLR5Z8LBDtb0q99k8sRQhmlh
         hs/RUJkuzx/4/R74ooPe6cGVbkER/psuG4fF2xih6MJ/1ibQuy5YHVxj3qnQiX6icQmp
         Ib0cI1HUsAuVXcmOonZhIPdJIBvp2y8ZZVm1W8OdES4cRifaBlqZM2k+N8MSPD4LqQgu
         VHuQ==
X-Gm-Message-State: AJIora9L7+EzWojZkMgGdMzyoKQaiCDBiv4fY+ox49PNzuaCFcvFX7CZ
        fHcPBiwQLymKwQa15tLY2X5UuW/zsbY=
X-Google-Smtp-Source: AGRyM1vrRR7vm0RYUigfJti8HWptCoi97JFa5SWvqgu7/TGw0SCzc3+F1fFbxRzifzMraaQpB/C1GA==
X-Received: by 2002:a05:622a:2cc:b0:31b:f484:768 with SMTP id a12-20020a05622a02cc00b0031bf4840768mr660155qtx.304.1656409101831;
        Tue, 28 Jun 2022 02:38:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.112.50.251])
        by smtp.gmail.com with ESMTPSA id m187-20020a37a3c4000000b006a75a8fd54asm10364684qke.84.2022.06.28.02.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:38:20 -0700 (PDT)
Message-ID: <62bacc0c.1c69fb81.c9c62.3dfd@mx.google.com>
Date:   Tue, 28 Jun 2022 02:38:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5134583205466333798=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix obex pointer is not null judgment
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220628074325.17105-1-wangyouwan@uniontech.com>
References: <20220628074325.17105-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5134583205466333798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=654468

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      48.67 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      9.53 seconds
Build - Make                  PASS      1402.89 seconds
Make Check                    PASS      12.73 seconds
Make Check w/Valgrind         PASS      500.51 seconds
Make Distcheck                PASS      264.83 seconds
Build w/ext ELL - Configure   PASS      10.05 seconds
Build w/ext ELL - Make        PASS      1409.61 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5134583205466333798==--
