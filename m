Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583430597E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474059; cv=none; b=UKKncQ7PaNWWy1TtgRoH2CU4fZERxPrusETcyYGhZF0b2PbCrt6b5UcEeBJsxXBvF55lb51JrnvFvL/DuTHpcQGP38bWpJdsfKkHicZlzVuf7dbu5FORAF1lEFw4XSuYlmuH8+7OMDvQRe7emT1pNpyDne3kngEDqrr/T04QVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474059; c=relaxed/simple;
	bh=23GUzEyy2zVrjNR/VvNGFVT88O0DQ3QnncqL7sy5Do0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzVJVM7cpAtFo0Q3O5NzYyJJFwWzyKyVfUCB2hWpiS0+TAFGohQa1hx6dIGZgkFv+EWUfXrvDGCWzS1H9YBEwQgjyoTTAvzg4UZc+nYgCBHO3eRj2+FFwhqjgh09UmKY+K6Fg3wal4DV6gZZOdEVab/iU8P+bbppeQ5/ZWwQ7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNOqPYuq; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNOqPYuq"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54bbe260539so2288909e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474056; x=1761078856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXLWfGhgEs+6gwmWdVwb1St5tjCpjnuw9kQrXrbUpc0=;
        b=TNOqPYuqpdJNeB2pogGs4HCILg1kIy4htEpLo4HARxNN4edFUWqw6l+b3nHWWo0xAU
         6EV9mVvT+89U2J/UdCYtU+HpUBESmT35y2Kta/ygSJgHweM8Y0GqIbvymsiWAADmVtx0
         HW3zMjsQcyQhh4b5FFjCkeez++7lMonMyjuMfatDDFnwUJk7lBxc4MtqdVGMEzjuHPh3
         noYR/LRLXLQP6jblt0KgHMaq0IQiMat+Zt8bTbx9dPV5w0TKTisvHJiwfMEpOpH8A9Yg
         hV0O1SGjDbLusmede2kNQDpL3oza3ezrm/TTgHVAwjE17WZYu+MxS03PIiXR7ova1mt1
         f/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474056; x=1761078856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXLWfGhgEs+6gwmWdVwb1St5tjCpjnuw9kQrXrbUpc0=;
        b=tLfyUkbvuLevm/jn353CFxOootx5W+a+NiEMvxs+f1ef5JY1DVq6fDJ/9din8EqlS5
         TrlSxP9eUJfYS7ModFBsHayClISbGXp2L9PDWA8vWoAlJ6RdlGJ82KLuUtURVtFEDwH3
         qavWzuKPxET6V2qzzS4OpsaIQme50rLmpJWem7R9ocTb0lP3k7mUxVM/dYo0iZRTy0VW
         juAelotFiOHiUu+KwOiNGDd4MYVNrU02RD08kfVk0ji03Q59zb9m340I8Y8g60NoGrMc
         R0mJ/vdz4q3wL/RHg4mFjSqWGsbDAzEO0YWNAjjrwLStoDaCyFCej4j801Al+jaXQDQM
         sUhA==
X-Gm-Message-State: AOJu0YzjAk5NUG+3NLD/dZ3nwx+mu/5tSNpiekAUV2RJIFsRU2QX6N9V
	2IW5+bVxF++nAHVZAdOsAgrB5Z7MY6YHcWHxYPZu5terRkqNGYff5Mnb0bCixFK8
X-Gm-Gg: ASbGnctynhwB3QLkiK1nveYda2WhYuYPnbaJEfTZu5316D5N2IWtNOnzkHmuM+vc3G/
	JBw3AH+L/ZmxKg4Sblx9/pk79otOC1dXF0cyA6rSobclo+4q38YVrNXk8jEsxlvmIoB6rHFvK3R
	wKh/vyazRM7df+gkl9RXdiXwr3jHPIiEOGzkR0BAiP6ACPm3m04CuHwfaFgPViASe6QAG4Til6t
	e7B7f+xRkhuSn0rHemfhljunNKonJ0ZTH38JUpVTeNR2WqhxtNjt66b6/gx2yIDfts9ZK0FY8s1
	9Dp7OUXPfdjWS/VEhL4b8QT06GRVENBlqkU1YqQyQlHUAZtWOVYcZEKW+c+RL/pcQGjSU2rn9pU
	aFFyHfXVUJSRE57LHe4rMsTCh7QtEUEaIPlkx1gmvPHuo
X-Google-Smtp-Source: AGHT+IFq8G0otdZd/d1wmKjffJqMgHZ/B3J5ojwKc3PfD3QyyAjBjjdhkcgG0P/tnZX52w59xuY9vQ==
X-Received: by 2002:a05:6122:2004:b0:544:4cd3:4bfb with SMTP id 71dfb90a1353d-554b8c30246mr8980129e0c.15.1760474055417;
        Tue, 14 Oct 2025 13:34:15 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a456csm4434116e0c.14.2025.10.14.13.34.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:34:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/6] emulator: Add initial support for PAST
Date: Tue, 14 Oct 2025 16:33:56 -0400
Message-ID: <20251014203400.453454-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014203400.453454-1-luiz.dentz@gmail.com>
References: <20251014203400.453454-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/scripts/broadcast-sink.bt |   2 +-
 emulator/btdev.c                 | 333 +++++++++++++++++++++++++++++--
 emulator/bthost.c                |  43 ++++
 emulator/bthost.h                |   3 +-
 4 files changed, 358 insertions(+), 23 deletions(-)

diff --git a/client/scripts/broadcast-sink.bt b/client/scripts/broadcast-sink.bt
index b912231b248f..b26dc44ac237 100644
--- a/client/scripts/broadcast-sink.bt
+++ b/client/scripts/broadcast-sink.bt
@@ -4,4 +4,4 @@ y
 a
 3
 4
-scan on
\ No newline at end of file
+scan on
diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1a0f9ef2de58..8c72a24290c6 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -52,9 +52,10 @@
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
-#define ACL_HANDLE 42
-#define ISO_HANDLE 257
-#define SCO_HANDLE 257
+#define ACL_HANDLE BIT(0)
+#define SCO_HANDLE BIT(8)
+#define CIS_HANDLE SCO_HANDLE
+#define BIS_HANDLE BIT(9)
 #define SYNC_HANDLE 1
 #define INV_HANDLE 0xffff
 
@@ -72,8 +73,10 @@ struct hook {
 struct btdev_conn {
 	uint16_t handle;
 	uint8_t  type;
+	uint8_t  past_mode;
 	struct btdev *dev;
 	struct btdev_conn *link;
+	struct queue *links;
 	void *data;
 };
 
@@ -386,7 +389,7 @@ static inline struct btdev *find_btdev_by_bdaddr_type(const uint8_t *bdaddr,
 		if (!dev)
 			continue;
 
-		if (bdaddr_type == 0x01)
+		if (bdaddr_type == 0x01 || bdaddr_type == 0x03)
 			cmp = memcmp(dev->random_addr, bdaddr, 6);
 		else
 			cmp = memcmp(dev->bdaddr, bdaddr, 6);
@@ -395,7 +398,7 @@ static inline struct btdev *find_btdev_by_bdaddr_type(const uint8_t *bdaddr,
 			return dev;
 
 		/* Check for instance own Random addresses */
-		if (bdaddr_type == 0x01) {
+		if (bdaddr_type == 0x01 || bdaddr_type == 0x03) {
 			adv = queue_find(dev->le_ext_adv, match_adv_addr,
 								bdaddr);
 			if (adv)
@@ -566,10 +569,15 @@ static void conn_remove(void *data)
 	if (conn->link) {
 		struct btdev_conn *link = conn->link;
 
-		conn_unlink(conn, conn->link);
-		conn_remove(link);
+		if (link->link == conn) {
+			conn_unlink(conn, conn->link);
+			conn_remove(link);
+		} else
+			queue_remove(link->links, conn);
 	}
 
+	queue_destroy(conn->links, conn_remove);
+
 	queue_remove(conn->dev->conns, conn);
 
 	free(conn->data);
@@ -1225,7 +1233,7 @@ static struct btdev_conn *find_bis_index(const struct btdev *remote,
 		conn = entry->data;
 
 		/* Skip if not a broadcast */
-		if (conn->type != HCI_ISODATA_PKT || conn->link)
+		if (conn->type != HCI_ISODATA_PKT && conn->handle < BIS_HANDLE)
 			continue;
 
 		if (!index)
@@ -1247,11 +1255,22 @@ static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
 	if (!bis)
 		return NULL;
 
-	conn = conn_add_bis(dev, ISO_HANDLE, bis->data);
+	conn = conn_add_bis(dev, BIS_HANDLE, bis->data);
 	if (!conn)
 		return NULL;
 
-	bis->link = conn;
+	if (!bis->link) {
+		bis->link = conn;
+	} else {
+		if (!bis->links)
+			bis->links = queue_new();
+
+		if (!queue_push_tail(bis->links, conn)) {
+			conn_remove(conn);
+			return NULL;
+		}
+	}
+
 	conn->link = bis;
 
 	util_debug(dev->debug_callback, dev->debug_data,
@@ -5466,6 +5485,9 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 	struct le_ext_adv *ext_adv;
 	uint16_t sync_handle = SYNC_HANDLE;
 
+	if (!remote)
+		return;
+
 	per_adv = queue_find(dev->le_per_adv, match_dev, remote);
 	if (!per_adv)
 		return;
@@ -6025,6 +6047,258 @@ static void set_le_50_commands(struct btdev *btdev)
 	btdev->cmds = cmd_le_5_0;
 }
 
+static void le_past_received_event(struct btdev_conn *acl,
+					struct bt_hci_evt_le_past_recv *ev,
+					struct le_per_adv *pa)
+{
+	struct btdev *remote;
+
+	le_meta_event(acl->dev, BT_HCI_EVT_LE_PAST_RECEIVED, ev, sizeof(*ev));
+
+	if (ev->status != BT_HCI_ERR_SUCCESS)
+		return;
+
+	remote = find_btdev_by_bdaddr_type(pa->addr, pa->addr_type);
+	if (!remote)
+		return;
+
+	switch (acl->past_mode) {
+	case 0x01:
+		/* HCI_LE_Periodic_Advertising_Report events will be
+		 * disabled.
+		 */
+		break;
+	case 0x02:
+		/* HCI_LE_Periodic_Advertising_Report events will be enabled
+		 * with duplicate filtering disabled.
+		 */
+	case 0x03:
+		/* HCI_LE_Periodic_Advertising_Report events will be enabled
+		 * with duplicate filtering enabled.
+		 */
+		send_pa(acl->dev, remote, 0, pa->sync_handle);
+		break;
+	}
+}
+
+static void le_past_received(struct btdev_conn *acl, struct le_per_adv *pa)
+{
+	struct btdev *dev = acl->dev;
+	struct bt_hci_evt_le_past_recv ev;
+	struct le_per_adv *cp;
+	uint16_t sync_handle = SYNC_HANDLE;
+
+	/* 0x00:
+	 * No attempt is made to synchronize to the periodic advertising and no
+	 * HCI_LE_Periodic_Advertising_Sync_Transfer_Received event is sent to
+	 * the Host.
+	 */
+	if (!acl->past_mode)
+		return;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = BT_HCI_ERR_SUCCESS;
+
+	/* Create a copy of the PA sync */
+	cp = le_per_adv_new(dev, pa->addr_type, pa->addr, pa->sid);
+	if (!cp) {
+		ev.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
+	/* Find the next available sync handle */
+	while (queue_find(dev->le_per_adv, match_sync_handle,
+					UINT_TO_PTR(sync_handle)))
+		sync_handle++;
+
+	cp->sync_handle = sync_handle;
+
+	ev.handle = cpu_to_le16(acl->handle);
+	ev.sync_handle = cpu_to_le16(cp->sync_handle);
+	ev.sid = cpu_to_le16(cp->sid);
+	ev.addr_type = cp->addr_type;
+	memcpy(ev.addr, cp->addr, sizeof(ev.addr));
+	ev.phy = 0x01;
+	ev.interval = acl->dev->le_pa_min_interval;
+	ev.clock_accuracy = 0x07;
+
+done:
+	le_past_received_event(acl, &ev, pa);
+}
+
+static int cmd_past(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_past *cmd = data;
+	struct bt_hci_rsp_le_past rsp;
+	struct le_per_adv *pa;
+	struct btdev_conn *acl = NULL;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.handle = cmd->handle;
+
+	pa = queue_find(dev->le_per_adv, match_sync_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->sync_handle)));
+	if (!pa) {
+		/* If the periodic advertising train corresponding to the
+		 * Sync_Handle parameter does not exist, the Controller shall
+		 * return the error code Unknown Advertising Identifier (0x42).
+		 */
+		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	acl = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!acl) {
+		/* If the Connection_Handle parameter does not identify a
+		 * current connection, the Controller shall return the error
+		 * code Unknown Connection Identifier (0x02).
+		 */
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_PAST, &rsp, sizeof(rsp));
+
+	if (rsp.status == BT_HCI_ERR_SUCCESS)
+		le_past_received(acl->link, pa);
+
+	return 0;
+}
+
+static void le_past_info_received(struct btdev_conn *acl, struct le_ext_adv *ea)
+{
+	struct btdev *dev = acl->dev;
+	struct bt_hci_evt_le_past_recv ev;
+	struct le_per_adv *pa;
+	uint16_t sync_handle = SYNC_HANDLE;
+
+	/* 0x00:
+	 * No attempt is made to synchronize to the periodic advertising and no
+	 * HCI_LE_Periodic_Advertising_Sync_Transfer_Received event is sent to
+	 * the Host.
+	 */
+	if (!acl->past_mode)
+		return;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.status = BT_HCI_ERR_SUCCESS;
+
+	/* Create a copy using EA parameters */
+	pa = le_per_adv_new(dev, ea->own_addr_type,
+			    ea->own_addr_type ? ea->random_addr :
+			    acl->link->dev->bdaddr, ea->sid);
+	if (!pa) {
+		ev.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
+	/* Find the next available sync handle */
+	while (queue_find(dev->le_per_adv, match_sync_handle,
+					UINT_TO_PTR(sync_handle)))
+		sync_handle++;
+
+	pa->sync_handle = sync_handle;
+
+	ev.handle = cpu_to_le16(acl->handle);
+	ev.sync_handle = cpu_to_le16(pa->sync_handle);
+	ev.sid = cpu_to_le16(pa->sid);
+	ev.addr_type = pa->addr_type;
+	memcpy(ev.addr, pa->addr, sizeof(ev.addr));
+	ev.phy = 0x01;
+	ev.interval = acl->dev->le_pa_min_interval;
+	ev.clock_accuracy = 0x07;
+
+done:
+	le_past_received_event(acl, &ev, pa);
+}
+
+static int cmd_past_set_info(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_past_set_info *cmd = data;
+	struct bt_hci_rsp_le_past_set_info rsp;
+	struct le_ext_adv *ea;
+	struct btdev_conn *acl = NULL;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.handle = cmd->handle;
+
+	ea = queue_find(dev->le_ext_adv, match_ext_adv_handle,
+					UINT_TO_PTR(cmd->adv_handle));
+	if (!ea) {
+		/* If the advertising set corresponding to the
+		 * Advertising_Handle parameter does not exist, the Controller
+		 * shall return the error code Unknown Advertising Identifier
+		 * (0x42).
+		 */
+		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	if (!dev->le_pa_enable) {
+		/* If periodic advertising is not currently in progress for the
+		 * advertising set, the Controller shall return the error code
+		 * Command Disallowed (0x0C).
+		 */
+		rsp.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+	acl = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!acl) {
+		/* If the Connection_Handle parameter does not identify a
+		 * current connection, the Controller shall return the error
+		 * code Unknown Connection Identifier (0x02).
+		 */
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_PAST_SET_INFO, &rsp, sizeof(rsp));
+
+	if (rsp.status == BT_HCI_ERR_SUCCESS)
+		le_past_info_received(acl->link, ea);
+
+	return 0;
+}
+
+static int cmd_past_params(struct btdev *dev, const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_le_past_params *cmd = data;
+	struct bt_hci_rsp_le_past_set_info rsp;
+	struct btdev_conn *acl = NULL;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.handle = cmd->handle;
+
+	acl = queue_find(dev->conns, match_handle,
+				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!acl) {
+		/* If the Connection_Handle parameter does not identify a
+		 * current connection, the Controller shall return the error
+		 * code Unknown Connection Identifier (0x02).
+		 */
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	acl->past_mode = cmd->mode;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_PAST_PARAMS, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
 static int cmd_read_size_v2(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -6062,19 +6336,19 @@ static int find_cig(struct btdev *dev, uint8_t cig_id)
 static uint16_t make_cis_handle(uint8_t cig_idx, uint8_t cis_idx)
 {
 	/* Put CIG+CIS idxs to handle so don't need to track separately */
-	return ISO_HANDLE + cig_idx*CIS_SIZE + cis_idx;
+	return CIS_HANDLE + cig_idx*CIS_SIZE + cis_idx;
 }
 
 static int parse_cis_handle(uint16_t handle, int *cis_idx)
 {
 	int cig_idx;
 
-	if (handle < ISO_HANDLE || handle >= ISO_HANDLE + CIS_SIZE*CIG_SIZE)
+	if (handle < CIS_HANDLE || handle >= CIS_HANDLE + CIS_SIZE*CIG_SIZE)
 		return -1;
 
-	cig_idx = (handle - ISO_HANDLE) / CIS_SIZE;
+	cig_idx = (handle - CIS_HANDLE) / CIS_SIZE;
 	if (cis_idx)
-		*cis_idx = (handle - ISO_HANDLE) % CIS_SIZE;
+		*cis_idx = (handle - CIS_HANDLE) % CIS_SIZE;
 
 	return cig_idx;
 }
@@ -6514,7 +6788,7 @@ static int cmd_create_big_complete(struct btdev *dev, const void *data,
 	for (i = 0; i < cmd->num_bis; i++) {
 		struct btdev_conn *conn;
 
-		conn = conn_add_bis(dev, ISO_HANDLE + i, bis);
+		conn = conn_add_bis(dev, BIS_HANDLE + i, bis);
 		if (!conn) {
 			queue_remove(dev->le_big, big);
 			le_big_free(big);
@@ -6691,17 +6965,28 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 	struct bt_hci_bis *bis;
 	int i;
 	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
-	struct le_per_adv *per_adv = queue_find(dev->le_per_adv,
-			match_sync_handle, UINT_TO_PTR(sync_handle));
+	struct le_per_adv *per_adv;
 	struct le_big *big;
 
-	if  (!per_adv)
+	memset(&pdu.ev, 0, sizeof(pdu.ev));
+
+	per_adv = queue_find(dev->le_per_adv, match_sync_handle,
+					UINT_TO_PTR(sync_handle));
+	if  (!per_adv) {
+		pdu.ev.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		le_meta_event(dev, BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED, &pdu,
+					sizeof(pdu.ev));
 		return 0;
+	}
 
 	remote = find_btdev_by_bdaddr_type(per_adv->addr,
 						per_adv->addr_type);
-	if (!remote)
+	if (!remote) {
+		pdu.ev.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		le_meta_event(dev, BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED, &pdu,
+					sizeof(pdu.ev));
 		return 0;
+	}
 
 	big = le_big_new(dev, cmd->handle);
 	if (!big) {
@@ -6711,8 +6996,6 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	memset(&pdu.ev, 0, sizeof(pdu.ev));
-
 	for (i = 0; i < cmd->num_bis; i++) {
 		conn = conn_link_bis(dev, remote, i);
 		if (!conn)
@@ -6992,6 +7275,9 @@ static int cmd_config_data_path(struct btdev *dev, const void *data,
 }
 
 #define CMD_LE_52 \
+	CMD(BT_HCI_CMD_LE_PAST, cmd_past, NULL), \
+	CMD(BT_HCI_CMD_LE_PAST_SET_INFO, cmd_past_set_info, NULL), \
+	CMD(BT_HCI_CMD_LE_PAST_PARAMS, cmd_past_params, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2, cmd_read_size_v2, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_ISO_TX_SYNC, cmd_read_iso_tx_sync, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_EVENT_MASK, cmd_le_set_event_mask, NULL), \
@@ -7036,6 +7322,9 @@ static const struct btdev_cmd cmd_le_5_2[] = {
 
 static void set_le_52_commands(struct btdev *btdev)
 {
+	btdev->commands[40] |= BIT(6);	/* LE PAST */
+	btdev->commands[40] |= BIT(7);	/* LE PA Set Info Transfer */
+	btdev->commands[41] |= BIT(1);	/* LE PAST Parameters */
 	btdev->commands[41] |= 0x20;	/* LE Read Buffer Size v2 */
 	btdev->commands[41] |= 0x40;	/* LE Read ISO TX Sync */
 	btdev->commands[41] |= 0x80;	/* LE Set CIG Parameters */
@@ -7317,6 +7606,8 @@ static void set_bredrle_features(struct btdev *btdev)
 
 	if (btdev->type >= BTDEV_TYPE_BREDRLE52) {
 		btdev->le_features[1] |= 0x20;  /* LE PER ADV */
+		btdev->le_features[3] |= BIT(0);  /* LE PAST Sender */
+		btdev->le_features[3] |= BIT(1);  /* LE PAST Receiver */
 		btdev->le_features[3] |= 0x10;  /* LE CIS Central */
 		btdev->le_features[3] |= 0x20;  /* LE CIS Peripheral */
 		btdev->le_features[3] |= 0x40;  /* LE ISO Broadcaster */
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 079f14fb3bec..79d8305d78cf 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1855,6 +1855,24 @@ static void evt_le_big_sync_established(struct bthost *bthost,
 	}
 }
 
+static void evt_le_big_info_adv_report(struct bthost *bthost,
+						const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_info_adv_report *ev = data;
+	struct {
+		struct bt_hci_cmd_le_big_create_sync cp;
+		struct bt_hci_bis_sync index[1];
+	} cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cp.handle = 0x01;
+	cmd.cp.sync_handle = ev->sync_handle;
+	cmd.cp.encryption = ev->encryption;
+	cmd.cp.num_bis = 1;
+
+	send_command(bthost, BT_HCI_CMD_LE_BIG_CREATE_SYNC, &cmd, sizeof(cmd));
+}
+
 static void evt_le_meta_event(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1897,6 +1915,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED:
 		evt_le_big_sync_established(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_BIG_INFO_ADV_REPORT:
+		evt_le_big_info_adv_report(bthost, evt_data, len - 1);
+		break;
 	default:
 		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
 								*event);
@@ -3715,6 +3736,28 @@ void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_PA_ENABLE, &cp, sizeof(cp));
 }
 
+void bthost_set_past_mode(struct bthost *bthost, uint16_t handle, uint8_t mode)
+{
+	struct bt_hci_cmd_le_past_params cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(handle);
+	cp.mode = mode;
+
+	send_command(bthost, BT_HCI_CMD_LE_PAST_PARAMS, &cp, sizeof(cp));
+}
+
+void bthost_past_set_info(struct bthost *bthost, uint16_t handle)
+{
+	struct bt_hci_cmd_le_past_set_info cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(handle);
+	cp.adv_handle = 0x01;
+
+	send_command(bthost, BT_HCI_CMD_LE_PAST_SET_INFO, &cp, sizeof(cp));
+}
+
 void bthost_create_big(struct bthost *bthost, uint8_t num_bis,
 				uint8_t enc, const uint8_t *bcode)
 {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index d60111d25966..4061c0be5349 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -122,8 +122,10 @@ void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 void bthost_set_pa_params(struct bthost *bthost);
 void bthost_set_pa_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
+void bthost_set_past_mode(struct bthost *bthost, uint16_t handle, uint8_t mode);
 void bthost_set_base(struct bthost *bthost, const uint8_t *data, uint8_t len);
 void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
+void bthost_past_set_info(struct bthost *bthost, uint16_t handle);
 void bthost_create_big(struct bthost *bthost, uint8_t num_bis, uint8_t enc,
 				const uint8_t *bcode);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
@@ -133,7 +135,6 @@ void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
 void bthost_create_cis(struct bthost *bthost, uint16_t cis_handle,
 						uint16_t acl_handle);
 
-
 void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
 				uint8_t addr_type, uint8_t filter_policy);
 void bthost_set_scan_enable(struct bthost *bthost, uint8_t enable);
-- 
2.51.0

