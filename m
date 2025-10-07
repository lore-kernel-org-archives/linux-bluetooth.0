Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3A258CFA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876335; cv=none; b=j07njd1Vwb5VV08qdvSSy+EKKlEQYSBz8m5iWsrM7rR8+jYrbLK8IEbcab8OlzAZaFkJ74DZmlmcvsVAk8AQxdKCb5oilqZ8tawK6VbR88F9/S39Ilmtwc2Krow+VPdvio8viOYPrXCiAi432+T+ZFAkRV9XFxx9s7iUjTjuesk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876335; c=relaxed/simple;
	bh=qfRY3T01fnEJn4kjZmdH/yBD007VcOt6OyQUJeGH8+c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhaCekWRx5KSTu3QMCGnnLa5nZGwjT0HUpvf4jy+QxKYf7DG2G8j4dgZa5T0mbMQ91NTJLaNBa/SlAkoZh2CIBabQyPzxVMVVHii5/xYWNHOTiAuKjHudjNwL0pZV74VEYHrCqduibsOQkjRVFe99jQVHTipiLv5k9EsydjaD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVytbRQ/; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVytbRQ/"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-59f64abbb61so3263541137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876332; x=1760481132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+V/LGDjOM0ogNDbvlGiGgsWDehcL4uv2z/34iy5bZo=;
        b=ZVytbRQ/x6kjPx1wPn/OpgoT4QQjz6GrhtlhtbNEyh2toSaeVvQZzT8038oC/rHEjH
         qQW7SMP5Ur2LoOXDx8euCkjEJi57uyA1wRepirkTcPJFRoAWoXmh0OSceMqXulL6RRvm
         i6iLmnES/IiWo1Y2TYZMXtXx+ctIDmQd6wPLQoQC9zu7fslxTQPRwtkoyPVoVTOk+OfX
         v8ssmDzipDODt2Y0UIsOYjNBKQQUP+cxIFB30taQESzs4RGEvSVGU/LTSVBTPN8xKI97
         f94t/uMVCHVcu8gz8OTPcmzX3jPIs1mWETpWp7rH2/lZg/b4pOIsn3E5kEPu/KC0PPXN
         wV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876332; x=1760481132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+V/LGDjOM0ogNDbvlGiGgsWDehcL4uv2z/34iy5bZo=;
        b=WB3DVfK/s9NHR8gIckFjhHCSH+0IpdvMmVsXvkoyIWxg+qXAyyAMxB+5KzA8cy6Uub
         eLp6nmSvUo+72WKslMElkea4kaS654D+2saM0MQ+NxQT4kdAuelyQ3WbWQkXLtq2LNEK
         t/L2fuUKAp8X9T5l4hBRi5iloXOl2aoJMcjgNIiZB7si1GrRwNORjp7bj+O8oeMRraGC
         zFSK8dZvkJ+xpJbH42pIgLZq87RYjUivNpXK1CTW6pHSYm1aGsAKkUNl0T1jhk+oJyNl
         +J1yWDl0wd4kn1d3B3B4O8p27KfE7QW1cr0bZkfjYLM8UDj4i5W0OPUmeHhtvPS1tURm
         Mspg==
X-Gm-Message-State: AOJu0YyYuvZjOnpAErf2alGgA7NWvgkb76a8x0r+uFTvJ5qEem8erOEQ
	+Q8iMHNXJD3vSCTyZYG565gYaUj+zHhqVuKBxKDxClqBhnLS/vIzGjKujP2F+XsA
X-Gm-Gg: ASbGncupl7JaANJaAa6zSQlMK/DCfCSgHSiQknTBeKpyu0LM/uqHvsD2KPtgLHGviuJ
	rb5hJWLpPacyQb/H7H92GstxtHKVCE9fg5qqmjaIx0pYGuNcQiLYz7GQI6FhNMZI+xQ+yxnczUG
	qmU3NVTbbNp5Jy1YMwJrHamSl5MBPdp9yfdW5U7fg1Yk5M8VhW6646BxeW+MUdA+mXm03D7eiT5
	O2/mluupTVsWfOszz+gizNAuFA0Wf5QVg86RS7/in2pgkmta6O0AulgR8TZcOnuPD2rauLQUup8
	7Kw0jKuOVS6Zgs53jIz7Y1qtBZxOMDoi2s4c32sLZMELSc4p/O3SlClF7u7gUYp0W2HQmwl9TTU
	J9oMsOJvYqxJ9dEJMrsyMpmeCqTUqjjl4R9Vc9c8ai5CRJvg9/iwDdFG3OkSOy1CS3gtMEEljdp
	3yRhd0WhiceP9Vvw==
X-Google-Smtp-Source: AGHT+IG/iGsCJSYYzOtnJbkY0MxuudV4fcDQN9s+HrpGgtuRUU+7/pMjg0tXXQcvwKwdsPonERz6tQ==
X-Received: by 2002:a05:6102:6883:b0:523:fa25:9dcb with SMTP id ada2fe7eead31-5d5e226aab6mr627933137.8.1759876332221;
        Tue, 07 Oct 2025 15:32:12 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4da21c3sm3859567241.7.2025.10.07.15.32.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:32:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/8] Bluetooth: ISO: Add support to bind to trigger PAST
Date: Tue,  7 Oct 2025 18:31:50 -0400
Message-ID: <20251007223155.1539954-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_conn.c         | 12 +++++
 net/bluetooth/hci_sync.c         | 90 +++++++++++++++++++++++++++++++
 net/bluetooth/iso.c              | 91 ++++++++++++++++++++++++++------
 5 files changed, 178 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2a765a0521b4..d40817e5ac07 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1594,6 +1594,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			      struct bt_iso_qos *qos,
 			      __u8 base_len, __u8 *base, u16 timeout);
+int hci_past_bis(struct hci_conn *conn, bdaddr_t *dst, __u8 dst_type);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, struct bt_iso_qos *qos,
 				 u16 timeout);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index e352a4e0ef8d..3133f40fa9f9 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -188,3 +188,4 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 111f0e37b672..a3aef80e6a97 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2233,6 +2233,18 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 	return conn;
 }
 
+int hci_past_bis(struct hci_conn *conn, bdaddr_t *dst, __u8 dst_type)
+{
+	struct hci_conn *le;
+
+	/* Lookup existing LE connection to rebind to */
+	le = hci_conn_hash_lookup_le(conn->hdev, dst, dst_type);
+	if (!le)
+		return -EINVAL;
+
+	return hci_past_sync(conn, le);
+}
+
 static void bis_mark_per_adv(struct hci_conn *conn, void *data)
 {
 	struct iso_list_data *d = data;
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
index 7f66f287c14e..7cafb0bdb636 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -987,20 +987,14 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 	return 0;
 }
 
-static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
+/* Must be called on the locked socket. */
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
@@ -1023,6 +1017,70 @@ static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
 	return err;
 }
 
+static struct hci_dev *iso_conn_get_hdev(struct iso_conn *conn)
+{
+	struct hci_dev *hdev = NULL;
+
+	iso_conn_lock(conn);
+	if (conn->hcon)
+		hdev = hci_dev_hold(conn->hcon->hdev);
+	iso_conn_unlock(conn);
+
+	return hdev;
+}
+
+/* Must be called on the locked socket. */
+static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
+			      int addr_len)
+{
+	struct hci_dev *hdev;
+	struct hci_conn *bis;
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
+	hdev = iso_conn_get_hdev(iso_pi(sk)->conn);
+	if (!hdev)
+		return -EINVAL;
+
+	bis = iso_pi(sk)->conn->hcon;
+
+	/* Release the socket before lookups since that requires hci_dev_lock
+	 * which shall not be acquired while holding sock_lock for proper
+	 * ordering.
+	 */
+	release_sock(sk);
+	hci_dev_lock(bis->hdev);
+
+	BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bc->bc_bdaddr,
+	       sa->iso_bc->bc_bdaddr_type);
+
+	err = hci_past_bis(bis, &sa->iso_bc->bc_bdaddr,
+			   le_addr_type(sa->iso_bc->bc_bdaddr_type));
+
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+	lock_sock(sk);
+
+	return err;
+}
+
 static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -1038,13 +1096,12 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 
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

