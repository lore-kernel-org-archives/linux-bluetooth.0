Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92CFC19F21
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 03:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbiG0DT3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 23:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiG0DT1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 23:19:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D030F70
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 20:19:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d3so7162974pls.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=mZ99UNnrpyXj0A2JbrzoCNd+PC0wH7balS+3Wu+y8bs=;
        b=eb1Uumsd+rbSOt11pDJYohtaXYcqqmfzVqZvqcfaEBxvgcucp2IZoulaqsRymJ0sds
         jxyFpQsJ+f869dQFKi7WkgRYBA28gk5Gdc94WT/BHQelLzfA7nMKwv72aicXhI6Ib4Te
         iNKaoKk1/1Pindgt7XKBHcYhXQlCk7RaCNKuWt7yqXw/V7M0MK21qWHCbrr+1KRzXRYP
         OEJBErMBFWiUB88sZ4UOnPfIiQ8s6U/usoxxET3JfjMai/LKSswzeoOEC/sF4F23bpbx
         pKoEOMPIQ8Kx89Qwd43sKCt6szTTlzwPqdsW7BAxKHHM3WRqH5DbKIN9lxO/WF/6yGc7
         T9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=mZ99UNnrpyXj0A2JbrzoCNd+PC0wH7balS+3Wu+y8bs=;
        b=Q1OkS0RXlPZmA/A7MvEFkbaVG7Jko1/YDiiLKV+N4lQKZbdQRRiVf/yYqo12syEkao
         m+Nagxo7rEfiCCipLdQY166/8t7+4Q/MSuDbnjhQRxE7vNTHR7++uEZieBJEv29K5mcy
         pinJC6hColXChwtg3XYuW39zuvq7j5Bg16UKaBNsU1gF/zupLLFpyGwU9KPux1LV9+Cg
         S8Bke0IjWpR0SP1akHG7u+eDWuU6MOB0i9MTJGKrSei7/G2f9y6i713A91Q22es9KYk6
         +YhD+CWUY8m9qiyxSVvJt7mxyDyzZM+XfN9OmWqCJ9bAC5EoUiV8kyvHSUUNCQecDM0f
         qbmw==
X-Gm-Message-State: AJIora/4Z2pIq/ABBzK3IfaLVbhiPYJLUgJhRTa8WgdaVycLlmdiXC7/
        St3iQlCAL7fiSXzBAcDya/ijZUfhGa8=
X-Google-Smtp-Source: AGRyM1usffqxNuKYlOhV4hJbYpWoDxlwU2ydlVp/EUIKOkOjAchArod3T4vjR7L6TgcjGn/Bt19sog==
X-Received: by 2002:a17:902:6b0b:b0:16c:e69c:bb11 with SMTP id o11-20020a1709026b0b00b0016ce69cbb11mr19389223plk.147.1658891965758;
        Tue, 26 Jul 2022 20:19:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.22.152])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b0016d02acb57fsm12449819plg.217.2022.07.26.20.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 20:19:25 -0700 (PDT)
Message-ID: <62e0aebd.1c69fb81.6f74b.3c82@mx.google.com>
Date:   Tue, 26 Jul 2022 20:19:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3627225754304635032=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zachdecook@librem.one
Subject: RE: dbus-common: Add icon for watches
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220727021801.3564-1-zachdecook@librem.one>
References: <20220727021801.3564-1-zachdecook@librem.one>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3627225754304635032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663288

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
GitLint                       PASS      0.44 seconds
Prep - Setup ELL              PASS      32.77 seconds
Build - Prep                  PASS      0.97 seconds
Build - Configure             PASS      10.25 seconds
Build - Make                  PASS      1061.40 seconds
Make Check                    PASS      12.00 seconds
Make Check w/Valgrind         PASS      343.19 seconds
Make Distcheck                PASS      293.25 seconds
Build w/ext ELL - Configure   PASS      10.14 seconds
Build w/ext ELL - Make        PASS      101.05 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      636.33 seconds



---
Regards,
Linux Bluetooth


--===============3627225754304635032==--
