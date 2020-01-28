Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66FBC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5220708
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViBdZhT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA1UNo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:13:44 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:34823 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgA1UNn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 15:13:43 -0500
Received: by mail-pl1-f179.google.com with SMTP id g6so5554590plt.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7PNitGNBLMTj2k5raXkxTT5DtOuf0T55XL9mvcTlHnc=;
        b=ViBdZhT1skKrZcktXhK6P66AaLBDOkFW2dGPaarOaOuhpeRTapYHA0/3lel9RHOkRh
         oj0vAmchpSoJsk0cRMoM0iRhEbsUNkA+fNYKnYAAQLeZeKr2gRN2kD3CxaQVhZDowong
         5807CYnyXFcWH/V1XEeJn8yAbNJpBaVlqpzMu75oUx0Rx1CBkn0at7dhknd7aFdc0LP2
         f2hQrjFzh8zh7KZLyeZh5O9URP+mD4Wu1m18wJHJxYuoQHo+wJemFJGE1xCYzziAGZe1
         kRGdUYTIAHHVZMzTiwfM42h44+bktMNvxzDdKCv+pEtliV9sO7kJ6ufBFNE1yWnVINBi
         nV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PNitGNBLMTj2k5raXkxTT5DtOuf0T55XL9mvcTlHnc=;
        b=AkRfom3nOLj3ZlaGCRs6FvzQs1K4NG4jYtLwjFzOX/UN1MxxDvnSIKG8ymYy1k2+1u
         sMMJAcyokMtLnnztGKYR7Sjq1aQvT7hhIJBfhgGc2oM1aQRaUKrOZIaGpiNuLmSK639m
         JVBVGSy49rXkqnRZhwBhwWft4Z+d6mn8hxGujv8KMmnpAuJeBfFUm1przdOuZE9W+4IM
         ZExrbH0JhrNxkxdHigqPlHsupE3ZNVnfDNHgC3CxrfllIUhRoU7PH1yzIuqwnnE0J//S
         9NtHBTzkRcoDd6ZyOuqyRf9EqBSxM9/Z07jIuAfukYY2EW4MrJVCh4Y08eDn2QhfKVKk
         9YTA==
X-Gm-Message-State: APjAAAV+9JVueYAG/dueOp++nP0fUbtjQyxf34WRejqd6YNWwSkIDd3Q
        QYV3tch0c9W3O/QEuybO8wkiVk0KGwk=
X-Google-Smtp-Source: APXvYqzTNf8QL4xbZz2u30Rpz4Yp0s2vnRHT4xinRfQkXgKxQqnXXnDo1QAQi/2uhX/qarV28d1+wA==
X-Received: by 2002:a17:902:900c:: with SMTP id a12mr24702870plp.87.1580242421861;
        Tue, 28 Jan 2020 12:13:41 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.38])
        by smtp.gmail.com with ESMTPSA id x8sm3367504pfr.104.2020.01.28.12.13.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 12:13:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] emulator: Add initial support for BT 5.2
Date:   Tue, 28 Jan 2020 12:13:34 -0800
Message-Id: <20200128201335.6165-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128201335.6165-1-luiz.dentz@gmail.com>
References: <20200128201335.6165-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial command/event decoding for 5.2.
---
 emulator/btdev.c  | 293 +++++++++++++++++++++++++++++++++++++++-------
 emulator/btdev.h  |   1 +
 emulator/hciemu.c |   3 +
 emulator/hciemu.h |   1 +
 emulator/vhci.c   |   3 +-
 5 files changed, 258 insertions(+), 43 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 38d5b3b1f..0de273e53 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -47,6 +47,9 @@
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
+#define ACL_HANDLE 42
+#define ISO_HANDLE 44
+
 struct hook {
 	btdev_hook_func handler;
 	void *user_data;
@@ -92,6 +95,8 @@ struct btdev {
 	uint8_t  feat_page_2[8];
 	uint16_t acl_mtu;
 	uint16_t acl_max_pkt;
+	uint16_t iso_mtu;
+	uint16_t iso_max_pkt;
 	uint8_t  country_code;
 	uint8_t  bdaddr[6];
 	uint8_t  random_addr[6];
@@ -139,6 +144,10 @@ struct btdev {
 	uint8_t  le_filter_dup;
 	uint8_t  le_adv_enable;
 	uint8_t  le_ltk[16];
+	struct {
+		struct bt_hci_cmd_le_set_cig_params params;
+		struct bt_hci_cis_params cis;
+	} __attribute__ ((packed)) le_cig;
 
 	uint8_t le_local_sk256[32];
 
@@ -438,6 +447,30 @@ static void set_le_50_commands(struct btdev *btdev)
 	btdev->commands[38] |= 0x40;	/* LE Read Periodic Adv List Size */
 }
 
+static void set_le_60_commands(struct btdev *btdev)
+{
+	btdev->commands[41] |= 0x20;	/* LE Read Buffer Size v2 */
+	btdev->commands[41] |= 0x40;	/* LE Read ISO TX Sync */
+	btdev->commands[41] |= 0x80;	/* LE Set CIG Parameters */
+	btdev->commands[42] |= 0x01;	/* LE Set CIG Parameters Test */
+	btdev->commands[42] |= 0x02;	/* LE Create CIS */
+	btdev->commands[42] |= 0x04;	/* LE Remove CIG */
+	btdev->commands[42] |= 0x08;	/* LE Accept CIS */
+	btdev->commands[42] |= 0x10;	/* LE Reject CIS */
+	btdev->commands[42] |= 0x20;	/* LE Create BIG */
+	btdev->commands[42] |= 0x40;	/* LE Create BIG Test */
+	btdev->commands[42] |= 0x80;	/* LE Terminate BIG */
+	btdev->commands[43] |= 0x01;	/* LE BIG Create Sync */
+	btdev->commands[43] |= 0x02;	/* LE BIG Terminate Sync */
+	btdev->commands[43] |= 0x04;	/* LE Request Peer SCA */
+	btdev->commands[43] |= 0x08;	/* LE Setup ISO Path */
+	btdev->commands[43] |= 0x10;	/* LE Remove ISO Path */
+	btdev->commands[43] |= 0x20;	/* LE ISO TX Test */
+	btdev->commands[43] |= 0x40;	/* LE ISO RX Test */
+	btdev->commands[43] |= 0x80;	/* LE ISO Read Test Counter */
+	btdev->commands[44] |= 0x01;	/* LE ISO Test End */
+}
+
 static void set_le_commands(struct btdev *btdev)
 {
 	set_common_commands_all(btdev);
@@ -482,6 +515,10 @@ static void set_le_commands(struct btdev *btdev)
 	/* Extra LE commands for >= 5.0 adapters */
 	if (btdev->type >= BTDEV_TYPE_BREDRLE50)
 		set_le_50_commands(btdev);
+
+	/* Extra LE commands for >= 6.0 adapters */
+	if (btdev->type >= BTDEV_TYPE_BREDRLE60)
+		set_le_60_commands(btdev);
 }
 
 static void set_bredrle_commands(struct btdev *btdev)
@@ -550,6 +587,14 @@ static void set_bredrle_features(struct btdev *btdev)
 		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
 	}
 
+	if (btdev->type >= BTDEV_TYPE_BREDRLE60) {
+		btdev->le_features[3] |= 0x10;  /* LE CIS Master */
+		btdev->le_features[3] |= 0x20;  /* LE CIS Slave */
+		btdev->le_features[3] |= 0x40;  /* LE ISO Broadcaster */
+		btdev->le_features[3] |= 0x80;  /* LE Synchronized Receiver */
+		btdev->le_features[4] |= 0x01;  /* LE ISO channels */
+	}
+
 	btdev->feat_page_2[0] |= 0x01;	/* CSB - Master Operation */
 	btdev->feat_page_2[0] |= 0x02;	/* CSB - Slave Operation */
 	btdev->feat_page_2[0] |= 0x04;	/* Synchronization Train */
@@ -644,8 +689,9 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	memset(btdev, 0, sizeof(*btdev));
 
-	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE
-				|| type == BTDEV_TYPE_BREDRLE50) {
+	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE ||
+			type == BTDEV_TYPE_BREDRLE50 ||
+			type == BTDEV_TYPE_BREDRLE60) {
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -661,6 +707,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	switch (btdev->type) {
 	case BTDEV_TYPE_BREDRLE:
 	case BTDEV_TYPE_BREDRLE50:
+	case BTDEV_TYPE_BREDRLE60:
 		btdev->version = 0x09;
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
@@ -700,6 +747,9 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	btdev->acl_mtu = 192;
 	btdev->acl_max_pkt = 1;
 
+	btdev->iso_mtu = 251;
+	btdev->iso_max_pkt = 1;
+
 	btdev->country_code = 0x00;
 
 	index = add_btdev(btdev);
@@ -893,13 +943,13 @@ static void le_meta_event(struct btdev *btdev, uint8_t event,
 	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, pkt_data, 1 + len);
 }
 
-static void num_completed_packets(struct btdev *btdev)
+static void num_completed_packets(struct btdev *btdev, uint16_t handle)
 {
 	if (btdev->conn) {
 		struct bt_hci_evt_num_completed_packets ncp;
 
 		ncp.num_handles = 1;
-		ncp.handle = cpu_to_le16(42);
+		ncp.handle = cpu_to_le16(handle);
 		ncp.count = cpu_to_le16(1);
 
 		send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS,
@@ -1106,12 +1156,12 @@ static void conn_complete(struct btdev *btdev,
 		memcpy(cc.bdaddr, btdev->bdaddr, 6);
 		cc.encr_mode = 0x00;
 
-		cc.handle = cpu_to_le16(42);
+		cc.handle = cpu_to_le16(ACL_HANDLE);
 		cc.link_type = 0x01;
 
 		send_event(remote, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
-		cc.handle = cpu_to_le16(42);
+		cc.handle = cpu_to_le16(ACL_HANDLE);
 		cc.link_type = 0x01;
 	} else {
 		cc.handle = cpu_to_le16(0x0000);
@@ -1208,7 +1258,7 @@ static void le_conn_complete(struct btdev *btdev,
 			memcpy(cc->peer_addr, btdev->bdaddr, 6);
 
 		cc->role = 0x01;
-		cc->handle = cpu_to_le16(42);
+		cc->handle = cpu_to_le16(ACL_HANDLE);
 		cc->interval = lecc->max_interval;
 		cc->latency = lecc->latency;
 		cc->supv_timeout = lecc->supv_timeout;
@@ -1255,7 +1305,7 @@ static void le_ext_conn_complete(struct btdev *btdev,
 			memcpy(cc->peer_addr, btdev->bdaddr, 6);
 
 		cc->role = 0x01;
-		cc->handle = cpu_to_le16(42);
+		cc->handle = cpu_to_le16(ACL_HANDLE);
 		cc->interval = lecc->max_interval;
 		cc->latency = lecc->latency;
 		cc->supv_timeout = lecc->supv_timeout;
@@ -1356,6 +1406,63 @@ static void le_ext_conn_request(struct btdev *btdev,
 					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 }
 
+static void le_cis_estabilished(struct btdev *dev, uint8_t status)
+{
+	struct bt_hci_evt_le_cis_established evt;
+
+	memset(&evt, 0, sizeof(evt));
+
+	evt.status = status;
+
+	if (!evt.status) {
+		evt.conn_handle = cpu_to_le16(ISO_HANDLE);
+		/* TODO: Figure out if these values makes sense */
+		memcpy(evt.cig_sync_delay, dev->le_cig.params.m_interval,
+				sizeof(dev->le_cig.params.m_interval));
+		memcpy(evt.cis_sync_delay, dev->le_cig.params.s_interval,
+				sizeof(dev->le_cig.params.s_interval));
+		memcpy(evt.m_latency, &dev->le_cig.params.m_latency,
+				sizeof(dev->le_cig.params.m_latency));
+		memcpy(evt.s_latency, &dev->le_cig.params.s_latency,
+				sizeof(dev->le_cig.params.s_latency));
+		evt.m_phy = dev->le_cig.cis.m_phy;
+		evt.s_phy = dev->le_cig.cis.s_phy;
+		evt.nse = 0x01;
+		evt.m_bn = 0x01;
+		evt.s_bn = 0x01;
+		evt.m_ft = 0x01;
+		evt.s_ft = 0x01;
+		evt.m_mtu = dev->iso_mtu;
+		evt.s_mtu = dev->iso_mtu;
+		evt.interval = dev->le_cig.params.m_latency;
+	}
+
+	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
+
+	if (dev->conn)
+		le_meta_event(dev->conn, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt,
+							sizeof(evt));
+}
+
+static void le_cis_request(struct btdev *dev,
+				const struct bt_hci_cmd_le_create_cis *leccis)
+{
+	struct btdev *remote = dev->conn;
+
+	if (remote) {
+		struct bt_hci_evt_le_cis_req evt;
+
+		evt.acl_handle = cpu_to_le16(ACL_HANDLE);
+		evt.cis_handle = cpu_to_le16(ISO_HANDLE);
+		evt.cis_id = 0x00;
+		evt.cis_id = 0x00;
+
+		le_meta_event(remote, BT_HCI_EVT_LE_CIS_REQ, &evt, sizeof(evt));
+	} else {
+		le_cis_estabilished(dev, BT_HCI_ERR_UNKNOWN_CONN_ID);
+	}
+}
+
 static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
 {
 	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
@@ -1464,8 +1571,10 @@ static void disconnect_complete(struct btdev *btdev, uint16_t handle,
 	dc.handle = cpu_to_le16(handle);
 	dc.reason = reason;
 
-	btdev->conn = NULL;
-	remote->conn = NULL;
+	if (dc.handle == ACL_HANDLE) {
+		btdev->conn = NULL;
+		remote->conn = NULL;
+	}
 
 	send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
 	send_event(remote, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
@@ -1492,7 +1601,7 @@ static void link_key_req_reply_complete(struct btdev *btdev,
 		return;
 	}
 
-	ev.handle = cpu_to_le16(42);
+	ev.handle = cpu_to_le16(ACL_HANDLE);
 
 	if (!memcmp(btdev->link_key, remote->link_key, 16))
 		ev.status = BT_HCI_ERR_SUCCESS;
@@ -1587,7 +1696,7 @@ static void encrypt_change(struct btdev *btdev, uint8_t mode, uint8_t status)
 	struct bt_hci_evt_encrypt_change ev;
 
 	ev.status = status;
-	ev.handle = cpu_to_le16(42);
+	ev.handle = cpu_to_le16(ACL_HANDLE);
 	ev.encr_mode = mode;
 
 	send_event(btdev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
@@ -1628,7 +1737,7 @@ static void pin_code_req_reply_complete(struct btdev *btdev,
 	}
 
 	if (remote->conn) {
-		ev.handle = cpu_to_le16(42);
+		ev.handle = cpu_to_le16(ACL_HANDLE);
 		send_event(remote, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
 	} else {
 		conn_complete(remote, btdev->bdaddr, ev.status);
@@ -1651,7 +1760,7 @@ static void pin_code_req_neg_reply_complete(struct btdev *btdev,
 	}
 
 	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
-	ev.handle = cpu_to_le16(42);
+	ev.handle = cpu_to_le16(ACL_HANDLE);
 
 	if (btdev->conn)
 		send_event(btdev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
@@ -1944,7 +2053,7 @@ static void ssp_complete(struct btdev *btdev, const uint8_t *bdaddr,
 	}
 
 	auth.status = status;
-	auth.handle = cpu_to_le16(42);
+	auth.handle = cpu_to_le16(ACL_HANDLE);
 	send_event(init, BT_HCI_EVT_AUTH_COMPLETE, &auth, sizeof(auth));
 }
 
@@ -2207,7 +2316,7 @@ static void le_read_remote_features_complete(struct btdev *btdev)
 	memset(buf, 0, sizeof(buf));
 	buf[0] = BT_HCI_EVT_LE_REMOTE_FEATURES_COMPLETE;
 	ev->status = BT_HCI_ERR_SUCCESS;
-	ev->handle = cpu_to_le16(42);
+	ev->handle = cpu_to_le16(ACL_HANDLE);
 	memcpy(ev->features, remote->le_features, 8);
 
 	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
@@ -2230,7 +2339,7 @@ static void le_start_encrypt_complete(struct btdev *btdev, uint16_t ediv,
 
 	memset(buf, 0, sizeof(buf));
 	buf[0] = BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST;
-	ev->handle = cpu_to_le16(42);
+	ev->handle = cpu_to_le16(ACL_HANDLE);
 	ev->ediv = ediv;
 	ev->rand = rand;
 
@@ -2244,7 +2353,7 @@ static void le_encrypt_complete(struct btdev *btdev)
 	struct btdev *remote = btdev->conn;
 
 	memset(&rp, 0, sizeof(rp));
-	rp.handle = cpu_to_le16(42);
+	rp.handle = cpu_to_le16(ACL_HANDLE);
 
 	if (!remote) {
 		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
@@ -2266,7 +2375,7 @@ static void le_encrypt_complete(struct btdev *btdev)
 		ev.encr_mode = 0x01;
 	}
 
-	ev.handle = cpu_to_le16(42);
+	ev.handle = cpu_to_le16(ACL_HANDLE);
 
 	send_event(btdev, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
 	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
@@ -2279,7 +2388,7 @@ static void ltk_neg_reply_complete(struct btdev *btdev)
 	struct btdev *remote = btdev->conn;
 
 	memset(&rp, 0, sizeof(rp));
-	rp.handle = cpu_to_le16(42);
+	rp.handle = cpu_to_le16(ACL_HANDLE);
 
 	if (!remote) {
 		rp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
@@ -2293,7 +2402,7 @@ static void ltk_neg_reply_complete(struct btdev *btdev)
 
 	memset(&ev, 0, sizeof(ev));
 	ev.status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
-	ev.handle = cpu_to_le16(42);
+	ev.handle = cpu_to_le16(ACL_HANDLE);
 
 	send_event(remote, BT_HCI_EVT_ENCRYPT_CHANGE, &ev, sizeof(ev));
 }
@@ -2364,6 +2473,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_ext_scan_params *lsesp;
 	const struct bt_hci_le_scan_phy *lsp;
 	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
+	const struct bt_hci_cmd_le_reject_cis *lrcis;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -2425,6 +2535,11 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_evt_le_generate_dhkey_complete dh_evt;
 	struct bt_hci_rsp_le_read_num_supported_adv_sets rlrnsas;
 	struct bt_hci_rsp_le_set_ext_adv_params rlseap;
+	struct bt_hci_rsp_le_read_buffer_size_v2 lrbsv2;
+	struct lescp {
+		struct bt_hci_rsp_le_set_cig_params params;
+		uint16_t handle;
+	} __attribute__ ((packed)) lscp;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -2960,7 +3075,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_READ_LE_HOST_SUPPORTED:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50)
+				btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 		rlhs.status = BT_HCI_ERR_SUCCESS;
 		rlhs.supported = btdev->le_supported;
@@ -2971,7 +3087,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 				btdev->type != BTDEV_TYPE_LE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50)
+				btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 		wlhs = data;
 		btdev->le_supported = wlhs->supported;
@@ -2982,7 +3099,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_READ_SECURE_CONN_SUPPORT:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50)
+				btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 		rscs.status = BT_HCI_ERR_SUCCESS;
 		rscs.support = btdev->secure_conn_support;
@@ -2991,7 +3109,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50)
+				btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 		wscs = data;
 		btdev->secure_conn_support = wscs->support;
@@ -3001,7 +3120,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50)
+				btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 		rloed.status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &rloed, sizeof(rloed));
@@ -3009,7 +3129,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50)
+				btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 		rstp.status = BT_HCI_ERR_SUCCESS;
 		rstp.interval = cpu_to_le16(btdev->sync_train_interval);
@@ -3160,7 +3281,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_READ_ENCRYPT_KEY_SIZE:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
 					btdev->type != BTDEV_TYPE_BREDR &&
-					btdev->type != BTDEV_TYPE_BREDRLE50)
+					btdev->type != BTDEV_TYPE_BREDRLE50 &&
+					btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 		reks = data;
 		read_enc_key_size_complete(btdev, le16_to_cpu(reks->handle));
@@ -3535,7 +3657,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lcprnr_rsp, sizeof(lcprnr_rsp));
 		break;
 	case BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		rlrnsas.status = BT_HCI_ERR_SUCCESS;
@@ -3544,7 +3667,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &rlrnsas, sizeof(rlrnsas));
 		break;
 	case BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		lsasra = data;
@@ -3553,7 +3677,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		if (btdev->le_adv_enable) {
@@ -3573,7 +3698,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &rlseap, sizeof(rlseap));
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		lseae = data;
@@ -3588,7 +3714,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			le_set_ext_adv_enable_complete(btdev);
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_DATA:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		lsead = data;
@@ -3598,7 +3725,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		lsesrd = data;
@@ -3608,14 +3736,16 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 	case BT_HCI_CMD_LE_REMOVE_ADV_SET:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 	case BT_HCI_CMD_LE_CLEAR_ADV_SETS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		status = BT_HCI_ERR_SUCCESS;
@@ -3636,7 +3766,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		lsesp = data;
@@ -3658,7 +3789,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		lsese = data;
@@ -3672,11 +3804,63 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			goto unsupported;
 
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
 		break;
+
+	case BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2:
+		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+			goto unsupported;
+		lrbsv2.status = BT_HCI_ERR_SUCCESS;
+		lrbsv2.acl_mtu = cpu_to_le16(btdev->acl_mtu);
+		lrbsv2.acl_max_pkt = btdev->acl_max_pkt;
+		lrbsv2.iso_mtu = cpu_to_le16(btdev->iso_mtu);
+		lrbsv2.iso_max_pkt = btdev->iso_max_pkt;
+		cmd_complete(btdev, opcode, &lrbsv2, sizeof(lrbsv2));
+		break;
+
+	case BT_HCI_CMD_LE_SET_CIG_PARAMS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+			goto unsupported;
+		memcpy(&btdev->le_cig, data, len);
+		lscp.params.status = BT_HCI_ERR_SUCCESS;
+		lscp.params.cig_id = 0x00;
+		lscp.params.num_handles = 1;
+		lscp.handle = cpu_to_le16(ISO_HANDLE);
+		cmd_complete(btdev, opcode, &lscp, sizeof(lscp));
+		break;
+
+	case BT_HCI_CMD_LE_CREATE_CIS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+			goto unsupported;
+
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+
+		break;
+
+	case BT_HCI_CMD_LE_ACCEPT_CIS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+			goto unsupported;
+
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		le_cis_estabilished(btdev, BT_HCI_ERR_SUCCESS);
+
+		break;
+
+	case BT_HCI_CMD_LE_REJECT_CIS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE60)
+			goto unsupported;
+
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+
+		lrcis = data;
+		le_cis_estabilished(btdev, lrcis->reason);
+
+		break;
+
 	default:
 		goto unsupported;
 	}
@@ -3716,6 +3900,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_scan_enable *lsse;
 	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
 	const struct bt_hci_cmd_le_ext_create_conn *leecc;
+	const struct bt_hci_cmd_le_create_cis *leccis;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3912,19 +4097,28 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 			le_set_scan_enable_complete(btdev);
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			return;
 		lsese = data;
 		if (btdev->le_scan_enable && lsese->enable)
 			le_set_ext_scan_enable_complete(btdev);
 		break;
 	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
-		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
 			return;
 		leecc = data;
 		btdev->le_scan_own_addr_type = leecc->own_addr_type;
 		le_ext_conn_request(btdev, leecc);
 		break;
+	case BT_HCI_CMD_LE_CREATE_CIS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50 &&
+				btdev->type != BTDEV_TYPE_BREDRLE60)
+			return;
+		leccis = data;
+		le_cis_request(btdev, leccis);
+		break;
 	}
 }
 
@@ -4033,6 +4227,16 @@ static void send_acl(struct btdev *conn, const void *data, uint16_t len)
 	send_packet(conn, iov, 3);
 }
 
+static void send_iso(struct btdev *conn, const void *data, uint16_t len)
+{
+	struct iovec iov;
+
+	iov.iov_base = (void *) (data);
+	iov.iov_len = len;
+
+	send_packet(conn, &iov, 1);
+}
+
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 {
 	uint8_t pkt_type;
@@ -4052,7 +4256,12 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 	case BT_H4_ACL_PKT:
 		if (btdev->conn)
 			send_acl(btdev->conn, data, len);
-		num_completed_packets(btdev);
+		num_completed_packets(btdev, ACL_HANDLE);
+		break;
+	case BT_H4_ISO_PKT:
+		num_completed_packets(btdev, ISO_HANDLE);
+		if (btdev->conn)
+			send_iso(btdev->conn, data, len);
 		break;
 	default:
 		printf("Unsupported packet 0x%2.2x\n", pkt_type);
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 362d1e7a2..b535930de 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -64,6 +64,7 @@ enum btdev_type {
 	BTDEV_TYPE_AMP,
 	BTDEV_TYPE_BREDR20,
 	BTDEV_TYPE_BREDRLE50,
+	BTDEV_TYPE_BREDRLE60,
 };
 
 enum btdev_hook_type {
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 1045043f1..23891a2ee 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -335,6 +335,9 @@ struct hciemu *hciemu_new(enum hciemu_type type)
 	case HCIEMU_TYPE_BREDRLE50:
 		hciemu->btdev_type = BTDEV_TYPE_BREDRLE50;
 		break;
+	case HCIEMU_TYPE_BREDRLE60:
+		hciemu->btdev_type = BTDEV_TYPE_BREDRLE60;
+		break;
 	default:
 		return NULL;
 	}
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index e37c069e1..6f651cb98 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -32,6 +32,7 @@ enum hciemu_type {
 	HCIEMU_TYPE_LE,
 	HCIEMU_TYPE_LEGACY,
 	HCIEMU_TYPE_BREDRLE50,
+	HCIEMU_TYPE_BREDRLE60,
 };
 
 enum hciemu_hook_type {
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 8dec20a08..7a69b484e 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -89,6 +89,7 @@ static void vhci_read_callback(int fd, uint32_t events, void *user_data)
 	case BT_H4_CMD_PKT:
 	case BT_H4_ACL_PKT:
 	case BT_H4_SCO_PKT:
+	case BT_H4_ISO_PKT:
 		btdev_receive_h4(vhci->btdev, buf, len);
 		break;
 	}
@@ -104,7 +105,7 @@ struct vhci *vhci_open(enum vhci_type type)
 
 	switch (type) {
 	case VHCI_TYPE_BREDRLE:
-		btdev_type = BTDEV_TYPE_BREDRLE;
+		btdev_type = BTDEV_TYPE_BREDRLE60;
 		ctrl_type = HCI_PRIMARY;
 		break;
 	case VHCI_TYPE_BREDR:
-- 
2.21.0

