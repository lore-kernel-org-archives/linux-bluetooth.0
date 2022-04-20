Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273E4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 21:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382500AbiDTV0n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 17:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382498AbiDTV0m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 17:26:42 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542648881
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 14:23:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bb21so1970124qtb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IATZNkDeVFn/PRIjkPI0TNKSh2DzVB6WH7EpKbf+cXI=;
        b=Cv3kLMjy8l0/ldOihAZw7934Ubi3RvzOzMgibUhH5tgt+LpbIk3eaJXz46UhajwLdk
         L7130Mx1qwQeMGLiQ027sA40/76Do1FOZivKJ283RRKdCBv4jFUhoAgVKeuw/4QuJdQl
         sarllpvAAQL6YMYjkKq1Achq7wDnMNJ2tEq/lLC4dmM03R0wqUogU2aQM0yCAYLQPwvF
         ekwFNAONZw/XBhwdM/qAQN4g1cAxCdBxwJY+iAAShUnN2CK4FtcWV0Zs9D18ybE2elHs
         Oj3TRcVii607Pjxbz4HZZpKn4gbZo1W/ia0llBRgUClRjht0AjjyJ6Z5I7M5JvVLqWgY
         ttbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IATZNkDeVFn/PRIjkPI0TNKSh2DzVB6WH7EpKbf+cXI=;
        b=wIuh9mXdN3iPusVB5fu6aFC41AaJg+H/8WOUbtKoWcPSnQcdpJ1czu1n1HCzxTUise
         RUEGg5b/JDk/XzjdDQ6+7mnlylLHIqY8akafUU5EQFJWgYz5ps39oXYS5jBwX1SOLJJB
         LtX72cp/NxOEoCJnxKEqL2DCGGZbQOwBwBBtgv7JwdA2dZxB/GqSnPzj3pQ5sKs1dtLk
         eXwBMyHfkuiD7juvsdwT/Z06CkYzzPyVc6yYOjsB13N+7xporaMZpi7Z9B1yLemflznb
         Sd0loZO2Ywxu4Oq9rZDeMbROwaSCzuQxf76l5jVDJjiGhs+ABLwBncqEd3LpcKbVzY4O
         W03A==
X-Gm-Message-State: AOAM531PINOQMiZgs1XBbOAXmcGnHC+5LwL5IkIGhPGj9uw6BNAFCbYh
        2JftM7YVlP7RmooPHjenvN9dmoavYnLtOA==
X-Google-Smtp-Source: ABdhPJwsTmO4dPeMAM8UyL2cVXbWDYWALlBfgPLl7kM90mcuv8aC16BIoiMwxyz63WNpzBuw7R2Tsw==
X-Received: by 2002:ac8:7c46:0:b0:2e1:d6c2:2b15 with SMTP id o6-20020ac87c46000000b002e1d6c22b15mr15235795qtv.405.1650489834955;
        Wed, 20 Apr 2022 14:23:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.123.31])
        by smtp.gmail.com with ESMTPSA id t12-20020a05622a01cc00b002f204a559a4sm2386480qtw.53.2022.04.20.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:23:54 -0700 (PDT)
Message-ID: <626079ea.1c69fb81.c8e68.2613@mx.google.com>
Date:   Wed, 20 Apr 2022 14:23:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3487161249284201561=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] hog-lib: Check if Report ID is set before prepending it
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220420201437.2855806-1-luiz.dentz@gmail.com>
References: <20220420201437.2855806-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3487161249284201561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633916

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      42.85 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      8.67 seconds
Build - Make                  PASS      1271.22 seconds
Make Check                    PASS      11.98 seconds
Make Check w/Valgrind         PASS      444.82 seconds
Make Distcheck                PASS      231.22 seconds
Build w/ext ELL - Configure   PASS      8.82 seconds
Build w/ext ELL - Make        PASS      1263.07 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3487161249284201561==--
