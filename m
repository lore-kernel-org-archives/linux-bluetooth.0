Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbiESWth (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 18:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiESWtf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 18:49:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0428292D05
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 15:49:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a38so3391908pgl.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=l7VtsUQjBYc2l6xvEK1FXkSWaD4fIdgNmZ+jKUVujWI=;
        b=ZwNGqSueoJcuiwh47rW6H0UrGCAjsC4w9CqswHOG/sZbXH73kJ1XM52S7trW6XW6dk
         /o5K6i5AC/2vXlkoUZ/JngH4jVGUKtifmy+mvqyjDxWa/REDyYBSCntdOXkUF5OZdVuX
         g0fszMrRz1ZSXb3CMJdr6OAEHeUg2ywliPnF5+ZNjTqjl6QZEBBmGiGNiYWjLp7yMRl6
         JlLyvWEKCPOKX37KAST79SpapB7dM22GoF/+vbtb3DEd3HNgZ/7pN96Ja/0G8hKsGaU9
         44udaHyWGf+II4XhNDQocPdGCETeOdg/WjhEDQMahyJ9J1r/VwjUZrxEKqnr7I1xFBuj
         jOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=l7VtsUQjBYc2l6xvEK1FXkSWaD4fIdgNmZ+jKUVujWI=;
        b=f6l/VaJWZerElqCmwX9VjZyEoBIxQWIXrbRp+EsQhxY5sCTsEllEhk4fe7V45+m0Bj
         Z1ZQWtqiNV1hJSz2TiglTRwL9QmH0jG2KKotSPumGJvGBoRqSO1bMViOsHj0tuQ+PZLU
         +COFD9qeohnEifGJxrXLQhPvULY1i/HgtMlZtOSNiIEnT1t5kNLAhCFSEjpPUtsNkFHf
         hfmeUoOj00VOeXRbO/wRDmQQqNaB5ssTCI98OYrBiLPmOuYWRDpgkrbeVxvIbJOQIYk/
         EZdgcXE1pcEV7jyxlfMg9rZ2jqxaQTxRHwmHNfYZuOWB8OF08nqd0OVW9c7WxEfOymKM
         HTxQ==
X-Gm-Message-State: AOAM532hGfku2P12s2X1vi2qeDvUbgkJunm9gdsXV1lA8z+fdK+giDwl
        vHPQyuLghZHxbzNid0idxyPKbdvdkVc=
X-Google-Smtp-Source: ABdhPJxuVYKjp/wjQiePO2CMvtXomhxAyvuDxyHcgVf4mis5M7BWGpStH/hJe3snyALx/5xb6lY3oQ==
X-Received: by 2002:a63:bf07:0:b0:3f5:dca9:d200 with SMTP id v7-20020a63bf07000000b003f5dca9d200mr5642437pgf.530.1653000574194;
        Thu, 19 May 2022 15:49:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.237.216.115])
        by smtp.gmail.com with ESMTPSA id a133-20020a621a8b000000b0050dc76281e4sm178031pfa.190.2022.05.19.15.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 15:49:33 -0700 (PDT)
Message-ID: <6286c97d.1c69fb81.976c3.0a8e@mx.google.com>
Date:   Thu, 19 May 2022 15:49:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4820197741145870085=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt-server: Fix crash while disconnecting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220519214002.2525857-1-luiz.dentz@gmail.com>
References: <20220519214002.2525857-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4820197741145870085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643344

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      52.05 seconds
Build - Prep                  PASS      0.48 seconds
Build - Configure             PASS      10.03 seconds
Build - Make                  PASS      1455.43 seconds
Make Check                    PASS      12.39 seconds
Make Check w/Valgrind         PASS      526.31 seconds
Make Distcheck                PASS      275.38 seconds
Build w/ext ELL - Configure   PASS      10.22 seconds
Build w/ext ELL - Make        PASS      1424.75 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4820197741145870085==--
