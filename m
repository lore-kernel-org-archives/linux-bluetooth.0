Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883E1E1A05
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746108748; cv=none; b=StdFHV8gP8L+UL3TVa600WWphIAKu+s1j9c7GjOAnz0DmYzH+nchU66KXgAxA/fc1ZW708vrU2J+5/5JbYE1NmOQB+zRqWMIUzTaGoHsRFQNCeNVHDno3ZpBuTunR8iEkjjJIcKT34GoKKmmsojex6IA9PFvLgr6cEaumw8zrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746108748; c=relaxed/simple;
	bh=vNYfQyAJMqItDHzKYUq6FzgP+vJYV8e1Ngrn6Q/uHUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gDhoMxi+oywqM7iSXQG+rPy+2I5nN0X12osi56XTTWuu0zqPxJL5XPOb+zgV9UuXpXm3RDxuPdEWYueJMNq/wiBjXkHgFZ8L2/0KwuS8IlpQAFNc5ShjH80LISOQESvOa7zRgqjlhnHdAwFtk3vWuouO2Rw2piE3BY6wj6xLr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqNYl8KB; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqNYl8KB"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-877d7fa49e0so785651241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 May 2025 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746108745; x=1746713545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKfCSXnn42egHhv4X8P2AUcgZQf8+IjAD8+3geDov9w=;
        b=BqNYl8KBnuD86jl5kx12wT4c6kIuhlCxPLv29KRbj8wK/5l0H9YSfYpyfOnjFgN8Lu
         ffdAojrSEgY6BW2mIG8RSS+LUl1reojjiOaWpvDHYm9eVj+87HIoOMAZOhJJonVezpcZ
         ZiWu/aNNWWPa9MJPziiIeLljeb6MhVqOqOEeI/SfY0KPaLcuj74jHJWkOPZNUx6zWrxZ
         jSjXAG2X+xvUgwvdc48A4VUw/muGI8din+Yu1DyyiLgQQ/EbjYqTysqA3dfqb/58aSGn
         iNVwA1575i6Fe3xE0IPlSRc3oO573jTqaw0DlXb1shHHIjpQkU6kneGJjlYdqnRaER+Y
         7IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746108745; x=1746713545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKfCSXnn42egHhv4X8P2AUcgZQf8+IjAD8+3geDov9w=;
        b=NkLLlQu7G2+8DihLkfZpiNywEsZ1R58cPOyMbWacXVIxuUGK+Ujq2TgBJsCu9RW/hi
         Y9NWcCUyezHlv0/zDSPykQKRB9Nb/PLDSiNzclCMK8bmhSsq4wIH+5OcznZA84Ycu4j/
         TO0/zW/VNLsdAUsRyP7QMvsnyOpBwaY5ys/l0srKDC/W9hJW0hNNrOxg6/pgiYB/RQxg
         wZ0qzFDSspBU5hzeQLqoalUO1xPe3SXt/u+ok9xdr6IVcV8jd7/D7Cgqw2VhS6ZdgmbT
         7dn9TdzyAH9fS3EzFHsgGMJbRoxbnRUxDkYQmG2Q6cONm52vkQZ6omuazkK82l87eDap
         M3Pw==
X-Gm-Message-State: AOJu0YyTUDCDbfIOdGOre5HiZo3FfAldv+RiOdulsbv4QbRnNTD4BR3N
	wZmJR16f21BMlAGPaYWRJv7XImd7+OhA9pQmciQ/Wb+827cMDcgu2W7nx6q5TEs=
X-Gm-Gg: ASbGncvILItracrcfdqN+3yBsdOYAhVrPGHJ3gm2PgePepzkGatFPayyAPa8oR0jzQo
	xBHKT/r+2qhIcxE9W55n9ok6ugo9udGYimeojmX0jSYAUkgvZYDmgovKkyxl1InXVdui3R/oD8X
	7tLq2ZG0aT2FicNrvz5HRyDbb3jXQGEnaStfv556GBWDhZehYvdSNbDGw6eGaOZiGReKvYNckqJ
	ntxLdugFEPNP3eZgWbmjL7aWcpP+shoJNF6uHvm4HNb9CM57oby2hs/mgWUJWQ8J8/nqK227lYN
	MGj8+FmcWuhHvXt0AC1G5cJbSvIi7mi0SV5GQQnsGzUSLqvTQpKKJnDMzX5GL3UZbzGc5kCv0wS
	xcO6tLTadjb68AhiE9dZL
X-Google-Smtp-Source: AGHT+IFFJU7fMThPZrInZOmEMqfm6roseiDdrpfLSGV8oEKGs0vqPM12JYtDkhq26QCUVnG+OEn7YA==
X-Received: by 2002:a05:6122:d04:b0:526:2356:f3fb with SMTP id 71dfb90a1353d-52ade3bd577mr1662043e0c.11.1746108745003;
        Thu, 01 May 2025 07:12:25 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae3ff5f5esm118288e0c.4.2025.05.01.07.12.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:12:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: Fix not using key encryption size when its known
Date: Thu,  1 May 2025 10:12:22 -0400
Message-ID: <20250501141222.2498357-1-luiz.dentz@gmail.com>
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
index 105d1446c9dc..2a4907d45e26 100644
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

