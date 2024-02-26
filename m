Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1312C7F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980786; cv=none; b=FBbm+HLjbgCTiKCVJ3sgC6ZLWq6vzc25puefxhVUIl5lOXco/tSeEMhcAOhPNtF9nCU/OPGbr/eLs5f6IpJnaG+Umdgwo/RQ1jxuN2BfC8kCP5oxzpv7aQwGPMr18A17BYPKz6ENj1oz5pfpGUPnY/XzpTgFFOeQShNI8ODn+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980786; c=relaxed/simple;
	bh=4jK6IfgaAadUAr5Sy/kNVPaLf7uQJJJRnN+B0W97vw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC+pl+1RJVSCyAlqyltih4rD4KoRrEI1yWqIUHWOpeTmxTsu6+NJi47zR2c/eJXWlTZZ8FZ44xuSk5HnU27zJV5PR+92dyghN0oW3PJpXah+BkQP1KpMiRuCP7THjli3e4Zi/8BoITQhViLL6A2RuL0rtz8ug1WUnEmd/XTPmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keO9RAoo; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keO9RAoo"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4c8fa4a17faso462593e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708980782; x=1709585582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLRRtGrLTgl5xTBQwRcOD+DJLqyNJYkHFa/EMDCKF2g=;
        b=keO9RAooyWIt0qdxa1ijaczjT2AgRNYUobRCRHwnFXxApj+aogmoZPGlixgsELl/6T
         leREfsx4EN27iVUIOu/kfPieRt/Ph3UXX+6s0QVtdyBgKv7L2F0xokqEchWz+FnzET4O
         CVBYxstz0dIJ0yfcn5HKVjYzRbWXieEQjlD9Fi6yZOLEtfbVOKSq7HeBOf2rchFEVi2r
         JRZ76OGxcBMIUnevevl6HiE1vLWjSnoZ8VIN1xFPBOOOF1Bk77CFqNUTx7V+QW2bdk4r
         zEWYfPIUdytwopZR30eokGO/q0jrBt0ODKRLdqC9t7GLY35ZLl0Utni1EqrLDGu/G3wv
         fqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708980782; x=1709585582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLRRtGrLTgl5xTBQwRcOD+DJLqyNJYkHFa/EMDCKF2g=;
        b=K3hTOkvSy5ekNfQzkJ2HJqHJ1DlpZZvYtDdmbikzX+W00GLPbOv0QsB4L25kUGNXdL
         9se3WeVY5LmABdJLU/+vfeCmH0BBQ+YkONeM9SmKvRJ3WBkhuy9XOVi8V+qo6OrhVQxH
         HZeT2HdkWeDv7CV9y9JAX3kigrLwCNj3WngAlSEiigqhVx/piDOsXRtkbsKUvlRa1HnM
         cTeiGRsOmDOjXiVZhvOt1eUidihDfvll7Ey/pNaGVeM1oFdR+rWyWlEDjpFT7yrsCrlk
         /LMqU9vWjUGp1BLNuN2XkPlfZiDjjNGlNpiWc8RMs8zSONWGL137w9ktssOsVpNr381M
         mrHw==
X-Gm-Message-State: AOJu0YzMuK0s1sJ7uYMaI7FjWlfFdF+BJVoxzfKOs1Zji5PTwzCy2+kZ
	DakpMWSEcBKl8OHeConsB4aRwWthN32el0QH4xOgQ+7VLPy5hOiQiwZc0XAF
X-Google-Smtp-Source: AGHT+IFHexXzMR0w1XfZKV0dgcaEi15LGiP/7tLFvV6nZYxo0/BxLvT6WEGC8sCz40EYEgeKMHY/JQ==
X-Received: by 2002:a1f:dac1:0:b0:4c9:3426:2ce3 with SMTP id r184-20020a1fdac1000000b004c934262ce3mr4783326vkg.7.1708980782493;
        Mon, 26 Feb 2024 12:53:02 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id eh5-20020a056122268500b004cc0afbce34sm722203vkb.10.2024.02.26.12.53.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 12:53:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Don't scan on Coded PHY when HCI_PA_SYNC is set
Date: Mon, 26 Feb 2024 15:52:57 -0500
Message-ID: <20240226205257.1671077-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226205257.1671077-1-luiz.dentz@gmail.com>
References: <20240226205257.1671077-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This disables Coded PHY when HCI_PA_SYNC is enabled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 65 +++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 11 deletions(-)

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

