Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E569366816
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787478959; cv=none; b=dxBPEe8esHtm9U2iZ05RIc7GzO+T3C8zXDYNMzUgtehtVOT7aVtoDuHDbzSUUaGh9DQvsDJG0HKWN1DozRM033lqOhKo5mhRXv362ci39eyioQSix66R0ePzv9so3sWhZ3AdhJ4zbzl3xmbAZCiiT3g8+NE1g8H3RZj9DccnB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787478959; c=relaxed/simple;
	bh=XMMGhYP59luII3hmiCnrUic5QXcsTg2gH/IMDu3Tc4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbrYgg14gEcj6GtnfZ29PZK7KDa+NucME/e4Be4pFBNeTU3NzWDAC5vT9j3LrwJj6j9BymyirfJ50RvXWCKvtnKHgLQhkf78Dcd/PY9wAECrKSJo89hhO79pw4731PeQOZtRAkbBektLCvac1tk8umSchZan+LiMOVFBzUmTrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IshQyjRc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IshQyjRc"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cace91f112so27160745ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787478955; x=1788083755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GYc/dM8G7XqLtprpN5SLNeRbkfYO7LaPYZyCfmqct0Q=;
        b=IshQyjRcsdGEVZ9G7o+zb6914l3SXl+OekNgqH+enGCBTaGN4HwqMji+kVvDusM5A2
         0Iaz/bd38YoF1ei3bDtmcpsbh/Jq6xaMFHZbLbUUwkmEE9ZXDfnzPEH7DXdJJDRjwmaH
         YsjryZiG+JfAl4X/FC84lGRW9CNg3mPGTGxNsRWNL4DrjNSxD1fA4d02Mg68yH6iplTf
         /EWBbJ/OQ+0xx9JKkmE1iy+HpVALojgQu0v22f7TSCFRaCXN7uKjLW0qsBe6pBHEm4vp
         UFJMUewv7ynowJ/ixV/8o9oAcpNpsERixd63ZGyUx1uoh2ogdc7kWvbcMV7pzl4A/mwK
         1PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787478955; x=1788083755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GYc/dM8G7XqLtprpN5SLNeRbkfYO7LaPYZyCfmqct0Q=;
        b=SA3azU15tjnWKKWXe2FuNnx49lnD+iVRgfR3di3k/prNBs55fIUhBSG3EhpGvcdIXc
         0M32K6siu4g7bu1BjefT8q7WFOSyRVEyvFlGRcJURYJ5cGiqtMzQyF+XQGaHUgyrRE3i
         XxY1fad+YiayM3jtj3ZPRr5ufKmUSAjIrel6iJHllVShwc9NTy8lEH7La9kJYU4HoDnl
         ZDg7wNBVPCj99uJaTtt3IOQQCs5OoH5acPatYN+vakN/bjOwg07qzjcLIEmFN0DlO2xg
         XR7N8uUfzwUgZGHqcQFz9AQRkNh9sdRTCy+lNV7MNcY5TkfwWfiIXFtE0m/0s+V9Hin5
         zBEA==
X-Gm-Message-State: AFuF++kvp/oCxspWon0VaUBjuDnF7Y4HHwXTduU0GXoj+ruzzlcyx3Il
	5oTaL8bJPGJdIhlOaJDo3XIhIHUDKwI2u764melh+nqkCeE0AI3EzrE=
X-Gm-Gg: AR+sD11tlIlDbxfwywMX1FcyASWS9gejNwbqXh+fJsjcPKkzututdYEdeN7+nJVavSC
	XxT/UITmpYIeMglMDdhDEFwGcal91jVSKumVAOp60nFCnHJ4KcJLDX86AW135UcyL2pN0iJX5h0
	vprJzikzacGgMtEjFH+nc+gswBbaBqFA9xiCN0XwIQD2YRbjgObn5YMxi9r12hRhpF9imjoP5Z5
	Kud5Pm56B1/Vdw12EaXQweeafq6Y+MdXZ8HObRwvxbspS9jt5ZxIqF0Di9KV6XFj+gcoAW/msbw
	hIG+XidChV7tBEyRXiDT8WFN5nrbnMcR+5OYyMurdO8AF/MFMZ1dqTk01e0fkhdubQZS+Qx7SQs
	5tVCnG5Jtd2VRy9jy1NWepcqJavmKk337ClkUkaOy788bZOzlUGti/JxrABVBeiSm2bFqVZieDf
	tNgjRj//ZWVanYSFJkNRbWPMcXmGQcDBl9bWYi2zHrRr4ImeUUgxjegR50npZV1PbnQ3JkVDqNw
	s/hADfBNjjvR49w3Vo3ljXgIDyNevD89RSZRviuNmLf7uNkAHwRJ4GX+mI8gVM4T29HRw==
X-Received: by 2002:a17:902:f70b:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d670d07a21mr195309555ad.13.1787478955162;
        Sun, 23 Aug 2026 02:55:55 -0700 (PDT)
Received: from codespaces-2db70c.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net ([207.46.224.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676895391sm8922535ad.45.2026.08.23.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 02:55:54 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] Bluetooth: Remove unnecessary braces
Date: Sun, 23 Aug 2026 09:55:26 +0000
Message-ID: <20260823095527.57473-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing unnecessary braces and splitting statements
onto separate lines, with no functional change.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/bluetooth/btusb.c         | 3 +--
 drivers/bluetooth/hci_ldisc.c     | 3 ++-
 drivers/bluetooth/hci_serdev.c    | 3 ++-
 include/net/bluetooth/bluetooth.h | 3 +--
 net/bluetooth/hci_conn.c          | 9 +++++----
 net/bluetooth/hci_core.c          | 3 +--
 net/bluetooth/l2cap_core.c        | 8 +++-----
 net/bluetooth/mgmt.c              | 3 +--
 8 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index be82bbbc1b5c..407daaa427f4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1076,9 +1076,8 @@ static void btusb_intel_reset(struct hci_dev *hdev)
 		/* If ACPI reset method fails, lets try with legacy GPIO
 		 * toggling
 		 */
-		if (!intel_data->acpi_reset_method(hdev)) {
+		if (!intel_data->acpi_reset_method(hdev))
 			return;
-		}
 	}
 
 	if (!reset_gpio) {
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 58f5504a336e..680f1939f0a3 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -248,7 +248,8 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	disable_work_sync(&hu->write_work);
 
 	if (hu->tx_skb) {
-		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
+		kfree_skb(hu->tx_skb);
+		hu->tx_skb = NULL;
 	}
 
 	/* Flush any pending characters in the driver and discipline. */
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 593d9cefbbf9..5b0e0c6364cb 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -98,7 +98,8 @@ static int hci_uart_flush(struct hci_dev *hdev)
 	BT_DBG("hdev %p serdev %p", hdev, hu->serdev);
 
 	if (hu->tx_skb) {
-		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
+		kfree_skb(hu->tx_skb);
+		hu->tx_skb = NULL;
 	}
 
 	/* Flush any pending characters in the driver and discipline. */
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da5026f5..4873e8c859f2 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -600,9 +600,8 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 		struct sk_buff *tmp;
 
 		tmp = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
-		if (IS_ERR(tmp)) {
+		if (IS_ERR(tmp))
 			return skb;
-		}
 
 		len -= tmp->len;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 19b7629b1cc1..324c92bbb10b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1364,11 +1364,13 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
 			}
 
 			if (!bacmp(&id_addr, src) && id_addr_type == src_type) {
-				hdev = d; break;
+				hdev = d;
+				break;
 			}
 		} else {
 			if (bacmp(&d->bdaddr, dst)) {
-				hdev = d; break;
+				hdev = d;
+				break;
 			}
 		}
 	}
@@ -1479,9 +1481,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * to connect.
 	 */
 	conn = hci_conn_hash_lookup_le(hdev, dst, dst_type);
-	if (conn && !test_bit(HCI_CONN_SCANNING, &conn->flags)) {
+	if (conn && !test_bit(HCI_CONN_SCANNING, &conn->flags))
 		return ERR_PTR(-EBUSY);
-	}
 
 	/* Check if the destination address has been resolved by the controller
 	 * since if it did then the identity address shall be used.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 509c820a693d..c9ee533bb8d1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2892,9 +2892,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	/* Check if the driver agree with packet type classification */
 	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
-	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
+	if (hci_skb_pkt_type(skb) != dev_pkt_type)
 		hci_skb_pkt_type(skb) = dev_pkt_type;
-	}
 
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_EVENT_PKT:
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ee459dd411f5..975dd033991f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1431,11 +1431,10 @@ static void l2cap_le_start(struct l2cap_chan *chan)
 
 static void l2cap_start_connection(struct l2cap_chan *chan)
 {
-	if (chan->conn->hcon->type == LE_LINK) {
+	if (chan->conn->hcon->type == LE_LINK)
 		l2cap_le_start(chan);
-	} else {
+	else
 		l2cap_send_conn_req(chan);
-	}
 }
 
 static void l2cap_request_info(struct l2cap_conn *conn)
@@ -4618,9 +4617,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
-	if (!chan) {
+	if (!chan)
 		return 0;
-	}
 
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 860c086011b7..9494ecf8d2f0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -818,9 +818,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_BREDR;
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
-		if (lmp_ssp_capable(hdev)) {
+		if (lmp_ssp_capable(hdev))
 			settings |= MGMT_SETTING_SSP;
-		}
 
 		if (lmp_sc_capable(hdev))
 			settings |= MGMT_SETTING_SECURE_CONN;
-- 
2.53.0

