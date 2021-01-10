Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94224C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Jan 2021 01:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5710E2085B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Jan 2021 01:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAJBr2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jan 2021 20:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbhAJBr1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jan 2021 20:47:27 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C0FC061786
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jan 2021 17:46:47 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id m23so14099530ioy.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jan 2021 17:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0s4ewikVocAXcxSB55Dctnz7AI4m9QCG3kBiiOSxYZk=;
        b=gafxmFTxWLatvcjL781VpJl3SzL7U1uvRB7RUNlZN/glSXrcEl7HJ84DptkzpMYYCP
         7RJW/40uA716jn7Z+ErEfy8429qSNvQlzuNS/0JcO6Rxf2Rk27hiIQ/TTMaETeAUvPBo
         w/AJEJ0znB2aUqTAgVt6JkH7q/ftV29PPcQRhWMQ2/gZh/UUlkq84qpf+UDyDyj/khSK
         9eNhpUh+37qu8TWd60k2DQ3gPnOGEE+dPkVtBTuEzU/lnR6m0vFIaPaJKnKdP0wLf6Dr
         mLvMjKDJvsHOlrKiAyjXC0s6ItMU5RpPClCoqkpBMZgJg5tZFH85BfNaQTu74rKIGOHg
         GnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0s4ewikVocAXcxSB55Dctnz7AI4m9QCG3kBiiOSxYZk=;
        b=P5MDgy8SUyM4aD0YcH/L8a2Trr8qks+TbQ5uzah4TeJkks/RZVfSg2pk8AE1OLpX14
         /zMl0vEZuW/Qk5YPE9rXMxHcOC6whP+OglMptci54I21Zn1UQOZ+p/htVSxpBZShHUDY
         jWtM5emuD8T/mGVgw3zg8qerY0j4Y92O6jlcdhpe7flNxXuWN5xigT4neow5VI9XG2mL
         Of6wmMqROH8HS3QHaig/IuKI7Jl3wPsUHXjT1gmOp6V/f7CH5WI5xGAeOYDKFBfu31B5
         oIUzi0MUd7WChEIaUJ2znRmPbsUDTFukMJy7tCe0lQsKWLkQNanW2snlH4BpAm3R3Ud0
         nGIg==
X-Gm-Message-State: AOAM530KvR0yQqPqYoOVlzFWqHjHDrr9e5bo9DJH9eagJd1pPHSob6VP
        jvC+EOvA9XrHWpv+DUKWZdNTqrSQRIQ=
X-Google-Smtp-Source: ABdhPJy31f5U1JfLYegGx7dF/I57+6X/jhF8aVIDG9WqOAQr+Anquqz0pHSWGyakfcShRUih90l/cw==
X-Received: by 2002:a6b:f112:: with SMTP id e18mr10600772iog.195.1610243206613;
        Sat, 09 Jan 2021 17:46:46 -0800 (PST)
Received: from [172.17.0.2] ([52.177.200.120])
        by smtp.gmail.com with ESMTPSA id w1sm8312839iop.50.2021.01.09.17.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 17:46:46 -0800 (PST)
Message-ID: <5ffa5c86.1c69fb81.d5aa2.5759@mx.google.com>
Date:   Sat, 09 Jan 2021 17:46:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5853786599217028326=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] input/hog: Fix double registering report value callbacks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210110003033.2528-1-sonnysasaka@chromium.org>
References: <20210110003033.2528-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5853786599217028326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=411857

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5853786599217028326==--
