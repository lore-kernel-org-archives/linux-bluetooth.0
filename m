Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273591EB1A7
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746217259; cv=none; b=gF1FoOmsVVw94JD5q7I7UWWjw24RkkWXLVOan2gAbrQ+vYlEG+GIn9foNjeqOmhxr/TmgicGFJPmYTJNPMDPsHiJ6yGrEM9v5dG8IhGdDLrWbuBuB9oR1DFm85WZyxaYI+DUZtgW7xJqYgXUBpLtDkTRNNAbDSQd44FiHRZdwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746217259; c=relaxed/simple;
	bh=FbzrTW0WoCwTs2GSMo/RbzOW/CUkrncdmDVeey0YfIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O3k/E9ALl1ghB6kvCmjabE5+6HFYwdZsKfe3g3oFHEYvo/kxbtP+D9EAF67X455pHWaHs7JTv2F6N6NvpbVGB5EBSgeMSYKsz/5KKs2+cME7tUcxKSGuKhPGdsdr5YSuO5O3tIg4H3QT0X8OHUnD9UVGylVVYf3doJpg+k5sn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVQ1yQ4l; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVQ1yQ4l"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86feb848764so601717241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746217256; x=1746822056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEVSHXko+1XngstRY9lx2wSpVUEBUVZSpw5K56hJ0X8=;
        b=cVQ1yQ4ll5nkkLGFvUoQ2N2htaTb64rKeO8h+paYeQEQUMQ1wn1x9IquONH3uiePpX
         EesaCUKLjvxrXdfuzdDDC1gon8vmKWabIIKOoMomqEqY2fUGH4cCewDuwoTaIANsVsQu
         Fvs+oofyKN+fYuGJhLE1iP4zuhejs0G2AIB1cxwL6PJFjiWGLDe8ma2SlUuE1hyQdr/W
         Z7JmWQVwyQ3ymK5wS7fq+ZtCiS70XQNMYKA7XgMZEUE3Il2TgZ6HPwpt78umLWTRTSNT
         Kh4W7tUnKY4MK5mtc2Yn7/5yoEW4rwXpkfsp85WhpflabVMu7SlmcJfRjbBDHKcId9PB
         1jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746217256; x=1746822056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEVSHXko+1XngstRY9lx2wSpVUEBUVZSpw5K56hJ0X8=;
        b=Yu97uNrtXoFh1wI95wehFnf5jvjd2124avR+8q0wsH/6KtH2VQXpYOoXY17Cp+/B7R
         prAmefGlqXgaKB62nPS02JPIA5CfNe91pviBKc1jQjiKMOtJf00Ee3Xz0IThhg9bXpfC
         1wTm8y64lanDLDD13m7G60SvbIWNOP0DEquFZ0T2C8DtP6bkspH4feyJxkCeejNtHpku
         FVDXBpH+/7LRCIqRZugTdnsh1cVln6p6J8AobLnT/+XVmmA1fvujpQiDhqfFgozy3J1P
         FT/ewOclp8SpVsu/aPySgsAgj0uqSUMObmaQMOaIFuvXkz7iAByawURb3PQLxQ9XNzjQ
         sudQ==
X-Gm-Message-State: AOJu0YxUjg5RN8gX3lG0oZGMmmEKGBUoyMvHLqL+KWqF7trxNrWkWvCD
	WdlkG2KYCfNVv1NWR32syG0ATNp27GTPrRU+7fPP5mURYKZVw+QBU+JD15jxE/c=
X-Gm-Gg: ASbGncthUS5Vn3fI4QarHD5k7LwF73nkLJl39jr/R+avHT4pJ1BkG8jnmDbWtmqI/hO
	e1z3UpoDjmkObX48gGgrzzBGz50AlkbpL9jyeGZmFdbPu8AUTKBHOeZZN3lDVI5/+gFMgZAJ/54
	J/ofWyUhipryC04t4rScw9qxtUofgjt+EHcUbobe43PBBsVpBx+tDr5BsxlnHEtMQJ0guilMl9Q
	S5e6y2D19BKX7BPSdb1XbrSBh/Ow2gDa3QbuRXuYvNiHIfZKR+XNM4JTQFUbZKV34kOVljI2tIR
	FoN093ja2AiXDmTI9ti/IBOFnzkoWWB9yfcjHbO1E7e4IhslyfWvcheKa7r4ErDhp9SwSC5azi+
	Vhr2KTySsNQ==
X-Google-Smtp-Source: AGHT+IFrlgGlpOZOG+vmyd/aqIvnR8Nf7tZjqRVswcseuDJl+I50L80NYO7kGptx5tiLlx1Ig0+PLQ==
X-Received: by 2002:a05:6102:1589:b0:4b2:c391:7d16 with SMTP id ada2fe7eead31-4dafb5027e5mr3096431137.7.1746217256204;
        Fri, 02 May 2025 13:20:56 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4daf26722ffsm547577137.28.2025.05.02.13.20.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:20:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_event: Fix not using key encryption size when its known
Date: Fri,  2 May 2025 16:20:52 -0400
Message-ID: <20250502202052.2802441-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h |  2 +
 net/bluetooth/hci_conn.c         | 24 +++++++++++
 net/bluetooth/hci_event.c        | 74 +++++++++++++++++++-------------
 3 files changed, 69 insertions(+), 31 deletions(-)

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
index 105d1446c9dc..f74d66146a2c 100644
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
@@ -3065,6 +3076,35 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, void *edata,
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
@@ -3157,23 +3197,11 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
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
@@ -3612,24 +3640,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
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

