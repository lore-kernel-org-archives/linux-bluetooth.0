Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF39C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Feb 2022 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiBVUho (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 15:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiBVUhm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 15:37:42 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A21E12AF6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 12:37:16 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id x3so2594545qvd.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JC4thUeMj45YWzqIebtgnjEeGvBDTfd7V0bkxeHA2ks=;
        b=noWzwvYxjiHyl5/Nb+13i1sB6gjSD4Bu5vgIrE3yTaRQpxFDGyWDkcViqDZJ3aQsX2
         hxXbbdpsKFuygT40XcqP99WM5pPzNIU5ZAyEbskT6vRRTDiA4Ggnsbzfi9fEHXRtACuQ
         5G9O3Pgmwec3JuUGa3VwyvuOhT39Jk199ARRcgTHz/geJntE1gbyoSx8uoV8pNR8GZVS
         wlJ3w5zRVFvX8azXZ7DBZEBDUz0vk17zuRlYfccJGjgs47Ac52i2dXQ/BXIepfjr0lES
         d8uogMWqbQ2wFrotOkR5IossIq6J9fYGCFvQ8PhOUtlKGAs79TcYDA/N1VhTDyZ8ZRxk
         1xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JC4thUeMj45YWzqIebtgnjEeGvBDTfd7V0bkxeHA2ks=;
        b=2zdFxI1PdtaufbUoSfhk6gL/HDmMQX4Li8QgzoJkLCwnDf7Ff0hUCXiWQBm8s8zWFr
         XgRyukA35Ok+VMCkrnk/qVbgcvLe056Sf2y1gYJGifeu1TJynVyAd8pQP9wBs8VyXv+m
         UAbZOJ/zfSBhm/+AV/ZEiHJeD0x0nKoHlN4n+fhBNS0U7th8dcrW/VR/Y61C1WDBJgV2
         rirpHv5d6yIL3lS9v3rpHXdmeJblZEwBj2Kjy+hZJ0jiH8W2MrJPRvg+UapDSamoV/G6
         +JcNi1XWsM2dTPIE3YHSGPLIpkxolkzn/HsaGmI8fL/Ke+AtuA2ozWAWTMiIe4ogvsVG
         TCJw==
X-Gm-Message-State: AOAM533Rg5m/UeAOELsIQ+Oz345i+gvGMh4808NfAv1qF0lwsuuTtME+
        hA0xyrM0X+cLNPJMthL4sYSxAZ62BJILvQ==
X-Google-Smtp-Source: ABdhPJwlB/OAn7YiAET8c2YkSiZFLxBjAas4qPTzlkjFpI/IZynMMPB3ulZy8b5r5N1PSg9V6lCp2Q==
X-Received: by 2002:ac8:5a49:0:b0:2de:6fa3:f928 with SMTP id o9-20020ac85a49000000b002de6fa3f928mr2072552qta.677.1645562235181;
        Tue, 22 Feb 2022 12:37:15 -0800 (PST)
Received: from [172.17.0.2] ([20.119.250.185])
        by smtp.gmail.com with ESMTPSA id 84sm418543qkk.32.2022.02.22.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:37:14 -0800 (PST)
Message-ID: <6215497a.1c69fb81.c6f2a.3b5d@mx.google.com>
Date:   Tue, 22 Feb 2022 12:37:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0888431204086914779=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,BlueZ] player: Fix Track being emitted with empty metadata
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220222191428.294428-1-luiz.dentz@gmail.com>
References: <20220222191428.294428-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0888431204086914779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=616860

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      41.05 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.43 seconds
Build - Make                  PASS      1252.41 seconds
Make Check                    PASS      11.06 seconds
Make Check w/Valgrind         PASS      451.14 seconds
Make Distcheck                PASS      229.57 seconds
Build w/ext ELL - Configure   PASS      9.63 seconds
Build w/ext ELL - Make        PASS      1230.50 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0888431204086914779==--
