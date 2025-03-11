Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7D23774
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722936; cv=none; b=RD8TTMEirLpoT5OdNrELS1e0dtNrL77atE4Rxm4aW519OfoT1Wd9bvURU5myi+bUDwsEYlwuu3WBA1NXwibNRakaf8yAFJiPmATwvdcqvTvXwFh6/kFM9l1fVwGAYMGo8sDDLsgaCIkDC0C7Cw+2N3FOd6AohPWcdfG2nMM8eXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722936; c=relaxed/simple;
	bh=eddC/7gdPVhzvuCbS1Hz7917aTsYo0O5U0mX40PGM80=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HqUa23qoL1wW/t/d8GK4wKVOOZetg4K6cGsSDRjn41B7h/LHm6w0R4vkZt9FvdWxND/9kq73SOLXaa6cpyEbX4uC5J+OefqYC/rJMDLXbROECtoAdixw57+ewkV1fIZWkXA7VoeuNTzKu029b2/0XPclzGbK2M+h+8xJ00Ql8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T19gpz62; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T19gpz62"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso2437211e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741722933; x=1742327733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jjPQ0eeIXkTLkAi0w/GEQzZy3DwrttUGWq9NmoeAGQ=;
        b=T19gpz624M2ewgWhVc5zu4/VMlnjnRybh8MeD1g1uT3/i2XoolRSKwK4NOpF58RalI
         NjYNupxRhaaXkrPp+EKg70TeEtB18TRlGEewGqNlN9NMwOB0CzNvFpCwF5x092fUnzNe
         eZSDTANtpYhQgDuK3OKo91yS8yn/jronxGgZqbJtpHE0CJ2z1eISO+D9X6jvx2SO+BrU
         I65p/YqETnkxv8cPHGuLcncvp9vEB9REv5rRYQyyjf8n9xPXKlC91Mt3ji0ghePMLjB+
         xbaHG/vcj0ILJBAi0qQwUQoOTUNa5NV+LFKQkujEZ2yrTMZdNH8HuW5h462BSsqtxgO3
         yo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722933; x=1742327733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jjPQ0eeIXkTLkAi0w/GEQzZy3DwrttUGWq9NmoeAGQ=;
        b=cUHdzvE7To5Ab9DSGsq49CVYNxiAGzF8p44YBP2kYZ2A5KVb7pKx9wohRMdf00H50V
         JnXCzy8HdOlD1XAVxEPvZl0k9Ik6Q4J91NJSK71pUscWkDr46uZuQHh5zsHGO2YiHwum
         jYAudgbTz7lS30GpMDSAjobFt3esccFZN14mm9pndwYXtJZ9Y11EuhNWYi9fp5Hvh1P5
         xKyi/cF9G7gxDXqFNxYh+vPlwqRxsR8m/J19BDKQcOScLveOyF6SNkpun/ZMUNQwryb4
         xLXGh1VyQ2iJSUZ8ujazMoBqRyGv7FVyuUQ5QNwS28BfoIiCehvepyXQNVJZiE0TegbT
         N0QQ==
X-Gm-Message-State: AOJu0YwXA/XR/Uk7GQQdDkzXIj5v/vmFlmhIABmZG25N0NW6JFHQPxks
	wwliVWQ+NYiNyktuE3WW/1MfFC2+rNCyaI05hbV0p3j6Iy+dxHqd1GSsEPdh
X-Gm-Gg: ASbGnctbgDyH3vGkJ2g5B7G/pmaIsaKmxqFho8MeHPe4MCd0/jL4qTFHEQa4uw9wjpK
	ArVVbJ8ii9y7sx1sw4pzTtdbbobqzYZWQrPEYeXIJ2kmyuXNdlodrYrCrjRA1J3AWHWCckMzrs6
	1khqF7RtoEfMNg5/m+taVp96u1DRlGUjhrXoGgNbSSs4L7+SaYp/ZYZhS39dNhV6DZx/uegk9dM
	Hkpst0FlD8xy6UWwxLnSKwohZ34B1S2/JjywmwS0anaLqK0f1Vn0fyOVfrw+dinorJ9AKSettSo
	4Op+fbSsW9VXoopqRuQu5Sggpfr0CHc7Yy8JTuIyybboojIv0EZu4DMwUQx5AgDliGA9dA40hoL
	5Eu6b4qZ5KGqBcA==
X-Google-Smtp-Source: AGHT+IFMUnlvh+un18N9DUOlEZY41pkrF0KH0gINE4LlBQw3y9b94e8ODCRd5DysQ7ne9sQSlRiyoQ==
X-Received: by 2002:a05:6122:1d9f:b0:516:230b:eec with SMTP id 71dfb90a1353d-523e4076cf3mr12725834e0c.5.1741722932856;
        Tue, 11 Mar 2025 12:55:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8cbad9csm1896086e0c.43.2025.03.11.12.55.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:55:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Tue, 11 Mar 2025 15:55:27 -0400
Message-ID: <20250311195528.41993-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci.h      | 13 +++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 67 ++++++++++++++++----------------
 net/bluetooth/hci_event.c        |  2 +
 net/bluetooth/hci_sync.c         | 24 ++++++++++++
 5 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b99818df8ee7..3c8f95174fcf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -208,6 +208,13 @@ enum {
 	 */
 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 
+	/* When this quirk is set consider Sync Flow Control as supported by
+	 * the driver.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED,
+
 	/* When this quirk is set, the LE states reported through the
 	 * HCI_LE_READ_SUPPORTED_STATES are invalid/broken.
 	 *
@@ -448,6 +455,7 @@ enum {
 	HCI_WIDEBAND_SPEECH_ENABLED,
 	HCI_EVENT_FILTER_CONFIGURED,
 	HCI_PA_SYNC,
+	HCI_SCO_FLOWCTL,
 
 	HCI_DUT_MODE,
 	HCI_VENDOR_DIAG,
@@ -1544,6 +1552,11 @@ struct hci_rp_read_tx_power {
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
index 7966db4038cc..f78e4298e39a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1858,6 +1858,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
 #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
 #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
+#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
 #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ)
 #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
 #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BREDR))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 012fc107901a..efba2b539902 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3552,51 +3552,52 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
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
@@ -3632,8 +3633,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco_type(hdev, SCO_LINK);
+			hci_sched_sco_type(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3688,8 +3689,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco_type(hdev, SCO_LINK);
+			hci_sched_sco_type(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3734,8 +3735,8 @@ static void hci_tx_work(struct work_struct *work)
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
-		hci_sched_sco(hdev);
-		hci_sched_esco(hdev);
+		hci_sched_sco_type(hdev, SCO_LINK);
+		hci_sched_sco_type(hdev, ESCO_LINK);
 		hci_sched_iso(hdev);
 		hci_sched_acl(hdev);
 		hci_sched_le(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 19e19c9f5e68..6d0138b778aa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4445,9 +4445,11 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 			break;
 
 		case SCO_LINK:
+		case ESCO_LINK:
 			hdev->sco_cnt += count;
 			if (hdev->sco_cnt > hdev->sco_pkts)
 				hdev->sco_cnt = hdev->sco_pkts;
+
 			break;
 
 		case ISO_LINK:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c4c2cf51b219..609b035e5c90 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3769,6 +3769,28 @@ static int hci_write_ca_timeout_sync(struct hci_dev *hdev)
 				     sizeof(param), &param, HCI_CMD_TIMEOUT);
 }
 
+/* Enable SCO flow control if supported */
+static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_sync_flowctl cp;
+	int err;
+
+	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL */
+	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)) ||
+	    !test_bit(HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED, &hdev->quirks))
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
@@ -3787,6 +3809,8 @@ static const struct hci_init_stage br_init2[] = {
 	HCI_INIT(hci_clear_event_filter_sync),
 	/* HCI_OP_WRITE_CA_TIMEOUT */
 	HCI_INIT(hci_write_ca_timeout_sync),
+	/* HCI_OP_WRITE_SYNC_FLOWCTL */
+	HCI_INIT(hci_write_sync_flowctl_sync),
 	{}
 };
 
-- 
2.48.1

