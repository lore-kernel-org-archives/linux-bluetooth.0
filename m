Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA0ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 16:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiH3QIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiH3QH7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 12:07:59 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363F2CDC4
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 09:07:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h78so9603638iof.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=mcwbPi/6YwNcLvV6Y6P2ec52wJB4px0mAfFOPuyzAxI=;
        b=PYJ/kfnQl8El8OnS+jjOmmOYr0BDMFmqR2HnvWtAeyfDs1gFh02L0zZnMoiHIjnSXO
         2Z0YoI30v1mg5tXu6QVw2TSVrUuP8PnMlZ2MY62OZ9tRFLRJDEEUKIST1qtaNx38beER
         UM2gM6igk5XK+1icZQOUDB0+890kXg7ReRSj+jIyWKRXwpJAJ/hygNKtwWeAin0ubhDM
         ds8+HDRsoCHHiRN+V70h67QmReDapajfTMEA2fZkpwoLDdKO5fsTDng3/8behvw/NpYp
         1hjY+PJSpsJGiBG0uCV+zqbz/2NQu5h8FqyvmNq34nD8RdFI4p5oxrpFZd/bmT40HuCX
         gPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mcwbPi/6YwNcLvV6Y6P2ec52wJB4px0mAfFOPuyzAxI=;
        b=0rwbHJhXzzCgg/G2hCCNCDiyf+vbv3Bn/VUHAg+Y2ZY5H1I6omgtbH7BnM10fX5/1c
         jI+ycGpphfIEaRKxMtOCqa2RB+YNcNlEWxe/HvBnqrJR5+CjpWHi/BmRPi6qM+qJl2mQ
         CEyikrpXV/7jH5ezDGveaI8tjshKwq0R/g05QmKQKyEUkBFGNnCRo/V+kBSD3YVA11JA
         7umzVWXFrohOkExhQmvYp2atS/Rxyjf9nwsowyzL1h2LrH7I/33HwbzmZsn557UmDHr3
         klJ8/rJRIamsySJwLwizI8EIO0FQo2TOhmuo9tvs3tWd5uHTRK1TQfrVl454jmX4dZeH
         Xwvw==
X-Gm-Message-State: ACgBeo26IsB5/k89dLJQGlj0DdWiXH08+iMo3PReHhrlZxGhZWrLmQz3
        g+F6N2qVDSBjl3T/rbCw3XGyf0EHelU=
X-Google-Smtp-Source: AA6agR5qd5DZZg10ERx6Ha89O4W3dnHn2JeugyhIFJnILIuobccn0MaxK7ghD4ZaV7lUlip1+GOKbA==
X-Received: by 2002:a05:6638:2686:b0:343:7299:2c8c with SMTP id o6-20020a056638268600b0034372992c8cmr13224963jat.198.1661875674403;
        Tue, 30 Aug 2022 09:07:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.69.131.183])
        by smtp.gmail.com with ESMTPSA id x10-20020a026f0a000000b00349bd096a82sm5715711jab.109.2022.08.30.09.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:07:53 -0700 (PDT)
Message-ID: <630e35d9.020a0220.8c3cf.63d7@mx.google.com>
Date:   Tue, 30 Aug 2022 09:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2800893021266124795=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: profiles: Add remote endpoint path to SelectProperties
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220830144734.55263-2-frederic.danis@collabora.com>
References: <20220830144734.55263-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2800893021266124795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672467

---Test result---

Test Summary:
CheckPatch                    PASS      3.40 seconds
GitLint                       FAIL      2.32 seconds
Prep - Setup ELL              PASS      26.45 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.09 seconds
Build - Make                  PASS      735.40 seconds
Make Check                    PASS      11.29 seconds
Make Check w/Valgrind         PASS      286.38 seconds
Make Distcheck                PASS      237.35 seconds
Build w/ext ELL - Configure   PASS      8.26 seconds
Build w/ext ELL - Make        PASS      82.60 seconds
Incremental Build w/ patches  PASS      292.60 seconds
Scan Build                    WARNING   516.29 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v2,3/3] profiles: Fix function definition style
6: B3 Line contains hard tab characters (\t): "+	int (*select) (struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,"


##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
profiles/audio/media.c:1459:6: warning: 8th function call argument is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3005:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3008:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.




---
Regards,
Linux Bluetooth


--===============2800893021266124795==--
