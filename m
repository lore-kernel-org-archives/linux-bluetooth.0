Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F977F7EC
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982147; cv=none; b=WM/9A7lYaldT108tLPe/KGFJeF8sf1NuFKCOUmc955SnMxEfNxgSDCt1qqAIya3Jaz/OotnAViJ1UyLB1q8E6hcvvfxIAZiQ+ios3E+BrHn3rr2guDEyBMKHxKYDsC0I4oStbkQy/XIcawLBN7azw3DhuuSOOKDgk8taPhFPX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982147; c=relaxed/simple;
	bh=VMRJNFCS3u4eW87yVH5Lqzq3rw86gPXt3lwClP4Z6DQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT/6PCIqY4hGX633DyJD8Ia18klzxogxfpZyv/P0hT/Ai41E/IeInjldH+PJDXhoj9EtGprrLs6lQzKSZ9KNofIZNdT2euBFpQEmKepe0SCkvNVjZZMrTurXHu3VEOlIaDterNWzOxHr8Rx2cPy0/8+ILfd8rEQWWudm+XfC5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0NIej/W; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0NIej/W"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7da6e831972so698776241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 13:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708982143; x=1709586943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5G8xGVqqVVGSXR6nJfjbvCWsfLHUcCjRGS99mP2Slw=;
        b=O0NIej/W5XpZTIhKsIrRUbl9+X1FQR2qsUimLqIdew3IHip0GtdJauxs7mU3Sg/+tY
         t+vjwsPWoe2DXyydnNAG2mbYis5GNJJuSOy2fpDhuD9UnbYiP+neEeu7qP2DDf5qxcuo
         PsmDfzFDSKOtdo/F6Tierwp6ZbsP+JDDVsZWlMCYhWCbErd98gOMops0r7KjZRplvwG7
         q7brJiOPMBAhvavnnd/+GMhTolXN4SmyS8VH27z/cKilU1C5dYpwhIVsee5LvYNah8ZY
         TzHBF33cTShtglabrAqAwQuQ6pHv7we+KzDxnovtUdCAiKGI8UrM7M4FrNcZWaumI9zX
         rHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982143; x=1709586943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5G8xGVqqVVGSXR6nJfjbvCWsfLHUcCjRGS99mP2Slw=;
        b=op/cY/h2KhdKbV40jBQ62z0VnaGeMVhaFXB9JUwXu/0ljPnhEHMUS05uPAgWitSj0J
         AzZ5yusKjxchY9b0DsL9c1BHgxjjgeOlMdmSu4e1F9FXeuTDCluZ7bt0buy/fX/qQehF
         ORaccsagsdyRKGRYxvhFSJjWsP+BQtfoDcMpFVyrnIcv0f/kOY0smLXTbFhc1UfTvt4j
         lEcoZX65t4TBjqo/qyNvCiOmIZLo7C8aklTj5sXRJ6j6cO5TJ6htf1Lq7HlKbum7ukOX
         uW636jyKcNst4WM8Fuj3LTewj7eNHpj7XEUiV1hFe3XR7qynOrcTVTzMoDfJKLngaCsS
         XYXA==
X-Gm-Message-State: AOJu0YzckIPiOkbnuDS080gU0B4/JPeKQj0opLVBqqvN7vbHCVQIugrW
	ulIUiso1deg8C1cRIuNVyafkZgByG4rJCB2dIVtTXuaOliHzp0nJAeuczsQs
X-Google-Smtp-Source: AGHT+IHeksvX/HM6N2FaqWb0uyUIu9SjBlASvmcJWgg2zBZzWQXpq5kS61ZOKqwjaU+KBy7xPcR4CQ==
X-Received: by 2002:a1f:db84:0:b0:4cc:5529:5806 with SMTP id s126-20020a1fdb84000000b004cc55295806mr4785605vkg.11.1708982143265;
        Mon, 26 Feb 2024 13:15:43 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ep9-20020a056122390900b004c003cf5e14sm724487vkb.28.2024.02.26.13.15.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:15:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_sync: Use QoS to determine which PHY to scan
Date: Mon, 26 Feb 2024 16:15:39 -0500
Message-ID: <20240226211539.1675928-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226211539.1675928-1-luiz.dentz@gmail.com>
References: <20240226211539.1675928-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This used the hci_conn QoS to determine which PHY to scan when creating
a PA Sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_request.c |  2 +-
 net/bluetooth/hci_sync.c    | 65 ++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 00e02138003e..42f2477026bd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -34,9 +34,9 @@
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 {
+	memset(req, 0, sizeof(*req));
 	skb_queue_head_init(&req->cmd_q);
 	req->hdev = hdev;
-	req->err = 0;
 }
 
 void hci_req_purge(struct hci_request *req)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ab609089ac4c..2bd9b6b050e0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2758,6 +2758,14 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	return filter_policy;
 }
 
+static void hci_le_scan_phy_params(struct hci_cp_le_scan_phy_params *cp,
+				   u8 type, u16 interval, u16 window)
+{
+	cp->type = type;
+	cp->interval = cpu_to_le16(interval);
+	cp->window = cpu_to_le16(window);
+}
+
 static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 					  u16 interval, u16 window,
 					  u8 own_addr_type, u8 filter_policy)
@@ -2765,7 +2773,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 	struct hci_cp_le_set_ext_scan_params *cp;
 	struct hci_cp_le_scan_phy_params *phy;
 	u8 data[sizeof(*cp) + sizeof(*phy) * 2];
-	u8 num_phy = 0;
+	u8 num_phy = 0x00;
 
 	cp = (void *)data;
 	phy = (void *)cp->data;
@@ -2775,28 +2783,63 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 	cp->own_addr_type = own_addr_type;
 	cp->filter_policy = filter_policy;
 
+	/* Check if PA Sync is in progress then select the PHY based on the
+	 * hci_conn.iso_qos.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+		struct hci_cp_le_add_to_accept_list *sent;
+
+		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST);
+		if (sent) {
+			struct hci_conn *conn;
+
+			conn = hci_conn_hash_lookup_ba(hdev, ISO_LINK,
+						       &sent->bdaddr);
+			if (conn) {
+				struct bt_iso_qos *qos = &conn->iso_qos;
+
+				if (qos->bcast.in.phy & BT_ISO_PHY_1M ||
+				    qos->bcast.in.phy & BT_ISO_PHY_2M) {
+					cp->scanning_phys |= LE_SCAN_PHY_1M;
+					hci_le_scan_phy_params(phy, type,
+							       interval,
+							       window);
+					num_phy++;
+					phy++;
+				}
+
+				if (qos->bcast.in.phy & BT_ISO_PHY_CODED) {
+					cp->scanning_phys |= LE_SCAN_PHY_CODED;
+					hci_le_scan_phy_params(phy, type,
+							       interval,
+							       window);
+					num_phy++;
+					phy++;
+				}
+
+				goto done;
+			}
+		}
+	}
+
 	if (scan_1m(hdev) || scan_2m(hdev)) {
 		cp->scanning_phys |= LE_SCAN_PHY_1M;
-
-		phy->type = type;
-		phy->interval = cpu_to_le16(interval);
-		phy->window = cpu_to_le16(window);
-
+		hci_le_scan_phy_params(phy, type, interval, window);
 		num_phy++;
 		phy++;
 	}
 
 	if (scan_coded(hdev)) {
 		cp->scanning_phys |= LE_SCAN_PHY_CODED;
-
-		phy->type = type;
-		phy->interval = cpu_to_le16(interval);
-		phy->window = cpu_to_le16(window);
-
+		hci_le_scan_phy_params(phy, type, interval, window);
 		num_phy++;
 		phy++;
 	}
 
+done:
+	if (!num_phy)
+		return -EINVAL;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_PARAMS,
 				     sizeof(*cp) + sizeof(*phy) * num_phy,
 				     data, HCI_CMD_TIMEOUT);
-- 
2.43.0

