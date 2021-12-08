Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 02:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhLHCJ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHCJ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 21:09:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6CC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 18:05:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so3269620pju.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 18:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyLXMUv/DNy8rNpTnVvFg42X1TD3WqEF+5Yghb2sdZo=;
        b=U+YKsOQ4GuNV3jt+i37VMf2duHWSBXNc1eKtx6JMtEkzQ4a/M8Adc1gZelrcEvDAgM
         O7O7q2u/OMosggZ9UbwqOM32tvakEyMIDUh9EyVnbzaNBJEHFMFF0lJqrpfO0cviSzIC
         E6x9aT8WeeivB6aQrrLpK4zh7QWs0PBkbZxXVRf/xdK6tXiJol1umnKMCgvsNXAvIzaz
         tSm/yXgiouspxi/Wxt5lpSMezdu3NZ6mC5CiwXPu64PYrJE+6i//y02QcEBM8oWHT04Q
         RpE8VC+gSWj5VB9gsu+nGplGhkV+xdVNMh7brOI23bxiuJDD+brU1UPKSbyn9ZESsitm
         /KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyLXMUv/DNy8rNpTnVvFg42X1TD3WqEF+5Yghb2sdZo=;
        b=O5bbiT+FIeXi8XSudY6SazGFG7XFz9VvxsXjnE/VbSGqNULeAZfB+paIydGJQS23Jq
         5Yn+62f0Q7ZXqv7xKFfxd4rb1cas0lPzc/kWWOjX4MYVxQQ6wBYgHONgLv/Kswb/b9G1
         RpA/+zGxMNq2a2eFOh4sUHxfFl5jTWCZQ64Z4tiwvTGFhPN9qikpSuSGn4cdu539sD06
         qJitruruz8+AHNbChl3kE7dGt/4MBM6ncFTKben9jqmmACfaHFZT966ie2neO1GxAwCu
         /KS1TWo8xkNam/nh92w2USToH7bbKFEhkg4S+gVDgbIGCl1bGy6ukmC996cyPqEbiss+
         Gm1g==
X-Gm-Message-State: AOAM530kZJfc+A47KZhqvfr60LtNdLfJO745jC6gtQeiYOUbvFZyoJi4
        NXvSWGShsW4qn0xxMrOVbcJGeBTrpxU=
X-Google-Smtp-Source: ABdhPJwMmoYN0roZynd7lv0h/v9V8TLwC0WZi0h255Lecza8wrXxXgHyWdNC17WpxGvVP+RWEwlo/g==
X-Received: by 2002:a17:903:32d1:b0:142:1ce1:30c9 with SMTP id i17-20020a17090332d100b001421ce130c9mr56138506plr.0.1638929154767;
        Tue, 07 Dec 2021 18:05:54 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v3sm690140pga.78.2021.12.07.18.05.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 18:05:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Add hci_le_create_conn_sync
Date:   Tue,  7 Dec 2021 18:05:53 -0800
Message-Id: <20211208020553.219387-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds hci_le_create_conn_sync and make hci_le_connect use it instead
of queueing multiple commands which may conflict with the likes of
hci_update_passive_scan which uses hci_cmd_sync_queue.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/hci_sync.h |   4 +
 net/bluetooth/hci_conn.c         | 300 ++-----------------------------
 net/bluetooth/hci_sync.c         | 295 ++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+), 285 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4d69dcfebd63..c41ad7847d9d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -646,6 +646,7 @@ struct hci_conn {
 	__u8		init_addr_type;
 	bdaddr_t	resp_addr;
 	__u8		resp_addr_type;
+	bdaddr_t	direct_rpa;
 	__u8		adv_instance;
 	__u16		handle;
 	__u16		state;
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index f4034bf8f1ce..0d2a75d88e7c 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -101,3 +101,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev);
 
 int hci_suspend_sync(struct hci_dev *hdev);
 int hci_resume_sync(struct hci_dev *hdev);
+
+struct hci_conn;
+
+int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cd6e1cf7e396..a767f89ca86e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -911,267 +911,45 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	hci_enable_advertising(hdev);
 }
 
-static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct hci_conn *conn;
+	struct hci_conn *conn = data;
 
 	hci_dev_lock(hdev);
 
-	conn = hci_lookup_le_connect(hdev);
-
-	if (hdev->adv_instance_cnt)
-		hci_req_resume_adv_instances(hdev);
-
-	if (!status) {
+	if (!err) {
 		hci_connect_le_scan_cleanup(conn);
 		goto done;
 	}
 
-	bt_dev_err(hdev, "request failed to create LE connection: "
-		   "status 0x%2.2x", status);
+	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
 
 	if (!conn)
 		goto done;
 
-	hci_le_conn_failed(conn, status);
+	hci_le_conn_failed(conn, err);
 
 done:
 	hci_dev_unlock(hdev);
 }
 
-static bool conn_use_rpa(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-
-	return hci_dev_test_flag(hdev, HCI_PRIVACY);
-}
-
-static void set_ext_conn_params(struct hci_conn *conn,
-				struct hci_cp_le_ext_conn_param *p)
-{
-	struct hci_dev *hdev = conn->hdev;
-
-	memset(p, 0, sizeof(*p));
-
-	p->scan_interval = cpu_to_le16(hdev->le_scan_int_connect);
-	p->scan_window = cpu_to_le16(hdev->le_scan_window_connect);
-	p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
-	p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-	p->conn_latency = cpu_to_le16(conn->le_conn_latency);
-	p->supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
-	p->min_ce_len = cpu_to_le16(0x0000);
-	p->max_ce_len = cpu_to_le16(0x0000);
-}
-
-static void hci_req_add_le_create_conn(struct hci_request *req,
-				       struct hci_conn *conn,
-				       bdaddr_t *direct_rpa)
+static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_dev *hdev = conn->hdev;
-	u8 own_addr_type;
-
-	/* If direct address was provided we use it instead of current
-	 * address.
-	 */
-	if (direct_rpa) {
-		if (bacmp(&req->hdev->random_addr, direct_rpa))
-			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
-								direct_rpa);
-
-		/* direct address is always RPA */
-		own_addr_type = ADDR_LE_DEV_RANDOM;
-	} else {
-		/* Update random address, but set require_privacy to false so
-		 * that we never connect with an non-resolvable address.
-		 */
-		if (hci_update_random_address(req, false, conn_use_rpa(conn),
-					      &own_addr_type))
-			return;
-	}
-
-	if (use_ext_conn(hdev)) {
-		struct hci_cp_le_ext_create_conn *cp;
-		struct hci_cp_le_ext_conn_param *p;
-		u8 data[sizeof(*cp) + sizeof(*p) * 3];
-		u32 plen;
-
-		cp = (void *) data;
-		p = (void *) cp->data;
+	struct hci_conn *conn = data;
 
-		memset(cp, 0, sizeof(*cp));
+	bt_dev_dbg(hdev, "conn %p", conn);
 
-		bacpy(&cp->peer_addr, &conn->dst);
-		cp->peer_addr_type = conn->dst_type;
-		cp->own_addr_type = own_addr_type;
-
-		plen = sizeof(*cp);
-
-		if (scan_1m(hdev)) {
-			cp->phys |= LE_SCAN_PHY_1M;
-			set_ext_conn_params(conn, p);
-
-			p++;
-			plen += sizeof(*p);
-		}
-
-		if (scan_2m(hdev)) {
-			cp->phys |= LE_SCAN_PHY_2M;
-			set_ext_conn_params(conn, p);
-
-			p++;
-			plen += sizeof(*p);
-		}
-
-		if (scan_coded(hdev)) {
-			cp->phys |= LE_SCAN_PHY_CODED;
-			set_ext_conn_params(conn, p);
-
-			plen += sizeof(*p);
-		}
-
-		hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, plen, data);
-
-	} else {
-		struct hci_cp_le_create_conn cp;
-
-		memset(&cp, 0, sizeof(cp));
-
-		cp.scan_interval = cpu_to_le16(hdev->le_scan_int_connect);
-		cp.scan_window = cpu_to_le16(hdev->le_scan_window_connect);
-
-		bacpy(&cp.peer_addr, &conn->dst);
-		cp.peer_addr_type = conn->dst_type;
-		cp.own_address_type = own_addr_type;
-		cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
-		cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-		cp.conn_latency = cpu_to_le16(conn->le_conn_latency);
-		cp.supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
-		cp.min_ce_len = cpu_to_le16(0x0000);
-		cp.max_ce_len = cpu_to_le16(0x0000);
-
-		hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
-	}
-
-	conn->state = BT_CONNECT;
-	clear_bit(HCI_CONN_SCANNING, &conn->flags);
-}
-
-static void hci_req_directed_advertising(struct hci_request *req,
-					 struct hci_conn *conn)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 own_addr_type;
-	u8 enable;
-
-	if (ext_adv_capable(hdev)) {
-		struct hci_cp_le_set_ext_adv_params cp;
-		bdaddr_t random_addr;
-
-		/* Set require_privacy to false so that the remote device has a
-		 * chance of identifying us.
-		 */
-		if (hci_get_random_address(hdev, false, conn_use_rpa(conn), NULL,
-					   &own_addr_type, &random_addr) < 0)
-			return;
-
-		memset(&cp, 0, sizeof(cp));
-
-		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_DIRECT_IND);
-		cp.own_addr_type = own_addr_type;
-		cp.channel_map = hdev->le_adv_channel_map;
-		cp.tx_power = HCI_TX_POWER_INVALID;
-		cp.primary_phy = HCI_ADV_PHY_1M;
-		cp.secondary_phy = HCI_ADV_PHY_1M;
-		cp.handle = 0; /* Use instance 0 for directed adv */
-		cp.own_addr_type = own_addr_type;
-		cp.peer_addr_type = conn->dst_type;
-		bacpy(&cp.peer_addr, &conn->dst);
-
-		/* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
-		 * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
-		 * does not supports advertising data when the advertising set already
-		 * contains some, the controller shall return erroc code 'Invalid
-		 * HCI Command Parameters(0x12).
-		 * So it is required to remove adv set for handle 0x00. since we use
-		 * instance 0 for directed adv.
-		 */
-		__hci_req_remove_ext_adv_instance(req, cp.handle);
-
-		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
-
-		if (own_addr_type == ADDR_LE_DEV_RANDOM &&
-		    bacmp(&random_addr, BDADDR_ANY) &&
-		    bacmp(&random_addr, &hdev->random_addr)) {
-			struct hci_cp_le_set_adv_set_rand_addr cp;
-
-			memset(&cp, 0, sizeof(cp));
-
-			cp.handle = 0;
-			bacpy(&cp.bdaddr, &random_addr);
-
-			hci_req_add(req,
-				    HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
-				    sizeof(cp), &cp);
-		}
-
-		__hci_req_enable_ext_advertising(req, 0x00);
-	} else {
-		struct hci_cp_le_set_adv_param cp;
-
-		/* Clear the HCI_LE_ADV bit temporarily so that the
-		 * hci_update_random_address knows that it's safe to go ahead
-		 * and write a new random address. The flag will be set back on
-		 * as soon as the SET_ADV_ENABLE HCI command completes.
-		 */
-		hci_dev_clear_flag(hdev, HCI_LE_ADV);
-
-		/* Set require_privacy to false so that the remote device has a
-		 * chance of identifying us.
-		 */
-		if (hci_update_random_address(req, false, conn_use_rpa(conn),
-					      &own_addr_type) < 0)
-			return;
-
-		memset(&cp, 0, sizeof(cp));
-
-		/* Some controllers might reject command if intervals are not
-		 * within range for undirected advertising.
-		 * BCM20702A0 is known to be affected by this.
-		 */
-		cp.min_interval = cpu_to_le16(0x0020);
-		cp.max_interval = cpu_to_le16(0x0020);
-
-		cp.type = LE_ADV_DIRECT_IND;
-		cp.own_address_type = own_addr_type;
-		cp.direct_addr_type = conn->dst_type;
-		bacpy(&cp.direct_addr, &conn->dst);
-		cp.channel_map = hdev->le_adv_channel_map;
-
-		hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
-
-		enable = 0x01;
-		hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
-			    &enable);
-	}
-
-	conn->state = BT_CONNECT;
+	return hci_le_create_conn_sync(hdev, conn);
 }
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role, bdaddr_t *direct_rpa)
 {
-	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	struct smp_irk *irk;
-	struct hci_request req;
 	int err;
 
-	/* This ensures that during disable le_scan address resolution
-	 * will not be disabled if it is followed by le_create_conn
-	 */
-	bool rpa_le_conn = true;
-
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		if (lmp_le_capable(hdev))
@@ -1230,62 +1008,14 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 
-	hci_req_init(&req, hdev);
-
-	/* Disable advertising if we're active. For central role
-	 * connections most controllers will refuse to connect if
-	 * advertising is enabled, and for peripheral role connections we
-	 * anyway have to disable it in order to start directed
-	 * advertising. Any registered advertisements will be
-	 * re-enabled after the connection attempt is finished.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-		__hci_req_pause_adv_instances(&req);
-
-	/* If requested to connect as peripheral use directed advertising */
-	if (conn->role == HCI_ROLE_SLAVE) {
-		/* If we're active scanning most controllers are unable
-		 * to initiate advertising. Simply reject the attempt.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
-		    hdev->le_scan_type == LE_SCAN_ACTIVE) {
-			hci_req_purge(&req);
-			hci_conn_del(conn);
-			return ERR_PTR(-EBUSY);
-		}
+	if (direct_rpa)
+		bacpy(&conn->direct_rpa, direct_rpa);
 
-		hci_req_directed_advertising(&req, conn);
-		goto create_conn;
-	}
-
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
-		conn->le_conn_min_interval = params->conn_min_interval;
-		conn->le_conn_max_interval = params->conn_max_interval;
-		conn->le_conn_latency = params->conn_latency;
-		conn->le_supv_timeout = params->supervision_timeout;
-	} else {
-		conn->le_conn_min_interval = hdev->le_conn_min_interval;
-		conn->le_conn_max_interval = hdev->le_conn_max_interval;
-		conn->le_conn_latency = hdev->le_conn_latency;
-		conn->le_supv_timeout = hdev->le_supv_timeout;
-	}
-
-	/* If controller is scanning, we stop it since some controllers are
-	 * not able to scan and connect at the same time. Also set the
-	 * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
-	 * handler for scan disabling knows to set the correct discovery
-	 * state.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-		hci_req_add_le_scan_disable(&req, rpa_le_conn);
-		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
-	}
-
-	hci_req_add_le_create_conn(&req, conn, direct_rpa);
+	conn->state = BT_CONNECT;
+	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 
-create_conn:
-	err = hci_req_run(&req, create_le_conn_complete);
+	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync, conn,
+				 create_le_conn_complete);
 	if (err) {
 		hci_conn_del(conn);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3d28ca7ebe45..90fbf293a30e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4976,3 +4976,298 @@ int hci_resume_sync(struct hci_dev *hdev)
 
 	return 0;
 }
+
+static bool conn_use_rpa(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	return hci_dev_test_flag(hdev, HCI_PRIVACY);
+}
+
+static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
+						struct hci_conn *conn)
+{
+	struct hci_cp_le_set_ext_adv_params cp;
+	int err;
+	bdaddr_t random_addr;
+	u8 own_addr_type;
+
+	err = hci_update_random_address_sync(hdev, false, conn_use_rpa(conn),
+					     &own_addr_type);
+	if (err)
+		return err;
+
+	/* Set require_privacy to false so that the remote device has a
+	 * chance of identifying us.
+	 */
+	err = hci_get_random_address(hdev, false, conn_use_rpa(conn), NULL,
+				     &own_addr_type, &random_addr);
+	if (err)
+		return err;
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_DIRECT_IND);
+	cp.own_addr_type = own_addr_type;
+	cp.channel_map = hdev->le_adv_channel_map;
+	cp.tx_power = HCI_TX_POWER_INVALID;
+	cp.primary_phy = HCI_ADV_PHY_1M;
+	cp.secondary_phy = HCI_ADV_PHY_1M;
+	cp.handle = 0x00; /* Use instance 0 for directed adv */
+	cp.own_addr_type = own_addr_type;
+	cp.peer_addr_type = conn->dst_type;
+	bacpy(&cp.peer_addr, &conn->dst);
+
+	/* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
+	 * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
+	 * does not supports advertising data when the advertising set already
+	 * contains some, the controller shall return erroc code 'Invalid
+	 * HCI Command Parameters(0x12).
+	 * So it is required to remove adv set for handle 0x00. since we use
+	 * instance 0 for directed adv.
+	 */
+	err = hci_remove_ext_adv_instance_sync(hdev, cp.handle, NULL);
+	if (err)
+		return err;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Check if random address need to be updated */
+	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
+	    bacmp(&random_addr, BDADDR_ANY) &&
+	    bacmp(&random_addr, &hdev->random_addr)) {
+		err = hci_set_adv_set_random_addr_sync(hdev, 0x00,
+						       &random_addr);
+		if (err)
+			return err;
+	}
+
+	return hci_enable_ext_advertising_sync(hdev, 0x00);
+}
+
+static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
+					    struct hci_conn *conn)
+{
+	struct hci_cp_le_set_adv_param cp;
+	u8 status;
+	u8 own_addr_type;
+	u8 enable;
+
+	if (ext_adv_capable(hdev))
+		return hci_le_ext_directed_advertising_sync(hdev, conn);
+
+	/* Clear the HCI_LE_ADV bit temporarily so that the
+	 * hci_update_random_address knows that it's safe to go ahead
+	 * and write a new random address. The flag will be set back on
+	 * as soon as the SET_ADV_ENABLE HCI command completes.
+	 */
+	hci_dev_clear_flag(hdev, HCI_LE_ADV);
+
+	/* Set require_privacy to false so that the remote device has a
+	 * chance of identifying us.
+	 */
+	status = hci_update_random_address_sync(hdev, false, conn_use_rpa(conn),
+						&own_addr_type);
+	if (status)
+		return status;
+
+	memset(&cp, 0, sizeof(cp));
+
+	/* Some controllers might reject command if intervals are not
+	 * within range for undirected advertising.
+	 * BCM20702A0 is known to be affected by this.
+	 */
+	cp.min_interval = cpu_to_le16(0x0020);
+	cp.max_interval = cpu_to_le16(0x0020);
+
+	cp.type = LE_ADV_DIRECT_IND;
+	cp.own_address_type = own_addr_type;
+	cp.direct_addr_type = conn->dst_type;
+	bacpy(&cp.direct_addr, &conn->dst);
+	cp.channel_map = hdev->le_adv_channel_map;
+
+	status = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_PARAM,
+				       sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (status)
+		return status;
+
+	enable = 0x01;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+}
+
+static void set_ext_conn_params(struct hci_conn *conn,
+				struct hci_cp_le_ext_conn_param *p)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	memset(p, 0, sizeof(*p));
+
+	p->scan_interval = cpu_to_le16(hdev->le_scan_int_connect);
+	p->scan_window = cpu_to_le16(hdev->le_scan_window_connect);
+	p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
+	p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
+	p->conn_latency = cpu_to_le16(conn->le_conn_latency);
+	p->supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
+	p->min_ce_len = cpu_to_le16(0x0000);
+	p->max_ce_len = cpu_to_le16(0x0000);
+}
+
+int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				u8 own_addr_type)
+{
+	struct hci_cp_le_ext_create_conn *cp;
+	struct hci_cp_le_ext_conn_param *p;
+	u8 data[sizeof(*cp) + sizeof(*p) * 3];
+	u32 plen;
+
+	cp = (void *) data;
+	p = (void *) cp->data;
+
+	memset(cp, 0, sizeof(*cp));
+
+	bacpy(&cp->peer_addr, &conn->dst);
+	cp->peer_addr_type = conn->dst_type;
+	cp->own_addr_type = own_addr_type;
+
+	plen = sizeof(*cp);
+
+	if (scan_1m(hdev)) {
+		cp->phys |= LE_SCAN_PHY_1M;
+		set_ext_conn_params(conn, p);
+
+		p++;
+		plen += sizeof(*p);
+	}
+
+	if (scan_2m(hdev)) {
+		cp->phys |= LE_SCAN_PHY_2M;
+		set_ext_conn_params(conn, p);
+
+		p++;
+		plen += sizeof(*p);
+	}
+
+	if (scan_coded(hdev)) {
+		cp->phys |= LE_SCAN_PHY_CODED;
+		set_ext_conn_params(conn, p);
+
+		plen += sizeof(*p);
+	}
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
+				     plen, data, HCI_CMD_TIMEOUT);
+}
+
+int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct hci_cp_le_create_conn cp;
+	struct hci_conn_params *params;
+	u8 own_addr_type;
+	int err;
+
+	/* Disable advertising if we're active. For central role
+	 * connections most controllers will refuse to connect if
+	 * advertising is enabled, and for peripheral role connections we
+	 * anyway have to disable it in order to start directed
+	 * advertising. Any registered advertisements will be
+	 * re-enabled after the connection attempt is finished.
+	 */
+	hci_pause_advertising_sync(hdev);
+
+	/* If requested to connect as peripheral use directed advertising */
+	if (conn->role == HCI_ROLE_SLAVE) {
+		/* If we're active scanning most controllers are unable
+		 * to initiate advertising. Simply reject the attempt.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
+		    hdev->le_scan_type == LE_SCAN_ACTIVE) {
+			hci_conn_del(conn);
+			return -EBUSY;
+		}
+
+		err = hci_le_directed_advertising_sync(hdev, conn);
+		goto done;
+	}
+
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (params) {
+		conn->le_conn_min_interval = params->conn_min_interval;
+		conn->le_conn_max_interval = params->conn_max_interval;
+		conn->le_conn_latency = params->conn_latency;
+		conn->le_supv_timeout = params->supervision_timeout;
+	} else {
+		conn->le_conn_min_interval = hdev->le_conn_min_interval;
+		conn->le_conn_max_interval = hdev->le_conn_max_interval;
+		conn->le_conn_latency = hdev->le_conn_latency;
+		conn->le_supv_timeout = hdev->le_supv_timeout;
+	}
+
+	/* If direct address was provided we use it instead of current
+	 * address.
+	 */
+	if (bacmp(&conn->direct_rpa, BDADDR_ANY)) {
+		if (bacmp(&hdev->random_addr, &conn->direct_rpa)) {
+			err = __hci_cmd_sync_status(hdev,
+						    HCI_OP_LE_SET_RANDOM_ADDR,
+						    6, &conn->direct_rpa,
+						    HCI_CMD_TIMEOUT);
+			if (err)
+				return err;
+		}
+
+		/* direct address is always RPA */
+		own_addr_type = ADDR_LE_DEV_RANDOM;
+	} else {
+		/* Update random address, but set require_privacy to false so
+		 * that we never connect with an non-resolvable address.
+		 */
+		err = hci_update_random_address_sync(hdev, false,
+						     conn_use_rpa(conn),
+						     &own_addr_type);
+		if (err)
+			return err;
+	}
+
+	/* If controller is scanning, we stop it since some controllers are
+	 * not able to scan and connect at the same time. Also set the
+	 * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
+	 * handler for scan disabling knows to set the correct discovery
+	 * state.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+		hci_scan_disable_sync(hdev);
+		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
+	}
+
+	if (use_ext_conn(hdev)) {
+		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
+		goto done;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.scan_interval = cpu_to_le16(hdev->le_scan_int_connect);
+	cp.scan_window = cpu_to_le16(hdev->le_scan_window_connect);
+
+	bacpy(&cp.peer_addr, &conn->dst);
+	cp.peer_addr_type = conn->dst_type;
+	cp.own_address_type = own_addr_type;
+	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
+	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
+	cp.conn_latency = cpu_to_le16(conn->le_conn_latency);
+	cp.supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
+	cp.min_ce_len = cpu_to_le16(0x0000);
+	cp.max_ce_len = cpu_to_le16(0x0000);
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+
+done:
+	hci_resume_advertising_sync(hdev);
+	return err;
+}
-- 
2.33.1

