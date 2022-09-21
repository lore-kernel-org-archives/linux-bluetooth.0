Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C373C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 23:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIUXMl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 19:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIUXMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 19:12:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD5A6C40
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 16:12:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g12so5236377qts.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=2e7AiLnpA1O/gwsQZWagsBGM4apnyapH6FiwD6OKEoo=;
        b=nl2duokrPCaY0lS71wuTqeeuFZsVeqtQingspcFlEmo7Lfs3s7QYivWZicO4n3ACNq
         O7tV+yV9NMMIVp1O+Tdvl24sX1FN/e+tU78bGf8iZYEvc7mIPhwBgU1Ie8a7zhjpVLn1
         P8/MDINkfv4JLJHZ5WDcJWIU1gPl1ID/6G3P/mPxoSh1/XkwyaphBSH8gMNrpvSVmaTm
         +nUQ3Wnfmd/l4HXvRpLB5Xfek+bUIgS+TakeVmTcHVg7ACH1hutAM4e1hVxHPPBMQ05Y
         ExhCojW/dxslVpPsnaEvRDIW93JuXNFTyTRQv0n5Pjc+7Z5MmdJh0pNQB+JcwcRRYzvM
         G/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=2e7AiLnpA1O/gwsQZWagsBGM4apnyapH6FiwD6OKEoo=;
        b=OsviXElXWvjVHb7AfRl7T7VIA45HnUruJK144YjU3Sbbk8GAjR12jgFYB4rxI2vIRZ
         lbO72z1pFa2XNMcgSrqf8yzwXa5zGPzWU9GytQe1pdfzUAfv1EfBScTt2SVF6OME9dPQ
         JY2x13sgIbrfyrz7plzb3K9nybleojmmNCYwymfINuJH3yT/K0g2N3dFOeBVk+K5xFlQ
         hz4Jk0OZ6gch+/IdWmDSTelP9tIzZKr9EdlJ1JZ2f/qabUnBNCMgvWUBlKBnCO0qeGHd
         //dxHGFYgri6KU7h/EpBnzdgD56JkGjUMPnM7EfadcXGr2gM9Gy66oL2Z4Pnt/JNtS8G
         RZgQ==
X-Gm-Message-State: ACrzQf2PwNnuNqXVT9MojC0y3CsXAkrXYRStlr5ExmGtwHgp8ANejpzY
        RO/wLKNx4b6ed1hUmkiQXfg+mEW0oGnTQQ==
X-Google-Smtp-Source: AMsMyM5sruxQ6sVxODb78t02mcGOOjRSRnsHI18vhqTlagYXNrUgH3krEyGWy3d5OrsWOtiQjoAADg==
X-Received: by 2002:a05:622a:13cb:b0:35c:c00a:6b31 with SMTP id p11-20020a05622a13cb00b0035cc00a6b31mr657403qtk.322.1663801958526;
        Wed, 21 Sep 2022 16:12:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.146.41.128])
        by smtp.gmail.com with ESMTPSA id u2-20020ae9d802000000b006ce407b996asm2690697qkf.69.2022.09.21.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:12:38 -0700 (PDT)
Message-ID: <632b9a66.e90a0220.4b2ca.b3ba@mx.google.com>
Date:   Wed, 21 Sep 2022 16:12:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9204702917864371699=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-db: Fix scan-build warning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220921215342.2263924-1-luiz.dentz@gmail.com>
References: <20220921215342.2263924-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9204702917864371699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679177

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      1.14 seconds
Prep - Setup ELL              PASS      28.57 seconds
Build - Prep                  PASS      0.86 seconds
Build - Configure             PASS      9.10 seconds
Build - Make                  PASS      1056.77 seconds
Make Check                    PASS      12.48 seconds
Make Check w/Valgrind         PASS      306.51 seconds
Make Distcheck                PASS      260.10 seconds
Build w/ext ELL - Configure   PASS      9.34 seconds
Build w/ext ELL - Make        PASS      91.15 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   592.37 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
src/shared/gatt-db.c:725:5: warning: Access to field 'handle' results in a dereference of a null pointer
                                service->attributes[0]->handle == handle)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============9204702917864371699==--
