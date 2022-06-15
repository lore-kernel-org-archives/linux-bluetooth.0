Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6175AC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiFOOjI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiFOOjI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 10:39:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA94B7EC
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 07:39:06 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g15so7467865qke.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gGzwqwtiqVriQQcjUlzXxKGSL/vBaRa0g4/1OUaoiPY=;
        b=CCC3zHOEaynAwgIgONkOGMZj+rX4f4/PLJi8/c/TiljN+MY5ju3KubdAfKNigwZaSc
         wY9jOjwNv+QtoO0hcg+R2qR5ar1CYwPdqRxDbYFhn28zfmONl3DMCFJDjB2Zta1avvhc
         UmOMjjFASG8eU5ZgMcbP9JvgjCR6jQC33YlRa5fAUZoGR5s161ytY7mdK21FVsDXEWv7
         /+eRMF0fLas3I4p7Ykc3IcJ4eMVeOQQZJzcKME5c425Zay9gkv1rvSZXw3mBXNaQyRvf
         Nwf1tpBmMWAYPjMwOHv0jbQLMfTgtYksM3oigSEqB1jyGYB9Y5WbfOBANfrCM9ZyCWcq
         OUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gGzwqwtiqVriQQcjUlzXxKGSL/vBaRa0g4/1OUaoiPY=;
        b=VXmAdI9aP0WsHXIVeXxpMGTyC3oLUH0+cGigrIabaemNhIHKVyvLhihPPRHPx5czct
         d/P7YVnl0dCHU7kb97rTCIeKi7NwU2aA6B+9fWZEjy7jOprgu/nnh1ky5ZLRHDPa1Ny1
         SHb4cPXiYlNPjW+wRDXbIX/7VJATPMHhntjGKmfMQor7iyQaB5ijPtQCYg7hQGdQBCkD
         1VejqpSIosJRk/KyE02uYKMjTbe8X/PDZgja7m8NCAAYXpC2+MjwBcyJOh4SzNLpfpiD
         mfK0WCil+4RcFL+zE7974hMCsf0tmawG3YF4ffKkq0011f1Dn3v5Psea89LojxbF9C2E
         uwLQ==
X-Gm-Message-State: AOAM5302La+5pQG8McsehvhWG8b2V9/6JO2gTnquEFEFNvMYuaYXDsFa
        dI7ic8GRPuxTIJqrBPyP4mjP1jeWFWU0Ww==
X-Google-Smtp-Source: ABdhPJwDOfQqZXbG8PoTGBzNd2Drz1C5chPIMWnOQJiRM7KsRDBKyFx4gF64ZBaTTcfqydCE0esMXg==
X-Received: by 2002:a37:9f50:0:b0:6a6:886a:7aae with SMTP id i77-20020a379f50000000b006a6886a7aaemr8162341qke.419.1655303945326;
        Wed, 15 Jun 2022 07:39:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.76.239])
        by smtp.gmail.com with ESMTPSA id r145-20020a37a897000000b006a760640118sm11319500qke.27.2022.06.15.07.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:39:04 -0700 (PDT)
Message-ID: <62a9ef08.1c69fb81.ef43e.3c14@mx.google.com>
Date:   Wed, 15 Jun 2022 07:39:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6080375911616762916=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix crash of transfer pointer has being freed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220615124902.17347-1-wangyouwan@uniontech.com>
References: <20220615124902.17347-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6080375911616762916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650581

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.93 seconds
Prep - Setup ELL              PASS      42.31 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      1244.74 seconds
Make Check                    PASS      11.39 seconds
Make Check w/Valgrind         PASS      463.73 seconds
Make Distcheck                PASS      236.82 seconds
Build w/ext ELL - Configure   PASS      9.33 seconds
Build w/ext ELL - Make        PASS      1265.84 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============6080375911616762916==--
