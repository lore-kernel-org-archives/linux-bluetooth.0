Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92118E362
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199170; cv=none; b=jaTpUGMs2cwLzs988A1Mj/yMDnNjCVOBil2tW+Pt5sH1IkTpBzEEwGOkVMFiPkQ4CYHzcPPqoZiIoYYNvLowdBMdelMSjEZmXGw9PFsJntt+v+gHhW1kYskvZMQ2575KYxDzGPVqIuNowDWCOB550f1VPb8bYPsiWhdpMKpRbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199170; c=relaxed/simple;
	bh=CfAoDMukaFz4IWz/dm2LREXmpmIkyKpY2hci+nouvkA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H8rSOZZsUGSGZKmZQOkWtGDdJvNvbarrNBwqGLn5L+0s92BizSq3RpT+2QlFZzZFZ7bHc/dmxcFwJQ72BWzU2N5nxhddDFU0RP5HXiIMhNBS7XxvQs0hvkrXZSmLAc5wY8gDpSfHhWFs7L4aSYEmYNUYnPqeOMECTBwj/M+cpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV1lYXag; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV1lYXag"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523c67dba31so459095e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741199166; x=1741803966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qd+QuRpWQAcZNOt1WkALpL35Ybv9h4MgeQYJzN29R4=;
        b=TV1lYXag5TfzSYpFrNhFpZPu7jkI1HSGfBcomT672jsencG/IxaqtFgDqB6phwMJUY
         Y4VL3kc6cdAof4Pefdfs9vXPteVAI+q6HK4/G09Ft7xQj83uba6BqKFujwN0GdiaNkVb
         m85IWYQFmG8I9pT8iS2u0TmuoX7gw3DhsLVa5HlvEQbHjxd3C3mu9InIhXc16lmmGB9U
         6Q9/3oEyeYT3TRLvg4Vnd5mVfp/PWLEhA//iPunIc5WKYTjzg0qJDJq1WF1VhRa5TAtF
         BQkAkyMRVcYVG4nxhIT3VqRhXqhV3eBcHR46z2sLCWfPDCYgwwKRHOGizQW1KviUwOHR
         pezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199166; x=1741803966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qd+QuRpWQAcZNOt1WkALpL35Ybv9h4MgeQYJzN29R4=;
        b=u8BxRp0O7TNhTcnz8jkN8AMtkmW6nw1TNTS/nmWquX/3f1GEhvOg5bMOxgsKLkNWN+
         IHtf9Ou3bU2XVmKbYzKntfOiYWxB2SVopGmjolQhjgOP53Cz26KEe8F1r5a/TBx7PsO1
         tuTE3nQykv7mXxMbrqIM0XuNfwLvEroA04RGtNRHbwE05a1WtErmQ83M7NTV20HyK+uz
         G4M0j9GQzDC2QSwkv+4elsI5CLqhUklrhWDnlO3LdfMrBqIxX3u4orly/9zje1l5sjqo
         0aKHmyazR5GejGl8YZQ3NLiu92sk1rkPXuB40EPnQTmfIZ9EGBjD2Ip17eilvAl/6V3Y
         pD8Q==
X-Gm-Message-State: AOJu0YyCQ5vRMnbXJUwrQES/3W+rjotC1k7HJ5NJFQt2D+ifyIAQLGkM
	pxzyPKWirjclgpTpnzfl6f3pbPTmKcVx7xArG/mRMFgSJXl1Yac9vE8EDA==
X-Gm-Gg: ASbGncs0uJY/I+U7zQUV835wP4YQPgZxFFbwZs72GGj+w9o4+itQ823i9guwKDI8N+d
	L9iUhS1PCpRJyNH1kCU+RKGkxl/hVCwqHgyF4UMU6YHrCfo6JEd96o03XghhF0X9R/vZ7QhR+GI
	FRBei2OyU8HNRNNdb4VfFUPmKSB6wdYt/2UD6tmGf4GImLb996Jx6H2UswkfVpnNT5YCexpAM4t
	rx7pOVbpHtWuLyQDrVBW8T7rv2Ma5XkRlhouTG9B6wPOY5AA92DpyE0mIlIBa2kdv+Y23aBGk6q
	bIXfMskFk3MjAdENJ1W73NNgOim8pCegqla8UDVhfYsKL4MRw7mRWkkTKcJr7TsPWoZqLNw3cZ5
	SA5D72Z/WM978bQ==
X-Google-Smtp-Source: AGHT+IFPyogsKeY3pD22Ol7LE3Wa2PIn7FG5RGfpvH5jIAREbfHhE1P0Oq7GAj7komLmxlqed5AwDQ==
X-Received: by 2002:a05:6102:304f:b0:4ba:974c:891e with SMTP id ada2fe7eead31-4c2e29520d8mr2900558137.17.1741199166206;
        Wed, 05 Mar 2025 10:26:06 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b3dc41d48sm2497159241.20.2025.03.05.10.26.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:26:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Wed,  5 Mar 2025 13:26:03 -0500
Message-ID: <20250305182603.409335-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables buffer flow control for SCO/eSCO
(see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
recently this has caused the following problem and is actually a nice
addition for the likes of Socket TX complete:

< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 5
        SCO MTU: 240  SCO max packet: 8
...
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
> HCI Event: Hardware Error (0x10) plen 1
        Code: 0x0a

To fix the code will now attempt to enable buffer flow control:

< HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
        Flow control: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
        Status: Success (0x00)

And then test it by sending an empty packet to confirm the controller
will generate HCI_EV_NUM_COMP_PKTS events:

sco-tester[40]: < SCO Data TX:.. flags 0x00 dlen 9
> HCI Event: Number of Completed P.. (0x13) plen 5
        Num handles: 1
        Handle: 42 Address: 00:AA:01:01:00:00 (Intel Corporation)
        Count: 1
        #103: len 10 (40 Kb/s)
        Latency: 2 msec (2-2 msec ~2 msec)

Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  6 +++
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_core.c         | 80 ++++++++++++++++----------------
 net/bluetooth/hci_event.c        | 27 ++++++++++-
 net/bluetooth/hci_sync.c         | 41 ++++++++++++++++
 6 files changed, 117 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b99818df8ee7..70169533c940 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -448,6 +448,7 @@ enum {
 	HCI_WIDEBAND_SPEECH_ENABLED,
 	HCI_EVENT_FILTER_CONFIGURED,
 	HCI_PA_SYNC,
+	HCI_SCO_FLOWCTL,
 
 	HCI_DUT_MODE,
 	HCI_VENDOR_DIAG,
@@ -1544,6 +1545,11 @@ struct hci_rp_read_tx_power {
 	__s8     tx_power;
 } __packed;
 
+#define HCI_OP_WRITE_SYNC_FLOWCTL	0x0c2f
+struct hci_cp_write_sync_flowctl {
+	__u8     enable;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_TYPE	0x0c46
 struct hci_rp_read_page_scan_type {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f320eeddfec..cf18cf65fe5e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
 #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
 #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
+#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
 #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ)
 #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
 #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BREDR))
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 7e2cf0cca939..2581f3e1f756 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -185,3 +185,5 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			    struct hci_conn_params *params);
+
+int hci_sco_flowctl_test_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..b3f0dacbf038 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3548,51 +3548,52 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 }
 
 /* Schedule SCO */
-static void hci_sched_sco(struct hci_dev *hdev)
+static void hci_sched_sco_type(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
 	int quote;
+	unsigned int pkts;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "type %u", type);
 
-	if (!hci_conn_num(hdev, SCO_LINK))
+	if (!hci_conn_num(hdev, type))
 		return;
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
+	/* Use sco_pkts if flow control has not been enabled yet which will
+	 * limit the amount of buffer sent in a row.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		pkts = hdev->sco_pkts;
+	else
+		pkts = hdev->sco_cnt;
+
+	if (!pkts)
+		return;
+
+	while (pkts && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+			pkts--;
+
+			if (hdev->sco_cnt > 0)
+				hdev->sco_cnt--;
+
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
 		}
 	}
-}
 
-static void hci_sched_esco(struct hci_dev *hdev)
-{
-	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote;
-
-	BT_DBG("%s", hdev->name);
-
-	if (!hci_conn_num(hdev, ESCO_LINK))
-		return;
-
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK,
-						     &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
-
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
-		}
-	}
+	/* Rescheduled if all packets were sent and flow control is not enabled
+	 * as there could be more packets queued that could not be sent and
+	 * since no HCI_EV_NUM_COMP_PKTS event will be generated the reschedule
+	 * needs to be forced.
+	 */
+	if (!pkts && !hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
@@ -3628,8 +3629,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco_type(hdev, SCO_LINK);
+			hci_sched_sco_type(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3684,8 +3685,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco_type(hdev, SCO_LINK);
+			hci_sched_sco_type(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3730,8 +3731,8 @@ static void hci_tx_work(struct work_struct *work)
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
-		hci_sched_sco(hdev);
-		hci_sched_esco(hdev);
+		hci_sched_sco_type(hdev, SCO_LINK);
+		hci_sched_sco_type(hdev, ESCO_LINK);
 		hci_sched_iso(hdev);
 		hci_sched_acl(hdev);
 		hci_sched_le(hdev);
@@ -4052,10 +4053,13 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	err = hci_send_frame(hdev, skb);
-	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, -err);
-		return;
+	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
+		err = hci_send_frame(hdev, skb);
+		if (err < 0) {
+			hci_cmd_sync_cancel_sync(hdev, -err);
+			return;
+		}
+		atomic_dec(&hdev->cmd_cnt);
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4063,8 +4067,6 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
-
-	atomic_dec(&hdev->cmd_cnt);
 }
 
 static void hci_cmd_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 19e19c9f5e68..615fe4748bce 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4448,6 +4448,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 			hdev->sco_cnt += count;
 			if (hdev->sco_cnt > hdev->sco_pkts)
 				hdev->sco_cnt = hdev->sco_pkts;
+
 			break;
 
 		case ISO_LINK:
@@ -4916,6 +4917,23 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_sco_flowctl_test(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn = data;
+	int err;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	err = hci_sco_flowctl_test_sync(hdev, conn);
+	if (err)
+		hci_dev_clear_flag(hdev, HCI_SCO_FLOWCTL);
+
+	hci_connect_cfm(conn, 0x00);
+
+	return err;
+}
+
 static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
@@ -5021,7 +5039,14 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		}
 	}
 
-	hci_connect_cfm(conn, status);
+	/* If SCO flow control is enable attempt to generate
+	 * HCI_EV_NUM_COMP_PKTS by sending an empty packet.
+	 */
+	if (!status && hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		hci_cmd_sync_queue(hdev, hci_sco_flowctl_test, conn, NULL);
+	else
+		hci_connect_cfm(conn, status);
+
 	if (status)
 		hci_conn_del(conn);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c4c2cf51b219..97be83dcc32d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3769,6 +3769,27 @@ static int hci_write_ca_timeout_sync(struct hci_dev *hdev)
 				     sizeof(param), &param, HCI_CMD_TIMEOUT);
 }
 
+/* Enable SCO flow control if supported */
+static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_sync_flowctl cp;
+	int err;
+
+	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL */
+	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 0x01;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (!err)
+		hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
+
+	return err;
+}
+
 /* BR Controller init stage 2 command sequence */
 static const struct hci_init_stage br_init2[] = {
 	/* HCI_OP_READ_BUFFER_SIZE */
@@ -3787,6 +3808,8 @@ static const struct hci_init_stage br_init2[] = {
 	HCI_INIT(hci_clear_event_filter_sync),
 	/* HCI_OP_WRITE_CA_TIMEOUT */
 	HCI_INIT(hci_write_ca_timeout_sync),
+	/* HCI_OP_WRITE_SYNC_FLOWCTL */
+	HCI_INIT(hci_write_sync_flowctl_sync),
 	{}
 };
 
@@ -6871,3 +6894,21 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
+
+int hci_sco_flowctl_test_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct sk_buff *skb;
+
+	/* Allocate an empty skb to trigger testing of flow control */
+	skb = bt_skb_alloc(0, GFP_KERNEL);
+	if (IS_ERR(skb))
+		return -PTR_ERR(skb);
+
+	/* Send the packet to trigger testing of flow control */
+	hci_send_sco(conn, skb);
+
+	/* Wait for HCI_EV_NUM_COMP_PKTS */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					HCI_EV_NUM_COMP_PKTS,
+					conn->disc_timeout, NULL);
+}
-- 
2.48.1

