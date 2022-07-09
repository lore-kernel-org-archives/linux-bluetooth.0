Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16570C43334
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 20:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGIUSw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIUSv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 16:18:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D6DF38
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 13:18:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso1611082pjh.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HRn32gNXVxvPhlZ+vBQ85AduTNu65cHCq27Fe7j4qDQ=;
        b=fZJY3C8f3X+sDTo56ixFOPbJeLC+q7oGnretWWwcnqJyg2H45zPhvq+RyB4AVbSC4D
         bcme5MOdOxdPpBpGm1bvVhDbfVFFjmnnSigo2CU627LlL4apGuz8YXjdSwk/UqIMVKLH
         ngpccnKoni35Wd8B1t5/OukxRAg40Z8VnRrACGRirCuoOT5fbJ5exEcv1MLJ4Koai8Yf
         RPRc0Id+p9p0HK/dYEaAuM/xr5KSu1tLIdFKaz8Ihu+FqQc68lfwy9dupBZuSwVlLomC
         MXUL8WHNPhKJeITVCe5WjJf6LzrRmt7nZUikAU4YH3LS4q8f8+8EtsCO5RWaTqAyZ1nw
         sABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HRn32gNXVxvPhlZ+vBQ85AduTNu65cHCq27Fe7j4qDQ=;
        b=DLwkh4DW7zSD/wyKWCZDv+OrHoS4rmVKp+UYAqutFnBTKJ3HA2ER1H0LtLiCEhqp5M
         wgeMCpLnL+sXojNVhI0Hla/PGQ11vIKBUSkmFXupSccBUpVeCwfmEtFrRYTtjPaUBp5t
         ZSTQ8jXAi2HZb47shTiyuoSm2m0fLXcsJXKXAyGRUoD2um/2zf2qxgM/egD9cJQ1QGE9
         77cCAsryFA2g7pNeQHfpgJuFH4lsCBG+gBtqL9aDj6idLk4DYcvj91W4DdI0pxqvVt4g
         I2enT1+vQDY+Wp55yWSj09qbrx0Pg+u0bMt3E7PXlgQs7nCGNNR6xDZOb1uGQwRdmz10
         WkOw==
X-Gm-Message-State: AJIora8vBd5jyOlOy/cZ0l+n8Zfpodee7e3af2rPirumakPLjaXSHaPz
        Xrf2sQf7iR3bk0tFlTpv8XQWanuaZ0I=
X-Google-Smtp-Source: AGRyM1sx6cBE05US2d2ZCYkbBK6KeZXRp/ItuGa7gtq1Rl/iNbl+qOAVucpTvBhDHmFoR55M8bNOaw==
X-Received: by 2002:a17:902:ab41:b0:16b:cd1c:1361 with SMTP id ij1-20020a170902ab4100b0016bcd1c1361mr10357546plb.171.1657397929687;
        Sat, 09 Jul 2022 13:18:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.183.38])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902868600b0016bdd124d46sm1678439plo.288.2022.07.09.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 13:18:49 -0700 (PDT)
Message-ID: <62c9e2a9.1c69fb81.e8400.23d1@mx.google.com>
Date:   Sat, 09 Jul 2022 13:18:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4572117976597840108=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, shwoseph@gmail.com
Subject: RE: ExcludeAdapter configuration setting for input plugin
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220709192317.1704-2-shwoseph@gmail.com>
References: <20220709192317.1704-2-shwoseph@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4572117976597840108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=658206

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.43 seconds
Prep - Setup ELL              PASS      29.96 seconds
Build - Prep                  PASS      0.60 seconds
Build - Configure             PASS      9.38 seconds
Build - Make                  PASS      890.21 seconds
Make Check                    PASS      12.01 seconds
Make Check w/Valgrind         PASS      312.26 seconds
Make Distcheck                PASS      253.84 seconds
Build w/ext ELL - Configure   PASS      9.34 seconds
Build w/ext ELL - Make        PASS      89.40 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      524.20 seconds



---
Regards,
Linux Bluetooth


--===============4572117976597840108==--
