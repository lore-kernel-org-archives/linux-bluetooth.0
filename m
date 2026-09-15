Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC54A4EE2
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506947; cv=none; b=lD8o5t09GFYqXZQG3GHVzHW1/DIYD7gkuwkVpnip8pqQSJdnSQTC4Pv7Ay52VI5ZhZb7qFMbqVefwy6/ohknMeY8cu5p/K8vp7LcOIUMSTcKJwe0eSPPtlvdV3oCc5zJFEeTjIcMtOzH7fdzJdgIOzOWwS6K/xLfXZn7sHst7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506947; c=relaxed/simple;
	bh=FGaflZglzqxxDR8XkxdmCXciKLkCp5tv8og5090fvUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHyekL6/RF0ugbjJWerOGpUi4K2VaFk17bvJq1l3YCkFgpXrf0iR6rscAKPEKReQqDwjNxjBNzry5UQL52UhfT6zppLBZXOG7nLom/VA5Yf+zZAHE6nfNdXDz7hTY37GUExiRM8XvlojHminGitQLzvGeumjCcOyzmZvkAO5DTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO6OpBmG; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO6OpBmG"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97ea1a712deso84002241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506944; x=1790111744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WRV+nWZ3Cn0PR1EpIiemRWv2OlVIZ1pm553TXuF6vXA=;
        b=RO6OpBmGDdx92qWR7J0kLsBq4YgYmPMnm2tnYvsbXvDr8shDtwYqEktADlNx1ZCZhV
         lj16KkP6ez+y7ryeyosFUkYoyUluwljQfULJqDpOnGbta9nd3A2eTltFrnQ2qQ30tN2L
         PWDqUn7eQxWExTVWIfORdG0uJxf9XlXn8x6dfNHqMpNjHCuAJCoh5x8rFpYCpMPkVmuu
         qE1OjtygAodQLx3fEwifrUZqVYHm/wQSGwbFC6Qy4Hx5oaVHmFRy9ezjfxjtwRO0KWQn
         yawFV93OY117gEeauRIkU2GUpzajSzGGBRlQ+zuCEMj/RAIGUgYyHYjBzuvN7aXqm75m
         rn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506944; x=1790111744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WRV+nWZ3Cn0PR1EpIiemRWv2OlVIZ1pm553TXuF6vXA=;
        b=m5wQacclO74gDASQWj2/5hPBLXXFKTPDCk3y5utiMVHXTE4ljLG7tUj6jAUdmirG8H
         iCYMMxSkFMeEVw93jZlhwh1859REfSTcfiHLf26ev2KDoewMu4fEyEkK9DuSTJ3Fhng8
         Qd5W7msNxUia3pMBd6decNB9Z4VCmjihTGq+uwX5SDqlap9pHH5uA79hvj7M6BBMa42i
         fQpXc5WZRgdleELe0KBVjoIhtJBnXIMWThdAkGmPHDwH3mth2rcdYJ+dHOiAVpMQgry9
         /h/UMga9ht2ksuLolqVE+1Z66zXUpiKb3Wxy3a5ajQl/QD6VTwepJGSrVgJl4Bk0EcxC
         W1nA==
X-Gm-Message-State: AFuF++mng5AsgkAP1Q7HF11m3bL33WWe1zp6raXy1vTKafp2byPXU6L4
	Ke2j/F+Dbkkopk50L2mk8cTMOoTppcX9JrwIqmxoTg/OF73emA196tXR2NDtnUtC
X-Gm-Gg: AYBFou3B88JBV4fTkjXTVyuaEb1W0zBbGsDvMYdB/dkfDvzMqxVxD8h2rpoUsmpwgYo
	jkFFUiu4nOwG7FgrOhXW1cz+ovvJpAEGyWGcr00aXEK9BApA8kbMNyMPBdIG2PDbTB9m4yzOLez
	T45/rTgfF00IdVoGbVvW9Y98tgAkeZI9XSkIbJOC7xu/Ws6Y+GWstLgL4e8ecZz4kxLhU8KuBgz
	ZysTaKX1JW3y46Lm+00tvMTL+5vjijpm+Em4WEKSWxMV+Wq8WXpWz4L//KSlJ5cUzIkJyPdnUxh
	J2qJoCBWlmgRyRTWBgdWynb8OjsBhHsLAS4THbSoE62RMolkdm9QqVN4otDS/rkpot77ZdqCaZj
	93p6eUiv8OdxxRV19Xk1rXPvCt9YHIQ961SSt8EHstwd11T/p20bpZDwPi7A03WVs3kDfR/GpA5
	T5TVksEb1FWW0BB90hN0n1h9HtusgaizmRLr8Grw7HzA9Hi2/VMfaJCvn9AgWvgUxeK/SNtyeyY
	oZ2HnwMaot//Ie9WcYBGIRSRyhstUxSqGrbOPKuN38qLdM/mUTGTJJRMIlDGJAK1Q==
X-Received: by 2002:a05:6102:6445:b0:78d:31e7:e02 with SMTP id ada2fe7eead31-7a026372b28mr473508137.4.1789506943967;
        Tue, 15 Sep 2026 14:15:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/11] emulator: use the handle of the receiving side
Date: Tue, 15 Sep 2026 17:15:23 -0400
Message-ID: <20260915211528.1223784-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Every device assigns its own connection handles, so the two sides of a
link do not necessarily know it by the same handle: conn_link() picks
the lowest one free on each device, which differ as soon as a device
has more than one connection.

The events and the data delivered to the peer carried the handle of the
sender though, so the receiving side got a handle it knows nothing
about and dropped what it received: with three devices the second link
of the initiator is handle 2 on it and handle 1 on the peer, so neither
the ACL data nor the CIS requests reached their destination.

Give the receiving side its own handle, as the disconnection already
does, for the data as well as for the events reporting a connection, a
key request, a connection update and the CIS of a CIG.

This changes nothing for two devices, as both sides then assign the
same handles.

Assisted-by: opencode:claude-opus-5
---
 emulator/btdev.c | 84 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index fcc516f4947c..e29e050fad59 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1589,9 +1589,14 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 done:
 	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
-	if (conn)
+	if (conn) {
+		/* Each device assigns its own handles, so the event of
+		 * the receiving side carries its handle.
+		 */
+		cc.handle = cpu_to_le16(conn->link->handle);
 		send_event(conn->link->dev, BT_HCI_EVT_CONN_COMPLETE,
 							&cc, sizeof(cc));
+	}
 
 	return 0;
 }
@@ -4196,12 +4201,17 @@ static void le_conn_complete(struct btdev *btdev,
 			memcpy(cc.peer_addr, btdev->bdaddr, 6);
 
 		cc.role = 0x01;
-		cc.handle = cpu_to_le16(conn->handle);
+		/* Each device assigns its own handles, so the event of
+		 * the receiving side carries its handle.
+		 */
+		cc.handle = cpu_to_le16(conn->link->handle);
 		cc.interval = lecc->max_interval;
 		cc.latency = lecc->latency;
 		cc.supv_timeout = lecc->supv_timeout;
 		le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CONN_COMPLETE,
 					&cc, sizeof(cc));
+
+		cc.handle = cpu_to_le16(conn->handle);
 	}
 
 	cc.status = status;
@@ -4709,10 +4719,12 @@ static void le_conn_update(struct btdev *btdev, uint16_t handle,
 	le_meta_event(btdev, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &ev,
 					sizeof(ev));
 
-	if (conn)
+	if (conn) {
+		ev.handle = cpu_to_le16(conn->link->handle);
 		le_meta_event(conn->link->dev,
 					BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
 					&ev, sizeof(ev));
+	}
 }
 
 static void le_conn_param_req(struct btdev *btdev, uint16_t handle,
@@ -4729,7 +4741,7 @@ static void le_conn_param_req(struct btdev *btdev, uint16_t handle,
 
 	memset(&ev, 0, sizeof(ev));
 
-	ev.handle = cpu_to_le16(handle);
+	ev.handle = cpu_to_le16(conn->link->handle);
 	ev.min_interval = cpu_to_le16(min_interval);
 	ev.max_interval = cpu_to_le16(max_interval);
 	ev.latency = cpu_to_le16(latency);
@@ -4845,7 +4857,7 @@ static int cmd_start_encrypt(struct btdev *dev, const void *data, uint8_t len)
 
 	memcpy(dev->le_ltk, cmd->ltk, 16);
 
-	ev.handle = cpu_to_le16(conn->handle);
+	ev.handle = cpu_to_le16(conn->link->handle);
 	ev.ediv = cmd->ediv;
 	ev.rand = cmd->rand;
 
@@ -5003,7 +5015,7 @@ static int cmd_conn_param_neg_reply_complete(struct btdev *dev,
 
 	memset(&ev, 0, sizeof(ev));
 
-	ev.handle = cpu_to_le16(cmd->handle);
+	ev.handle = cpu_to_le16(conn->link->handle);
 	ev.status = cpu_to_le16(cmd->reason);
 
 	le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE, &ev,
@@ -6190,7 +6202,10 @@ static void le_ext_conn_complete(struct btdev *btdev,
 			memcpy(ev.peer_addr, btdev->bdaddr, 6);
 
 		ev.role = 0x01;
-		ev.handle = cpu_to_le16(conn->handle);
+		/* Each device assigns its own handles, so the event of
+		 * the receiving side carries its handle.
+		 */
+		ev.handle = cpu_to_le16(conn->link->handle);
 		ev.interval = lecc->max_interval;
 		ev.latency = lecc->latency;
 		ev.supv_timeout = lecc->supv_timeout;
@@ -6205,7 +6220,10 @@ static void le_ext_conn_complete(struct btdev *btdev,
 				sizeof(ev));
 
 		/* Disable EXT ADV */
-		queue_foreach(conn->link->dev->le_ext_adv, ext_adv_term, conn);
+		queue_foreach(conn->link->dev->le_ext_adv, ext_adv_term,
+								conn->link);
+
+		ev.handle = cpu_to_le16(conn->handle);
 	}
 
 	ev.status = status;
@@ -7063,9 +7081,11 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
 
-	if (conn)
+	if (conn) {
+		evt.conn_handle = cpu_to_le16(conn->link->handle);
 		le_meta_event(conn->link->dev, BT_HCI_EVT_LE_CIS_ESTABLISHED,
 						&evt, sizeof(evt));
+	}
 }
 
 static int cmd_create_cis_complete(struct btdev *dev, const void *data,
@@ -7110,8 +7130,11 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 			}
 		}
 
-		evt.acl_handle = cpu_to_le16(acl->handle);
-		evt.cis_handle = cpu_to_le16(iso->handle);
+		/* Each device assigns its own handles, so the event of
+		 * the receiving side carries its handles.
+		 */
+		evt.acl_handle = cpu_to_le16(acl->link->handle);
+		evt.cis_handle = cpu_to_le16(iso->link->handle);
 		evt.cig_id = le_cig->params.cig_id;
 		evt.cis_id = le_cig->cis[cis_idx].cis_id;
 
@@ -8737,6 +8760,7 @@ static void send_acl(struct btdev *dev, const void *data, uint16_t len)
 	struct iovec iov[3];
 	struct btdev_conn *conn;
 	uint8_t pkt_type = BT_H4_ACL_PKT;
+	uint8_t flags;
 
 	/* Packet type */
 	iov[0].iov_base = &pkt_type;
@@ -8751,11 +8775,18 @@ static void send_acl(struct btdev *dev, const void *data, uint16_t len)
 
 	num_completed_packets(dev, conn);
 
+	flags = acl_flags(hdr.handle);
+
 	/* ACL_START_NO_FLUSH is only allowed from host to controller.
 	 * From controller to host this should be converted to ACL_START.
 	 */
-	if (acl_flags(hdr.handle) == ACL_START_NO_FLUSH)
-		hdr.handle = acl_handle_pack(conn->handle, ACL_START);
+	if (flags == ACL_START_NO_FLUSH)
+		flags = ACL_START;
+
+	/* Each device assigns its own handles, so the one of the
+	 * receiving side has to be used.
+	 */
+	hdr.handle = acl_handle_pack(conn->link->handle, flags);
 
 	iov[1].iov_base = &hdr;
 	iov[1].iov_len = sizeof(hdr);
@@ -8794,8 +8825,8 @@ static void send_sco(struct btdev *dev, const void *data, uint16_t len)
 
 static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 {
-	struct bt_hci_acl_hdr *hdr;
-	struct iovec iov[2];
+	struct bt_hci_acl_hdr hdr;
+	struct iovec iov[3];
 	struct btdev_conn *conn;
 	uint8_t pkt_type = BT_H4_ISO_PKT;
 
@@ -8803,18 +8834,31 @@ static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 	iov[0].iov_base = &pkt_type;
 	iov[0].iov_len = sizeof(pkt_type);
 
-	iov[1].iov_base = hdr = (void *) (data);
-	iov[1].iov_len = len;
+	memcpy(&hdr, data, sizeof(hdr));
 
 	conn = queue_find(dev->conns, match_handle,
-					UINT_TO_PTR(acl_handle(hdr->handle)));
+					UINT_TO_PTR(acl_handle(hdr.handle)));
 	if (!conn)
 		return;
 
 	num_completed_packets(dev, conn);
 
-	if (conn->link)
-		send_packet(conn->link->dev, iov, 2);
+	if (!conn->link)
+		return;
+
+	/* Each device assigns its own handles, so the one of the
+	 * receiving side has to be used.
+	 */
+	hdr.handle = acl_handle_pack(conn->link->handle,
+						acl_flags(hdr.handle));
+
+	iov[1].iov_base = &hdr;
+	iov[1].iov_len = sizeof(hdr);
+
+	iov[2].iov_base = (void *) (data + sizeof(hdr));
+	iov[2].iov_len = len - sizeof(hdr);
+
+	send_packet(conn->link->dev, iov, 3);
 }
 
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
-- 
2.55.0

