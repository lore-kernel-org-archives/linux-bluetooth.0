Return-Path: <SRS0=McSj=ON=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECBC04EBF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E582520850
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Dec 2018 20:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJxbWiZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E582520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeLDUQy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:16:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42205 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeLDUQf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Dec 2018 15:16:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so4030469plp.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Dec 2018 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwxN7F9W0dVELR0nkJk8X+8XSqeBdiskikKIS2ys58I=;
        b=mJxbWiZkDf85NBiALjxzf5AQsltqsqqwZ/ZwGM8Je/wNFGksA4zyad0h8VHyCh5nie
         MCAVtX0OqYi879syseM1JsQzubl5pcwadRxV99SCLP8UUawFFkrH7JFDT85nSeXF7G5L
         ue3jHCYj80D8fVyX3etTKLX7pyi74u8wqTzug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwxN7F9W0dVELR0nkJk8X+8XSqeBdiskikKIS2ys58I=;
        b=kjc7vjAxHZmFhGH3jOJSXQVmqCe0wKrI14xp/CDGX3lKmOUcYGi4IowayhwSn6BYuF
         Lk0tE4sTVwWlXj/HZO6lCjJk3jH94BY0LHQGumMROLSg1FKXRDrutZI6jvHqCrKJMsYt
         MJ5AHAAgN2DbfKFu5ckBUwGCwQWjEWnct6US6W7rGtOMdUAbRRkwPbIQVP45TTeEkAPv
         pMvm4qX1kkrJDD96cvq9t3Fo3RxiRGApztUGXQvQY/wQhRB0ur5UUmR8sLXN2LV6QKj7
         WYnNGgO7Fx+inXMLq5HZElJfvYdlXzkgFp9YjxBJyJUZJCZj84PimjPb/kOzaYcVCFoG
         VB2g==
X-Gm-Message-State: AA+aEWaac0nyYdOAIzITiUN93qiG+Y1lzFvw1LDHs9u31AgY+7UNluaY
        qD2fAuPl2Xnn/mdUY2xnHPqXGCM35OQ=
X-Google-Smtp-Source: AFSGD/UNjSmQPHObl6hML2iS/ZBJLWVNvRV6fp51l3u4OYB+1R89u6Y7N/lR36nZDLNHebVSEws/gg==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr20993495ply.261.1543954595439;
        Tue, 04 Dec 2018 12:16:35 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b185sm29499593pga.85.2018.12.04.12.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:16:34 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH RESEND v2 3/3] Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
Date:   Tue,  4 Dec 2018 12:16:15 -0800
Message-Id: <20181204201615.245574-4-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204201615.245574-1-mka@chromium.org>
References: <20181204201615.245574-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set quirk for wcn3990 to read BD_ADDR from a firmware node property.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v2:
- patch added to the series

tested with https://lore.kernel.org/patchwork/patch/1003830
("Bluetooth: hci_qca: Add helper to set device address.")
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea33..0535833caa52c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1193,6 +1193,7 @@ static int qca_setup(struct hci_uart *hu)
 		 * setup for every hci up.
 		 */
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
 		ret = qca_wcn3990_init(hu);
 		if (ret)
-- 
2.20.0.rc1.387.gf8505762e3-goog

