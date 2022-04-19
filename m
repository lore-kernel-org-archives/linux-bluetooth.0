Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD72C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 19:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353084AbiDST4X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 15:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbiDST4W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 15:56:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E291F3818F
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 12:53:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j6so14375507qkp.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CyCxkUZfLAjgeTar/NYweRJ89UyOf10BqOTFg3MV6L8=;
        b=JOHyJIIJblrSGRn+UfJMSN5QBFf4eRi3KMS4vi+JVmaWbq8E19LTZ89B/4pw7VU6pE
         0AZqIHtU5fqBX6Iz+chE3aaZYo5k8ACI7RevhO9qynwUaKUu1+G0IYeaFGMGLMaQdAVJ
         PvBNhrqzb+Z9Vrhso8NmtxMJ5AgCcqV777PaedszpX60lJ6wdIPym/1MIOJ4URgHJ3bK
         oaT+IrM3JT+los59277v7sdSRx7PQVFFNSi8+qQJXamjMAYR+DLZ+B8jSo2EJGuWtINg
         2hjQ84MZOaVB8yWV3/ZaUas9lKbuFfAcSdPAOb9DJBboGE+xv11N/v5OLA+V4Wt32Wc9
         XpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CyCxkUZfLAjgeTar/NYweRJ89UyOf10BqOTFg3MV6L8=;
        b=kK7g25fRnqD6xGBJt9EGfPAfiOLN11654ywh/9qhKEj3OwbRRLKxOoKAP88rk3n799
         9ZL2UzqlyGe8LMvLjuvyXmvgnPk59mcofMgDNJ7wa5isWEb1SdAqLMdwXJm1KOtBM/5y
         ZLEl65W0NV5d+FRA58W92AJxzWX6O5alZ+yIsT/tCFlTw3s7erXUOACABUG5rdKo/ish
         ChW7lYiMA4nsHDGhiovYV9VybX90hFTarmVaY9TL/LTKbBO41UhL+llSMuQMJJGBoS2T
         FN9AhZ3dG5zNrRRaMztthqqeg2ORKqsPWPLa8vFrbUH4ZxK/yYV30tDq5O+1j+FSxnla
         /+SQ==
X-Gm-Message-State: AOAM530bQrvmiRlHKc3XJdtRobW8xc0RV/qbfr59J8EmqbrE8clLft6d
        fX7cUVUE6U0c7bp3nLIU0t2WrL93nZjWIA==
X-Google-Smtp-Source: ABdhPJz5CbR39zFSBqFPLV13cZYRNuqle1vWzXKon9rITvrfhwoRZX6zdIH7EAhD9NZ5hfvQKb1fsw==
X-Received: by 2002:a37:9e91:0:b0:69c:739e:45c3 with SMTP id h139-20020a379e91000000b0069c739e45c3mr10947067qke.748.1650398017912;
        Tue, 19 Apr 2022 12:53:37 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.170.6])
        by smtp.gmail.com with ESMTPSA id s195-20020a37a9cc000000b0069ca29ab6f4sm455548qke.26.2022.04.19.12.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:53:37 -0700 (PDT)
Message-ID: <625f1341.1c69fb81.b2c55.428d@mx.google.com>
Date:   Tue, 19 Apr 2022 12:53:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1103365274513242909=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] settings-storage: Document use of StateDirectory
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220419183435.2534491-1-luiz.dentz@gmail.com>
References: <20220419183435.2534491-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1103365274513242909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633492

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
GitLint                       PASS      0.95 seconds
Prep - Setup ELL              PASS      43.35 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.73 seconds
Build - Make                  PASS      1437.45 seconds
Make Check                    PASS      12.18 seconds
Make Check w/Valgrind         PASS      447.82 seconds
Make Distcheck                PASS      234.23 seconds
Build w/ext ELL - Configure   PASS      8.81 seconds
Build w/ext ELL - Make        PASS      1425.42 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1103365274513242909==--
