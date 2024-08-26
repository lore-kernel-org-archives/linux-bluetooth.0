Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F940199EA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703925; cv=none; b=cgqwpI7anMseL/X+GbdFh0ej7ndSlhnPqee8XPcLqjkNKUkb3jxy7WrP+uT32o8LZ7mUp0+156n+jWcntF6Kr8bBTkVHACve/0Ix5suFQP8t6YqA/wAE64fG286BzU4M/lGdBb6Dfl0ggy5wHZW17OaBnlqc5sXxZr0XiimVKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703925; c=relaxed/simple;
	bh=jSpyShSQBFJOPEmOIUo5Wn7gDssRx4wD9dnq8cBD4Rg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkf5162Y+NpAnrJGTt4R18ekkJtRsSWjezF6nDkDfp4tChcBYA4YjqA2J5ZJCUXggZ7oGvj7o5FECIYMhqimAFVXGJFoLX0fRSBz06WlkJwhipRoMrhgjLp+BkYtbflsqpPaZ88aSAfT1cvnwp6zCQQql0pBShbkOE1gBkWgimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIXWlXCA; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIXWlXCA"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8430557e436so1356887241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724703922; x=1725308722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1iJS8WrD3YqpQ2TSihxoSRoS98guPNwg5uUmaBpykE=;
        b=iIXWlXCAwWGeOvjrVzJc8LcWxjT2SY4QOJOcOJtFVNeSWUrV+g81DdpZg3iCO092Qo
         eyYrLM/L0piHN9dM1uqzuSQt69jwVrf3SYPM73dhpjx4gX+0lL7dm2dCAHYxSzB4g0Zy
         dhx/SNBhDg8UpgY3GmmcSWLoJe08aBEEQN2nw6PKOh5gVj7zppHyGE60742jBKMgQLfX
         TwlYsoquJI54K3nRnNFBGSQxRfI9rbWwREopkhjRV9v8aNz6NFVY+Ij56sr6wWNF6wio
         lZEmyfPMKw4Mj/csFcGR8xXfj/Bmc5Ydz3Ag8VZVhlIlzKtlu3tWmb1R9iziUbwKBJP/
         9M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703922; x=1725308722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1iJS8WrD3YqpQ2TSihxoSRoS98guPNwg5uUmaBpykE=;
        b=M+Wi7kASYU3W/2/ZS9yLO1fGqe18LyyypSdYfnD7REguB15i21FaEjj7rFgnPeuV7p
         AmJaCFXmG9WUdUAncHevwoTha5enPzwdTgqPXRSorrGOXXeIGtBTKjBWpnUs4Lnv7mC4
         JNvBsXNJAUX2d+hmySgkFrvEAY6skniTJrlHfBoGGSfBQLygRdLrQ7V55aX6UTxLKO45
         CMUxYXvQh25uFzbgnJYPuSX3QKchxIvlsZz7XRxzFSIB7AslgMqA3cOguswjZjSTPkGc
         2KDbtx5KAA/sSDbHd3WhQ8ztjMyvtYFuTy1SC0Kx104FBXZJPgMRYonTcNDfELqQCKQx
         Hb7w==
X-Gm-Message-State: AOJu0Yx3xpbqRJ01dh4j7AocC1tmKWRZGMpoRi0aGniqCPhvdP6B+BGU
	pdgI1+Y8JhZgHOuPM5qs8fy1RWp7PCzOp6ppuigQsHqF/iiQF5LxsUAXmg==
X-Google-Smtp-Source: AGHT+IFz4FiuYNTeyGV45Zq26MXSSP7oK766ejJ3SEMbGPyA6GsVUrLz/txt+b2nfddpgzJxsqC5sw==
X-Received: by 2002:a05:6102:cca:b0:495:6a25:d1ed with SMTP id ada2fe7eead31-49a3bcefe8emr1023926137.25.1724703922385;
        Mon, 26 Aug 2024 13:25:22 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce572f68sm1195475241.29.2024.08.26.13.25.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:25:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
Date: Mon, 26 Aug 2024 16:25:18 -0400
Message-ID: <20240826202518.524007-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826202518.524007-1-luiz.dentz@gmail.com>
References: <20240826202518.524007-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MGMT_OP_DISCONNECT can be called while mgmt_device_connected has not
been called yet, which will cause the connection procedure to be
aborted, so mgmt_device_disconnected shall still respond with command
complete to MGMT_OP_DISCONNECT and just not emit
MGMT_EV_DEVICE_DISCONNECTED since MGMT_EV_DEVICE_CONNECTED was never
sent.

To fix this MGMT_OP_DISCONNECT is changed to work similarly to other
command which do use hci_cmd_sync_queue and then use hci_conn_abort to
disconnect and returns the result, in order for hci_conn_abort to be
used from hci_cmd_sync context it now uses hci_cmd_sync_run_once.

Link: https://github.com/bluez/bluez/issues/932
Fixes: 12d4a3b ("Bluetooth: Move check for MGMT_CONNECTED flag into mgmt.c")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c |  6 +++-
 net/bluetooth/mgmt.c     | 72 +++++++++++++++++++++++-----------------
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8f0c9322eadb..6225f13177c3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2951,5 +2951,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		return 0;
 	}
 
-	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
+	/* Run immediately if on cmd_sync_work since it maybe called from
+	 * as a result to MGMT_OP_DISCONNECT and MGMT_OP_UNPAIR which does
+	 * already queue its callback on cmd_sync_work.
+	 */
+	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25979f4283a6..54dc9976abcf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2921,7 +2921,12 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	if (!conn)
 		return 0;
 
-	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
+	/* Disregard any possible error since the likes of hci_abort_conn_sync
+	 * will cleanup the connection no matter the error.
+	 */
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
+	return 0;
 }
 
 static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3053,13 +3058,44 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void disconnect_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	cmd->cmd_complete(cmd, mgmt_status(err));
+	mgmt_pending_free(cmd);
+}
+
+static int disconnect_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_disconnect *cp = cmd->param;
+	struct hci_conn *conn;
+
+	if (cp->addr.type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
+					       le_addr_type(cp->addr.type));
+
+	if (!conn)
+		return -ENOTCONN;
+
+	/* Disregard any possible error since the likes of hci_abort_conn_sync
+	 * will cleanup the connection no matter the error.
+	 */
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
+	return 0;
+}
+
 static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		      u16 len)
 {
 	struct mgmt_cp_disconnect *cp = data;
 	struct mgmt_rp_disconnect rp;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_conn *conn;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -3082,27 +3118,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (pending_find(MGMT_OP_DISCONNECT, hdev)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-					MGMT_STATUS_BUSY, &rp, sizeof(rp));
-		goto failed;
-	}
-
-	if (cp->addr.type == BDADDR_BREDR)
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
-					       &cp->addr.bdaddr);
-	else
-		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
-					       le_addr_type(cp->addr.type));
-
-	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-					MGMT_STATUS_NOT_CONNECTED, &rp,
-					sizeof(rp));
-		goto failed;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_DISCONNECT, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -3110,9 +3126,10 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	cmd->cmd_complete = generic_cmd_complete;
 
-	err = hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
+	err = hci_cmd_sync_queue(hdev, disconnect_sync, cmd,
+				 disconnect_complete);
 	if (err < 0)
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -9744,8 +9761,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (link_type != ACL_LINK && link_type != LE_LINK)
 		return;
 
-	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
-
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.reason = reason;
@@ -9758,9 +9773,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	if (sk)
 		sock_put(sk);
-
-	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
-			     hdev);
 }
 
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
2.46.0

