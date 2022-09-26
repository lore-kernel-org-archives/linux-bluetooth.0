Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC1C32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 16:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiIZQ6H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIZQ5w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 12:57:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A12C54668
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 08:54:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d11so6619796pll.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=9dA2q93Py0ZODP0TMAaBQp1gLdJ2hCsmQf04ujEZ9TM=;
        b=DAauvrH19D6REotTcUcpDkklAnUH8OGDtp2Oyf4z9qLAu3F390GUKyjOGriU2GTWUp
         exL7QnRh04icM+EF9aVZOjxQ/ZbV9HC6zmxUw3adhpXEVWBXtAMj8mYCwO0RqLYn+lf6
         Y6XfnT3dMgtXLMSufpBjq8CYYaCVuvfoWaan9zpuaSmeCdJdV30eILc/vsqbBiI2Cw6T
         pH6T3bRPU3WnldQKHIXU3h41DR/1FTqeSmh5Y0BNk23EUE10+VjcvA91wVdFjW9o3N1C
         3Zj1qB73ZBzpJ+n2+GQoV4FWOUAHzdYtW5uFqdBHPrDxt87pYNOt4IPoriORg5VZ8S8b
         9svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=9dA2q93Py0ZODP0TMAaBQp1gLdJ2hCsmQf04ujEZ9TM=;
        b=2DpSuHd+f2qKyOwgb1ac8Hf+Mc/l0ZtqBZiXJHx0qBmwnJLS9jJ1aYg6DIIJQiEgCB
         6MBMu7IDOQ3j/8gLiBBUsOnQg+IsUP39+r57+ru/JWDYUKNRdxV1gjE5qlbiT/q6MWqH
         fJy/CoIEGLUx9+wWlLv1ULj8/Y8ITInV5xwMj3pmZtbB1WFCBYePuzqr3jTXN3e97nOH
         0HsbBVS9ZTQTqAMsTXvXQUdWRmT46UQ+3+ohr0gCNJPzyE2jEB21JkYNaKNQhLaZEPoM
         c4deGLn23/lGd8rN0Cs7SBDMuhNvuInGSBWRS7M5SXEZ4Ib7t9vzPASskwgdSfpWCC6n
         WWAw==
X-Gm-Message-State: ACrzQf2ZylZ2CwSeOiYQ9b2l/Zz+WdmZDAjEoe5i/v2T0d0mGkSULbxp
        VdoSKxbRLEiYZD2XW+OGCTVHnAN821vHrw==
X-Google-Smtp-Source: AMsMyM5OD95neDb6rggedyaLqCFocW4saIGaDVnTY0wlE3toShiLHTW5rMPG2pdXF9mNYvO67xWfHg==
X-Received: by 2002:a17:90b:1c07:b0:202:ff6e:6015 with SMTP id oc7-20020a17090b1c0700b00202ff6e6015mr26139799pjb.210.1664207644762;
        Mon, 26 Sep 2022 08:54:04 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.166.165])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902684100b00173cfb184c0sm11417485pln.32.2022.09.26.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:54:04 -0700 (PDT)
Message-ID: <6331cb1c.170a0220.2d0e6.4cbd@mx.google.com>
Date:   Mon, 26 Sep 2022 08:54:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8062655555653478485=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@loytec.com
Subject: RE: Mesh: Fix heartbeat publication/subscription
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220926130110.2146-2-isak.westin@loytec.com>
References: <20220926130110.2146-2-isak.westin@loytec.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8062655555653478485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680522

---Test result---

Test Summary:
CheckPatch                    PASS      3.06 seconds
GitLint                       PASS      2.07 seconds
Prep - Setup ELL              PASS      35.30 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      10.94 seconds
Build - Make                  PASS      1231.41 seconds
Make Check                    PASS      13.40 seconds
Make Check w/Valgrind         PASS      380.05 seconds
Make Distcheck                PASS      324.29 seconds
Build w/ext ELL - Configure   PASS      11.27 seconds
Build w/ext ELL - Make        PASS      115.80 seconds
Incremental Build w/ patches  PASS      538.07 seconds
Scan Build                    PASS      738.03 seconds



---
Regards,
Linux Bluetooth


--===============8062655555653478485==--
