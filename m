Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D1C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Sep 2022 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIYRgC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Sep 2022 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiIYRgA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Sep 2022 13:36:00 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED5107
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 10:35:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 138so3572679iou.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=x5d8c1uGZ5nn+vRnZGBi4v7rl0UDpjpGM7jjFqis52w=;
        b=XUg6HYoAE0jhw7h9F36mmNVFMdLwCXkK4iJraD7BEOvi2Y2UzvNqAjYfTVa4xzFzH6
         WBBgCkdT6+L4JPZ2PTLAeev8RD/gNdMyz8bh3ks2C1FOwvNvGcYsBPMmWZpIyfZ8t8rx
         QGlqO0IAdvD0t9tSoHJtCBfOe04RMM7roGCq1x1Uk9nFpv4sPNZUPpJiRY1Sx3pnVwjY
         3eUhgxJA/clUSzj7LKi3SVTZbynrCrP4BcLxykN5ZFnLtB02U0zjQQ1BfgpPQagNzlyL
         taBPrj1Ce5cw4yr4wN05+Qo/96pvXd1IBjhva0lVc+qtgPsQEhfN2Zfl7J+hnsOH3jA5
         iOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=x5d8c1uGZ5nn+vRnZGBi4v7rl0UDpjpGM7jjFqis52w=;
        b=6zxWB8lAYQzyOaF0Uy0HbThqf57MpqSzEFl/aZ56vlmwOiYTJrXHAKkfEY2gYkLoGs
         OAiXpIMcrVfacYG78iXH0xbGNtQPfjf9N3f6rhWCV4U2TubTMtP275alkGtjxNkxQTmX
         n4sV7VbXIn4X2CM+mu+A7ybYgVbLjbpHvpHaFKapfUaTfiE5Jo+Ozrod8mHmgexaX1NM
         CaCtHM8/Acl8GxK6fZjhdIPDvAXjWpPdf3Y6zGo0/ZicALci3FD2W8HxeXuXTYloBeqR
         2reXRYF66g5QkLDfE2SboOtH8aKHaoZNdxTBaWkkU0ZcdHovz7Lv+gAiBEGQ3UNW8Lzs
         OvdA==
X-Gm-Message-State: ACrzQf1yvVURnP6K2tU7t/jzvlH8SAEFd5rq5R9+xnQGaZfd9/EvfMsD
        ZjX5cYzyXdIRC9ygbq/btxxos1qCcaE=
X-Google-Smtp-Source: AMsMyM4tzD0Zrh9syS6iF0yL6vy9bRnFAMN8DqqTf+sD9Qq9LjDAWJTvmsNyqxydAu8YUsuP4aPwUg==
X-Received: by 2002:a02:cc53:0:b0:35a:1885:92d2 with SMTP id i19-20020a02cc53000000b0035a188592d2mr9562157jaq.242.1664127358506;
        Sun, 25 Sep 2022 10:35:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.44.91])
        by smtp.gmail.com with ESMTPSA id x26-20020a0566380cba00b0035b2f0ebf65sm4204369jad.76.2022.09.25.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:35:58 -0700 (PDT)
Message-ID: <6330917e.050a0220.962a3.439f@mx.google.com>
Date:   Sun, 25 Sep 2022 10:35:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0377889347251808004=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, i@hexchain.org
Subject: RE: [BlueZ] tools/mpris-proxy: unregister object path if player registration fails
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220925163139.194382-1-i@hexchain.org>
References: <20220925163139.194382-1-i@hexchain.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0377889347251808004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680261

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.80 seconds
Prep - Setup ELL              PASS      26.66 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.31 seconds
Build - Make                  PASS      761.28 seconds
Make Check                    PASS      11.50 seconds
Make Check w/Valgrind         PASS      290.45 seconds
Make Distcheck                PASS      242.20 seconds
Build w/ext ELL - Configure   PASS      8.36 seconds
Build w/ext ELL - Make        PASS      84.93 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      493.69 seconds



---
Regards,
Linux Bluetooth


--===============0377889347251808004==--
