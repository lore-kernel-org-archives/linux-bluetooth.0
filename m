Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC7C28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 14:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiAZOHW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiAZOHU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 09:07:20 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C6C06173B
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 06:07:20 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id w8so14906031qkw.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 06:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yArE1wL8Ek1zMRT6o6xePTc/WONIO2l55R0GT/+YNKE=;
        b=jy7+e8qmdL0/yio0kjaSS/5S0DcMgW9IQ+6INZfuZx7362hXuqLZXe6KC9rOIZmHH+
         KJqjYR2dCtvWAt//Akm2uPxmDghbivdJgSDuCMK3iCJ11aWVMll1aXl6fkEJoJTDAKKF
         GtBzr7NMjE6OKhxanFrDOd6ceS3pu9vSjDvuaITn9KFxZyTxxUMUQ/WT6qSO1BXYRfqf
         +rgQ+OQWHuwMIrJL/ilNKhoLzGlj28fV5LTSjHgeWDoBFZX5PUqFA8Vb7HOgUf8d2dcy
         pR07U/AFSK9ylpjrf4etg2ibdTyrgVcRS1Ko9P44CotJe2aWx8hc2pfaf/sLMvZw6510
         mJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yArE1wL8Ek1zMRT6o6xePTc/WONIO2l55R0GT/+YNKE=;
        b=EUGXftN7mLv70Xcc7hisfHZsHklr29BPt2TpXaIoFfY/zmOcUCxDQ7qkwM9vPx/wXa
         g6Hy/bP/eT+cjzeeRL6b8BZKGPBRHnYA7ZpRaUUoYrPM3XUcisLRjMuu7dccLz6/LP4b
         PYGchDEFheuWmis93ISc8clALRPqC/GsGfZNrwj6cuJ8zJ+3QN8cQ1UvNkr/1AGpmmsh
         EE302+TDrW+QrgrBYJapJMgU1FH9a64Kt5VLfjbzODkGon70gvzouHKcxIrZusYJIQTr
         tp9ZDv3myuDIa1VObkp5w3DsJJOGfjNqd0T+tujr0iuB1zXA2/oU4KpfW1IRmwb7BAO5
         AA2w==
X-Gm-Message-State: AOAM533Qv/it8orYP77phkVdQMAplsM59i/jkTo7NH0ep0lsiLy9QKxz
        3PyAp6nazGLNOw/+K9LATi7aFELidbRVHg==
X-Google-Smtp-Source: ABdhPJwxTIiEsJJZnIEsxO+KheoiAGn+QIIwaCDP5xoWHifvSjhqCduCPPs4FjrRuUJo42SrtZGZKA==
X-Received: by 2002:ae9:c313:: with SMTP id n19mr18354206qkg.507.1643206038860;
        Wed, 26 Jan 2022 06:07:18 -0800 (PST)
Received: from [172.17.0.2] ([40.76.8.47])
        by smtp.gmail.com with ESMTPSA id u14sm10539484qta.31.2022.01.26.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:07:18 -0800 (PST)
Message-ID: <61f15596.1c69fb81.ba6f2.d20a@mx.google.com>
Date:   Wed, 26 Jan 2022 06:07:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3670236194414543350=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [1/4] build: Always define confdir and statedir
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220126113638.1706785-1-hadess@hadess.net>
References: <20220126113638.1706785-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3670236194414543350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608628

---Test result---

Test Summary:
CheckPatch                    PASS      5.68 seconds
GitLint                       PASS      3.84 seconds
Prep - Setup ELL              PASS      41.84 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      1292.67 seconds
Make Check                    PASS      11.33 seconds
Make Check w/Valgrind         PASS      448.95 seconds
Make Distcheck                PASS      231.67 seconds
Build w/ext ELL - Configure   PASS      8.74 seconds
Build w/ext ELL - Make        PASS      1305.94 seconds
Incremental Build with patchesPASS      5303.63 seconds



---
Regards,
Linux Bluetooth


--===============3670236194414543350==--
