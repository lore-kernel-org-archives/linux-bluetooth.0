Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 06:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358143AbiD0Gie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbiD0Gic (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 02:38:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7C1E4E
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 23:35:19 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 38ABC3F1D3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651041317;
        bh=MmefrrBswVUvzgRTE2NPvGr6V97N4RUSYuDtOffwdhE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=J+uaNA7eod8azVJqNpAEEqDPPuNSDZcM5EDOm6zX1kWPGvs44gfKeSU5VKh/g3UaJ
         Be3PrIpR3sWrgT31PSoClbYetJvEr/ag3CMBEO4KRtcePJ5V81GxTMJDFkY3U81Qih
         w7vSXT6vG9Lc/+smH21qCsveMxIxWD3/OEjsU6WjsfIWECqlF5BXOhP9lxJgQpjnwq
         zfSr9eo8tXNooT3nQDHd7XhW0uhSqiItoj3+pyBHUO90ZHewIClQor4f7Js2RcA2Eq
         /AFewnaNtyr94cWTopAOs20psqbj5defjOuuSXASIQmhNjkYgV/FKN1PIHuQ3F/puv
         4ghz73MWqMTNg==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso435842edt.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 23:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmefrrBswVUvzgRTE2NPvGr6V97N4RUSYuDtOffwdhE=;
        b=eQWWaFPZa+XgN7dadY+uy5A03Ig6aBEPBeXGwTB7WN9NMAtZ6C8Ejp/awC8A6o2F+L
         QpAzT9olER/EmTnztMTooUMHLD3F2ZqvlpRmITfZWAvYi56urX224cFKk4XPyd3T0Fgw
         VzC7P3HWK0K4tkLgBO9tSIvHXREf1VJd5Bh8RmdMGJ45OHNs0o0/8D9Lpl9TeqcF0bgx
         CHkwl3O9C6pRGREOEwtChJwjhdj7FIzHKWg2/EniOfIeha6w5yTw74uMHrsW7cSeJoak
         sdUpnUPO7GvciYkFzNer61q57VAhT/Z5FoauhXNzwb7vZLVbkcy/0URI5Jcezp9exTJ5
         uneg==
X-Gm-Message-State: AOAM53091JpEZu7kpu3w9ZAkfGNqirZjJuNOrcaXf//7gyOjBRFp4wXD
        Qd+89fYRu+TFHAfC3QzEzXC//0laypN5nQnFAr70Al1SXbBdqWSrsub9YLBaHgjB+99iEr/1CG4
        qDgY1dDZMuFHfpYPeTWaj/jZh8a9L1Ief8IltMgSWAwZZ2g==
X-Received: by 2002:a17:907:3f9e:b0:6f2:b3d8:63c0 with SMTP id hr30-20020a1709073f9e00b006f2b3d863c0mr22671643ejc.86.1651041315960;
        Tue, 26 Apr 2022 23:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynnSs4jOFEV9GW6BdweHs2YdX16aH7caB5g2dU8QtqdplvwIlTdkiQMjPSuQftugFxM8nPLw==
X-Received: by 2002:a17:907:3f9e:b0:6f2:b3d8:63c0 with SMTP id hr30-20020a1709073f9e00b006f2b3d863c0mr22671633ejc.86.1651041315825;
        Tue, 26 Apr 2022 23:35:15 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm7696688edb.23.2022.04.26.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:35:15 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@protonmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
Subject: [PATCH] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Date:   Wed, 27 Apr 2022 08:35:04 +0200
Message-Id: <20220427063504.384540-1-juergh@protonmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ath3k driver loads patch and configuration files so add MODULE_FIRMWARE
macros to povide that information via modinfo.

Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
---
 drivers/bluetooth/ath3k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 88262d3a9392..56e9a64177ae 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware driver");
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(ATH3K_FIRMWARE);
+MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
+MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");
-- 
2.32.0

