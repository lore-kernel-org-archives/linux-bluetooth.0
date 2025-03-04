Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA89280418
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111826; cv=none; b=eCi351/2pzuoKGmSBgMVGkHitch2DfkEoH5ZfD+MScsng+g8a2l5u2L7vCvzAcz4LQDStXHZ4BZxSUznYWIqBFg6dtput8BfjVQNjyBFoWOD29xcHz4Dwat810N2oHkhD1AnIACRdyTN/crDWzuWjOtWD261bZyvvXn4bre1itc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111826; c=relaxed/simple;
	bh=PBGgU206YYHROiD3tn2ffkFwJKHwf8GSFXR11ZjvvJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UjuYa4yZ57Dfug891HDkeVRVqHzRh2lInNC4U9/+1fmV4oWN/u2K4i1toVjLyOX+tD1bcxJCqAU2o9KzCpZhzxDgewXDrhjFvqFMj1Mjx9yrNEY/rPcwS1kB/q7fL7N+/JRX8qR2aoYLns+5YGT70weMMFyptUKRn+mBDa4Xe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZEATepy; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZEATepy"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52361a772e7so36707e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741111822; x=1741716622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZVUJPZ/0j+m0pWA8a96v2+buGOmTtRUiwM8sSku46w=;
        b=eZEATepyeGRIVVcokgutKw6pou19WXFbZLKQpI1TeNU9exICBj/ls6UVbxz5epJnwS
         jeIT/bVgDEVSEdVbJbntbycr+pyTJ2xEiD3ZfzXCoX0r/l/nztx4oi4CaE/y8Nxs+z3c
         6zRlaSxT+3oLQ2ltDeluRn1kD8lvnq4M6ug5i7RsyB/noU4f9yhtd7CJoyxYWsAYCWDG
         PQ813Epwy8dCP7O0TQ2DNdpn1uISSM5saP+ltx7ph/n7mBjPywvMApZhu278HxmDgs1W
         7Xdry2L+StWR33UR+kwmJ1htMuiBrU3cq4QJh3Uq8zjC+pY8skMBwUwNb7kgTbPndKc4
         64GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111822; x=1741716622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZVUJPZ/0j+m0pWA8a96v2+buGOmTtRUiwM8sSku46w=;
        b=L8Ow+7BXYFVdhHQNPVQe8S8zphyLPRt9mDM7Gqm7/2dHl4YlPHDLaqohHrktEF+H9T
         8c3rkHDGbE2esg4e6/VrXlbKRldtybm4UpgnLjRmsf/OKlX++vJjz+3GnlK0+Am5tBSS
         IgE8w0Jpnsr07sXi26jcJv1h2i8emrbWEodhIqIP+OSPjSB3/ALjL6YWsTmuXm9M0kli
         xrjtmWgHr51PVMIMmlFc1c+eL45NCCSWXngfY0SXkYFiMCp5I+HyZgtLg0aQ2BkiGc08
         lbTbZ3djhG8aeyrtD01N4b8qFWg718Aqy2/s7bIDbxYySlCexfSLFWETk8WpisQhZeR2
         ap1g==
X-Gm-Message-State: AOJu0YysAs5Fu36zSoiLqz0WNl4OlMDjYEKhlqLDlesz9vIiji+ly55x
	I+tiBxCzUXAC65D5iZ0Z2uBy9GleOYPfhZwBeaUwEz8VdVSl2VPOFRwLjQ==
X-Gm-Gg: ASbGnct5HjsnjdvS6CYVtXnM4RLGYnpmuYNClRTpNyaqYNhYoIHFSaECoZmLBzNgt4a
	gKGosCKg4Wt8QvTsVA+AYiak+X8jmYalLk+Km3fhJ623ssYC7pUr2sv+nJxF76hy0rP081V61fo
	Qsci0rqJPqfXmndNqzvCSs7kyqkHhkKtMD+DxfXzUenMNK6pauBeedFWvdZlWGtDC866e93D5Fy
	wPO/h9aWpnM2pW/x2hMKq0h4RSh7KfkJ2iSa0KkRd0ezFHh4wfiCDPRqu/Yjny0d3DpeV6clOns
	H7rq+YrsaCAR3RDVS08ULT4jI2Pgx2ajJVCpK2Sou/Y9zKFDE7Tf9g10IZsMuOzdjvyvRw7c+gE
	WzwjyHEgCrIpDdg==
X-Google-Smtp-Source: AGHT+IGAR+Xhh/+foiWixitUjWMS8pRCv5AJRBNP4ru/liRK6oqfk71SemyjJ5Po2P668z8qmon/jQ==
X-Received: by 2002:a05:6122:308a:b0:520:56ee:78e2 with SMTP id 71dfb90a1353d-523c597ea82mr81226e0c.5.1741111822247;
        Tue, 04 Mar 2025 10:10:22 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5237e9c140dsm1201583e0c.3.2025.03.04.10.10.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:10:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Tue,  4 Mar 2025 13:10:19 -0500
Message-ID: <20250304181019.214207-1-luiz.dentz@gmail.com>
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

Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  6 ++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 54 +++++++++++++-------------------
 net/bluetooth/hci_event.c        |  5 +++
 net/bluetooth/hci_sync.c         | 18 +++++++++++
 5 files changed, 52 insertions(+), 32 deletions(-)

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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..9ea9b4091f8f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3548,45 +3548,35 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
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
+	while (pkts && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
-		}
-	}
-}
+			pkts--;
 
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
+			if (hdev->sco_cnt > 0)
+				hdev->sco_cnt--;
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3628,8 +3618,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco_type(hdev, SCO_LINK);
+			hci_sched_sco_type(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3684,8 +3674,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco_type(hdev, SCO_LINK);
+			hci_sched_sco_type(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3730,8 +3720,8 @@ static void hci_tx_work(struct work_struct *work)
 
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
index 19e19c9f5e68..e6eadcc13484 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4448,6 +4448,11 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 			hdev->sco_cnt += count;
 			if (hdev->sco_cnt > hdev->sco_pkts)
 				hdev->sco_cnt = hdev->sco_pkts;
+
+			/* Enable HCI_SCO_FLOWCTL so sco_cnt is used instead of
+			 * sco_pkts.
+			 */
+			hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
 			break;
 
 		case ISO_LINK:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c4c2cf51b219..91cfb7c2cb08 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3769,6 +3769,22 @@ static int hci_write_ca_timeout_sync(struct hci_dev *hdev)
 				     sizeof(param), &param, HCI_CMD_TIMEOUT);
 }
 
+/* Enable SCO flow control if supported */
+static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_sync_flowctl cp;
+
+	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL */
+	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 0x01;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
 /* BR Controller init stage 2 command sequence */
 static const struct hci_init_stage br_init2[] = {
 	/* HCI_OP_READ_BUFFER_SIZE */
@@ -3787,6 +3803,8 @@ static const struct hci_init_stage br_init2[] = {
 	HCI_INIT(hci_clear_event_filter_sync),
 	/* HCI_OP_WRITE_CA_TIMEOUT */
 	HCI_INIT(hci_write_ca_timeout_sync),
+	/* HCI_OP_WRITE_SYNC_FLOWCTL */
+	HCI_INIT(hci_write_sync_flowctl_sync),
 	{}
 };
 
-- 
2.48.1

