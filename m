Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D786DC27C7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 22:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346934AbjHPWcZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346928AbjHPWby (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 18:31:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0519125
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 15:31:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc8045e09dso46666605ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692225111; x=1692829911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHCnStYv3VpHCvWJ+Rqq7y9urXTVeJpgi7x1cxy6CdQ=;
        b=ZTzzUPmizDrDGboO8jNNp8fXAOeP/lBurztSX1MfAS+hxSjDvUCE56n/5gAP1NTM4F
         88xnixP6bxI3R4xBzo6QFkf8hcvvvsWEJrCxp+UcAPc0HqUnLAfG6UcOLSKg8seCbzfv
         k6PJx9NkQGCkV1JhhuCBDWwTl5lTjTwD0Kx21FQmpQfJ4YDOItajCd7Vr8pEM/4GHLfd
         DLA3Y44ZkucynqQ2QGFOxlLj9eiOq5e3KtNzQHB1vlmxNCTCoXYat8M6n1wys7KwBPbm
         1xmIH6DYzlDnGkC6vjaetBcGnr64hYIrDcFZt66AEm37gKP/Gw6c+D51sNpi+wTs/aOM
         5N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692225111; x=1692829911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHCnStYv3VpHCvWJ+Rqq7y9urXTVeJpgi7x1cxy6CdQ=;
        b=kjVSUYpeUxUg7SM1ZBlngDgJdIQLfXP0yEHX8a6nOaO53E1DyCX77hxY5johunK6bf
         VNS+9aIl4Vw3BAdK7+MLeFpLknKAS26V/dyck3rhjTglHnpYdom0INP2hiCZD0IPytaU
         hG0jMEJK6gV53i97IkXaNtR0hlOxO/5GFXghQgnzVfRA0ON9Hy5U5sreIlPivbAvfpT8
         qERLafiaOY1NMbFZ+p/mvST8rlzM2BD9dEziA24eainNh4O9FgBxqdyoovHR3qFyA51p
         RU9I5Tmlgpky0RyEFFtGVtfJqNQiM01m5MKWjbAmJkp53l6B2fXrvyeLzwnhS7r7kWry
         nqEg==
X-Gm-Message-State: AOJu0YwGjLrvvmCRQ+18LBlW6rXbjVs20Eiue1y/GvdAwKLJsYIOMvp7
        2ilKqwQoilo7mJkqlL+QwCBK21EQ1rs=
X-Google-Smtp-Source: AGHT+IHI6USqwexVzdsVYJC0YvJdWHHhhkKGX2jnsuAxKozLOZg9Qh4GRXm9WVDfLljcMgKcvkzEZQ==
X-Received: by 2002:a17:902:ea08:b0:1b3:ea47:796c with SMTP id s8-20020a170902ea0800b001b3ea47796cmr3183104plg.29.1692225111529;
        Wed, 16 Aug 2023 15:31:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001993a1fce7bsm13582347plk.196.2023.08.16.15.31.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:31:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor: Detect LE-ACL connections
Date:   Wed, 16 Aug 2023 15:31:47 -0700
Message-ID: <20230816223147.2787284-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816223147.2787284-1-luiz.dentz@gmail.com>
References: <20230816223147.2787284-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables LE-ACL connections to be detected by processing its events
otherwise they would be assumed to be BR-ACL. Also make sure that LE-ISO
address is set based on its ACL link.
---
 monitor/analyze.c | 88 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 608ef4d77c85..3cc482cd9227 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -71,6 +71,7 @@ struct hci_stats {
 
 struct hci_conn {
 	uint16_t handle;
+	uint16_t link;
 	uint8_t type;
 	uint8_t bdaddr[6];
 	bool setup_seen;
@@ -290,6 +291,20 @@ static struct hci_conn *conn_lookup(struct hci_dev *dev, uint16_t handle)
 						UINT_TO_PTR(handle));
 }
 
+static bool link_match_handle(const void *a, const void *b)
+{
+	const struct hci_conn *conn = a;
+	uint16_t handle = PTR_TO_UINT(b);
+
+	return (conn->link == handle && !conn->terminated);
+}
+
+static struct hci_conn *link_lookup(struct hci_dev *dev, uint16_t handle)
+{
+	return queue_find(dev->conn_list, link_match_handle,
+						UINT_TO_PTR(handle));
+}
+
 static struct hci_conn *conn_lookup_type(struct hci_dev *dev, uint16_t handle,
 								uint8_t type)
 {
@@ -297,7 +312,7 @@ static struct hci_conn *conn_lookup_type(struct hci_dev *dev, uint16_t handle,
 
 	conn = queue_find(dev->conn_list, conn_match_handle,
 						UINT_TO_PTR(handle));
-	if (!conn || conn->type != type) {
+	if (!conn || (type && conn->type != type)) {
 		conn = conn_alloc(dev, handle, type);
 		queue_push_tail(dev->conn_list, conn);
 	}
@@ -542,6 +557,42 @@ static void plot_add(struct queue *queue, struct timeval *latency,
 	queue_push_tail(queue, plot);
 }
 
+static void evt_le_conn_complete(struct hci_dev *dev, struct timeval *tv,
+					struct iovec *iov)
+{
+	const struct bt_hci_evt_le_conn_complete *evt;
+	struct hci_conn *conn;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status)
+		return;
+
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), CONN_LE_ACL);
+	if (!conn)
+		return;
+
+	memcpy(conn->bdaddr, evt->peer_addr, 6);
+	conn->setup_seen = true;
+}
+
+static void evt_le_enh_conn_complete(struct hci_dev *dev, struct timeval *tv,
+					struct iovec *iov)
+{
+	const struct bt_hci_evt_le_enhanced_conn_complete *evt;
+	struct hci_conn *conn;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status)
+		return;
+
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), CONN_LE_ACL);
+	if (!conn)
+		return;
+
+	memcpy(conn->bdaddr, evt->peer_addr, 6);
+	conn->setup_seen = true;
+}
+
 static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 					const void *data, uint16_t size)
 {
@@ -612,7 +663,7 @@ static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
 					struct iovec *iov)
 {
 	const struct bt_hci_evt_le_cis_established *evt;
-	struct hci_conn *conn;
+	struct hci_conn *conn, *link;
 
 	evt = util_iov_pull_mem(iov, sizeof(*evt));
 	if (!evt || evt->status)
@@ -624,6 +675,27 @@ static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
 		return;
 
 	conn->setup_seen = true;
+
+	link = link_lookup(dev, conn->handle);
+	if (link)
+		memcpy(conn->bdaddr, link->bdaddr, 6);
+}
+
+static void evt_le_cis_req(struct hci_dev *dev, struct timeval *tv,
+					struct iovec *iov)
+{
+	const struct bt_hci_evt_le_cis_req *evt;
+	struct hci_conn *conn;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt)
+		return;
+
+	conn = conn_lookup(dev, le16_to_cpu(evt->acl_handle));
+	if (!conn)
+		return;
+
+	conn->link = le16_to_cpu(evt->cis_handle);
 }
 
 static void evt_le_big_complete(struct hci_dev *dev, struct timeval *tv,
@@ -685,9 +757,18 @@ static void evt_le_meta_event(struct hci_dev *dev, struct timeval *tv,
 		return;
 
 	switch (subevt) {
+	case BT_HCI_EVT_LE_CONN_COMPLETE:
+		evt_le_conn_complete(dev, tv, &iov);
+		break;
+	case BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE:
+		evt_le_enh_conn_complete(dev, tv, &iov);
+		break;
 	case BT_HCI_EVT_LE_CIS_ESTABLISHED:
 		evt_le_cis_established(dev, tv, &iov);
 		break;
+	case BT_HCI_EVT_LE_CIS_REQ:
+		evt_le_cis_req(dev, tv, &iov);
+		break;
 	case BT_HCI_EVT_LE_BIG_COMPLETE:
 		evt_le_big_complete(dev, tv, &iov);
 		break;
@@ -811,8 +892,7 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	dev->num_hci++;
 	dev->num_acl++;
 
-	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
-								CONN_BR_ACL);
+	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff, 0x00);
 	if (!conn)
 		return;
 
-- 
2.41.0

