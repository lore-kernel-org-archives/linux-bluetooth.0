Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F1183CD9
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792470; cv=none; b=qHBDETOJATaz71SLH7HXDw9v7pELXxM/cWDl0tOfqTbzwjDzJlFmRYn8xnyXALdEFKDVbtN8S92Za/lbacEZsTaDbVSvdMUy5RsD051pG/PCSa6/JEfk1v85QU75L+ZURuh17aKjuTrf7b2u+nONsqxd6UMVeHxCmE8+fQnGQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792470; c=relaxed/simple;
	bh=/qScAJh+8NvOOmDqNqkHBsmOoWf9kofmfQ77dIRgxtw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZbKPyf8KvGiOto9RIHOkzoZaDaKU+yXmjznlBLsd52EhJWXPlMZ6bWqQtjQ1qu+UehbUxasg0GMBnsjxV/TKGc0viXaAbi18ohrKZIRii6WiHsYaLIUyuW43mVWEoDVsRv4PIcWy02yMJRHu8z9+SGvbJp2tF/hC0Ptk6VoRW+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBF3U5Us; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBF3U5Us"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso2818912e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741792466; x=1742397266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=av/exWHxCfBXyazN+yHRc8avIxJnHdkGX4tGbtFvGRk=;
        b=bBF3U5UsZFFKIqCNr6GM4ETdEomnqHWbVy7gOIHFh3Nsv/b5LkhuSBOUmIlweW3jHD
         7UhCx3Fy8UtooAS1qoNj4NFQ6BNQk5My4HLX6LHgjWMXJAw75q5Pwe+4m98OyYhlpo2P
         df1Juod+Z4FbTWmpuZTy7x3Exd4itMkOLrgMVpB6LjMTQx5X15vprovQfApZpgsbXgep
         VEGHNAif+5EMd0flSVlMC1NmWFPFsuwzHHxft5CfO9m0pgHc2UfiISXF9mqAcBU2cOVl
         yRLmQV3u41n6VMtZGYurFysiwV6ihh4P4JqWDm9RlPgeDVm/eAVRVkgrhQOO3FLzi+89
         PeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792466; x=1742397266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=av/exWHxCfBXyazN+yHRc8avIxJnHdkGX4tGbtFvGRk=;
        b=RVP1i7+9S6Bpc1O9kE5BwgzHxalxm/48b2xBVhgtsb2lLgJyKnsWC6gCJfBSESQcnd
         /n1MJ8S0nWNo3+mIVHjBRLlixqqko2kEesaSr0no6UyDmWlGUOupzcpytIUEQZNMx8Tq
         Mea9NJfHiQPABKKqNzlN298GT5TUCNek4+07CwgESLyOTybdCVoPG/Nii4yn5CFPol5n
         U5RaWjqoDkomyd2LKpFmVnozW3cirNf8wKTfdyoG/eNPQpFCWE5GKvfI4tvpRtnlekvf
         qMsma0zkBti4HWxd3on285VT95qXletXa81mlPv7nVvTyPSi/WWMptOI4TYTrnrPMQU6
         Q1TA==
X-Gm-Message-State: AOJu0YyztxNKfbY1VVLIp3cmAyeNojyb+jZ4BVw3HHJYY+4dSvrTXrfK
	Aj5+TYB7WF7ca44UR+1H4KTAZlmkulysHt6rjGEELwZREsBmrxPzHvrv/CPt
X-Gm-Gg: ASbGncv2Oo/fw3Uoe+IHtJ+yA+BU7cwEIq8kI1SkGj33bd2njX0amm+V93ccRI6OXmU
	LoX+AOC76aZST72t38ZZuug2js1300F/kuvoaF8RgivMKmYW9kvoP4mfv6wADPS9hzT+gwEtUME
	l/UM+ou7H4fW6J4HYVVFwgMmCmg6O4OOime/HHwQLxrqKQTqNFb6hN7UI4xcW/jzEFkNLbHFTz8
	8hgfmhu+5TevJpaybyPy5xunzenPeLSYjOeFuxWIFdtq8kWajPi26gvYAHSKTfzCBhqcC+MFPTc
	VoQS+kVl4WbgUuC1/IlCMIPPPN/mAhcB4ubigLDhW8i1S2Al6/uBdSEJEF7G0NHzUBOOybXF4B6
	sDoNqJbl2Oyp7hlS+HijbMYoi
X-Google-Smtp-Source: AGHT+IFOYL2mYWQQkJ2bAWim3UVb6nESOz4TjZ4PtyljSdxLUiS0rD6MPKKxe5d+t5tgaMofofbIOw==
X-Received: by 2002:a05:6122:310c:b0:523:8230:70db with SMTP id 71dfb90a1353d-523e41a68e3mr12664371e0c.10.1741792466006;
        Wed, 12 Mar 2025 08:14:26 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8c8339asm2152287e0c.34.2025.03.12.08.14.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:14:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Wed, 12 Mar 2025 11:14:20 -0400
Message-ID: <20250312151421.201772-1-luiz.dentz@gmail.com>
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

To fix the code will now attempt to enable buffer flow control when
HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED is set by the driver:

< HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
        Flow control: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
        Status: Success (0x00)

On success then HCI_SCO_FLOWCTL would be set which indicates sco_cnt
shall be used for flow contro.

Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      | 13 +++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 62 +++++++++++++++-----------------
 net/bluetooth/hci_event.c        |  2 ++
 net/bluetooth/hci_sync.c         | 24 +++++++++++++
 5 files changed, 68 insertions(+), 34 deletions(-)

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
index 012fc107901a..94d9147612da 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3552,18 +3552,27 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 }
 
 /* Schedule SCO */
-static void hci_sched_sco(struct hci_dev *hdev)
+static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
-	int quote;
+	int quote, *cnt;
+	unsigned int pkts = hdev->sco_pkts;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "type %u", type);
 
-	if (!hci_conn_num(hdev, SCO_LINK))
+	if (!hci_conn_num(hdev, type) || !pkts)
 		return;
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
+	/* Use sco_pkts if flow control has not been enabled which will limit
+	 * the amount of buffer sent in a row.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		cnt = &pkts;
+	else
+		cnt = &hdev->sco_cnt;
+
+	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
@@ -3571,32 +3580,17 @@ static void hci_sched_sco(struct hci_dev *hdev)
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
+			(*cnt)--;
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
@@ -3632,8 +3626,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco(hdev, SCO_LINK);
+			hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3688,8 +3682,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev);
-			hci_sched_esco(hdev);
+			hci_sched_sco(hdev, SCO_LINK);
+			hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3734,8 +3728,8 @@ static void hci_tx_work(struct work_struct *work)
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
-		hci_sched_sco(hdev);
-		hci_sched_esco(hdev);
+		hci_sched_sco(hdev, SCO_LINK);
+		hci_sched_sco(hdev, ESCO_LINK);
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

