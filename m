Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243D2E093E
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848590; cv=none; b=gvz8H8gH8H05kG4WDUuA2fCNq/rhJuRBMesOt1AjckoCBhwhd0w+gsK4aBzzGdUyxo4wDnvWu+BWsxUYh8/wAvKGgJWXGimaUXc2VJYQsJK0x1pM41bT3wN4epPHLhiBz5uDlzIz9avxBFrVbRNKPnDqXwwmjukTC7Jr85wVjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848590; c=relaxed/simple;
	bh=fyEj2tf22rBV6T6GeVYaXHmmVR7Cl31rxsuyaVhcRMc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtfUjFArQsukx1uWR7i+R0lB/uT4m0zyn+BdPEGj3mGbhW+LRiWFZyZK809Zb8bYyx0G1E3LZstCewI/pk3OYMN45WsR/GGGi2iNm6kczVqnlrwtu7ZZZdaSNz9QJNBE5NIkJ3Ui4t+eQGOqT3HUqnHGzQ+S95JGgA8SAUCpdSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh0x3ErV; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh0x3ErV"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-554a7e98e19so991596e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848587; x=1760453387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5NHy9y2k+KRozjJQda3yOXEIaEz41kfZfELlQm6r0Q=;
        b=dh0x3ErVY9GJDmcDnr0J8REpRQFJEU7TBU1GNcUwe1NrVSnPLp9SHUB9t2i1tsIF00
         iTlTFFFq8OwsNcmmqQRS0EjIrVOhn9G72/lvaxcc+yVmzn7ZjEO/PJ7aOi1Vz+LD/O9G
         KZyyQgCjVrEITkpE3/1pqaOjMHUK2Jb4vhQUpECtG0sF1rOXFDnuCavdhqssGi8WnvGL
         QfiPs53fq4bBH5lr1DqlxjFHY6ew8W0AhYBmM7ua5ifBAmNkVxjACOcY/nl8J3BUL2Ru
         G4XsZlIa+8QZkpmgTH0ybHuzQPbsjs69MN+73p5Filz/uxZyyzW4De1z5Q1DdTF8TB82
         y39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848587; x=1760453387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5NHy9y2k+KRozjJQda3yOXEIaEz41kfZfELlQm6r0Q=;
        b=Ufocd09DbiSfe+Mcl4Zzx3++GMTdbDekzVcYU1atjgbgMwMcYXEybMBn4hpfWsdqIY
         atG1r5IwZcy0JyKb2uiB3tCtNS6uESbRQu3mzPNOQQe4MS8a0aPtdsIDJVvzR48m9PFt
         t8txpgik66QKYJvTINu/2Oqj6QbVZ8ImdtXrfIMsy4/RQEN2jmbttCfJX2lZMi1h6gpo
         rXfZhk6fUfKZCwVIN1docBwqaTp/pSE0fU/1LX1x91qlcBu4x7lbFS6VA5tcbf3Lgto9
         Lr9jJky8TcFOA1zi4oWGdYE02PXtJqRH58b6MCOXXcmDbQycTexjWhFDp8IsDOycjzVO
         qdNg==
X-Gm-Message-State: AOJu0YxBMIVq9OzAl9snX8lmkKruq0PvHGMq5YLEX02dCCXvZEgmD5Eg
	RSMqm8hYDDcOG+ZHbFoqvyVZop4Oog9zqNlQ3u50r1YyQkatWoEtL7WcmuLozA==
X-Gm-Gg: ASbGncsP2uOsSfaa87m1cFBp74C4xeN3o+x3I8vcVsJkO2DSR+D40rgOGt74M5QVgg1
	/QSn+A9TrthVASPhp5XdjUs2owBcV1aW4IMtqMraeXUQnCRK59boBUryx7Q5ENSBOMTkCmSaRBb
	L5rtnx99pe1Z3vRAdz1Qj8jptll//hvr6AyDjAErLuAZ6xIIxdCNEvb1Ludw1sOyK1kzMovfSX9
	jSllHXT603t+J4QtjDlOBXyUOv0OHdOcGATpFBRj5sYkJgVAPgYksNJNV6q9DbAHMOamKyRCRGG
	nRxu3cusiOT34ugxIkVr9jeUHahxEWKKcWDqYkhFNe1rJjrdKh9nhw/S2xEiDWu7R/GOaZu6vE0
	N065E5srEMS6Tev+0/XJKuc1n5lgr3wTrA9GcrJI8zWQjfwMpEs3/tDbTxXQh3HIUXDrl73XBnf
	moD+0LG79eAP4ZoA==
X-Google-Smtp-Source: AGHT+IHVHSGgMX/YV8LSLWvvbpL5fqGDV5OlWPrqLAsGYiLWlsuCjGcAyEqsAnJIIQbG8JrXSeNdpg==
X-Received: by 2002:a05:6122:32c5:b0:535:e35d:49f4 with SMTP id 71dfb90a1353d-5524ea2702fmr6397744e0c.11.1759848586790;
        Tue, 07 Oct 2025 07:49:46 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce64af0sm3731864e0c.8.2025.10.07.07.49.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:49:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/7] Bluetooth: ISO: Add support to bind to trigger PAST
Date: Tue,  7 Oct 2025 10:49:26 -0400
Message-ID: <20251007144930.1378274-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007144930.1378274-1-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c         | 90 ++++++++++++++++++++++++++++++++
 net/bluetooth/iso.c              | 80 +++++++++++++++++++++-------
 3 files changed, 153 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index e352a4e0ef8d..3133f40fa9f9 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -188,3 +188,4 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5051413f1a97..571e07f81523 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7228,3 +7228,93 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
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
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, past->conn) ||
+	    !hci_conn_valid(hdev, past->le)) {
+		hci_dev_unlock(hdev);
+		return -ECANCELED;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(past->le->handle);
+	cp.adv_handle = past->conn->iso_qos.bcast.bis;
+
+	hci_dev_unlock(hdev);
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
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, past->conn) ||
+	    !hci_conn_valid(hdev, past->le))
+		return -ECANCELED;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = past->le->handle;
+	cp.sync_handle = cpu_to_le16(past->conn->sync_handle);
+
+	hci_dev_unlock(hdev);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
+{
+	struct past_data *data;
+	int err;
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
+		err = hci_cmd_sync_queue_once(conn->hdev,
+					      hci_le_past_set_info_sync, data,
+					      past_complete);
+	else
+		err = hci_cmd_sync_queue_once(conn->hdev, hci_le_past_sync,
+					      data, past_complete);
+
+	if (err)
+		kfree(data);
+
+	return err;
+}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7f66f287c14e..d4c8772152bd 100644
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
@@ -1023,6 +1016,58 @@ static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
 	return err;
 }
 
+static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
+			      int addr_len)
+{
+	struct hci_conn *bis;
+	struct hci_conn *le;
+	int err;
+
+	if (sk->sk_type != SOCK_SEQPACKET || !iso_pi(sk)->conn)
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
+	iso_conn_lock(iso_pi(sk)->conn);
+	bis = iso_pi(sk)->conn->hcon;
+	iso_conn_unlock(iso_pi(sk)->conn);
+
+	if (!bis)
+		return -EINVAL;
+
+	hci_dev_lock(bis->hdev);
+
+	/* Lookup existing LE connection to rebind to */
+	le = hci_conn_hash_lookup_le(bis->hdev, &sa->iso_bc->bc_bdaddr,
+				     le_addr_type(sa->iso_bc->bc_bdaddr_type));
+	if (!le) {
+		hci_dev_unlock(bis->hdev);
+		return -EINVAL;
+	}
+
+	BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bc->bc_bdaddr,
+	       sa->iso_bc->bc_bdaddr_type);
+
+	err = hci_past_sync(bis, le);
+
+	hci_dev_unlock(bis->hdev);
+
+	return err;
+}
+
 static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -1038,14 +1083,13 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 
 	lock_sock(sk);
 
-	/* Allow the user to bind a PA sync socket to a number
-	 * of BISes to sync to.
-	 */
-	if ((sk->sk_state == BT_CONNECT2 ||
-	     sk->sk_state == BT_CONNECTED) &&
-	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
-		err = iso_sock_bind_pa_sk(sk, sa, addr_len);
-		goto done;
+	if ((sk->sk_state == BT_CONNECT2 || sk->sk_state == BT_CONNECTED) &&
+	    addr_len > sizeof(*sa)) {
+		release_sock(sk);
+		/* Allow the user to rebind to a different address using
+		 * PAST procedures.
+		 */
+		return iso_sock_rebind_bc(sk, sa, addr_len);
 	}
 
 	if (sk->sk_state != BT_OPEN) {
-- 
2.51.0

