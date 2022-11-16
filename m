Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5BBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 06:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiKPG2I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiKPG1p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 01:27:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5048A1D0EA
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 22:27:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 4so15586328pli.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 22:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=onGJsOC8sQiwsSjz9f9qzt+vQiKXUsdWUJda1GqiPTo=;
        b=EOSdXsRBGHvFu13w6IF0QsjGZky/dWzPns9XDzBqIsTRLNupkg1lUlgngd+l5lhsl6
         xZBkfXTJlShqdVkvZp0vJtxnOOU7gsggWgZGzZybe/BB9YadMj2Hs5Ua0blK4bwh/vzK
         6NCluzNSHTMtixD1JuNG+xKY9YnC+YBzS3lsiofGgCybLFFRz6N6SSTharpxnf64fh04
         3kBW31crDCLPXzBpZMPYRH/tYLmegTFPL7COpKNcXNVXzTejVORqkjBq1H3f2Rfm2idh
         TDomu/10q9c/o1GYpt4v/VP7+JQYcxxPvMenQ7anLbIsX3nEU1d3SAScSOA89qH7z8Ho
         p+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onGJsOC8sQiwsSjz9f9qzt+vQiKXUsdWUJda1GqiPTo=;
        b=pgnCFiL1ICT1B6lYaVjv1bZcwZYiO4On8PaIME3KihFq64y7PaA5Ia0sCVN/hMMGR7
         oEzE6LIiOIawuaSnKFxt4l0CpmuUU40J6x2uL2RXN4D87miAbg1O0ypeDTuk1sRfiLiY
         SitFE71de/PYjrmzfERPkur9GuS1mfTfckArVFTLSVRtTpo7U0OyZrV/9zFHiRhdpsYz
         eg+Bv5K1H0SxahgFvPNoiQxRhOUlNbAe/rvM9GRSiXBgbcZZ5wrdYpVbIenzsUbEjrnB
         LB3KAuools49FZYB44OCjzzyhnmCuLxykb8TFj2WEvGF+cErkUu6SnEe19Lr73y29J6p
         itxw==
X-Gm-Message-State: ANoB5pnkjjwJnIm1P1cfDH7qR1pXsSvwZP4qB3QBZ885tsPER8haW0rx
        gwl1FtGKHQTNjpCljsHSM863uVLw7ls=
X-Google-Smtp-Source: AA0mqf7tfA1iFxkm+jbXvUNixwDQUBJ9fIOEd+x7tF8zizuMDp4qKdS4514rYcU7rq/AlUYAfLFfag==
X-Received: by 2002:a17:902:f549:b0:188:5c0c:7590 with SMTP id h9-20020a170902f54900b001885c0c7590mr7856845plf.65.1668580063487;
        Tue, 15 Nov 2022 22:27:43 -0800 (PST)
Received: from [172.17.0.2] ([20.230.159.220])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b00186f81bb3f0sm11209816plg.122.2022.11.15.22.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 22:27:43 -0800 (PST)
Message-ID: <637482df.170a0220.7501d.130f@mx.google.com>
Date:   Tue, 15 Nov 2022 22:27:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5903696575442131835=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5903696575442131835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.35 seconds
Prep - Setup ELL              PASS      34.32 seconds
Build - Prep                  PASS      0.91 seconds
Build - Configure             PASS      10.65 seconds
Build - Make                  PASS      1096.36 seconds
Make Check                    PASS      12.62 seconds
Make Check w/Valgrind         PASS      366.48 seconds
Make Distcheck                PASS      304.62 seconds
Build w/ext ELL - Configure   PASS      11.12 seconds
Build w/ext ELL - Make        PASS      108.32 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      672.43 seconds



---
Regards,
Linux Bluetooth


--===============5903696575442131835==--
