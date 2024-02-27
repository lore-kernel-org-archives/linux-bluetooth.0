Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB671420B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046944; cv=none; b=q2iYZg1u/eq3JVZv2HTOXOJt4a2tW5sQ1O1X7AjNmk0m/aOPrtkY9GCqUhzc+SxrKUcV4LvVrBEuuFKotoSoa0gpqpLPPjJar2Lg5VaU3+irtKZ+JCEa2oLyhbuUae7W+y2SauKuK66FFJD6vZHP7QvuKVrwtWf2bzejw/3Pvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046944; c=relaxed/simple;
	bh=eSFD0jMX9QX3F36TXKIE36SpBbtzb+/+q2DtOdKZDt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2AyIgYYX+tbajcIQDd+PyOgFoArb3DrDT1SJCrQzkIA6lVH/MkySwL/E/ukn4FBaKBzGT+rGnsOM9x/7QvHsyyPrSIiFjqUfKW+GNNeVezs7mHZ56awUsR01dhsZ3B8WcCq2OVeZ516IAI0GZfJySS7bbZHM1ylv/CKUnGa/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ7301Dk; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ7301Dk"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607f8894550so31457357b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046942; x=1709651742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXvzMmiAQBkYjtoM4i7MxrToF6Q1C4jv7wnZl9wJ/YM=;
        b=HZ7301Dk/Dhdi+ftdMLjVCXYrEiHp9EZGKKx9MSxKedbtbEKMsBomth/NjrFSAvYkr
         45Mg3YZk2UE4S0LBawqRnyPetfbhpvW5TAw/pn/F9WcYOhmcIzKZyWH4OoLXRVhqGcS8
         UgBozU3LyOGPTd/LepeQZSJGMo3uW1WqACjyfMQ0fjw0U1mDZS6lJ9hiBPNUPz0zrjCk
         wV5xiQpemf/klcZVK1vo/WjpiQSGHPOMTnNWiB+A1whNa5xVRJwlUs2+5pzV3kEU0v5o
         dSm5+OLGQ/PXrEpftZbAe9AEKLK/HrV5+V1sD8ac4kqntlH2pRCsrEoPQYYJW/j1QVlb
         A8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046942; x=1709651742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXvzMmiAQBkYjtoM4i7MxrToF6Q1C4jv7wnZl9wJ/YM=;
        b=JERZDKySvFtbkXv86i2G1nU7TuGV944qhop18SWhjQoesvLOE7CC7Lo79rKyElKMG/
         mTXU9qQjKVbz9YHsBfatLP4k//hc6Zn2pPU1EbOq0OALWmJGej4NgOHMZoqM3cz6wMJY
         jGPC9oEaydHCgZBcS3w57N4SAVLZ+bdRtB8jXAQpw58nVDWTK2gQSp+twytLHebpKrzO
         5BfyH78msMb/3MP4lA22MFAAIiTJayWtTHeNzDpP3mFzczX9pcJlrdfgZdRgK55fhQNw
         jvESJFJffbIlMAwM/RJ5NBhy7HhgWcCCHP2a6/gV8N+GtMOIxTlTQDUsjWPs3uemO2E5
         TezA==
X-Gm-Message-State: AOJu0YxZQcnloTXCKtKoDfaw+v14qoIgjv2rVHe+QvueK/5SzZowoiEh
	1AkM+kIZ+PGADg6lFgM/aKlHL/S2mW0sqGzjKh2urtYx7DF3UUZHLcwlqrVO
X-Google-Smtp-Source: AGHT+IGSphaOqa3MvfcXJ6BAxuEnEU98wTDSrWQPjQq2OS2MR8lVJhKihzvDuE4jujzzw0MZ2LAQSQ==
X-Received: by 2002:a81:8352:0:b0:608:b64a:1517 with SMTP id t79-20020a818352000000b00608b64a1517mr2345623ywf.19.1709046941628;
        Tue, 27 Feb 2024 07:15:41 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id h28-20020a05612201dc00b004d335f1bdb7sm32726vko.37.2024.02.27.07.15.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:15:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/2] Bluetooth: hci_sync: Use QoS to determine which PHY to scan
Date: Tue, 27 Feb 2024 10:15:37 -0500
Message-ID: <20240227151537.1884044-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227151537.1884044-1-luiz.dentz@gmail.com>
References: <20240227151537.1884044-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 66 +++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ab609089ac4c..6e16ebde854d 100644
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
@@ -2775,28 +2783,64 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
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
+				if (num_phy)
+					goto done;
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

