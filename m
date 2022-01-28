Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925E8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 10:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243813AbiA1KMt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbiA1KMg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jan 2022 05:12:36 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B187C061714
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 02:12:36 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h25so3837702qtm.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+OzlJ1bzlA8mQyFyrpzfarWukXVj6S3QRzFmjG859x0=;
        b=X09KAPwVfyL5ni0zpjT0vo4ysxvF322A1pvtcV/SLMfi0Qhw02Dvu3HQWBUpIisBnd
         QFr+mQ2WfcGrvpMAK0i9PDVCoUzeGKND/h8sVvSkDBLA1r1qYeuhgbNfdZGvicQEZZLD
         ZL2Xo2KdfgsKAS+ToPkKIa+w7qm4SgUMEoTdDFBAsCZkWZKjYg3AnObRipBpWuUfmZYc
         A3HZLxhXa53LPqnwzh6M+7AzLuuCM6iuBbzx4GP+xYsMLUn/BVeCdPPiPd/h0V5P+TXZ
         AXsVid6JeimuYfGxjss/RFJDpw2waxFTPiQucI5jWC85WOi1rgcaohjw2Zj+kyqoNfS+
         dS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+OzlJ1bzlA8mQyFyrpzfarWukXVj6S3QRzFmjG859x0=;
        b=BtWkl1pshjVLjhuRbBXs+wDpicvPIrxK2BazmRTDb06PVhPJU8CAo3xi8T4+Im7Cul
         80gq20gG34A+u5aeWSPybFQQogmbNHvj51Ne6ESTNtK4TtQtguNLiLA9JqE5wqkBBoPh
         3SyGBDGVwdffwdsreYGOcFPfyfHco0esXoRYMJuiGi+SS4xn7LMDKDC7VzmlEpB6iIcH
         bVbiMOg36Aq8JPm/y97ZWvvqlTd/zxOWJqDu6S0vx/qzcqALsWBCiBJVKKSEZc6t7ndt
         qI/ErGIN2rDFM01lopCf0hxKtahjQSGhdPGIop9Vk68W0YCZJyqiLYI5wA1ywOjefnBR
         GoRg==
X-Gm-Message-State: AOAM5303ZZzJ3VrnVYTd2IenqMCwhhLYtcW0Wy09bLRrevLoRHwbtJ/Z
        HT/oyDG1KRDqw06FueG5xG0D8SR4DP5qiQ==
X-Google-Smtp-Source: ABdhPJzEnxQTSqZay1V0GE+cIepBESCotpFSR5+BfGgp3qArUSzeo888+8yqqYD77xqmkzAN8snLkA==
X-Received: by 2002:ac8:7fca:: with SMTP id b10mr5426806qtk.427.1643364755334;
        Fri, 28 Jan 2022 02:12:35 -0800 (PST)
Received: from [172.17.0.2] ([20.127.114.135])
        by smtp.gmail.com with ESMTPSA id s34sm2714739qtc.88.2022.01.28.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 02:12:35 -0800 (PST)
Message-ID: <61f3c193.1c69fb81.b9c21.c64f@mx.google.com>
Date:   Fri, 28 Jan 2022 02:12:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1229678802776899720=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v2,1/4] doc: Add Bluetooth quality report event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220127101609.3646316-1-josephsih@chromium.org>
References: <20220127101609.3646316-1-josephsih@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1229678802776899720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=609026

---Test result---

Test Summary:
CheckPatch                    PASS      6.62 seconds
GitLint                       PASS      4.23 seconds
Prep - Setup ELL              PASS      53.22 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      10.74 seconds
Build - Make                  PASS      1519.99 seconds
Make Check                    PASS      13.07 seconds
Make Check w/Valgrind         PASS      547.72 seconds
Make Distcheck                PASS      310.18 seconds
Build w/ext ELL - Configure   PASS      12.03 seconds
Build w/ext ELL - Make        PASS      1530.38 seconds
Incremental Build with patchesPASS      6168.51 seconds



---
Regards,
Linux Bluetooth


--===============1229678802776899720==--
