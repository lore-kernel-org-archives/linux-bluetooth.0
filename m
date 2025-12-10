Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085230171F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765399826; cv=none; b=IZZokmXhDXR5zh6xZUZnL040KOu1r1ryNag1CF//d9yJNj7IBkx4UAKtAHqOMPxkPux12cUIKYML6XIjJ1X8aDSyIZ4uEEPTe6v4sNxvXnCDu3KFp+ZzW92eMhGyt64PMG6tNhZoHZC4ALZVKJyYTqH5sPC77kcRoN/I1a0N3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765399826; c=relaxed/simple;
	bh=WME22asTu9tFYRrVV4YDTXE4i2e24Nq5p1koStFgFDg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WLYXJlZo7gJv4NIrb8jCIQCxRjXd+I+epnR+3D6jiMBxQ4tUmFuJRNX52UoU0YQkdxdVUeqGAbEjkmOvpnKAEPBEjv3Wfc1WZ9BsE2Fp/XLcJIkeVN26XlfSfHBkEdO8n6l8cm/WWgwY3Sv0gsjWVK3s/BGcb9yBVzlne5Kjw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAmmXww8; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAmmXww8"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dbcd54d2d8so142095137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 12:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765399823; x=1766004623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1QJQ0TReXS4dfG0voCWbny663/EvZnHkfRxrmcqjh4A=;
        b=BAmmXww8aEfgje84KxyFNAiz+BczBVTN8QWfLx9h52o8JDvvjDGJWhJcDM+p+vYtPo
         Zo076vbOiPp0a0mo0gVj6UbwQw7dfeCaJJjq9ia4uoPCLWoVpO5OpgDlKoBbQ8YdUdLm
         SNkdT7sqo8tA3+2o7Cejp7D/faqaP9fPRkyzl4FyEsmLKvfA8pq8oCSzKrp47ANRcNvt
         EwKpTPgB91/ulENkFTKNEmOKeWhUX2uD228S56r5dxQ3HKBiwntxz7JaVSQVCA7WAVMN
         sIwbAPOzil7QXrnwT1Ul6/ScwHFjhPirmvV85baeIL0hvqn9G++Fx3kNCEcPsbugcClf
         +Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765399823; x=1766004623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QJQ0TReXS4dfG0voCWbny663/EvZnHkfRxrmcqjh4A=;
        b=c4DPBzuqsBYzeBMvV5tcxt2MeWYwNoOWRVNAMxOiJWg+L1TKjoPwSFw2cNumVesfJq
         gw18/QIJC6wn3ZdbxAEn5mzPD27iOQMbsqI8umJCl6ecPgSbyBhPzaoy+MrDtZMPiaV2
         0nn1gjL0SoCluzrls6eOsL0EH8yRI78ITikQ/JnK70ijFnNXmC5ZzxkVd1N5U2rJupNJ
         FeoGDTOmD0Bp0zX5SdaXZI5r9kksuq0XH/LtJE6UByvPhgEVIP9MTG87NpnBFqFKGTi9
         UPzitpLs5q6fxyBYPmNAa+/eceWQ/aZK1yWwMQufXLH+ISVzKYvniAs6OSVouyMmKUZC
         zFXw==
X-Gm-Message-State: AOJu0YyTMMr0ETAo61ePehV1rMD4Wz/jaGcAQWqAFxM7xCcobT2EzKM3
	pxH7gxSKAHfZkiOe9JNust2q4SBNPMqCOk1JhCLfMKnD3BCzz7RfcTI8fJYMd4bT
X-Gm-Gg: AY/fxX5J3pu2Qu9PlzwvmLS7NT32oUzXuo6ZzD9jM0XkLn9bHCYCYoQnC7FjqOCdJRU
	NwPHonFIiOO0JD7oB4kewaAoBFCtxEqmsHh4ipgvK/MU+UwdiXZ5w2eFDkIfWfgMmRCo6SCWvYh
	dI0a9XT8nPpxnue/vqyewNF81oko4qkTZZ4iLTdINbV4OWeHyiebISMAbnMM1fMGvHtPn3jPbZB
	TSCSdSbPNSpAgQ44b37mZkS+Gi5rxptSGyiXmbRQvQgQFAxg+s0RV99uhtabjAglyoDvmogvyYM
	wNP6qyuGGXc7blFoJLa9xARxA5e+3ZlPPhYM49w9QjHXVKdB7NKhOAv8nLaBkQgMxkBe/PvlX/+
	CK4DljXVQu7QQkkG4c7oTXhjCSn95h6H5S25X2bQwY8cJO6DPwDa2gdIG3vJ5oejIRMjhjeQ6Mu
	g2FuLgs/vsxwLrcw==
X-Google-Smtp-Source: AGHT+IHjYKM4H4CbIB9oJBwWbl1CXntHKXmtnmsTc3Jfl2E6WUNYsL8ROhiCKzNBWOMCCsQyLvhHkw==
X-Received: by 2002:a05:6102:374b:b0:530:f657:c40 with SMTP id ada2fe7eead31-5e571dd17e9mr1469261137.22.1765399822855;
        Wed, 10 Dec 2025 12:50:22 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55fdc73a1absm46121e0c.18.2025.12.10.12.50.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:50:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs
Date: Wed, 10 Dec 2025 15:50:12 -0500
Message-ID: <20251210205012.153919-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

conn->le_{tx,rx}_phy is not actually a bitfield as it set by
HCI_EV_LE_PHY_UPDATE_COMPLETE it is actually correspond to the current
PHY in use not what is supported by the controller, so this introduces
different fields (conn->le_{tx,rx}_def_phys) to track what PHYs are
supported by the connection.

Fixes: eab2404ba798 ("Bluetooth: Add BT_PHY socket option")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 17 +++++++++++------
 net/bluetooth/hci_event.c        | 26 +++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4263e71a23ef..8aadf4cdead2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -730,6 +730,8 @@ struct hci_conn {
 	__u16		le_per_adv_data_offset;
 	__u8		le_adv_phy;
 	__u8		le_adv_sec_phy;
+	__u8		le_tx_def_phys;
+	__u8		le_rx_def_phys;
 	__u8		le_tx_phy;
 	__u8		le_rx_phy;
 	__s8		rssi;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c3f7828bf9d5..5a4374ccf8e8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1008,6 +1008,11 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 		conn->mtu = hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
+		/* Use the controller supported PHYS as default until the
+		 * remote features are resolved.
+		 */
+		conn->le_tx_def_phys = hdev->le_tx_def_phys;
+		conn->le_rx_def_phys = hdev->le_tx_def_phys;
 		break;
 	case CIS_LINK:
 		/* conn->src should reflect the local identity address */
@@ -2928,22 +2933,22 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 		break;
 
 	case LE_LINK:
-		if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
+		if (conn->le_tx_def_phys & HCI_LE_SET_PHY_1M)
 			phys |= BT_PHY_LE_1M_TX;
 
-		if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
+		if (conn->le_rx_def_phys & HCI_LE_SET_PHY_1M)
 			phys |= BT_PHY_LE_1M_RX;
 
-		if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
+		if (conn->le_tx_def_phys & HCI_LE_SET_PHY_2M)
 			phys |= BT_PHY_LE_2M_TX;
 
-		if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
+		if (conn->le_rx_def_phys & HCI_LE_SET_PHY_2M)
 			phys |= BT_PHY_LE_2M_RX;
 
-		if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
+		if (conn->le_tx_def_phys & HCI_LE_SET_PHY_CODED)
 			phys |= BT_PHY_LE_CODED_TX;
 
-		if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
+		if (conn->le_rx_def_phys & HCI_LE_SET_PHY_CODED)
 			phys |= BT_PHY_LE_CODED_RX;
 
 		break;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a9868f17ef40..bc3a90600d73 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6607,8 +6607,18 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
-		if (!ev->status)
-			memcpy(conn->features[0], ev->features, 8);
+		if (!ev->status) {
+			memcpy(conn->le_features, ev->features, 8);
+
+			/* Update supported PHYs */
+			if (conn->le_tx_def_phys & HCI_LE_SET_PHY_2M &&
+			    !(conn->le_features[1] & HCI_LE_PHY_2M))
+				conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_2M;
+
+			if (conn->le_tx_def_phys & HCI_LE_SET_PHY_CODED &&
+			    !(conn->le_features[1] & HCI_LE_PHY_CODED))
+				conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_CODED;
+		}
 
 		if (conn->state == BT_CONFIG) {
 			__u8 status;
@@ -7221,9 +7231,19 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 	if (!conn)
 		goto unlock;
 
-	if (!ev->status)
+	if (!ev->status) {
 		memcpy(conn->le_features, ev->features, 248);
 
+		/* Update supported PHYs */
+		if (conn->le_tx_def_phys & HCI_LE_SET_PHY_2M &&
+		    !(conn->le_features[1] & HCI_LE_PHY_2M))
+			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_2M;
+
+		if (conn->le_tx_def_phys & HCI_LE_SET_PHY_CODED &&
+		    !(conn->le_features[1] & HCI_LE_PHY_CODED))
+			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_CODED;
+	}
+
 	if (conn->state == BT_CONFIG) {
 		__u8 status;
 
-- 
2.52.0

