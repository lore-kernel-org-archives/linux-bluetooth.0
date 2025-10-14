Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466726B765
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405605; cv=none; b=IFtrhDxDhk4bO7d3ZSFFJtjRHVP0MI3X+c+1qQPabJ7ToKahd41KbC86LrjUGEtK+ge7y6Ilhh5WTp3oVLUjo9wg39x5BEZGWOuEPH5SPrWaQdhrBEnDmGHiK68K0WJ2fgF/J5T56TlbcSN+86jwfPwWnGa1Bb5vhD0paC8U9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405605; c=relaxed/simple;
	bh=Hmc0i3MK4SUv0uN+AEtrAeYaNk7ycFwlWQkBzamFwvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvwJ92kqZx6Y45/5UHVIOeb+9Wml0hwocO6tN6ZlqcP2elIqTElMSX9C7R06mNrUNrdr8GB9DCF7IJcI0QoJcJs/myTHKGhmiUls84q3C6q2cfSvRufTH66NwpkIYWJKfjXaKUQooIgvMxnYle331WGpKqY/gjtzkvMH/03uP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+/ctTM3; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+/ctTM3"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e364003538so3284708241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760405602; x=1761010402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+N0NXJRn6Jsslh6TNVhwU3AdkFriu/sty/cqWHrDWko=;
        b=d+/ctTM31rcE5G4fCbTj3Nfglea/lnpDuI8ffx8pUTKVJgm1ltxJN62bRS9IgdkEar
         kl8FhoeK5sJFfX+fUY9aV1w8EeLEs/Ln8ib7AORSJjQphv/voHHK64wcdlVVeLqzOc0e
         +0u7WbDnkA2HzykFk2YwlwvFl9fjht6RbPBOJO9DjfQPoNpytM4gSBtBCXTUcnIOovCR
         Cr4nrMj1NC0ve/2AwuGDJOFI+Iyq92DSgWx3QHBn8miPQfuGBv++vuJx/g2+yclDqME8
         iQG2VbgzaQB3GEhYTHM/dyyJokrhnJ3ufbC6Tfz4rl3JsmW/t2vGtcE/DuWmz/3zz+t/
         rO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405602; x=1761010402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N0NXJRn6Jsslh6TNVhwU3AdkFriu/sty/cqWHrDWko=;
        b=cp7tMzKphOqxAWUoDQKnTk7VbtAC9ds9e9pFuHPalHt946p8aLVSlTXM3g+VNtLHec
         X6SSRjk4W7H3gvP+VH7zWKzPwLzDlgnx/3/IrusmT2pwM1E1kFrsI1hA38oA4SU/sr3+
         rvVn6frlTIuWBqN8HB2uKvccLF98E11Xh000NKjuEyz7TWxOWrG6ArrvZk/w0TwbttiW
         5UO2VW0RXMhP2vLHxzpHYbOJWxmzPnWv/7eEK27Q6bjenJmS/1DvMuiVbrs0KIajIA0N
         WgIV5pPEW8J6SHK0Cx2ZFR62Cpi2ZEAAySCwakA5TtpncjsYqZYD89GOelWap6nxJjZ1
         UTsA==
X-Gm-Message-State: AOJu0YyY1WRuFQxAxFJXSbHeh4JXyVfAWYKsFxupxACa0Dn6tHwDInPI
	iHlDCJ0TUDRbykuug8eBUrsav4lTxX4xbiRKjwTP+tPC9T7847kys674bKisDVZo
X-Gm-Gg: ASbGncvQgz+UJuo3F9w+wB1nEFwqC5KdqnCtjWlOaNyOL7q9V8Vd7OviqbrdaZINM0w
	JQhtp2MIn/EQ+jFxR0oeQbPz+RupINhO1jfBVciUTe/GdBqFVEIrr+9BuU2fK39DIPTHzt/VsYH
	IarXa7/6XxvvwHLDK+VXONSosrAfOyPakDCtPTszHN3z4zqFpoxYyLIjbxfdYQB4kD+i9spIcam
	kWxQWd7q3K7jjVKXWPjslpBehW3R0v5l7O/TY6E8WvrkS9UOWuoH5YEqQFBNxhCFfJedFfsMmr7
	zZ6SpZPMV56z1kkX7BEYXBMYART6Q5wq3df8cUr/jzwuCdJihOPyWF/US4MSzkT+HM/+bWwY8un
	IM/ZG/psgRx8MAY+7yX7nRzwX2TZectdO9tSHG9Y+6he3OHS4Oo8/f+nnfPa6iaJAC3qzFs3JgV
	hOHyWwixBnPlmqOnaZWoY=
X-Google-Smtp-Source: AGHT+IGIaQ0fvmw3AfetuVSsA0iDKt65YeGV+jlP9kn0dFt/D8L/APavBaWOn/e+/NB5W9DhzuUZeQ==
X-Received: by 2002:a05:6102:3ec2:b0:527:8b63:790c with SMTP id ada2fe7eead31-5d5e21cf2fcmr9481398137.7.1760405602104;
        Mon, 13 Oct 2025 18:33:22 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc7126c7sm3985806137.5.2025.10.13.18.33.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:33:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/8] Bluetooth: ISO: Add support to bind to trigger PAST
Date: Mon, 13 Oct 2025 21:33:03 -0400
Message-ID: <20251014013308.174151-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014013308.174151-1-luiz.dentz@gmail.com>
References: <20251014013308.174151-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_conn.c         | 12 ++++
 net/bluetooth/hci_sync.c         | 90 +++++++++++++++++++++++++++++
 net/bluetooth/iso.c              | 98 ++++++++++++++++++++++++++------
 5 files changed, 185 insertions(+), 17 deletions(-)

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
index 5051413f1a97..6ae628363f42 100644
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
+	cp.handle = cpu_to_le16(past->le->handle);
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
index 7f66f287c14e..302ed6b99cf2 100644
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
@@ -1023,6 +1017,77 @@ static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
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
+	lock_sock(sk);
+
+	if (!iso_pi(sk)->conn || iso_pi(sk)->conn->hcon != bis) {
+		/* raced with iso_conn_del() or iso_disconn_sock() */
+		err = -ENOTCONN;
+		goto unlock;
+	}
+
+	BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bc->bc_bdaddr,
+	       sa->iso_bc->bc_bdaddr_type);
+
+	err = hci_past_bis(bis, &sa->iso_bc->bc_bdaddr,
+			   le_addr_type(sa->iso_bc->bc_bdaddr_type));
+
+unlock:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -1038,13 +1103,12 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 
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

