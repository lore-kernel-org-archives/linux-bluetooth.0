Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 20:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiFVUUm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiFVUUl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 16:20:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FF3120A
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 13:20:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id r138so2872075qke.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Lp6FSBIhZZuhCnzJscMapuowE78juMKBNHd7siiJ8ew=;
        b=Ao3NZVYNRvgv7h7L/p8xSuxIDxAMz2jrZlNi3im6YSe9oWnRyVRdJUT7sstbJ3rPbK
         Mm7spELBZFX1WI/+UdXuM0MvYUvd8zMNIixXtITxhNLd6QT4svJZ0PFelHpR6r00vZUf
         2pjHSFkcUZXSgzAU+AC1AdZIic600aV580Pgi6B7zPH6BEqxW40aoPuu2XMOLgfm9A39
         92rrXvg7CvhHhYOvTwFDVGqlH8QqC5OdLePKSA9ANPK4z03un4K1eQpuUPiNCzuBJSKn
         //LuP3R5oS+mrR7ILHBS32PAcj26WCXgY539l9qSPP538CwlftUyW4dx2O6ujcVCnNhz
         Ip/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Lp6FSBIhZZuhCnzJscMapuowE78juMKBNHd7siiJ8ew=;
        b=fRy1Lv7r7HA26a/GsQhyh1eQVcGGQBA/Jx3nbR2qeBSwz0afAlJ5wR5SUwrarjvg3K
         whH7k9xhr8nR+6lTa24x59t6XfnrlSzjuF0D4i4elpfZJdoIBA/P/hQ0sn1req2tqTlf
         fiuWOpl/KFX869G1edtK4P0uLRpRdW2ZZ1kVJnmq9i5h4iw23RVQbjItAHzE763cLtSH
         GKKuDH+8T5TaKsn3ExGGKDfhPew6Vqge2lSGbCf6taVcv+lfl6TgcfQp29XuDokhQbos
         YPKQ14gGF9lIOzrNMuFSGHA4MqQAVqJ1JscW6dE1Wq8B266BfLz5MSogK83HxGgq3jhc
         p1jA==
X-Gm-Message-State: AJIora8zC2zlMaPvkUvnWbtQg6S4bA3eDbLO3N+ht/k47g0IE5LhQX26
        iLx6O3R4qVC1YkPVMLDRa9Ns8gomkeT5+g==
X-Google-Smtp-Source: AGRyM1uetaVD26M8ahYd4zy/fu8vZSsJPaW07Ow5AyYr4RIk25qfe07iiJsjSygTnsrOv8AlermXzQ==
X-Received: by 2002:a05:620a:2489:b0:6a7:2540:93f with SMTP id i9-20020a05620a248900b006a72540093fmr3794053qkn.34.1655929239494;
        Wed, 22 Jun 2022 13:20:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.220.191])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b00304dd83a9b1sm16866743qtx.82.2022.06.22.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 13:20:39 -0700 (PDT)
Message-ID: <62b37997.1c69fb81.b6251.1f59@mx.google.com>
Date:   Wed, 22 Jun 2022 13:20:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0067183716920570484=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix not removing when connected
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220622190053.2605233-1-luiz.dentz@gmail.com>
References: <20220622190053.2605233-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0067183716920570484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652912

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      40.94 seconds
Build - Prep                  PASS      0.65 seconds
Build - Configure             PASS      7.93 seconds
Build - Make                  PASS      1344.46 seconds
Make Check                    PASS      11.39 seconds
Make Check w/Valgrind         PASS      447.75 seconds
Make Distcheck                PASS      228.15 seconds
Build w/ext ELL - Configure   PASS      8.11 seconds
Build w/ext ELL - Make        PASS      1344.12 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0067183716920570484==--
