Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18330285419
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505684; cv=none; b=U3ghYDTJ+0Dd5DdX9gb9vjQ3PFGczqQH313wOJF2HVviqKCxYvzyod1oAS195Hl2XMcEdhVt8pUt4A/NZ8CGVyKii3K3zQVqvPRYLsCuPfIvK3et3UsYnpAkvsBBcdi2xzcbmXKEChYqKaSAY58sBKkTug6E98sYcNvH9ufx1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505684; c=relaxed/simple;
	bh=Hs8Xqj9RVXgUNIqKATxwzsRSQmVtqnVbrf41v97H1UM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+Mg/nGzrsfvtcrYUMqzUeGNIdav8jdFhU6Dwdo9zU5eHzFZ6v7l5C3LSUKvmUiRMjlyfGty/XpB9LntHD3BMpavX4CTbYFtVDJGx2ekt3EinK9jd3FqyHqttBnk3e6B3oh0dvCcM++HBbMHZxrmpSgUPJnAVCsMa+ltu0377JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsAS7uPT; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsAS7uPT"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-890190c7912so1070151241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759505681; x=1760110481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GKtOen/U31mWvc4u/3KF3C/k545S/UQBOVM7GbAI/M=;
        b=NsAS7uPTXNi6efuim+oDd7IMiJcAl8cnsalJNRw0bHT9oKS0LfJHUIM9pdgVoFcbvZ
         YHb1K7NYzUiQBkZUPFp6ggDe33vC6fFcmI4zOVMZVoeN1hUsOTB1/bqHDhpvxEM1YkVd
         jtNsJVg9LGA8lWtBNDvuTYmbUn54lwq7ZCNl6X/B1ot9xwaVzXlPHrJcu201rFTu2Oh8
         OAqC106jy/vRIkN+JVI9eQJ0pBmdPcNmbMBFZO3rJSckhkig5htO1DR6uTOMM7MogXF4
         J/oGlHbmMt6bSgP+JFycg33K8LJtdO0IbXW/HpkPu2jjVcLLk5P1DqUqxkq6dNhRsdFh
         wbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759505681; x=1760110481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GKtOen/U31mWvc4u/3KF3C/k545S/UQBOVM7GbAI/M=;
        b=VanyzOIgps7eWMqwQBAl2WsXgBngsPztzB9W2mqjeNe/O4sibwe8A00soVf4eWPWSF
         IZLp/3X/Urm1QEYVJQSISPv9v2vBluAGLQVYGmcIsypBXdOW3n8+cC9TGyHLK0SLnQFI
         KP7Ba9X5Im7tYfJQumHLOrHqdRRWY/m2sw8gdD63x+MWE2OnV9QIABbm7Mp8OUjV/AR/
         zec+oyEMIcupw6yuC1esmUZUvWbl8FsKiotFx5YLIrD8fL3fzOJ5XyOG+nPBEjfyRhul
         oQCoMUJda+1Od4zl4VZMo3oQ9XfBXokXH8WvNQD0kvURqWSLiuGSkfp3tV8OO+/owQPl
         Bh0g==
X-Gm-Message-State: AOJu0YxSzptacU/Wa4oS9YinK/kWZhtcoCoRF7LAsprnEEtBU8vxdKSM
	TE2MZkUBLFjer7W1CjkIun93TjVojVwLj1BwQiLSFP3CrKsr256s9rBjeGaLGo+o
X-Gm-Gg: ASbGncs0qinOXexF34OxbsDPcxBABayWrzXOMYS3z+qYFV1+/QUvhxTZicxmaX3u/+v
	qxXydWV7DYKSHbCSPb9RyNyPABoPWCTR6/2+oczVkZyho5CtqS4Z8QwHQJOScr/4ZPM+TfhcuhH
	LZykFUbqQNL+wm67g90Fz7PCIPYFYZ1ZdR1ubMazyy18hEWqMHii/eKjOFGw5WGLM0AEnrnR7tv
	n812uU3j/KeGe10w5XFJwN7LEwXtx1ICwg5zz+Hyt5hnwi4Vz7314wAjiq0UOvvkJGj+Kyy6HUZ
	tgBGyZ+qeOSQKlHqtvHP3n5hjUxI6mceGEgbFZW7QIToaTp58agTWE5MN0cIjrqADU3KCEFVs9j
	az7MM0kWKOlwSv3ccYlEJesYqrqIHlVdCMojGOwpVis4MS4HgOrY5yJt0ihM8QbmBbCee4VeiiY
	Y3xg9giHPr8NfIxg==
X-Google-Smtp-Source: AGHT+IGgRXzTFu9AFxGy6QVg1p5cI4hXnTPUKXHrYWQgRdOZYuK0PMXuY9IHZaDSzbcJyOwR9CM2TA==
X-Received: by 2002:a05:6102:50a4:b0:523:b5c8:2b0b with SMTP id ada2fe7eead31-5d41d047c2emr1383723137.12.1759505681249;
        Fri, 03 Oct 2025 08:34:41 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb67dec87sm994090241.11.2025.10.03.08.34.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:34:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/5] Bluetooth: ISO: Add support to bind to trigger PAST
Date: Fri,  3 Oct 2025 11:34:22 -0400
Message-ID: <20251003153424.470938-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003153424.470938-1-luiz.dentz@gmail.com>
References: <20251003153424.470938-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to bind to a different destination address
after being connected (BT_CONNECTED, BT_CONNECT2) which then triggers
PAST Sender proceedure to transfer the PA Sync to the destination
address.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         | 74 ++++++++++++++++++++++++++++++++
 net/bluetooth/iso.c              | 62 ++++++++++++++++++--------
 3 files changed, 120 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index e352a4e0ef8d..3133f40fa9f9 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -188,3 +188,4 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5051413f1a97..aad9689af610 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7228,3 +7228,77 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
 				       create_big_complete);
 }
+
+struct past_data {
+	struct hci_conn *conn;
+	struct hci_conn *le;
+};
+
+static void past_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct past_data *past = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	kfree(past);
+}
+
+static int hci_le_past_set_info_sync(struct hci_dev *hdev, void *data)
+{
+	struct past_data *past = data;
+	struct hci_cp_le_past_set_info cp;
+
+	if (!hci_conn_valid(hdev, past->conn) ||
+	    !hci_conn_valid(hdev, past->le))
+		return -ECANCELED;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = past->le->handle;
+	cp.adv_handle = past->conn->iso_qos.bcast.bis;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST_SET_INFO,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_past_sync(struct hci_dev *hdev, void *data)
+{
+	struct past_data *past = data;
+	struct hci_cp_le_past cp;
+
+	if (!hci_conn_valid(hdev, past->conn) ||
+	    !hci_conn_valid(hdev, past->le))
+		return -ECANCELED;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = past->le->handle;
+	cp.sync_handle = cpu_to_le16(past->conn->sync_handle);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
+{
+	struct past_data *data;
+
+	if (conn->type != BIS_LINK && conn->type != PA_LINK)
+		return -EINVAL;
+
+	if (!past_sender_capable(conn->hdev))
+		return -EOPNOTSUPP;
+
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->conn = conn;
+	data->le = le;
+
+	if (conn->role == HCI_ROLE_MASTER)
+		return hci_cmd_sync_queue_once(conn->hdev,
+					       hci_le_past_set_info_sync, data,
+					       past_complete);
+
+	return hci_cmd_sync_queue_once(conn->hdev, hci_le_past_sync, data,
+					       past_complete);
+}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7f66f287c14e..318b5b914cc4 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -987,20 +987,13 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 	return 0;
 }
 
-static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
+static int iso_sock_rebind_bis(struct sock *sk, struct sockaddr_iso *sa,
 			       int addr_len)
 {
 	int err = 0;
 
-	if (sk->sk_type != SOCK_SEQPACKET) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	if (addr_len != sizeof(*sa) + sizeof(*sa->iso_bc)) {
-		err = -EINVAL;
-		goto done;
-	}
+	if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
+		return -EBADFD;
 
 	if (sa->iso_bc->bc_num_bis > ISO_MAX_NUM_BIS) {
 		err = -EINVAL;
@@ -1023,6 +1016,42 @@ static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
 	return err;
 }
 
+static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
+			      int addr_len)
+{
+	struct hci_conn *le;
+
+	if (sk->sk_type != SOCK_SEQPACKET)
+		return -EINVAL;
+
+	/* Check if it is really a Broadcast address being requested */
+	if (addr_len != sizeof(*sa) + sizeof(*sa->iso_bc))
+		return -EINVAL;
+
+	/* Check if the address hasn't changed then perhaps only the number of
+	 * bis has changed.
+	 */
+	if (!bacmp(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr) ||
+	    !bacmp(&sa->iso_bc->bc_bdaddr, BDADDR_ANY))
+		return iso_sock_rebind_bis(sk, sa, addr_len);
+
+	/* Check if the address type is of LE type */
+	if (!bdaddr_type_is_le(sa->iso_bc->bc_bdaddr_type))
+		return -EINVAL;
+
+	/* Lookup existing LE connection to rebind to */
+	le = hci_conn_hash_lookup_le(iso_pi(sk)->conn->hcon->hdev,
+				     &sa->iso_bc->bc_bdaddr,
+				     le_addr_type(sa->iso_bc->bc_bdaddr_type));
+	if (!le)
+		return -EINVAL;
+
+	BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bc->bc_bdaddr,
+	       sa->iso_bc->bc_bdaddr_type);
+
+	return hci_past_sync(iso_pi(sk)->conn->hcon, le);
+}
+
 static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -1038,13 +1067,12 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 	lock_sock(sk);
 
-	/* Allow the user to bind a PA sync socket to a number
-	 * of BISes to sync to.
-	 */
-	if ((sk->sk_state == BT_CONNECT2 ||
-	     sk->sk_state == BT_CONNECTED) &&
-	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
-		err = iso_sock_bind_pa_sk(sk, sa, addr_len);
+	if ((sk->sk_state == BT_CONNECT2 || sk->sk_state == BT_CONNECTED) &&
+	    addr_len > sizeof(*sa)) {
+		/* Allow the user to rebind to a different address using
+		 * PAST procedures.
+		 */
+		err = iso_sock_rebind_bc(sk, sa, addr_len);
 		goto done;
 	}
 
-- 
2.51.0

