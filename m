Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5605C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 20:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIUUYi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 16:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiIUUYg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 16:24:36 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492C115E
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 13:24:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x18so4829974qkn.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Piun0CZ2a322dwqOBvTQWWspefdZzYpH85cDX74I95o=;
        b=MOxPlt2BqC7m3+1zq0RiDdy8/yPynMQkF3wnJrwx7R/ufE5GrUzFukJGuaCF3CsBcg
         0I3Kk6Rt7OjnNFUzePT7vhW3aFgTnBP30UbkjvBaJckFy5n6igMWkw7cuEkPAxtLra3B
         yv5NZWgWAaAo5BhmqI5rV2l4lLRKej7PVN0udBdbNL1gLLE+ZkglggukeXcsp0tECUH4
         6PDalfjOF5jWgtaAaZTA4t5V4Xwc8hntBLvAE5lL76+t9FSZ+14RJNhNekbSBDFBgIvY
         UkBTtUAEPsHG4BQFGdXa0BvARI6lXec21vQLNjFRvM89QuuZFhmYQkvrKm5YPBB2Kmz8
         QGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Piun0CZ2a322dwqOBvTQWWspefdZzYpH85cDX74I95o=;
        b=qyAM/3IZFR2N0q0/IdV9LMpraW8rwpXuciy6EtswGh3l+18KYR6l1qo9L6tiA4CV6H
         2X2xooQ0/wvAAPD3OM9yE6lddyzy1jGZbVYVoFxMxfCmviv8/6SEEuUpFFKfhOuo7nsZ
         7MsMbemIpslXNsID00OlPpomTPVEE69a/7a74DYTB+LPyJosNH+1t5WKu+wgEDWLC9Zr
         Jdaz/I152dQTVaG8qfRtLMA5TXU4O9VKj2E0rNcf0xRuh3YVHOigeYSYzBMBwMgZzyck
         IF1YJfVX4fLquI+5etqQ36YP2ESJvcPrEB2T9uhk5g0SkoOjvfjjb3XUI6wW0h2ExZff
         fmZQ==
X-Gm-Message-State: ACrzQf0YU+QqsqLLs6U2ShIW64cz60qnHog/Y41arOV4aFRnTsV9ZGsf
        SNLElOdy4m+hDFlabqx2SBCtgAdIF2S+vQ==
X-Google-Smtp-Source: AMsMyM7lh/d8/wBGbMfdmJBsMSmirCJtZDk64vr/JPwIuYZd0NkiXBLigcBmbajENoqeJEly/Mw+wQ==
X-Received: by 2002:a37:a943:0:b0:6ce:731:997b with SMTP id s64-20020a37a943000000b006ce0731997bmr20933628qke.344.1663791871558;
        Wed, 21 Sep 2022 13:24:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.226.55])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a268200b006bb49cfe147sm2660402qkp.84.2022.09.21.13.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 13:24:31 -0700 (PDT)
Message-ID: <632b72ff.050a0220.7a43a.af9a@mx.google.com>
Date:   Wed, 21 Sep 2022 13:24:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0891535782442853836=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] tools/ioctl-tester - Add ioctl-tester
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220921192826.102801-1-hj.tedd.an@gmail.com>
References: <20220921192826.102801-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0891535782442853836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679139

---Test result---

Test Summary:
CheckPatch                    PASS      2.44 seconds
GitLint                       PASS      1.13 seconds
Prep - Setup ELL              PASS      27.93 seconds
Build - Prep                  PASS      0.87 seconds
Build - Configure             PASS      8.91 seconds
Build - Make                  PASS      1001.77 seconds
Make Check                    PASS      12.25 seconds
Make Check w/Valgrind         PASS      296.65 seconds
Make Distcheck                PASS      247.77 seconds
Build w/ext ELL - Configure   PASS      8.94 seconds
Build w/ext ELL - Make        PASS      86.63 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      577.90 seconds



---
Regards,
Linux Bluetooth


--===============0891535782442853836==--
