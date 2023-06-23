Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8898EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 21:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjFWVZq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFWVYo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 17:24:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A02626BD
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:24:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so712667b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687555482; x=1690147482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=amEudiRBJEwgOHfrj8/QOr9vZYNBUy0UYt+Ok7aslmU=;
        b=Oes70nTI13EyD3CNV6fPyS+34se+5HKspV1cCYy6DGVLJorrgbE+VIf2mtwj2v+gU9
         /kwKOLRCgFIcXvIr37bxAoYY/uKtXaCQ/HVuatEYUvpyHQW30yNTBv8H23DI8QYRNmGS
         a+TY1nBeSYnyXZI7K2Cs5UhfGwRdfvBiVBF8cms1EpVXjc9HdxRG+vbDIbpRky9s5UrW
         TgUkrup0BOSxuf7aFii40Lbm4R/MxpRzPomfRFJA7t/JpN6R3oYHH+ybix5zZ2sqOGVe
         eKHQq4x3+qgM+ndvn0vKpc8f0HvSaWBq+7zoc8WIJeRIHrSsuj3qdk0ZH4NgeG78fmtR
         kAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687555482; x=1690147482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amEudiRBJEwgOHfrj8/QOr9vZYNBUy0UYt+Ok7aslmU=;
        b=HP1EmX2DHvO3wLLIFCCz4BfuKeR+Mk++Ec3/tIo6BVF2po3YmmzpqezUp5HZ4LN3Yi
         U5ts8JpMl0kwXPtxO7BxaUB7NoTIIeLrN6OUyoKo5WpNql1NYbJfhi3+rjJVYrT+xE/8
         Vj+1cVzKfSzcatF7JwYJLM/cAtiMCUC6uTPZwO+gNSVuLUWv9btI8ANTdwTTewPadnd6
         5icMrj4B5Wy1wRdLkTVVxkB4LZnPe0VSDNPsT9ND52J2g1qQQm8Bjdv0lmgkAVuhJgF6
         2ndHn4T59DRljl+9e078O/AGh0B2QXtnnlsVyNHF0MOy8PSOFM/DY9MqLfMzfcPFrxil
         qhng==
X-Gm-Message-State: AC+VfDwTaEYZV9fXbFGy+mWjmX60g3DWpAENj5S/9rnWYlRvjCdfTXM8
        NXbPRP0DHa2C/3WTFoYXp135CEN6k2gNtQ==
X-Google-Smtp-Source: ACHHUZ7sgTR5h7a3zi3snzoWkxGp3n0uLXJJPskTDgJhDijOcK5SaW5jVj6x/j7MgHq4yobZnlKJ8Q==
X-Received: by 2002:a05:6a21:118c:b0:119:5af7:7cd2 with SMTP id oj12-20020a056a21118c00b001195af77cd2mr10078180pzb.24.1687555481708;
        Fri, 23 Jun 2023 14:24:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id x11-20020aa793ab000000b00659af3079d3sm17854pff.16.2023.06.23.14.24.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:24:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
Date:   Fri, 23 Jun 2023 14:24:39 -0700
Message-Id: <20230623212439.1702413-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_event.c | 45 ++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b1aefe4bb751..77cbf13037b3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
 	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 
@@ -6846,21 +6847,39 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 
-	if (conn->role == HCI_ROLE_SLAVE) {
-		__le32 interval;
+	qos = &conn->iso_qos;
 
-		memset(&interval, 0, sizeof(interval));
+	/* Convert ISO Interval (1.25 ms slots) to SDU Interval (us) */
+	qos->ucast.in.interval = le16_to_cpu(ev->interval) * 1250;
+	qos->ucast.out.interval = qos->ucast.in.interval;
 
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
+		/* Convert Transport Latency (us) to Latency (msec) */
+		qos->ucast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
+					  1000);
+		qos->ucast.out.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
+					  1000);
+		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.in.phy = ev->c_phy;
+		qos->ucast.out.phy = ev->p_phy;
+		break;
+	case HCI_ROLE_MASTER:
+		/* Convert Transport Latency (us) to Latency (msec) */
+		qos->ucast.out.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
+					  1000);
+		qos->ucast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
+					  1000);
+		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
+		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.out.phy = ev->c_phy;
+		qos->ucast.in.phy = ev->p_phy;
+		break;
 	}
 
 	if (!ev->status) {
-- 
2.40.1

