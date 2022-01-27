Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA002C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 02:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiA0CWx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 21:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiA0CWw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 21:22:52 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A186C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 18:22:52 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b35so868508qkp.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 18:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OAaCYD9CDKH/hLLO4Yo/d/g/rmumcCFRed43kFGC5ho=;
        b=ol7pVAkci4BDTG/2TF9qrUWd7syuXOnCpTKRP3uZjWmXskfNW6GA0P3Jr/WrLsYL/s
         e5ldWC8yLmaW67EQdb1vuhDit+ivtxoR4INGr7CA6xeDmr/J5/eewMFwF3FPl8ZpVDHU
         zSawuJYCmZ2qJ2YZhjAedRsjAQngWmcmexjw/oDN0L0AwuN/7LcejcA0XIvYTxaILX6r
         A8uGDnxLRG1x2y7nU8IeFEoe+a9s3Cm+90z7hUmGQlBgn+3HIo/hScpBEihuMrXn3Kep
         h2ypW5A37Sbr6nxh+YcLd4RQRknq/BErTCX7upGCastY8zALS7fimyTCbt50duXHt/lB
         xe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OAaCYD9CDKH/hLLO4Yo/d/g/rmumcCFRed43kFGC5ho=;
        b=X260DtSbCRRMr6LRo5ebDZy4evJioYu7jwHcP6yL21yWRxvEZ8o7bQfGoSEEvTFYKU
         LqhMLDgNdfByJiMjlhbR9ahGB/zgAK82+i+ghvWpMWLQN0m0yJoWFyUoUAGCG7KxdtBp
         GlWinZVqhkAwxL0r1UhIos/f82ko+kNxcOAw19P9QeoxGziVAGu5tavQRGR8icfHif4j
         NmU0ZIitMwyFyMkjmtHwLDZTFGdJGqPvkrv+GqoClmO7LEGnyHnPw7UV7s5/jGOkfjeR
         mQ43c98+9zTiph7gtVrjodhnHxyDmmncbybAJ/DsoOaCnlDJe69GIQJMIwXBOjL5+Sft
         G03A==
X-Gm-Message-State: AOAM530vKFizM2iHVjQZimYk/ZVvXR5Akz/GtJvzKBgZiSMif/Zk9oQ7
        FxCxcfWXJ580p0LlJBs6Lex4yCI4H6c=
X-Google-Smtp-Source: ABdhPJykog58jCiF9ydFreX/raG6/Vltyv81wyNv2xdXiEwJ4S4b9LYcUPxUk7RwkY/PDM9fe70EIQ==
X-Received: by 2002:a05:620a:1399:: with SMTP id k25mr1276665qki.662.1643250171139;
        Wed, 26 Jan 2022 18:22:51 -0800 (PST)
Received: from [172.17.0.2] ([104.46.195.130])
        by smtp.gmail.com with ESMTPSA id x14sm794862qkp.105.2022.01.26.18.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:22:50 -0800 (PST)
Message-ID: <61f201fa.1c69fb81.9b4f9.4268@mx.google.com>
Date:   Wed, 26 Jan 2022 18:22:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1233839840760222895=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Add implementation for BT_HCI_CMD_LE_TERM_BIG
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220127010327.3087364-1-luiz.dentz@gmail.com>
References: <20220127010327.3087364-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1233839840760222895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608881

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      51.48 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      10.14 seconds
Build - Make                  PASS      1502.48 seconds
Make Check                    PASS      12.33 seconds
Make Check w/Valgrind         PASS      535.54 seconds
Make Distcheck                PASS      279.31 seconds
Build w/ext ELL - Configure   PASS      10.27 seconds
Build w/ext ELL - Make        PASS      1437.51 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1233839840760222895==--
