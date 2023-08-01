Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE34EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHAXVu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjHAXVu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:21:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177AD26A2
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:21:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f94328a4so233674b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932104; x=1691536904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVMcQ/mN4qzoaXflcSf8aSfstIOnnWhVxxJ+tu9PHtI=;
        b=ftngeHu+iENw+5okDXJAHNyJETlYVRvIIWBUPJTRdy6XkL4ANhMgcQzcoAQQEpbXTc
         r40Ms95cG6OBYG1LZ7BPKMFruGgeW3Sb0Q5Q9VktNq3NxMUKp2D4Gzpaz0/GqOBkSMGD
         Cjgh5Zg0Gl7eHU1/Nj5wHBvBOIIQaqe1j3AHyGfvfW+v4b/9CdeIYNqOzL8B5fYRalZm
         MJU1yQoy4v2Gkqq8cDLIXNwNjmJrWJ0rwzbdnkP6xLYXQeWOxMQc6HWDJaMNLTr5xfE1
         NOLUN9y5fTCv/x+kv/N0aM6tXDzzs2d4fFYdwrUQv8fkeS7yjDLMV+aXNRW/tUo0hrVR
         xQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932104; x=1691536904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVMcQ/mN4qzoaXflcSf8aSfstIOnnWhVxxJ+tu9PHtI=;
        b=DdZKwzNgYQfn2R2rlzbfd9NEM0C+PSS3Z8edOUe/JHQLZfhnz6x2pxQEX6ykfbUqVb
         zz0oNAMmj1D+avSHWJtiFs56TMlacOl8j5HEbzcBBcAQ36Px4k11TuPR4honSUiMm/T8
         SxUIZpRxDNd3FYFaLCqXjhDzajc4PhBFn+iQwKiGQFRwMaDQFIKd1YAnGtuOXh4F+pky
         fzqaZ06IM4fW7oCt1RcZa+EqNvduOHWCnro9xYi4yc9+f/ODV6IjwsRFNGGeYpfZMeQ0
         IcmSJQ/WiO6w5CGhw/UOp55fGpHT37T//dqH0FVvnKr5scIc+zg1ndMXsAwGGWMg65LF
         WR9A==
X-Gm-Message-State: ABy/qLay1559A3GIAoSdAV821Cq7sGcRV0osDH7DwGlrh+58eiypdg8L
        5/8AmYdpiqmlw+CPRUidIfD9LeabtK0=
X-Google-Smtp-Source: APBJJlEv8yFprpC46AEYFyPw4iQtfJLQGMWtwqQ868ApzOqiFUpNuq2NC8TehiH1kULNDc6bpEhnZg==
X-Received: by 2002:a05:6a20:6a1f:b0:137:c971:6a0c with SMTP id p31-20020a056a206a1f00b00137c9716a0cmr14380947pzk.31.1690932103619;
        Tue, 01 Aug 2023 16:21:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a8e600f0sm9856157pfb.35.2023.08.01.16.21.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:21:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 4/5] monitor: Add connection tracking for SCO/ISO with -a/--analyze
Date:   Tue,  1 Aug 2023 16:21:34 -0700
Message-ID: <20230801232135.535733-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232135.535733-1-luiz.dentz@gmail.com>
References: <20230801232135.535733-1-luiz.dentz@gmail.com>
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

