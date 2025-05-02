Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057C2A1AA
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219136; cv=none; b=bSXQm7HfAdGs3XfelEed2trin7Uff8Z2tzMsl0lcsk2AR2SRF9ANhbX3cbUyhFwKnP+buphbFuj7437GzBaEt7SyRu65O9ZJjA3/3zZFe3iPOCqTKtsQMO/o4mm+VKOnwTWGFL0WqfmFeM9Whcr/Zj2LJ5eU6k7dvHmP9R6apfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219136; c=relaxed/simple;
	bh=P5Sc5D7KV+bTSpQOyvwnF4U7hYttqNZxIQG7HV6Rlco=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uPSp6thlW6fMla7/XcjnMecNaHiBtMMqAbRm5q0MI3n1Slyk2HJPKShoGYQK7aHtGmPz61qVTg8UlTjKCAUXB5B+bX4Xp4DNZJ5Z7IVUbCw8MOCRAgBhN0Iyhube8VhGDVuYQCmdqEHM3poJyWSdBxkF01S9KMJelnj1PbESLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7Wh1w7E; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7Wh1w7E"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso649303241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746219132; x=1746823932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zM+tnsc/8MeHwo0gTo1POFN3QjUYcud6rhzO2ooStD0=;
        b=M7Wh1w7EuuQPIgA1vBBsoeyag2Y+AodGq7UW59p3XDCQwMjtrz1lTo6kXqr2ipl0nD
         83otOAUQY5rgrzQoryDRJaPDXiQrPysvvlxjssFD/9kqply7XGNlSBQeaCCjiB5bNmEa
         i+amCDALf3XOngiJBdnTDies2mxk9pfHtjoAGVCSjcEXe99f55SJjrtu1V1yh/eMnL6A
         EPWcwHKM4ogFZtKygJq71JarXa/SS9a/S1VNCaPmNHFa8j8OAQI4RvSD9N2yEnip43Xe
         ipaH3ke7OZ9BOBp6qsu1mimhyOK2XNUUsjUsgPLP2adIVB9BcNib4yBxo44HFKrmiU5V
         QSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746219132; x=1746823932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM+tnsc/8MeHwo0gTo1POFN3QjUYcud6rhzO2ooStD0=;
        b=hrYWk0QoNZm8bOza1CRr69UpbjUzRvX+cosFd/x3+opDCttugSpLX3/wrEylx90XpR
         JOB78DT0fKTtxhbrDsNLzqotAE24klY8iL7HHGyrqhXQCdz7g1Z0UbK3v7C/GPSRqvhE
         Oh8RiYdsNTjj/9KjVwrq2AKHuUYsGyGfGtmwCM1KvI8wxhlaREhdvUWleUKOZPATDopi
         IRJg4I2CrkOuUMtPqObSN7nATGNPwpUMqGFyz8lskq3b5e4s4xJK5DGLtGO/CBSJ9Qiv
         TN011Mt33YYQyxMgJGUZYyuIqoAqzuanO1aZaz1EApEpPf0uRSLueMkb+34jPSPuGXjE
         mRGA==
X-Gm-Message-State: AOJu0YzmMbsa8WS8A4Q8FzGwsrkj49wbgqF5zcLLBO0BR8iQ9uQX62k/
	iOP6dVH6RQXarY/Cq2b/c6DkQXntCe8ieXOJf+wfMa16dpzZKb8hRy4H+hubVBY=
X-Gm-Gg: ASbGncuo83NP/TBTcikUWcacKGJqaOBk5/hm87BqpxqgSfGJ+Rwn7pHJ8BWK2GU/eRX
	xXrAtDJqDXL3Q8Vti6B/QOwEosawa0xuZ3qGwNzOadRp7WMF7kS0zLCUC5UBSknsB6abYw3xrO4
	qOwqjXzs3A+FpUf9sK7NUrlq6fSP/WT3SlUivmr8P4RdN/2oL8Gwg/ZpSWlU+BfLwH+k/ZjETmA
	riGc9OXrGfXfcd4H6uy4zpx4WeeqedICVrsw5WRcuTel8D7F6Zv8gQPrs5qwdu6z4vsekuwzkr4
	vIP1T8MDAPLfpc5kjleYQCDThZH0LYo9QeOcBsfjfD/sMYti4R4OuUMjMoQK+mIgzflC60tWf06
	OjUpNhQH2dA==
X-Google-Smtp-Source: AGHT+IEyBZI4SM8tmJ8FA5C4IkVJEh/5uvP9FGoF9N4bleqdEOw8COmN/VxUrgQJeOLAV7lzwSNB9Q==
X-Received: by 2002:a05:6102:4b0d:b0:4cb:5d6c:9933 with SMTP id ada2fe7eead31-4dafb4e5326mr3350878137.8.1746219131886;
        Fri, 02 May 2025 13:52:11 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4daf26062b0sm520436137.19.2025.05.02.13.52.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:52:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: hci_event: Fix not using key encryption size when its known
Date: Fri,  2 May 2025 16:52:08 -0400
Message-ID: <20250502205208.2815502-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the regression introduced by 50c1241e6a8a ("Bluetooth: l2cap:
Check encryption key size on incoming connection") introduced a check for
l2cap_check_enc_key_size which checks for hcon->enc_key_size which may
not be initialized if HCI_OP_READ_ENC_KEY_SIZE is still pending.

If the key encryption size is known, due previously reading it using
HCI_OP_READ_ENC_KEY_SIZE, then store it as part of link_key/smp_ltk
structures so the next time the encryption is changed their values are
used as conn->enc_key_size thus avoiding the racing against
HCI_OP_READ_ENC_KEY_SIZE.

Now that the enc_size is stored as part of key the information the code
then attempts to check that there is no downgrade of security if
HCI_OP_READ_ENC_KEY_SIZE returns a value smaller than what has been
previously stored.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220061
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220063
Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encryption key size on incoming connection")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 24 ++++++++++
 net/bluetooth/hci_event.c        | 76 +++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 965ca1ca841c..57f6175fd1cd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1801,6 +1801,7 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
+u8 *hci_conn_key_enc_size(struct hci_conn *conn);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 				  bdaddr_t *bdaddr, u8 *val, u8 type,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d8f6aaf14703..932175d65a14 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3058,3 +3058,27 @@ int hci_ethtool_ts_info(unsigned int index, int sk_proto,
 	hci_dev_put(hdev);
 	return 0;
 }
+
+u8 *hci_conn_key_enc_size(struct hci_conn *conn)
+{
+	if (conn->type == ACL_LINK) {
+		struct link_key *key;
+
+		key = hci_find_link_key(conn->hdev, &conn->dst);
+		if (!key)
+			return NULL;
+
+		return &key->pin_len;
+	} else if (conn->type == LE_LINK) {
+		struct smp_ltk *ltk;
+
+		ltk = hci_find_ltk(conn->hdev, &conn->dst, conn->dst_type,
+				   conn->role);
+		if (!ltk)
+			return NULL;
+
+		return &ltk->enc_size;
+	}
+
+	return NULL;
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 105d1446c9dc..c2a898eb5086 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -739,10 +739,17 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			   handle);
 		conn->enc_key_size = 0;
 	} else {
+		u8 *key_enc_size = hci_conn_key_enc_size(conn);
+
 		conn->enc_key_size = rp->key_size;
 		status = 0;
 
-		if (conn->enc_key_size < hdev->min_enc_key_size) {
+		/* Attempt to check if the key size is too small or if it has
+		 * been downgraded from the last time it was stored as part of
+		 * the link_key.
+		 */
+		if (conn->enc_key_size < hdev->min_enc_key_size ||
+		    (key_enc_size && conn->enc_key_size < *key_enc_size)) {
 			/* As slave role, the conn->state has been set to
 			 * BT_CONNECTED and l2cap conn req might not be received
 			 * yet, at this moment the l2cap layer almost does
@@ -755,6 +762,13 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
 		}
+
+		/* Update the key encryption size with the connection one */
+		if (key_enc_size && *key_enc_size != conn->enc_key_size) {
+			bt_dev_info(hdev, "key size changed from %u to %u",
+				    *key_enc_size, conn->enc_key_size);
+			*key_enc_size = conn->enc_key_size;
+		}
 	}
 
 	hci_encrypt_cfm(conn, status);
@@ -3065,6 +3079,34 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_read_enc_key_size(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct hci_cp_read_enc_key_size cp;
+	u8 *key_enc_size = hci_conn_key_enc_size(conn);
+
+	if (!read_key_size_capable(hdev)) {
+		conn->enc_key_size = HCI_LINK_KEY_SIZE;
+		return -EOPNOTSUPP;
+	}
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(conn->handle);
+
+	/* If the key enc_size is already known, use it as conn->enc_key_size,
+	 * otherwise use hdev->min_enc_key_size so the likes of
+	 * l2cap_check_enc_key_size don't fail while waiting for
+	 * HCI_OP_READ_ENC_KEY_SIZE response.
+	 */
+	if (key_enc_size && *key_enc_size)
+		conn->enc_key_size = *key_enc_size;
+	else
+		conn->enc_key_size = hdev->min_enc_key_size;
+
+	return hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
+}
+
 static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
@@ -3157,23 +3199,11 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
 		    ev->link_type == ACL_LINK) {
 			struct link_key *key;
-			struct hci_cp_read_enc_key_size cp;
 
 			key = hci_find_link_key(hdev, &ev->bdaddr);
 			if (key) {
 				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
-
-				if (!read_key_size_capable(hdev)) {
-					conn->enc_key_size = HCI_LINK_KEY_SIZE;
-				} else {
-					cp.handle = cpu_to_le16(conn->handle);
-					if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
-							 sizeof(cp), &cp)) {
-						bt_dev_err(hdev, "sending read key size failed");
-						conn->enc_key_size = HCI_LINK_KEY_SIZE;
-					}
-				}
-
+				hci_read_enc_key_size(hdev, conn);
 				hci_encrypt_cfm(conn, ev->status);
 			}
 		}
@@ -3612,24 +3642,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
 	/* Try reading the encryption key size for encrypted ACL links */
 	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
-		struct hci_cp_read_enc_key_size cp;
-
-		/* Only send HCI_Read_Encryption_Key_Size if the
-		 * controller really supports it. If it doesn't, assume
-		 * the default size (16).
-		 */
-		if (!read_key_size_capable(hdev)) {
-			conn->enc_key_size = HCI_LINK_KEY_SIZE;
+		if (hci_read_enc_key_size(hdev, conn))
 			goto notify;
-		}
-
-		cp.handle = cpu_to_le16(conn->handle);
-		if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
-				 sizeof(cp), &cp)) {
-			bt_dev_err(hdev, "sending read key size failed");
-			conn->enc_key_size = HCI_LINK_KEY_SIZE;
-			goto notify;
-		}
 
 		goto unlock;
 	}
-- 
2.49.0

