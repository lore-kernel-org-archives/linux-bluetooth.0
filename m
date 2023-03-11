Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB711C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 11:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCKLPk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Mar 2023 06:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCKLPI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Mar 2023 06:15:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA6222E5
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ec29so30734421edb.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6tUGFbQ7oA7pUDn55v/Wy+VlBUMSyXyYmPtvu2ws50=;
        b=yWfJY7Out3CLSvURy2RybRjEidhVO/LsVGJFdgbAa+h5D9jYNoCZ+WWjRxJaEMNzR5
         AHF/txrarIzqBQpbDHB6p2t9Z0JwTpECwOXzA5w/E7PPtfMuPamhT1gIwV9XCNd/k0TO
         guxePCLFhaVFSGDvnrej+2XHiSUfzbhVSjL9QGo7h57wM0/vi0ZYj/T/b64nP0ebtiAf
         FNCk/8F01LYXJGArb0gGwbV4KGUZ1VER6U3OFRW6MawsoLY4ZYPmnlk3UhbeRFXCfDjh
         riSSaZixfero/LblE/wyYAnZc8e9BKjFNu8VrvEbnWHGV/6AMzdNUPzeExmRLbwh3XTV
         xBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6tUGFbQ7oA7pUDn55v/Wy+VlBUMSyXyYmPtvu2ws50=;
        b=Sys3/W31qVUouSR0uQMc3+g1cmJBLjuj0XxMJykPm3QxNqtt0SbUDNICxcAwrdvn6T
         fzLjDJqrcHMaHUVUbMpYl1CA0MAuJxmmyLZ75rDzE9ush+cS77izcmyk+TUhyI/uiHpV
         B/eqExTKFWMHAnLEWQpnNThtrlDjsfNbBM9H7B3rpcFfexu9OkR1E3sv5w3XnVHUq131
         bbTj9IADDJ5d3kWGX9kQm12kyjp7OFmNx4VsXENneocBz5CoQUF1ydr2ieCPvsf5tbWZ
         4mHIeZMIG41LDlq+Rr0lVR3TrzbLgJ+L3ZMPdmn6ipzJi2rwBnN1a+XCA79EJ5V4Txw3
         Ihlw==
X-Gm-Message-State: AO0yUKUCWh//FwLg1Kje0j1Mpb5P5wmFyyvMQ+xbZWtrDvdQphgrNIpr
        xxewS0zeH2d3BBdEzQ4XOHsgKQ==
X-Google-Smtp-Source: AK7set/Ym4uNmH4ker5UTWxzfE7MOeCqeY26Mt3utH2TftFJqHph2kbqZKF7D3tT1nW8fuqt1SHCRA==
X-Received: by 2002:aa7:c6c6:0:b0:4bf:1989:9e87 with SMTP id b6-20020aa7c6c6000000b004bf19899e87mr28871962eds.20.1678533244417;
        Sat, 11 Mar 2023 03:14:04 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id q12-20020a50c34c000000b004bf2d58201fsm1053859edb.35.2023.03.11.03.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:14:04 -0800 (PST)
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
Subject: [PATCH 1/4] Bluetooth: hci_ll: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:13:51 +0100
Message-Id: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/bluetooth/hci_ll.c:769:34: error: ‘hci_ti_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/hci_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 5abc01a2acf7..4a0b5c3160c2 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -786,7 +786,7 @@ MODULE_DEVICE_TABLE(of, hci_ti_of_match);
 static struct serdev_device_driver hci_ti_drv = {
 	.driver		= {
 		.name	= "hci-ti",
-		.of_match_table = of_match_ptr(hci_ti_of_match),
+		.of_match_table = hci_ti_of_match,
 	},
 	.probe	= hci_ti_probe,
 	.remove	= hci_ti_remove,
-- 
2.34.1

