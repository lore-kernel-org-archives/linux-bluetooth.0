Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6055131733
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984838; cv=none; b=bMYHqoyp+DihSNKT+tIEPS8Or//oQV+JpK2DXh5RM41whV6E846ux2oEJnC3BZFnDwKW3ZaqoBVMuZShkNXFe3KaIYZzZSHf/b7D/8UnU+i9OTCKT4jt340yNk0E98knpx6fhjWAUXzCVks15Ki8TY6YPXPfamUKDF/q49y3lmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984838; c=relaxed/simple;
	bh=PBemC8eLkTVfNh0dwYJ2wYP2+UQNVZyPXP0l+8IDzyk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGZfE+XIsXSH9k4Qb3nO81F5h/TeqE1fV04yI8VooVjuJD8b0AK/SHzRNwO+c1Kx1aNB7EB+U5BI7MONi9phvcFUrOapINA2cQrBTJepIRy4IJUvagmZUmE0bkXrRThLBDtoq5kbRR5wXOG+kBtVk/3gLDrjYLY64yms/iZPXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am6PoLyV; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am6PoLyV"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4ccfb94ee5cso410835e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708984835; x=1709589635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQwU9BZ8ZHeA+YsMY+rfVU1i7tvh/Zon3HuyxPG4BIM=;
        b=Am6PoLyV/lif+rp6BKmdR0F9TlRVopCxm51sugYAT/nDHa8LPeNcCGzj2Qu+l4DkxF
         41qT8tMSlBHGzVQpku/vg+puwlZ4rGoj6kSXqJ9dI3QMqunf97KC6VxvorvfdLcxd66N
         C0lETPGGCSS3rWBWNpOMIZlRJZclxa1DUHjzPunqm9tctw2OSaeAvKQW/58WhnHKd/79
         kwakC7qNyqc36qsB3Md81dCqo+EubcSG8remLtHYRJJ0aix5VcVYCjQQPK4xHMvmcm2c
         P/jOmIA8hwUdnnVsZ/tJc/TJ+sq5mjTfZ0ihbh2UY8EaLzIxetM2r9M06sNTPwy4NtwD
         GTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984835; x=1709589635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQwU9BZ8ZHeA+YsMY+rfVU1i7tvh/Zon3HuyxPG4BIM=;
        b=MgeaYfowUO93hPC3x20X3NX3bWXS4QWDqse5m9S2kUy5N6Cf6aHx6qiJMy5R/Z/96G
         sBTIFr2G01I993y59QOnx8PSAWS3zPq91O0kav9gZehatY2Gic0aSFrKRzMEDcoRWb/S
         7SvUQMjUVonVw54hloyYqKq/1jGtPuzlggvHYOuVQGshIbumkSaLvYKL7tWH0AeQqPqX
         dbwIFPfyfHWT9vK50raVGkLd29zkegoFogs47j+kZunRxV7Pguni44xSfcLwNnrSqC0e
         5+BGnbPC88swuA5+Xt8hVwf55Vq64f1EWQ3CyCBrKPIIShBxiUSvSM6E6WrdTeBFqQ3I
         l7qQ==
X-Gm-Message-State: AOJu0YwJdvFggZLzNndWs9Sq7Vbt6MdNoSiUZg+FAg6lbARxhVPXodct
	EJL1BjUZXZsl1zZAlcN55+nIkl+6766GpVvK82i3pgZxKPNgwHpp0uqHh0oa
X-Google-Smtp-Source: AGHT+IF22kHNYduO9xdAKzXB76fXX1k5FANuajR/VdnAG+3qYS5e/yGlS4NPZMC/Jpia4M029yvOXw==
X-Received: by 2002:a1f:c703:0:b0:4cc:9cee:7cbd with SMTP id x3-20020a1fc703000000b004cc9cee7cbdmr4187709vkf.6.1708984835135;
        Mon, 26 Feb 2024 14:00:35 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id n15-20020a1f720f000000b004c04a84d80csm815764vkc.56.2024.02.26.14.00.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:00:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: hci_sync: Use QoS to determine which PHY to scan
Date: Mon, 26 Feb 2024 17:00:31 -0500
Message-ID: <20240226220031.1686256-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226220031.1686256-1-luiz.dentz@gmail.com>
References: <20240226220031.1686256-1-luiz.dentz@gmail.com>
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

