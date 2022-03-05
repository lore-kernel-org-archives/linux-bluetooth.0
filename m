Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE51FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiCEBXf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiCEBXa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806628E36
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id kx1-20020a17090b228100b001bf2dd26729so2199514pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kLgLzYVc8A/ZbeNHx7AVn2c3UDsNrYm1LuYu8aNKta4=;
        b=jbP7x3qkbkWW31V1p1Lj+k4UuIVH7XZEJyP0WaBc3LLj2PDWtLo5nSlO2n4DITy8Hu
         raKsy+Qper8+owjxWmszXxtPcr7nzQiP4HX9QKgAi6YYOzXmZpLWsvcsKzMGBY3abfgC
         M7ZeMOeXWEkDkLKhoJ1y15XUmLw6I+RWZ/pXZWHWsL7XfJHIQVfJU1N1Xh/n8n9soyqj
         265gw7MJhPYLD+20jGNtjRx6efyWxN9K7Tyw/ywGTsfTgMBKInRiHKR9u1Rccq3ikccg
         x5rtEwO3Wb6jFdHefP5w4xI+iiAJzUA5cHhTYB+CDqIGIQMur4S8wgN4hJHvHeKcQU2C
         OySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLgLzYVc8A/ZbeNHx7AVn2c3UDsNrYm1LuYu8aNKta4=;
        b=Ox3PYm2v/UTeJmb4SfEjshJ+DxV1z4UeHlf+PRMbFfjJfXDpJjC1CYCsDDlOnE5WN1
         DcmLvyTGUrhblMhM7H2eV4tc2jr65L+UWsC/E+3wXCkF641MQtaPgrVQ3jCeLC/vJF+/
         zZT1ixQ3UKV5xyprkHazM/XwWzLDO3kkZEEIqrdPZVZpen4No6FxEwU91yakvnpjUnFV
         XmnFBfojf6pDj74lcy/QtJ/6OWjg++krUirh1qfH71PwJuBALHWVvXWoxroAMa8Bd+Qq
         KnDXLVcERX8t1ATERPZz3tTYaN40M7MgLRrRa6gAOjX6Eg7aLrOg/2cOgdDgkY0bN0Er
         XqJQ==
X-Gm-Message-State: AOAM530avIsaN+/xl0Eci3MoC9dYWPSoB2RSb1YSUSUbcQTBRIJvnSAR
        4pTFht6L3VEfJfAGwTtoN53Nq2Q7N5U=
X-Google-Smtp-Source: ABdhPJwrpGO991Z/hyqhc//cE83Ha0ryltjuZbSC+2k9oi5XV/nlGzfChZ4lH9ak7dCFu+boyVBsBw==
X-Received: by 2002:a17:902:690c:b0:151:b8ec:2048 with SMTP id j12-20020a170902690c00b00151b8ec2048mr1079763plk.163.1646443359296;
        Fri, 04 Mar 2022 17:22:39 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 10/12] bthost: Add support for BT_H4_ISO_PKT
Date:   Fri,  4 Mar 2022 17:22:27 -0800
Message-Id: <20220305012229.853784-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sending and receiving BT_H4_ISO_PKT packets.
---
 emulator/bthost.c | 356 ++++++++++++++++++++++++++++++++++++++++------
 emulator/bthost.h |  11 ++
 emulator/hciemu.c |   1 +
 monitor/bt.h      |   2 +
 4 files changed, 328 insertions(+), 42 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index d751e7dd4..54a2728e0 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -37,6 +37,9 @@
 #define acl_handle(h)		(h & 0x0fff)
 #define acl_flags(h)		(h >> 12)
 
+#define iso_flags_pb(f)		(f & 0x0003)
+#define iso_data_len_pack(h, f)	((uint16_t) ((h) | ((f) << 14)))
+
 #define L2CAP_FEAT_FIXED_CHAN	0x00000080
 #define L2CAP_FC_SIG_BREDR	0x02
 #define L2CAP_FC_SMP_BREDR	0x80
@@ -131,6 +134,11 @@ struct rfcomm_chan_hook {
 	struct rfcomm_chan_hook *next;
 };
 
+struct iso_hook {
+	bthost_cid_hook_func_t func;
+	void *user_data;
+};
+
 struct btconn {
 	uint16_t handle;
 	uint8_t bdaddr[6];
@@ -142,8 +150,12 @@ struct btconn {
 	struct rcconn *rcconns;
 	struct cid_hook *cid_hooks;
 	struct rfcomm_chan_hook *rfcomm_chan_hooks;
+	struct iso_hook *iso_hook;
 	struct btconn *next;
 	void *smp_data;
+	uint16_t recv_len;
+	uint16_t data_len;
+	void *recv_data;
 };
 
 struct l2conn {
@@ -203,9 +215,6 @@ struct bthost {
 	uint8_t bdaddr[6];
 	uint8_t features[8];
 	bthost_send_func send_handler;
-	uint16_t acl_len;
-	uint16_t l2_len;
-	void *acl_data;
 	void *send_data;
 	struct cmd_queue cmd_q;
 	uint8_t ncmd;
@@ -214,6 +223,8 @@ struct bthost {
 	void *cmd_complete_data;
 	bthost_new_conn_cb new_conn_cb;
 	void *new_conn_data;
+	bthost_new_conn_cb new_iso_cb;
+	void *new_iso_data;
 	struct rfcomm_connection_data *rfcomm_conn_data;
 	struct l2cap_conn_cb_data *new_l2cap_conn_data;
 	struct rfcomm_conn_cb_data *new_rfcomm_conn_data;
@@ -295,6 +306,8 @@ static void btconn_free(struct btconn *conn)
 		free(hook);
 	}
 
+	free(conn->iso_hook);
+	free(conn->recv_data);
 	free(conn);
 }
 
@@ -494,7 +507,6 @@ void bthost_destroy(struct bthost *bthost)
 
 	queue_destroy(bthost->le_ext_adv, le_ext_adv_free);
 
-	free(bthost->acl_data);
 	free(bthost);
 }
 
@@ -663,6 +675,28 @@ void bthost_add_cid_hook(struct bthost *bthost, uint16_t handle, uint16_t cid,
 	conn->cid_hooks = hook;
 }
 
+void bthost_add_iso_hook(struct bthost *bthost, uint16_t handle,
+				bthost_cid_hook_func_t func, void *user_data)
+{
+	struct iso_hook *hook;
+	struct btconn *conn;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn || conn->iso_hook)
+		return;
+
+	hook = malloc(sizeof(*hook));
+	if (!hook)
+		return;
+
+	memset(hook, 0, sizeof(*hook));
+
+	hook->func = func;
+	hook->user_data = user_data;
+
+	conn->iso_hook = hook;
+}
+
 void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t len)
 {
@@ -687,6 +721,52 @@ void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 	send_iov(bthost, handle, cid, iov, iovcnt);
 }
 
+static void send_iso(struct bthost *bthost, uint16_t handle,
+					const struct iovec *iov, int iovcnt)
+{
+	struct bt_hci_iso_hdr iso_hdr;
+	struct bt_hci_iso_data_start data_hdr;
+	uint8_t pkt = BT_H4_ISO_PKT;
+	struct iovec pdu[3 + iovcnt];
+	int i, len = 0;
+	static uint16_t sn;
+
+	for (i = 0; i < iovcnt; i++) {
+		pdu[3 + i].iov_base = iov[i].iov_base;
+		pdu[3 + i].iov_len = iov[i].iov_len;
+		len += iov[i].iov_len;
+	}
+
+	pdu[0].iov_base = &pkt;
+	pdu[0].iov_len = sizeof(pkt);
+
+	iso_hdr.handle = acl_handle_pack(handle, 0x02);
+	iso_hdr.dlen = cpu_to_le16(len + sizeof(data_hdr));
+
+	pdu[1].iov_base = &iso_hdr;
+	pdu[1].iov_len = sizeof(iso_hdr);
+
+	data_hdr.sn = cpu_to_le16(sn++);
+	data_hdr.slen = cpu_to_le16(iso_data_len_pack(len, 0));
+
+	pdu[2].iov_base = &data_hdr;
+	pdu[2].iov_len = sizeof(data_hdr);
+
+	send_packet(bthost, pdu, 3 + iovcnt);
+}
+
+void bthost_send_iso(struct bthost *bthost, uint16_t handle,
+					const struct iovec *iov, int iovcnt)
+{
+	struct btconn *conn;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return;
+
+	send_iso(bthost, handle, iov, iovcnt);
+}
+
 bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t code,
 				const void *data, uint16_t len,
 				bthost_l2cap_rsp_cb cb, void *user_data)
@@ -1337,6 +1417,40 @@ static void evt_le_ltk_request(struct bthost *bthost, const void *data,
 								sizeof(cp));
 }
 
+static void init_iso(struct bthost *bthost, uint16_t handle,
+				const uint8_t *bdaddr, uint8_t addr_type)
+{
+	struct btconn *conn;
+
+	bthost_debug(bthost, "ISO handle 0x%4.4x", handle);
+
+	conn = malloc(sizeof(*conn));
+	if (!conn)
+		return;
+
+	memset(conn, 0, sizeof(*conn));
+	conn->handle = handle;
+	memcpy(conn->bdaddr, bdaddr, 6);
+	conn->addr_type = addr_type;
+
+	conn->next = bthost->conns;
+	bthost->conns = conn;
+
+	if (bthost->new_iso_cb)
+		bthost->new_iso_cb(handle, bthost->new_iso_data);
+}
+
+static void evt_le_cis_established(struct bthost *bthost, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_evt_le_cis_established *ev = data;
+
+	if (ev->status)
+		return;
+
+	init_iso(bthost, ev->conn_handle, BDADDR_ANY->b, BDADDR_LE_PUBLIC);
+}
+
 static void evt_le_cis_req(struct bthost *bthost, const void *data, uint8_t len)
 {
 	const struct bt_hci_evt_le_cis_req *ev = data;
@@ -1384,6 +1498,38 @@ static void evt_le_ext_adv_report(struct bthost *bthost, const void *data,
 	}
 }
 
+static void evt_le_big_complete(struct bthost *bthost, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_evt_le_big_complete *ev = data;
+	int i;
+
+	if (ev->status)
+		return;
+
+	for (i = 0; i < ev->num_bis; i++) {
+		uint16_t handle = le16_to_cpu(ev->bis_handle[i]);
+
+		init_iso(bthost, handle, BDADDR_ANY->b, BDADDR_LE_PUBLIC);
+	}
+}
+
+static void evt_le_big_sync_established(struct bthost *bthost,
+						const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_sync_estabilished *ev = data;
+	int i;
+
+	if (ev->status)
+		return;
+
+	for (i = 0; i < ev->num_bis; i++) {
+		uint16_t handle = le16_to_cpu(ev->bis[i]);
+
+		init_iso(bthost, handle, BDADDR_ANY->b, BDADDR_LE_PUBLIC);
+	}
+}
+
 static void evt_le_meta_event(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1393,7 +1539,7 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	if (len < 1)
 		return;
 
-	bthost_debug(bthost, "event 0x%02x", *event);
+	bthost_debug(bthost, "meta event 0x%02x", *event);
 
 	switch (*event) {
 	case BT_HCI_EVT_LE_CONN_COMPLETE:
@@ -1414,9 +1560,18 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_EXT_ADV_REPORT:
 		evt_le_ext_adv_report(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_CIS_ESTABLISHED:
+		evt_le_cis_established(bthost, evt_data, len - 1);
+		break;
 	case BT_HCI_EVT_LE_CIS_REQ:
 		evt_le_cis_req(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_BIG_COMPLETE:
+		evt_le_big_complete(bthost, evt_data, len - 1);
+		break;
+	case BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED:
+		evt_le_big_sync_established(bthost, evt_data, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
 								*event);
@@ -2437,22 +2592,14 @@ static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
 	}
 }
 
-static void process_l2cap(struct bthost *bthost, uint16_t handle,
+static void process_l2cap(struct bthost *bthost, struct btconn *conn,
 					const void *data, uint16_t len)
 {
 	const struct bt_l2cap_hdr *l2_hdr = data;
 	struct cid_hook *hook;
-	struct btconn *conn;
 	struct l2conn *l2conn;
 	uint16_t cid, l2_len;
 
-	conn = bthost_find_conn(bthost, handle);
-	if (!conn) {
-		bthost_debug(bthost, "ACL data for unknown handle 0x%04x",
-								handle);
-		return;
-	}
-
 	l2_len = le16_to_cpu(l2_hdr->len);
 	if (len != sizeof(*l2_hdr) + l2_len) {
 		bthost_debug(bthost, "L2CAP invalid length: %u != %zu",
@@ -2496,36 +2643,55 @@ static void process_l2cap(struct bthost *bthost, uint16_t handle,
 	}
 }
 
-static void append_acl_data(struct bthost *bthost, uint16_t handle,
-				uint8_t flags, const void *data, uint16_t len)
+static void append_recv_data(struct bthost *bthost, struct btconn *conn,
+				const char *type, uint8_t flags,
+				const void *data, uint16_t len)
 {
-	if (!bthost->acl_data) {
-		bthost_debug(bthost, "Unexpected ACL frame: handle 0x%4.4x "
-				"flags 0x%2.2x", handle, flags);
+	if (!conn->recv_data) {
+		bthost_debug(bthost, "Unexpected %s frame: handle 0x%4.4x "
+				"flags 0x%2.2x", type, conn->handle, flags);
 		return;
 	}
 
-	if (bthost->acl_len + len > bthost->l2_len) {
-		bthost_debug(bthost, "Unexpected ACL frame: handle 0x%4.4x "
-				"flags 0x%2.2x", handle, flags);
+	if (conn->recv_len + len > conn->data_len) {
+		bthost_debug(bthost, "Unexpected %s frame: handle 0x%4.4x "
+				"flags 0x%2.2x", type, conn->handle, flags);
 		return;
 	}
 
-	memcpy(bthost->acl_data + bthost->acl_len, data, len);
-	bthost->acl_len += len;
+	memcpy(conn->recv_data + conn->recv_len, data, len);
+	conn->recv_len += len;
 
-	bthost_debug(bthost, "ACL data: %u/%u bytes", bthost->acl_len,
-							bthost->l2_len);
+	bthost_debug(bthost, "%s data: %u/%u bytes", type, conn->recv_len,
+							conn->data_len);
+}
 
-	if (bthost->acl_len < bthost->l2_len)
+static void free_recv_data(struct btconn *conn)
+{
+	free(conn->recv_data);
+	conn->recv_data = NULL;
+	conn->recv_len = 0;
+	conn->data_len = 0;
+}
+
+static void append_acl_data(struct bthost *bthost, struct btconn *conn,
+				uint8_t flags, const void *data, uint16_t len)
+{
+	append_recv_data(bthost, conn, "ACL", flags, data, len);
+
+	if (conn->recv_len < conn->data_len)
 		return;
 
-	process_l2cap(bthost, handle, bthost->acl_data, bthost->acl_len);
+	process_l2cap(bthost, conn, conn->recv_data, conn->recv_len);
 
-	free(bthost->acl_data);
-	bthost->acl_data = NULL;
-	bthost->acl_len = 0;
-	bthost->l2_len = 0;
+	free_recv_data(conn);
+}
+
+static void new_recv_data(struct btconn *conn, uint16_t len)
+{
+	conn->recv_data = malloc(len);
+	conn->recv_len = 0;
+	conn->data_len = len;
 }
 
 static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
@@ -2534,6 +2700,7 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	const struct bt_l2cap_hdr *l2_hdr = (void *) acl_hdr->data;
 	uint16_t handle, acl_len, l2_len;
 	uint8_t flags;
+	struct btconn *conn;
 
 	acl_len = le16_to_cpu(acl_hdr->dlen);
 	if (len != sizeof(*acl_hdr) + acl_len)
@@ -2542,14 +2709,18 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	handle = acl_handle(acl_hdr->handle);
 	flags = acl_flags(acl_hdr->handle);
 
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn) {
+		bthost_debug(bthost, "Unknown handle: 0x%4.4x", handle);
+		return;
+	}
+
 	switch (flags) {
 	case 0x00:	/* start of a non-automatically-flushable PDU */
 	case 0x02:	/* start of an automatically-flushable PDU */
-		if (bthost->acl_data) {
+		if (conn->recv_data) {
 			bthost_debug(bthost, "Unexpected ACL start frame");
-			free(bthost->acl_data);
-			bthost->acl_data = NULL;
-			bthost->acl_len = 0;
+			free_recv_data(conn);
 		}
 
 		l2_len = le16_to_cpu(l2_hdr->len) + sizeof(*l2_hdr);
@@ -2557,25 +2728,116 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 		bthost_debug(bthost, "acl_len %u l2_len %u", acl_len, l2_len);
 
 		if (acl_len == l2_len) {
-			process_l2cap(bthost, handle, acl_hdr->data, acl_len);
+			process_l2cap(bthost, conn, acl_hdr->data, acl_len);
 			break;
 		}
 
-		bthost->acl_data = malloc(l2_len);
-		bthost->acl_len = 0;
-		bthost->l2_len = l2_len;
+		new_recv_data(conn, l2_len);
 		/* fall through */
 	case 0x01:	/* continuing fragment */
-		append_acl_data(bthost, handle, flags, acl_hdr->data, acl_len);
+		append_acl_data(bthost, conn, flags, acl_hdr->data, acl_len);
 		break;
 	case 0x03:	/* complete automatically-flushable PDU */
-		process_l2cap(bthost, handle, acl_hdr->data, acl_len);
+		process_l2cap(bthost, conn, acl_hdr->data, acl_len);
 		break;
 	default:
 		bthost_debug(bthost, "Invalid ACL frame flags 0x%2.2x", flags);
 	}
 }
 
+static void process_iso_data(struct bthost *bthost, struct btconn *conn,
+					const void *data, uint16_t len)
+{
+	const struct bt_hci_iso_data_start *data_hdr = data;
+	uint16_t data_len;
+	struct iso_hook *hook;
+
+	data_len = le16_to_cpu(data_hdr->slen);
+	if (len != sizeof(*data_hdr) + data_len) {
+		bthost_debug(bthost, "ISO invalid length: %u != %zu",
+					len, sizeof(*data_hdr) + data_len);
+		return;
+	}
+
+	bthost_debug(bthost, "ISO data: %u bytes (%u)", data_len, data_hdr->sn);
+
+	hook = conn->iso_hook;
+	if (!hook)
+		return;
+
+	hook->func(data_hdr->data, data_len, hook->user_data);
+}
+
+static void append_iso_data(struct bthost *bthost, struct btconn *conn,
+				uint8_t flags, const void *data, uint16_t len)
+{
+	append_recv_data(bthost, conn, "ISO", flags, data, len);
+
+	if (conn->recv_len < conn->data_len) {
+		if (flags == 0x03) {
+			bthost_debug(bthost, "Unexpected ISO end frame");
+			free_recv_data(conn);
+		}
+		return;
+	}
+
+	process_iso_data(bthost, conn, conn->recv_data, conn->recv_len);
+
+	free_recv_data(conn);
+}
+
+static void process_iso(struct bthost *bthost, const void *data, uint16_t len)
+{
+	const struct bt_hci_iso_hdr *iso_hdr = data;
+	const struct bt_hci_iso_data_start *data_hdr;
+	uint16_t handle, iso_len, data_len;
+	uint8_t flags;
+	struct btconn *conn;
+
+	iso_len = le16_to_cpu(iso_hdr->dlen);
+	if (len != sizeof(*iso_hdr) + iso_len)
+		return;
+
+	handle = acl_handle(iso_hdr->handle);
+	flags = iso_flags_pb(acl_flags(iso_hdr->handle));
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn) {
+		bthost_debug(bthost, "Unknown handle: 0x%4.4x", handle);
+		return;
+	}
+
+	data_hdr = (void *) data + sizeof(*iso_hdr);
+
+	switch (flags) {
+	case 0x00:
+	case 0x02:
+		if (conn->recv_data) {
+			bthost_debug(bthost, "Unexpected ISO start frame");
+			free_recv_data(conn);
+		}
+
+		data_len = le16_to_cpu(data_hdr->slen) + sizeof(*data_hdr);
+
+		bthost_debug(bthost, "iso_len %u data_len %u", iso_len,
+								data_len);
+
+		if (iso_len == data_len) {
+			process_iso_data(bthost, conn, iso_hdr->data, iso_len);
+			break;
+		}
+
+		new_recv_data(conn, data_len);
+		/* fall through */
+	case 0x01:
+	case 0x03:
+		append_iso_data(bthost, conn, flags, iso_hdr->data, iso_len);
+		break;
+	default:
+		bthost_debug(bthost, "Invalid ISO frame flags 0x%2.2x", flags);
+	}
+}
+
 void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
 {
 	uint8_t pkt_type;
@@ -2598,6 +2860,9 @@ void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
 	case BT_H4_ACL_PKT:
 		process_acl(bthost, data + 1, len - 1);
 		break;
+	case BT_H4_ISO_PKT:
+		process_iso(bthost, data + 1, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported packet 0x%2.2x", pkt_type);
 		break;
@@ -2618,6 +2883,13 @@ void bthost_set_connect_cb(struct bthost *bthost, bthost_new_conn_cb cb,
 	bthost->new_conn_data = user_data;
 }
 
+void bthost_set_iso_cb(struct bthost *bthost, bthost_new_conn_cb cb,
+							void *user_data)
+{
+	bthost->new_iso_cb = cb;
+	bthost->new_iso_data = user_data;
+}
+
 void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 							uint8_t addr_type)
 {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 868af5469..f597d7596 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -47,6 +47,9 @@ typedef void (*bthost_new_conn_cb) (uint16_t handle, void *user_data);
 void bthost_set_connect_cb(struct bthost *bthost, bthost_new_conn_cb cb,
 							void *user_data);
 
+void bthost_set_iso_cb(struct bthost *bthost, bthost_new_conn_cb cb,
+							void *user_data);
+
 void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 							uint8_t addr_type);
 
@@ -62,10 +65,18 @@ typedef void (*bthost_cid_hook_func_t)(const void *data, uint16_t len,
 void bthost_add_cid_hook(struct bthost *bthost, uint16_t handle, uint16_t cid,
 				bthost_cid_hook_func_t func, void *user_data);
 
+typedef void (*bthost_iso_hook_func_t)(const void *data, uint16_t len,
+							void *user_data);
+
+void bthost_add_iso_hook(struct bthost *bthost, uint16_t handle,
+				bthost_iso_hook_func_t func, void *user_data);
+
 void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t len);
 void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const struct iovec *iov, int iovcnt);
+void bthost_send_iso(struct bthost *bthost, uint16_t handle,
+					const struct iovec *iov, int iovcnt);
 
 typedef void (*bthost_l2cap_rsp_cb) (uint8_t code, const void *data,
 						uint16_t len, void *user_data);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 057f76ff3..dcfed9be7 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -190,6 +190,7 @@ static gboolean receive_btdev(GIOChannel *channel, GIOCondition condition,
 	case BT_H4_CMD_PKT:
 	case BT_H4_ACL_PKT:
 	case BT_H4_SCO_PKT:
+	case BT_H4_ISO_PKT:
 		btdev_receive_h4(btdev, buf, len);
 		break;
 	}
diff --git a/monitor/bt.h b/monitor/bt.h
index 6ce6384a4..704c70fba 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -499,11 +499,13 @@ struct bt_hci_sco_hdr {
 struct bt_hci_iso_hdr {
 	uint16_t handle;
 	uint16_t dlen;
+	uint8_t  data[];
 } __attribute__ ((packed));
 
 struct bt_hci_iso_data_start {
 	uint16_t sn;
 	uint16_t slen;
+	uint8_t  data[];
 } __attribute__ ((packed));
 
 struct bt_hci_evt_hdr {
-- 
2.35.1

