Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9FEEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 00:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjF0Abt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 20:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjF0Abr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 20:31:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81DD9
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 17:31:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668709767b1so2377330b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687825905; x=1690417905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=amEudiRBJEwgOHfrj8/QOr9vZYNBUy0UYt+Ok7aslmU=;
        b=T8GVKebN9PwOruFIKCIZSoTV+ARXw9Zi3sE4/75IGoKj9KOoY95u4CK9EssqcZnp0I
         oiUE9bjND7pWZNsNE5MIx5BpxnZB3aVAqdEiELnNAopTb/STm5kdfoKRiH90Catnq2As
         Mwb7ZBobsv+4kfaIIHAO4RUINcD8qzlYZnB6sMcQ5ctF0tqyUj2slUXxzb2IxAszxXGm
         VRyLPaGa0j3lTXbnyYwdOVm6/qjQY33RsTabc0EcR1tYl7yGGRIdRgIeR6A+JQ7UFoup
         AaWmRADLCK0NvsbbPiTXBET24zrh9rRvU1tWJEnHnmY/nZQL+WARX7x9lf1iDYWQIyZU
         T5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687825905; x=1690417905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amEudiRBJEwgOHfrj8/QOr9vZYNBUy0UYt+Ok7aslmU=;
        b=BpkYizklCUEyIXSeNe64Rh0ixrEZzz3xZkBXe7icRn5XvphvPAHY7m5PUAbP9LEuPT
         JyJLZTGeeylC/dp6f42voKxfj58BQQH2dY9EPu/7ToJf5lmpa8r/crW7cKX0L/2VqcgW
         w5x8Gsl3Zy5hxa5m0sg3bbByJ7qpWo5o5wtP8GAHXdVL71JTU5nAa0eE4qyUIFKaOaqa
         CNO+GRepsmNCRRvDamgYgYt1MDTBSux6EbrYr/3kd5fUe6uonZrJxw79/J2KeY8EDfXW
         JUQ7+OiL6LLL2RDW+5EegjbJHlSQuE3mV0LCiHn9xdM3o1wPm4LzFUeDb7S7aNI/5n24
         g0ng==
X-Gm-Message-State: AC+VfDxM06avMwISAHRB0HzPE5UNEvajZTpmqpb/McA13A3ipP8YkEu6
        Q2mzTLKFdUDzx8nNInSqk+E42VnboEVSs0Ub
X-Google-Smtp-Source: ACHHUZ70Jef3Ynwl4wulsIrYOd+SWX9T6U5Yst1S58IDHP++0QNXo3LvoNr1qKeC8nAlH8Pu6sesDg==
X-Received: by 2002:a05:6a21:7881:b0:121:ef3f:ed0b with SMTP id bf1-20020a056a21788100b00121ef3fed0bmr20892915pzc.60.1687825905015;
        Mon, 26 Jun 2023 17:31:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001b3a21fbb4fsm4750582plg.12.2023.06.26.17.31.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 17:31:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
Date:   Mon, 26 Jun 2023 17:31:42 -0700
Message-Id: <20230627003142.2274828-1-luiz.dentz@gmail.com>
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

