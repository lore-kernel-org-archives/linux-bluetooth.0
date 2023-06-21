Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32194EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 19:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjFUTyO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFUTyM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 15:54:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9E186
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 12:54:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66615629689so5318695b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687377250; x=1689969250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlaXA8R5NjvQ8yQihVGSonTckZ3rsSciI1XtnrP85Do=;
        b=bKSstTHtxclMjA9iVMSxboiVL8lkzWOLm/mX+M5oG7sZ33rMYOVsaDN2JcXr1YSh4S
         OKVXY4WXgXlKSO64FM1BRpP7oaFcNRlhC8UWKP95ooKvDMj9fLfH+vUyuGQJxQaQrrZi
         mOJ/tY+as22wRL0lC1ieSd1z0rIDYI43Et7a05ma6rwLbIv/wTqU9jLGjgiiGpEwY2oJ
         mOKBMQSAdnBsjQqXQQ9o+ABKfyg9mUozwAoGo7YVmVWMhG11d6JJUjti9/iTaFR2CfqT
         voD1Z2YilXVULN7alyxWIjo8apk7wualKZlXUoEj2DdiJcH1WMBvTFnDV3j+IIr4JrJO
         cbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377250; x=1689969250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlaXA8R5NjvQ8yQihVGSonTckZ3rsSciI1XtnrP85Do=;
        b=Qba2oEmbvFIV9le/Fprkc/CASoZkP1GpM0zNXyvRQZYyuSiaz4tJh7bZaqKm0PHUFu
         v133BfThtVkz3cOBq//hZs1R4J4jqbSBibT8EOVKkwxRw3JLTV3gkAl1IG8Jm/0VDXqC
         /5noL6yYTnV1IziVTDq6ePX8/umWKPJKJXFJIvKtjlS4rTbfuE0dPvhJ0Ng+v7HeJ/U9
         Z5S8ID6AgKKjHIfoHNpVzk3V7QCaVi8PbrdUjOy+uQu4ZHyKuJiQU48BupqjalY0VCkm
         UYUt9THEXDyLd+4vElqhEv9kRH5Vobj8mmsSeCkWLrmEAYxgpARp5zk6MRWi/K4u5JS1
         mbPw==
X-Gm-Message-State: AC+VfDxpgESNamzXXZjHdcGVUCoINRm9Roo5JwZRTDn4I0vphM1e7j47
        cmd9vVs1x+LEKfx5clLs8HHuO4yZZxqJbg==
X-Google-Smtp-Source: ACHHUZ53e0lByOYXpKJRWBHWleg8y731zALKsJGn1X5VYwcUSoagZ3VXiukPlpSZGfVx7U7MzOysXw==
X-Received: by 2002:a17:903:41d0:b0:1b5:5a5f:367c with SMTP id u16-20020a17090341d000b001b55a5f367cmr11803318ple.69.1687377249543;
        Wed, 21 Jun 2023 12:54:09 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001b682336f83sm3584044plw.42.2023.06.21.12.54.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:54:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: Fix parsing of CIS Established Event
Date:   Wed, 21 Jun 2023 12:54:07 -0700
Message-Id: <20230621195407.977001-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The ISO Interval on CIS Established Event uses 1.25 ms slots:

    BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
    page 2304:

      Time = N * 1.25 ms

In addition to that this always update the QoS settings based on CIS
Established Event.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b1aefe4bb751..6fca6d9f1b34 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 
@@ -6846,21 +6847,30 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 
-	if (conn->role == HCI_ROLE_SLAVE) {
-		__le32 interval;
+	qos = &conn->iso_qos;
 
-		memset(&interval, 0, sizeof(interval));
+	/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
+	qos->ucast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
+	/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
+	qos->ucast.out.latency = le16_to_cpu(ev->interval) * 125 / 100;
 
-		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
-		conn->iso_qos.ucast.in.interval = le32_to_cpu(interval);
-		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
-		conn->iso_qos.ucast.out.interval = le32_to_cpu(interval);
-		conn->iso_qos.ucast.in.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.ucast.out.latency = le16_to_cpu(ev->interval);
-		conn->iso_qos.ucast.in.sdu = le16_to_cpu(ev->c_mtu);
-		conn->iso_qos.ucast.out.sdu = le16_to_cpu(ev->p_mtu);
-		conn->iso_qos.ucast.in.phy = ev->c_phy;
-		conn->iso_qos.ucast.out.phy = ev->p_phy;
+	switch (conn->role) {
+	case HCI_ROLE_SLAVE:
+		qos->ucast.in.interval = get_unaligned_le24(ev->c_latency);
+		qos->ucast.out.interval = get_unaligned_le24(ev->p_latency);
+		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.in.phy = ev->c_phy;
+		qos->ucast.out.phy = ev->p_phy;
+		break;
+	case HCI_ROLE_MASTER:
+		qos->ucast.out.interval = get_unaligned_le24(ev->c_latency);
+		qos->ucast.in.interval = get_unaligned_le24(ev->p_latency);
+		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.out.phy = ev->c_phy;
+		qos->ucast.in.phy = ev->p_phy;
+		break;
 	}
 
 	if (!ev->status) {
-- 
2.40.1

