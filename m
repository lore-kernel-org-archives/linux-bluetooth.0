Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67238C41513
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjHAXcC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHAXbv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:31:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF87268E
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:31:44 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-790ca0ed6d3so31921239f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932703; x=1691537503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVMcQ/mN4qzoaXflcSf8aSfstIOnnWhVxxJ+tu9PHtI=;
        b=Ivie46mRW9uSTezbQ8QV5LZ2qxLXoONT1Ypjj606L4Yz9VpEvA9C48iCcQiZQgJeNg
         Lh601km2DrO4993f7Ymtx7Gutlme4Brjbjb42pjHIwHY3fc07cdqfK3XOdFzHtCxYWq9
         S01nab6kEv1LaTggO2wWl5lPQTe2sppHBG7Aqhfc7UE9SKz49jNHOcuQ0BOWzZyIyzTj
         FDzyop87QDIMVfuDaSDDS7u1T6cpQDxyvVkZkpeq3LnbVwqZlnME0IO+l8BrEyHtta10
         pe7w4g+7NlVsfahktn4eyJ63U2Km5Ad8Lry074roFuQ7MIB8cIL0blrgxlLTfGvBIMmU
         XYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932703; x=1691537503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVMcQ/mN4qzoaXflcSf8aSfstIOnnWhVxxJ+tu9PHtI=;
        b=Kw7aEs3YY0GvysVkQAnVttEUP6pdNGCN6ZkcRNk4oKf8cRO3z/owKMCWo/GaUeFanj
         lWbAzVFR+mE1MxpLBVm6ITPYyNs9zH8jCXkt2QRpsYE2sNX9LEzqzaXuozHKFFrPKM99
         8VtpGCjYzCThZteOBifxTQ3xXQlcu/+Z5a38S7SoNnsUM7R5ktlqxNbjCSO2WetB6qJh
         eOqFwcxO9ft777KnPZ8y1UQx7afV73zwb1wXztb0i5+JPbyk7GJW564cFMUjafhMJZ4r
         Y5h5n6kpBK3Vur8Q96YJYdPzBGfsjq76xme39dMPnrEVliuq6IoXUeLQ8j/mVRMqYCx1
         BHcA==
X-Gm-Message-State: ABy/qLZmKFT6yUXrOJ/4y+WhRfjRO2qoo5e1bm3W4SuAgvO8xCVFxJ7N
        X1eRSckKRMKSb+WmgN0rJAmE+IwFKVs=
X-Google-Smtp-Source: APBJJlEouG445VIof3f0/uLhCbZyqfgHc0kqNBxLlKyaN6Amv3ZDa6c52gFkzDWRgxC1GPwYAgx5yw==
X-Received: by 2002:a6b:4a14:0:b0:783:4e11:76d7 with SMTP id w20-20020a6b4a14000000b007834e1176d7mr11245553iob.21.1690932703004;
        Tue, 01 Aug 2023 16:31:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id d20-20020a5d9bd4000000b00790af7745b1sm1286269ion.20.2023.08.01.16.31.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:31:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 4/5] monitor: Add connection tracking for SCO/ISO with -a/--analyze
Date:   Tue,  1 Aug 2023 16:31:34 -0700
Message-ID: <20230801233135.537864-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801233135.537864-1-luiz.dentz@gmail.com>
References: <20230801233135.537864-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper connection tracking to SCO/ISO connection by handling
the events that establishes them.
---
 monitor/analyze.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 89b0382825dc..d0ad70d5dc74 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -253,7 +253,9 @@ static void conn_destroy(void *data)
 			TV_MSEC(conn->tx_l.med));
 	print_field("%u-%u octets (~%u octets) TX packet size",
 			conn->tx_pkt_min, conn->tx_pkt_max, conn->tx_pkt_med);
-	print_field("~%lld Kb/s TX transfer speed",
+
+	if (TV_MSEC(conn->tx_l.total))
+		print_field("~%lld Kb/s TX transfer speed",
 			conn->tx_bytes * 8 / TV_MSEC(conn->tx_l.total));
 
 	plot_draw(conn->plot);
@@ -595,9 +597,110 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 	}
 }
 
+static void evt_sync_conn_complete(struct hci_dev *dev, struct timeval *tv,
+					const void *data, uint16_t size)
+{
+	const struct bt_hci_evt_sync_conn_complete *evt = data;
+	struct hci_conn *conn;
+
+	if (evt->status)
+		return;
+
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), evt->link_type);
+	if (!conn)
+		return;
+
+	memcpy(conn->bdaddr, evt->bdaddr, 6);
+	conn->setup_seen = true;
+}
+
+static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
+					struct iovec *iov)
+{
+	const struct bt_hci_evt_le_cis_established *evt;
+	struct hci_conn *conn;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status)
+		return;
+
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->conn_handle),
+						CONN_LE_ISO);
+	if (!conn)
+		return;
+
+	conn->setup_seen = true;
+}
+
+static void evt_le_big_complete(struct hci_dev *dev, struct timeval *tv,
+					struct iovec *iov)
+{
+	const struct bt_hci_evt_le_big_complete *evt;
+	int i;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status)
+		return;
+
+	for (i = 0; i < evt->num_bis; i++) {
+		struct hci_conn *conn;
+		uint16_t handle;
+
+		if (!util_iov_pull_le16(iov, &handle))
+			return;
+
+		conn = conn_lookup_type(dev, handle, CONN_LE_ISO);
+		if (conn)
+			conn->setup_seen = true;
+	}
+}
+
+static void evt_le_big_sync_established(struct hci_dev *dev, struct timeval *tv,
+					struct iovec *iov)
+{
+	const struct bt_hci_evt_le_big_sync_estabilished *evt;
+	int i;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status)
+		return;
+
+	for (i = 0; i < evt->num_bis; i++) {
+		struct hci_conn *conn;
+		uint16_t handle;
+
+		if (!util_iov_pull_le16(iov, &handle))
+			return;
+
+		conn = conn_lookup_type(dev, handle, CONN_LE_ISO);
+		if (conn)
+			conn->setup_seen = true;
+	}
+}
+
 static void evt_le_meta_event(struct hci_dev *dev, struct timeval *tv,
 					const void *data, uint16_t size)
 {
+	struct iovec iov = {
+		.iov_base = (void *)data,
+		.iov_len = size,
+	};
+	uint8_t subevt;
+
+	if (!util_iov_pull_u8(&iov, &subevt))
+		return;
+
+	switch (subevt) {
+	case BT_HCI_EVT_LE_CIS_ESTABLISHED:
+		evt_le_cis_established(dev, tv, &iov);
+		break;
+	case BT_HCI_EVT_LE_BIG_COMPLETE:
+		evt_le_big_complete(dev, tv, &iov);
+		break;
+	case BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED:
+		evt_le_big_sync_established(dev, tv, &iov);
+		break;
+	}
 }
 
 static void event_pkt(struct timeval *tv, uint16_t index,
@@ -629,6 +732,9 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 	case BT_HCI_EVT_NUM_COMPLETED_PACKETS:
 		evt_num_completed_packets(dev, tv, data, size);
 		break;
+	case BT_HCI_EVT_SYNC_CONN_COMPLETE:
+		evt_sync_conn_complete(dev, tv, data, size);
+		break;
 	case BT_HCI_EVT_LE_META_EVENT:
 		evt_le_meta_event(dev, tv, data, size);
 		break;
-- 
2.41.0

