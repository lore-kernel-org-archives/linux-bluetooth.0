Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C913FEE
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746041095; cv=none; b=ddqsLcCpEB9Eyq4EKZB6ymjezv2SolNJxsvdCQ87nEniBcC8frSrjRccSYKA6yZK4N4eLfv40cWnYMm8qr543GQhIAJMCX2h8ZFFGeEsDWkSIFaarizxbzmgDnRxn1X9to3FCdcGbJRWgazoDyDS+kW6NsMEnw/lJAkK0lACNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746041095; c=relaxed/simple;
	bh=MNhByi6fCaYQnS2ODGHWz6yrokHLf+7YFBJXz92X0Qk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PkFt4tZtKjHOC3m95lSJYAElktXJam6cdyFcoX1yAHaEdwRSxFFN5SJizchdR8R5UgWUOabdaPuXCr1JN/8xNXgZr5p+ylW8p7TPn7GScbc9uETPDRntDRb2Z4NFHCl9zlF5D+zAMRD1e26phD+wgSLue/xtG4VhDq3v3CSvd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdZ4Xw+Z; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdZ4Xw+Z"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-877d7fa49e0so111687241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746041091; x=1746645891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g54equaT2rm1G+MrsALqpoPRTOKLPL4G9mWZr5P8Qqw=;
        b=HdZ4Xw+ZVN4SBUfAVDNIV3WYd4HpZCqABgMUDoAFhhuHz5X0pLwT8xOCZRLEfU5/Ti
         inLsEHprl+BxrloajYM3fk5VZ5jifeltOs/q5BPCuT39XswEPpKNE9JAg4/wmI0vfrof
         2aGUPke6yCj/xdZBI4Ty+3ugaAoo3p589GF+vXic1IGy5deUwfINjBbGMCR4YvlQeN/Q
         PnH3hJt/rAAgSqrh4p6R3+WFGuy7H13/N+sXpXgVwtdsXfRJ2MY0j5WPVm2s8zcuBgJs
         mpyBgfNK35gBhnWfJRsPZoIXX3hZJTKuo3ZP8WKfRD5R80cB6tssy8uQX/9KLsgjHFN1
         g9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746041091; x=1746645891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g54equaT2rm1G+MrsALqpoPRTOKLPL4G9mWZr5P8Qqw=;
        b=WqlpHiLtuZJGSI0EfQQ9IWy8RwzxLU8Th7X9TifhdwTELMvnPxgo5InIZFa7Ived2H
         W18y6gz1WX4/uorNvkUw/OFBK+oGLgs1CbUfDR8y2LFvvsjwCI0AAfnG8VHDM49kVSkr
         5bcuRe7jLCEEwFmSCD/64pIT9/zaXgfyKvUzQkxOS/o9OLo8H/qr8r9FbH7SU7+0KuJr
         5ErwKjMCIxdv8pqwe6y3UovkgkPPCU7vYvO6XWEXiX7/B46sdTL6pTqAng7Q2j3c9AN6
         C/YboPegLWochH8IrrxjPGW5XAiqQOhrSSX9/WNGwYZk5xuehhkebgpqf6TkKBvFA1TG
         rnuA==
X-Gm-Message-State: AOJu0YwC4S54zPomrdssJTnl8UpkuqCh/aKXFDXXq5I94VW2ByAyRWaT
	4f8Iuw6nhYdC6zfLOh7Wy7sGU4BhZldM0jBZAWj4VxDdMNGDE9YicsUDUw==
X-Gm-Gg: ASbGncsX7JPry2aA0OAvc0I701qdSgFBNYhDHRZz0JNP5psdw95TTOzXbTOsOgafmQc
	DpiKnerycONZH1v2WSPsTweuJ7Ke/ytOudnsqVZNN1XmK9X52Xvoi3gJf52Y1CBi4jBgJ6WetsF
	RkDi76ZyxrRIiIPUlevNifOmQoQpbSC3sT99IP7w0QSrFcGTGoIkr81n1IC+VjnxPNCSdZ+yQ2q
	X6W12S3i8fU5cwjjJ9zJFFLDrJCRbyFiO3APkNP0oMP+oy5zKHfz0urT3v41st6ASRngovgCjYq
	FiGW4ygA2M48Xkp7bq0oUHfBX3zwEKhSu0KfXcCVraS/xBbQNhD/2DFH6yR1Y9zJTasdUDzVdZ+
	e6D7/qxFLKg==
X-Google-Smtp-Source: AGHT+IGlFrFTsRKOUhn6fVTbKU/cc63EgPY7HrlyL8SdqQEiz6ySGNoPP7Df9G/CUiocmby6hS2FdA==
X-Received: by 2002:a05:6122:88f:b0:520:5185:1c71 with SMTP id 71dfb90a1353d-52acd845a85mr3722597e0c.7.1746041091324;
        Wed, 30 Apr 2025 12:24:51 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ace389eb7sm428074e0c.21.2025.04.30.12.24.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:24:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix not using key encryption size when its known
Date: Wed, 30 Apr 2025 15:24:48 -0400
Message-ID: <20250430192448.2386611-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the key encryption size is known, due previously reading it using
HCI_OP_READ_ENC_KEY_SIZE, then store it as part of link_key/smp_ltk
structures so the next time the encryption is changed their values are
used as conn->enc_key_size thus avoiding the racing against
HCI_OP_READ_ENC_KEY_SIZE.

Now that the enc_size is stored as part of key the information the code
then attempts to check that there is no downgrade of security if
HCI_OP_READ_ENC_KEY_SIZE returns a value smaller than what has been
previously stored.

Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encryption key size on incoming connection")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +
 net/bluetooth/hci_conn.c         | 24 ++++++++++
 net/bluetooth/hci_event.c        | 75 +++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 965ca1ca841c..683e9de1180c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -221,6 +221,7 @@ struct link_key {
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
+	u8 enc_size;
 };
 
 struct oob_data {
@@ -1801,6 +1802,7 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
+u8 *hci_conn_key_enc_size(struct hci_conn *conn);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 				  bdaddr_t *bdaddr, u8 *val, u8 type,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d8f6aaf14703..364de56ae7fb 100644
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
+		return &key->enc_size;
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
index 105d1446c9dc..71f0c5650b8d 100644
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
+		 * been donwgraded from the last time it was stored as part of
+		 * the link_key.
+		 */
+		if (conn->enc_key_size < hdev->min_enc_key_size ||
+		    (key_enc_size && conn->enc_key_size < *key_enc_size)) {
 			/* As slave role, the conn->state has been set to
 			 * BT_CONNECTED and l2cap conn req might not be received
 			 * yet, at this moment the l2cap layer almost does
@@ -755,6 +762,10 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
 		}
+
+		/* Update the key encryption size with the connection one */
+		if (key_enc_size && *key_enc_size != conn->enc_key_size)
+			*key_enc_size = conn->enc_key_size;
 	}
 
 	hci_encrypt_cfm(conn, status);
@@ -3065,6 +3076,36 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_read_enc_key_size(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct hci_cp_read_enc_key_size cp;
+	u8 *key_enc_size = hci_conn_key_enc_size(conn);
+	int err;
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
+	/* If the key enc_size is already known, use it as conn->enc_key_size */
+	if (key_enc_size && *key_enc_size)
+		conn->enc_key_size = *key_enc_size;
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
+	if (err) {
+		bt_dev_err(hdev, "sending read key size failed");
+		if (!conn->enc_key_size)
+			conn->enc_key_size = HCI_LINK_KEY_SIZE;
+	}
+
+	return err;
+}
+
 static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
@@ -3157,23 +3198,11 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
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
@@ -3612,24 +3641,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
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

