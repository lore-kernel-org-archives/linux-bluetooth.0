Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E346C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 11:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCKLQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Mar 2023 06:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCKLPM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Mar 2023 06:15:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BFA139D24
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i34so30684245eda.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCTTb92AAoMVvXQ5aE8pDO5aVyOUz4eqvmWQp2fU5mw=;
        b=Xm4ZuJCCS7mm2qZMe06Jl5IFxegK2jOFxBFzdXD8adzQQtzra9b3D+2gZVDsRL2Z5p
         yKPHBv6EJz23Gldjk7JeKL3y+HQs5vwr3j8MxArHRdmbHUQezhso5hmxKI33oTpC+Bgj
         aDXRVDrPiOOypiDuaQxjGFJXba0ILv5OrgB6VuKgrKQz10PrvoMlWWxPmqURmzDVHen/
         fyO51YknvUUS058ozWRq4+5eu6XAl+yz1G6TmFFWHlQPhDVhQzLhReWj/Mgy0/cKxtZK
         86n7P0CqmxRaPazE944YAf1PnuEpRFCjnxffXywf+Ol07IZWuz6jP+rOAx/hZgzfAF3t
         mNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCTTb92AAoMVvXQ5aE8pDO5aVyOUz4eqvmWQp2fU5mw=;
        b=pXDbn/VT/3/V2ktgvNZ6W6llN2vRM0qXKFmwMZsbjTEWItDBpYVoH7GDFy7/NuiGAj
         3px32RWw8mpMMqBnlfjVXZpYz1Oa2t9Ic2F0hFwByrREEUM4Tzcd4CDZ8Qn15yIKeE+U
         9I+CN3ZOPq5Tv0CNro+7pHIy5kUbBXHcdoqKeLxE1REcUcO/uAd3HMdzb5iELbMW9s9P
         VpNdcpjK0Cew16L4pCRwvh1gBgXePYttKP5KCf4b0lyvSjPXKGfPNcrHmTw48ZSD1cFY
         oZ/hJduVScG6UjUUUvTpwGjfYV/lJSHTs91pA2LuNtCk57hG0A2o165XZEd1dhF1RyZl
         /lzw==
X-Gm-Message-State: AO0yUKWmF81STiIoVHD7rzOtcN/2MItcQ3J9cAI86ixyMyL29AP7Lhgv
        SMloDg2JXroQIPoBf4Vg0QxrMw==
X-Google-Smtp-Source: AK7set8VUBCC++0rZKvVuN9HoT+LHcQIhyp29YmG0D+xXFTSWOFjLW7ajPk00csdW30mYzCxwGXf6w==
X-Received: by 2002:a17:906:d54d:b0:91d:a049:17a9 with SMTP id cr13-20020a170906d54d00b0091da04917a9mr3961752ejc.36.1678533247256;
        Sat, 11 Mar 2023 03:14:07 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id q12-20020a50c34c000000b004bf2d58201fsm1053859edb.35.2023.03.11.03.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:14:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] Bluetooth: btmtkuart: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:13:54 +0100
Message-Id: <20230311111354.251316-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
References: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/bluetooth/btmtkuart.c:971:36: error: ‘mt7668_data’ defined but not used [-Werror=unused-const-variable=]
  drivers/bluetooth/btmtkuart.c:966:36: error: ‘mt7663_data’ defined but not used [-Werror=unused-const-variable=]
  drivers/bluetooth/btmtkuart.c:962:36: error: ‘mt7622_data’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/btmtkuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index c98691cdbbd5..7680c67cdb35 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -959,16 +959,16 @@ static void btmtkuart_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
-static const struct btmtkuart_data mt7622_data = {
+static const struct btmtkuart_data mt7622_data __maybe_unused = {
 	.fwname = FIRMWARE_MT7622,
 };
 
-static const struct btmtkuart_data mt7663_data = {
+static const struct btmtkuart_data mt7663_data __maybe_unused = {
 	.flags = BTMTKUART_FLAG_STANDALONE_HW,
 	.fwname = FIRMWARE_MT7663,
 };
 
-static const struct btmtkuart_data mt7668_data = {
+static const struct btmtkuart_data mt7668_data __maybe_unused = {
 	.flags = BTMTKUART_FLAG_STANDALONE_HW,
 	.fwname = FIRMWARE_MT7668,
 };
-- 
2.34.1

