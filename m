Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3FBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 21:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJSVLw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJSVLv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 17:11:51 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4285183DA7
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 14:11:50 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13ae8117023so629625fac.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tu/pEwzJOiG5fFaKfMkf6uikO4PexNkijXQC828WSYc=;
        b=ouxMSqRxdEk38ANVzAk4Iq5166oAAbsKnPfxnccSpaUNj0ZZQBIbsNeD7YPLAYWNXm
         zQze8jNC4oUigIaXEdD5wjwKyC9nb+kR20Qt6pk2ggBT/3ZOaFaKDLp3yAZFi3Hl8p4s
         wlgfLiWyAzAkX54DFNHI7nv428ZWYRuntaaJN0+4HZatXCdgqqtDhkXB5gEiQXk/EXmY
         TW+sEwR9a40d8i81mtHkYJn9JM+XIWXU8LRqlaz6gfiiBeFh9T9BGX9zNWYELyDrenxs
         gG2WicZ/E9sf9X5ArcOXPZxQYoZsegPPP09c9nfaoEhJkY72uhv80zS2RgAqJOBo9moL
         VISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tu/pEwzJOiG5fFaKfMkf6uikO4PexNkijXQC828WSYc=;
        b=trAVjGcFpYnlUCkPA/notPNjf/+kRrchIjF2ic3ORQXkaTwrU7ZaENzaxkea+ijrQg
         w28dbj+pu3OMk/pfiNQAgMIB1PRyWoFz+ghZSUnKnH27xdnkDQgVCKlDwCtg8VZOfFr/
         8OeNT1OESJ31BpUJxLhL5TVEYw4XB/UAx7y0wPnIHMuJ+GKPC+7xkJDoe8xrAS5qNfYZ
         GX8dZCh+VajIz41qh+hyAe/xgeeqn5z1xi6tE0ZsDZyfvQp3CBJ0n6tsShx/ONJX6VYt
         0XJ+tBHGis5OnsaUTd/0+3hqdZN7w5/vgNMxVGZgHJfUw6Edn9xr3G2qpUI4xWLgDihL
         wOrQ==
X-Gm-Message-State: ACrzQf2mkfnWfjk0ZQDtgfD4eLjgjFNB/WGGrDlpQHBDJxzF2+IfXWJJ
        bnaE1GDiodxU9sv5E5VaiXRTo08lbUU=
X-Google-Smtp-Source: AMsMyM5QjVNjGTiqG9UzJyRqrzl9Xhfx7Kx6mnnsCTwvFZX5aPUysfv0gY8XyMB+aNqhFw3fbdcFiQ==
X-Received: by 2002:a05:6870:6194:b0:136:90c5:2369 with SMTP id a20-20020a056870619400b0013690c52369mr24671442oah.274.1666213909454;
        Wed, 19 Oct 2022 14:11:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.205.176])
        by smtp.gmail.com with ESMTPSA id cm9-20020a056870b60900b00132741e966asm8042857oab.51.2022.10.19.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:11:48 -0700 (PDT)
Message-ID: <63506814.050a0220.6075d.026e@mx.google.com>
Date:   Wed, 19 Oct 2022 14:11:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0291065546692991024=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] shared/util: Increase debug trace buffer size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221019203028.57090-1-frederic.danis@collabora.com>
References: <20221019203028.57090-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0291065546692991024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686887

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.69 seconds
Prep - Setup ELL              PASS      27.86 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.79 seconds
Build - Make                  PASS      885.94 seconds
Make Check                    PASS      11.96 seconds
Make Check w/Valgrind         PASS      298.50 seconds
Make Distcheck                PASS      247.19 seconds
Build w/ext ELL - Configure   PASS      9.02 seconds
Build w/ext ELL - Make        PASS      88.93 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      545.81 seconds



---
Regards,
Linux Bluetooth


--===============0291065546692991024==--
