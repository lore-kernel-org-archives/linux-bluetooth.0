Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF23212F06
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004506; cv=none; b=U4HUCiHF09iLAOxldvEbK/+qq/hAyzqyRBemPogG2Q+TBFSSp6rUWdj1HNSPP1eh0aEismoIS6PHeb5D2pUCfQNe+mKm0+ictJiRQS5GRa+Pb/LtubSBs0XIB8BZj7zgalwVlu/6x+Qc9nsw0jzbX5KFRQVz+nE3j/Ps55iZHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004506; c=relaxed/simple;
	bh=HPAIi4bI8l6adDycZMRrZckC2y2zZ+La5xl8hHiHVMo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kL8rS+eb89Y+/06uHkDN3NHLtVxAfCQ1ftpZupM1xz9ZDxZoLVIK5ShWZab3kiPb/O44XzbA5xnSisxX7LscWIZE1TWMO/JtQueknV8g+HrEumrLqqKajkkg5j+H16tww+tFg5UYd6gexcU4HkPzbnNgPLJZiQKU6BqHH5OXxkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8aovHXY; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8aovHXY"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5eb73ec1e1aso679066eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2024 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731004503; x=1731609303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxxI9JNhe8WZ4K7bmWVwdKBwGlWYZ3LncP13YptGGVM=;
        b=J8aovHXYI/QspUqcwbckXlX8ydLvLwsmqXCLe9bbQPSsyxJdzlye/imZUt4w0fBXaA
         Xvhb7wmCl/UhrjI6X9acDN1e2Wweviki42NWi71Y/BdZjbk25WaBnLQoVLLjHmtkFuEx
         jxKlEdeJn5hFMnYl5PXocLySk0UdkO8qHgmgtmFub5QHb52RVZsQp34ib6YWATtnpPQ9
         XJrixc5ER2NsQXy5NvE7sV/Wo0hs+O+/F/5qZZDJsyiUdcTZv+dDUDZvitbzs4mKwlRy
         R8nJwNe55JoBjcETyYcy3OeExmnvGU8eAoRSBD9Kosvs8N5kdVu645aTrB1WDqJtbHEL
         E88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004503; x=1731609303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxxI9JNhe8WZ4K7bmWVwdKBwGlWYZ3LncP13YptGGVM=;
        b=O8kRi75jM1MfJrFzzfcvcVapqj2xxXACnb1aFKNts0o/7amFfB5E5w9z0sc0CuetXG
         +GomDsznsqS6ranFtKOlgOX9L/vARyjMrhPREi0XPnmes3bUqDwE/pWONjfxNjjbVvLy
         CA1jVKxS3BTXO4cMZs5kMGWWkOs8ft+LbtFSpOTRjkuRXcHTgK1BKrtqJQESMPSCPfIy
         pH4R6Ztag9SQB+FbD6UARzmbW4GRcOalZmYfviPeBRA+Dcl8uC/5KRO4MF/yulDnMBhQ
         2aXIw48/ozpB9La/+BuIM5zLEk3VDNvYWfH/aUVrCdnytVcscgWA4xQRyAFFYvrKQ6IL
         MRkg==
X-Gm-Message-State: AOJu0YyyZChnOZ0lqyC30AY0DjbfpWHoM/A5VHf2nHFcPr0O59Hwy1lN
	O87dWZdUpTw8mPAS6nqWjubNg3bbStzfQWQaasO6jD64WZsY38QcnBIcgg==
X-Google-Smtp-Source: AGHT+IGXMyEW/1HMy49ww0fEUIkbPxYMAVgu0pmJz6MNyKzQJD+kxdWNat6pP2xpXYfte/gnmQOPhA==
X-Received: by 2002:a05:6358:72a7:b0:1c2:f41e:dbd5 with SMTP id e5c5f4694b2df-1c641ea66c2mr14771455d.7.1731004503459;
        Thu, 07 Nov 2024 10:35:03 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856557908a3sm358193241.30.2024.11.07.10.34.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:35:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: ISO: Use kref to track lifetime of iso_conn
Date: Thu,  7 Nov 2024 13:34:55 -0500
Message-ID: <20241107183455.129897-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107183455.129897-1-luiz.dentz@gmail.com>
References: <20241107183455.129897-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of kref to keep track of reference of iso_conn which
allows better tracking of its lifetime with usage of things like
kref_get_unless_zero in a similar way as used in l2cap_chan.

In addition to it remove call to iso_sock_set_timer on iso_sock_disconn
since at that point it is useless to set a timer as the sk will be freed
there is nothing to be done in iso_sock_timeout.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 88 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9e119da43147..24e78ada9ad2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -35,6 +35,7 @@ struct iso_conn {
 	struct sk_buff	*rx_skb;
 	__u32		rx_len;
 	__u16		tx_sn;
+	struct kref	ref;
 };
 
 #define iso_conn_lock(c)	spin_lock(&(c)->lock)
@@ -93,6 +94,49 @@ static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
 #define ISO_CONN_TIMEOUT	(HZ * 40)
 #define ISO_DISCONN_TIMEOUT	(HZ * 2)
 
+static void iso_conn_free(struct kref *ref)
+{
+	struct iso_conn *conn = container_of(ref, struct iso_conn, ref);
+
+	BT_DBG("conn %p", conn);
+
+	if (conn->sk)
+		iso_pi(conn->sk)->conn = NULL;
+
+	if (conn->hcon) {
+		conn->hcon->iso_data = NULL;
+		hci_conn_drop(conn->hcon);
+	}
+
+	/* Ensure no more work items will run since hci_conn has been dropped */
+	disable_delayed_work_sync(&conn->timeout_work);
+
+	kfree(conn);
+}
+
+static void iso_conn_put(struct iso_conn *conn)
+{
+	if (!conn)
+		return;
+
+	BT_DBG("conn %p refcnt %d", conn, kref_read(&conn->ref));
+
+	kref_put(&conn->ref, iso_conn_free);
+}
+
+static struct iso_conn *iso_conn_hold_unless_zero(struct iso_conn *conn)
+{
+	if (!conn)
+		return NULL;
+
+	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
+
+	if (!kref_get_unless_zero(&conn->ref))
+		return NULL;
+
+	return conn;
+}
+
 static struct sock *iso_sock_hold(struct iso_conn *conn)
 {
 	if (!conn || !bt_sock_linked(&iso_sk_list, conn->sk))
@@ -109,9 +153,14 @@ static void iso_sock_timeout(struct work_struct *work)
 					     timeout_work.work);
 	struct sock *sk;
 
+	conn = iso_conn_hold_unless_zero(conn);
+	if (!conn)
+		return;
+
 	iso_conn_lock(conn);
 	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
+	iso_conn_put(conn);
 
 	if (!sk)
 		return;
@@ -149,9 +198,14 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 {
 	struct iso_conn *conn = hcon->iso_data;
 
+	conn = iso_conn_hold_unless_zero(conn);
 	if (conn) {
-		if (!conn->hcon)
+		if (!conn->hcon) {
+			iso_conn_lock(conn);
 			conn->hcon = hcon;
+			iso_conn_unlock(conn);
+		}
+		iso_conn_put(conn);
 		return conn;
 	}
 
@@ -159,6 +213,7 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 	if (!conn)
 		return NULL;
 
+	kref_init(&conn->ref);
 	spin_lock_init(&conn->lock);
 	INIT_DELAYED_WORK(&conn->timeout_work, iso_sock_timeout);
 
@@ -178,17 +233,15 @@ static void iso_chan_del(struct sock *sk, int err)
 	struct sock *parent;
 
 	conn = iso_pi(sk)->conn;
+	iso_pi(sk)->conn = NULL;
 
 	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
 
 	if (conn) {
 		iso_conn_lock(conn);
 		conn->sk = NULL;
-		iso_pi(sk)->conn = NULL;
 		iso_conn_unlock(conn);
-
-		if (conn->hcon)
-			hci_conn_drop(conn->hcon);
+		iso_conn_put(conn);
 	}
 
 	sk->sk_state = BT_CLOSED;
@@ -210,6 +263,7 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
 
+	conn = iso_conn_hold_unless_zero(conn);
 	if (!conn)
 		return;
 
@@ -219,20 +273,18 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	iso_conn_lock(conn);
 	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
+	iso_conn_put(conn);
 
-	if (sk) {
-		lock_sock(sk);
-		iso_sock_clear_timer(sk);
-		iso_chan_del(sk, err);
-		release_sock(sk);
-		sock_put(sk);
+	if (!sk) {
+		iso_conn_put(conn);
+		return;
 	}
 
-	/* Ensure no more work items will run before freeing conn. */
-	cancel_delayed_work_sync(&conn->timeout_work);
-
-	hcon->iso_data = NULL;
-	kfree(conn);
+	lock_sock(sk);
+	iso_sock_clear_timer(sk);
+	iso_chan_del(sk, err);
+	release_sock(sk);
+	sock_put(sk);
 }
 
 static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
@@ -652,6 +704,8 @@ static void iso_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
+	iso_conn_put(iso_pi(sk)->conn);
+
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 }
@@ -711,6 +765,7 @@ static void iso_sock_disconn(struct sock *sk)
 		 */
 		if (bis_sk) {
 			hcon->state = BT_OPEN;
+			hcon->iso_data = NULL;
 			iso_pi(sk)->conn->hcon = NULL;
 			iso_sock_clear_timer(sk);
 			iso_chan_del(sk, bt_to_errno(hcon->abort_reason));
@@ -720,7 +775,6 @@ static void iso_sock_disconn(struct sock *sk)
 	}
 
 	sk->sk_state = BT_DISCONN;
-	iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
 	iso_conn_lock(iso_pi(sk)->conn);
 	hci_conn_drop(iso_pi(sk)->conn->hcon);
 	iso_pi(sk)->conn->hcon = NULL;
-- 
2.47.0

