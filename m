Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15209306B1A
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470598; cv=none; b=HcxcTFhzkMCa4jFHE31S8U/Ql201oMxdCRE39Vlo1dZyyDkO4q//IqKqGEOMm0XgxrAnFf5cl27Mb5zgRyOsQMf7Eu1YPyL08ckbfrb0lzWlmhWMq2d/5H1eOmUN3KMbStq9Z1vkCIb5lOuolQvvvElmUv/98Iih0rtdHgtgwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470598; c=relaxed/simple;
	bh=GJON/UyNTYGzAEfps2U2BtEkmCUx07WGErA30bEI+fM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdLfgUmD4hi1UO2bIGlWTT3GzymPlQXz91LDMjM1ZKEaft+2pYNqj77uCRnasIyaoYfjOlmGymOmdEug/8hlYspbkZb8A4wxvrLQ9B3X9sP6W9ylYLlW/dFUlwXLNLWIuDeZkrmFklblicbCSNSWeVt7kUGtzjvfyeN2ycbzMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dczYml+k; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dczYml+k"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5597330a34fso113176e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762470595; x=1763075395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6U9cxXcBFjAfPz5noeOoEFOy7klsJyGOWu+NZON3oXc=;
        b=dczYml+kaEVN3kQS7gPvVuwRYZvqj9mehMpr8bFcHhJevtFmwUF+goR9xArea1qjQ0
         E3g8H4lg0ndrWNpEPkhgkftVOJd0TZteznGqN5Dxl65Htr+B30oRFwpyqHCoGwDGbowJ
         d8bGPDZcuCygXNI6fTu0v8MwKGUEZUS1k7TczQjvoKgLU6Igsb6uoJYqX+/FV3WFOGBa
         u4iBTssq/En6alU9SuhfMdGoz+6ULRNU/GrzWl6qqZgpB7wu5OC9zQfESXVEVwvufTEv
         Nx/glkwWZW/vyGNTst2d7uhSdaNm4QP2tR5B6WVWhydG89e5ExX0vm7KgkGXuIOgxvb6
         VE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470595; x=1763075395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6U9cxXcBFjAfPz5noeOoEFOy7klsJyGOWu+NZON3oXc=;
        b=xTLFl5p/TS4iXTagNWgiOaCQ9zpa1KJovG9wY2yCoVVHef3d9DleOhvQVa5DOcPBML
         QpZG8O5hwXoKQXRRcW6RwBPOLjhTEC2/kXNl3pbdvduHA/A3hvrFyWYFGz0n4evxr+SL
         amX0vZAHx1sADyrL6z0OCPEv1j4Rcg1CAQoGXGgCZn4gdYLCyhJ4Mp0hxqzfNKojWkQe
         ddmBR1k1Vn0/Ffrlgo6qOYkJEg9NNfu4jW3uuvZaRZ/omAH9EnMPIjnZjqyAEY4+nYMy
         C21KczTFtrwv4a4o9g+TMFWbrgPSE6qA1ZbBysjM/OvhyOVQ8ynK3QpxaIRHkkJoJqHg
         JSSg==
X-Gm-Message-State: AOJu0YxH+9A2plzn2sZbiW4ZRamTBHfFCmYVtSN3AUCa64C78/xk6apZ
	LFKdAufICyHFwRCb/eR/MvVyAPlUKw7lCef3Ew/0WPDkVUm6+LLzWCBxwuN6lA==
X-Gm-Gg: ASbGncsSBZLmqB42hAQCBiHJGOYPAb2/UcI8MZCxPL4yy5TELfdU4oPKaO9sPuXZLIO
	LkUGSpDny0fjAZIN7j3Ot4g6J42C4BZfHPQIBYsHxJbefYw1z37iHpmlFIbSRxMG49zSexv62up
	luWdcGWe/FbdfuQW72k/iGratD+esiKi3fYIQX1SGsXt135i1XFxMUpv3Om78PE+lIBetpRMIlm
	cbBv34jJ3tYg2QSy66KKfJNcxqgTBouLTaPTqeQadV8E5x4Nnffba1aDRdP0uDB1kgxsJ/aeu8l
	1s4KKoc8nhEmitReoqeNF26YPjovJyarhNqFtQfoVDdPJLy9bGyaUwjcbzXNV1ufc+CFOSUMWXb
	eeGt6N0/gKxd62ggf9eUjy5olCukb9z91cab0SQx383OsUc2gMk0z+yZp6wn3sBTsv+UlIsi+Il
	nOwFPrxLXT/8PYfA==
X-Google-Smtp-Source: AGHT+IHwitg15HxIDl7ly3lzHVPmGEDbo+uDhDDTeYCgCFW2np9/vKEp9p0jRtP8a7p7RJGbsQ00Yw==
X-Received: by 2002:a05:6122:2a47:b0:559:83be:69c5 with SMTP id 71dfb90a1353d-559a3c34febmr539422e0c.10.1762470595293;
        Thu, 06 Nov 2025 15:09:55 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm2163644e0c.16.2025.11.06.15.09.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:09:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_event: Fix not handling PA Sync Lost event
Date: Thu,  6 Nov 2025 18:09:43 -0500
Message-ID: <20251106230943.877242-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106230943.877242-1-luiz.dentz@gmail.com>
References: <20251106230943.877242-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This handles PA Sync Lost event which previously was assumed to be
handled with BIG Sync Lost but their lifetime are not the same thus why
there are 2 different events to inform when each sync is lost.

Fixes: b2a5f2e1c127 ("Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  5 ++++
 net/bluetooth/hci_event.c   | 49 ++++++++++++++++++++++++++-----------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a998f8edbb53..d0c80d397045 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2823,6 +2823,11 @@ struct hci_ev_le_per_adv_report {
 	__u8     data[];
 } __packed;
 
+#define HCI_EV_LE_PA_SYNC_LOST		0x10
+struct hci_ev_le_pa_sync_lost {
+	uint16_t handle;
+} __packed;
+
 #define LE_PA_DATA_COMPLETE	0x00
 #define LE_PA_DATA_MORE_TO_COME	0x01
 #define LE_PA_DATA_TRUNCATED	0x02
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 51c23264ee2f..7c4ca14f13e5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5843,6 +5843,29 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev, void *data,
 			     le16_to_cpu(ev->supervision_timeout));
 }
 
+static void hci_le_pa_sync_lost_evt(struct hci_dev *hdev, void *data,
+				    struct sk_buff *skb)
+{
+	struct hci_ev_le_pa_sync_lost *ev = data;
+	u16 handle = le16_to_cpu(ev->handle);
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "sync handle 0x%4.4x", handle);
+
+	hci_dev_lock(hdev);
+
+	/* Delete the pa sync connection */
+	conn = hci_conn_hash_lookup_pa_sync_handle(hdev, handle);
+	if (conn) {
+		clear_bit(HCI_CONN_BIG_SYNC, &conn->flags);
+		clear_bit(HCI_CONN_PA_SYNC, &conn->flags);
+		hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TERM);
+		hci_conn_del(conn);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 				    struct sk_buff *skb)
 {
@@ -7101,29 +7124,24 @@ static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
 				     struct sk_buff *skb)
 {
 	struct hci_evt_le_big_sync_lost *ev = data;
-	struct hci_conn *bis, *conn;
-	bool mgmt_conn;
+	struct hci_conn *bis;
+	bool mgmt_conn = false;
 
 	bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
 
 	hci_dev_lock(hdev);
 
-	/* Delete the pa sync connection */
-	bis = hci_conn_hash_lookup_pa_sync_big_handle(hdev, ev->handle);
-	if (bis) {
-		conn = hci_conn_hash_lookup_pa_sync_handle(hdev,
-							   bis->sync_handle);
-		if (conn)
-			hci_conn_del(conn);
-	}
-
 	/* Delete each bis connection */
 	while ((bis = hci_conn_hash_lookup_big_state(hdev, ev->handle,
 						     BT_CONNECTED,
 						     HCI_ROLE_SLAVE))) {
-		mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &bis->flags);
-		mgmt_device_disconnected(hdev, &bis->dst, bis->type, bis->dst_type,
-					 ev->reason, mgmt_conn);
+		if (!mgmt_conn) {
+			mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED,
+						       &bis->flags);
+			mgmt_device_disconnected(hdev, &bis->dst, bis->type,
+						 bis->dst_type, ev->reason,
+						 mgmt_conn);
+		}
 
 		clear_bit(HCI_CONN_BIG_SYNC, &bis->flags);
 		hci_disconn_cfm(bis, ev->reason);
@@ -7237,6 +7255,9 @@ static const struct hci_le_ev {
 				 hci_le_per_adv_report_evt,
 				 sizeof(struct hci_ev_le_per_adv_report),
 				 HCI_MAX_EVENT_SIZE),
+	/* [0x10 = HCI_EV_LE_PA_SYNC_LOST] */
+	HCI_LE_EV(HCI_EV_LE_PA_SYNC_LOST, hci_le_pa_sync_lost_evt,
+		  sizeof(struct hci_ev_le_pa_sync_lost)),
 	/* [0x12 = HCI_EV_LE_EXT_ADV_SET_TERM] */
 	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
 		  sizeof(struct hci_evt_le_ext_adv_set_term)),
-- 
2.51.0

