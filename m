Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64178194A52
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004505; cv=none; b=e0G3trwtwoP7t6xTlIOpD1Q1cSbWYB+ur+5Xj8QGvQKdGh/CzlZ018B+kqTPrQ8m6UwOx2TzimqLTfrB0pHh5/zT8Rs+VjeS5VCSjnSu1zlsFd8dDjw6+RgGz0D/kM0SA6sjZTHH73Ix/KVdzY8kOo02tPyM5Tdhf5l0aZEKk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004505; c=relaxed/simple;
	bh=pgRFtBTjepowiu3sOT9bJ17uJB8xH/EBPwYhxONhIxw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TaoexhuBcKuKWOwQiWpOFNGgz9okG6jL1Po7uKidB9U76Fo6SgJL6MWsXmEceKS8uIMccu/wp5qy2O/ofBbxSP+xPfJ94yV4p9e2CMejBToeEzX/uBy3NW5wdR+9aKCwQ6KbCUeP5KsH9BMNTDQNwsONK7XPehT8VDXqgVeAMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAtaC9oO; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAtaC9oO"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ebc349204cso660780eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2024 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731004501; x=1731609301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGf+8VWlYjkPAavYKAvqyVUmgF4040Q4CTUzVu0kSlA=;
        b=AAtaC9oO23zIyp037qNhs2ULp0hnrYVndjh76mb8/5XHpbr+kZKR/vi/2SaWPMnYcg
         i2lsakWT96GyBMRfCpssgASyMQR6s9sSrClnk9F4mvSWtbKRkJ7xWNYCAFG7de+WBw9M
         iud77rqfMYR8mOjTiPpmAW4gNDg/VNY7UuL0MbKhPbZ/TzcVGQ3Zw9ikPbUOjy/545Ku
         Vlry/qcXkdSOgOU3k+ZKDcOypva/fu1vXRNUhqRZs5+yiyd+WA4SvKzrgEZYff6Hx2nm
         tmvZEcOmJsvyl8PzUCeb+IckF529ZBfgUehCk41UlK6CwDaE2HjIpGcWhYZx3Jt87GQT
         2DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004501; x=1731609301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGf+8VWlYjkPAavYKAvqyVUmgF4040Q4CTUzVu0kSlA=;
        b=FWWLBcftkJ9MlxQ2uV/a+PoLMUfJlRR+B1M4vFd7AAtq/1G87NDmoIzZlu+8iNbfFZ
         tu7Sy6XAZc0/1hpWn0LZb23pJKPqyjCbQbS+OPKMlYfOMMCcjq1uUHAnnLibMaMLFJYC
         KB7fYUMfhRedg3bDMhOhr4VoKUFhQNE5MwT4OqCTC9dH9k8qleYqQ2vh9ZV2QKyLWv+j
         TK4XQ7l25Txpj2n5V5uMfOj9fGy4XAEiklrywBa81FztnKOyM8/PbjHNgZgnh/lKSl+k
         mSE/s0VUeJVwQlctdjYyQ9Yr1dZR8vYI8+Ks77r05Ao3UvR9hUWL8fJerJsZ2kYAs13J
         ISLA==
X-Gm-Message-State: AOJu0YwWBJz/ha+mrJoG7FzpaFo3M+hGk1FHnwJWCsZUBpYsl8ZBRh4N
	s6IuNrAowjkG/LKIYT/IqMQ/RtJYflu/A6D4mt0l2fEZv0ru+QZW1+OIcA==
X-Google-Smtp-Source: AGHT+IG7zjiPDhuAnsTzxxzsy19ipP8i7yiDT11AZ7cO5PErkR6/CcWIcz0/f3m2H+a0KMRHE9mL4A==
X-Received: by 2002:a05:6358:6e92:b0:1c3:813d:47c6 with SMTP id e5c5f4694b2df-1c641f5f4c3mr11567655d.19.1731004499131;
        Thu, 07 Nov 2024 10:34:59 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-856557908a3sm358193241.30.2024.11.07.10.34.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:34:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: SCO: Use kref to track lifetime of sco_conn
Date: Thu,  7 Nov 2024 13:34:54 -0500
Message-ID: <20241107183455.129897-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of kref to keep track of reference of sco_conn which
allows better tracking of its lifetime with usage of things like
kref_get_unless_zero in a similar way as used in l2cap_chan.

In addition to it remove call to sco_sock_set_timer on __sco_sock_close
since at that point it is useless to set a timer as the sk will be freed
there is nothing to be done in sco_sock_timeout.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 99 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1c7252a36866..1b8e468d24cf 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -51,6 +51,7 @@ struct sco_conn {
 	struct delayed_work	timeout_work;
 
 	unsigned int    mtu;
+	struct kref	ref;
 };
 
 #define sco_conn_lock(c)	spin_lock(&c->lock)
@@ -76,6 +77,49 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static void sco_conn_free(struct kref *ref)
+{
+	struct sco_conn *conn = container_of(ref, struct sco_conn, ref);
+
+	BT_DBG("conn %p", conn);
+
+	if (conn->sk)
+		sco_pi(conn->sk)->conn = NULL;
+
+	if (conn->hcon) {
+		conn->hcon->sco_data = NULL;
+		hci_conn_drop(conn->hcon);
+	}
+
+	/* Ensure no more work items will run since hci_conn has been dropped */
+	disable_delayed_work_sync(&conn->timeout_work);
+
+	kfree(conn);
+}
+
+static void sco_conn_put(struct sco_conn *conn)
+{
+	if (!conn)
+		return;
+
+	BT_DBG("conn %p refcnt %d", conn, kref_read(&conn->ref));
+
+	kref_put(&conn->ref, sco_conn_free);
+}
+
+static struct sco_conn *sco_conn_hold_unless_zero(struct sco_conn *conn)
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
 static struct sock *sco_sock_hold(struct sco_conn *conn)
 {
 	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
@@ -92,6 +136,10 @@ static void sco_sock_timeout(struct work_struct *work)
 					     timeout_work.work);
 	struct sock *sk;
 
+	conn = sco_conn_hold_unless_zero(conn);
+	if (!conn)
+		return;
+
 	sco_conn_lock(conn);
 	if (!conn->hcon) {
 		sco_conn_unlock(conn);
@@ -99,6 +147,7 @@ static void sco_sock_timeout(struct work_struct *work)
 	}
 	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
+	sco_conn_put(conn);
 
 	if (!sk)
 		return;
@@ -136,9 +185,14 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
 	struct sco_conn *conn = hcon->sco_data;
 
+	conn = sco_conn_hold_unless_zero(conn);
 	if (conn) {
-		if (!conn->hcon)
+		if (!conn->hcon) {
+			sco_conn_lock(conn);
 			conn->hcon = hcon;
+			sco_conn_unlock(conn);
+		}
+		sco_conn_put(conn);
 		return conn;
 	}
 
@@ -146,6 +200,7 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	if (!conn)
 		return NULL;
 
+	kref_init(&conn->ref);
 	spin_lock_init(&conn->lock);
 	INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
 
@@ -170,17 +225,15 @@ static void sco_chan_del(struct sock *sk, int err)
 	struct sco_conn *conn;
 
 	conn = sco_pi(sk)->conn;
+	sco_pi(sk)->conn = NULL;
 
 	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
 
 	if (conn) {
 		sco_conn_lock(conn);
 		conn->sk = NULL;
-		sco_pi(sk)->conn = NULL;
 		sco_conn_unlock(conn);
-
-		if (conn->hcon)
-			hci_conn_drop(conn->hcon);
+		sco_conn_put(conn);
 	}
 
 	sk->sk_state = BT_CLOSED;
@@ -195,29 +248,28 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	struct sco_conn *conn = hcon->sco_data;
 	struct sock *sk;
 
+	conn = sco_conn_hold_unless_zero(conn);
 	if (!conn)
 		return;
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
-	/* Kill socket */
 	sco_conn_lock(conn);
 	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
+	sco_conn_put(conn);
 
-	if (sk) {
-		lock_sock(sk);
-		sco_sock_clear_timer(sk);
-		sco_chan_del(sk, err);
-		release_sock(sk);
-		sock_put(sk);
+	if (!sk) {
+		sco_conn_put(conn);
+		return;
 	}
 
-	/* Ensure no more work items will run before freeing conn. */
-	cancel_delayed_work_sync(&conn->timeout_work);
-
-	hcon->sco_data = NULL;
-	kfree(conn);
+	/* Kill socket */
+	lock_sock(sk);
+	sco_sock_clear_timer(sk);
+	sco_chan_del(sk, err);
+	release_sock(sk);
+	sock_put(sk);
 }
 
 static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
@@ -401,6 +453,8 @@ static void sco_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
+	sco_conn_put(sco_pi(sk)->conn);
+
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 }
@@ -448,17 +502,6 @@ static void __sco_sock_close(struct sock *sk)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (sco_pi(sk)->conn->hcon) {
-			sk->sk_state = BT_DISCONN;
-			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
-			sco_conn_lock(sco_pi(sk)->conn);
-			hci_conn_drop(sco_pi(sk)->conn->hcon);
-			sco_pi(sk)->conn->hcon = NULL;
-			sco_conn_unlock(sco_pi(sk)->conn);
-		} else
-			sco_chan_del(sk, ECONNRESET);
-		break;
-
 	case BT_CONNECT2:
 	case BT_CONNECT:
 	case BT_DISCONN:
-- 
2.47.0

