Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3BC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 00:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjHDALZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 20:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjHDALX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 20:11:23 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC16F4219
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 17:11:20 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63d09d886a3so9761296d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107879; x=1691712679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZguMEN4f74aIRZKEXf9LyElH7zH8nSS/jAeZs8ucaCo=;
        b=BavinnWpR/kosABK2UPY7GH5HO131sqW5UtT4YSGxwzL6tL1oyuhP3/v6D7bownGDt
         292PC0mcWwxVKgDmVgpiqgTGT23iIoGEoVMWFR6i2j4pB3YawIUr2qY3g5XYcOjtfc10
         fluGlFDtULeh4ev3HfYKBrqFDoCT+Sz8jn9mYLie1CKRTpQk+QKLZ81J4rWfieCoY/CC
         85zU3aVirgG/iQcCOgqyajNhFl5lf6J9lq0LCmabwy+qT2/htpm5QjC5C63hTCJ+/FQF
         DXM9DIghw/IYUIZmfUXjmqzsQbdJBz/pkGt++KgXSttPGiEJs78frr/ygkeZzKA86BpS
         +dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107879; x=1691712679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZguMEN4f74aIRZKEXf9LyElH7zH8nSS/jAeZs8ucaCo=;
        b=du41t9PJ+EzmF0uWd1jf/CNkLKBn0EtZrxTwKEKJ2nJ7Pj6frHd+lYUNp9NA5rdp8O
         OaaPxGwImFbmE5GWHwyXXdOc5BSqEmkpMri1RwKmaoN/v8xh0ccsaCuomWMJ+KH+1yRE
         tF9yWym+rXc3r/Ep9F8TLXumN4OCMBc6swb+aCw+WgaljEHFyvJFIoQdZ8x8NgIbBWqW
         h6WAZiYBTOZnZXYeW3mPk9Bwh3XSHHxan10jisNifOdJx2doI9PoK8F2lGBKsOKW+qtp
         Yc60Pd74+H+ei842GAk5TwWp2BGObSMNuNamuPfOODkQJSj865gyh5Mvlz4ZsTBmDyQh
         Cgdw==
X-Gm-Message-State: AOJu0YzZTR863rZuVvFwwwtLsn4EgFLC8AcC4ufqXRKhiiPPiQSV7hwL
        cvdRvtYo1xLCeq2SClNNxD+hq3TjlLk=
X-Google-Smtp-Source: AGHT+IHoeWqxKxYEX1oUraItKY0EVGPzLDpcF95ZtSwTBLAUA3FLM9AzH92hdJA3xg55TB5oH3VH8A==
X-Received: by 2002:a0c:c406:0:b0:631:f6f1:87dd with SMTP id r6-20020a0cc406000000b00631f6f187ddmr174478qvi.8.1691107879041;
        Thu, 03 Aug 2023 17:11:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id y11-20020a0ce04b000000b0063c6c7f4b92sm272448qvk.1.2023.08.03.17.11.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:11:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: hci_sync: Fix handling of HCI_OP_CREATE_CONN_CANCEL
Date:   Thu,  3 Aug 2023 17:11:11 -0700
Message-ID: <20230804001115.907885-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When sending HCI_OP_CREATE_CONN_CANCEL it shall Wait for
HCI_EV_CONN_COMPLETE, not HCI_EV_CMD_STATUS, when the reason is
anything but HCI_ERROR_REMOTE_POWER_OFF. This reason is used when
suspending or powering off, where we don't want to wait for the peer's
response.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e114409628d1..a9b048d7b419 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5321,6 +5321,17 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
 
+	/* Wait for HCI_EV_CONN_COMPLETE, not HCI_EV_CMD_STATUS, when the
+	 * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This reason is
+	 * used when suspending or powering off, where we don't want to wait
+	 * for the peer's response.
+	 */
+	if (reason != HCI_ERROR_REMOTE_POWER_OFF)
+		return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN_CANCEL,
+						6, &conn->dst,
+						HCI_EV_CONN_COMPLETE,
+						HCI_CMD_TIMEOUT, NULL);
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_CREATE_CONN_CANCEL,
 				     6, &conn->dst, HCI_CMD_TIMEOUT);
 }
-- 
2.41.0

