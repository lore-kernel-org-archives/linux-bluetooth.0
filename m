Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160E3B27D6;
	Fri, 24 Jul 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924465; cv=pass; b=LvZSb7vDZ2gy0Y377L2eRBcwxaOjCUdp5BOruu8DyjJ9iQLmddqJTeHLvtJsxOAOisv895Ak1B4a0X9kovXllHWDqQQf986RYXOdmtGytlP5mKVFXrU3w95UvWGba7XwNkn2UqUoeYLjIlGc4HJRXunfQWQZJOhpwG7nnQfjmjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924465; c=relaxed/simple;
	bh=cXFf7YSd9JW72pVooGerQAnmqjnetHHiPX/3quozHak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOZufx1VYUkhUMhbhGtAvTpzHfuNkydFnX1PAhlZvRVV67PiL8YJyRF86jv8oNacReXazPxtkEo05pNRKaryLc8F9n2Vlxi4qH9/J7XMKaWN60/0njXy8mOl6wwFI2mnhoB0Vy0hgU2FcKjeWQEeKIpt3qONz51gkX61OpurqDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=lAhF92i3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="lAhF92i3"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KBJ07jvzyWH;
	Fri, 24 Jul 2026 23:20:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0fjg7kB4MMr+2W5AxUyDH8m0z85mGqM1zn5UvrZksY=;
	b=lAhF92i3Bu7wQ0MNBNTRifGvHMux8EHjwaaHh7McQ2qBLeWwXAhT5FmdolfNWAkMaN2ziY
	96vPXnUf1AxRvxwOvVLc13NUwcqjq9uac43IX/g5oYZxbws2Tun6+qVqDSWZ2iROFROKFf
	blaQcrJKxEbekUlbo8HzG52vv1IT9j4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924457;
	b=I7oXr7VktZ6RQibib52VUSyCUKsqt29AM406Ky1tZFkSwjAiiuWXK5F64q2AJFHrr5GQWC
	qLW4Wx5uOShJI+L75+JPPvppJn3kekO1xiHIkZ7xMeZAIP1M1zFs6VZ1EaYQpN64PNMcUU
	Qejzm/IPJKwJ9rCwAYF4Ow1HwD79m9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0fjg7kB4MMr+2W5AxUyDH8m0z85mGqM1zn5UvrZksY=;
	b=h0BYi//uCIb6xVsPwnIwXyA32Z9r6kQCn/LgbnhITrm0rz6/xGTeozScaHC4qfUIIuzFIc
	MPu4EtR0d0Nwi2sh7pZ1Gf7NwFJb5flxYB04mKZjPaNaaainKwrexsj4YwyhrotYI6dN0l
	/V/ZubWZF/uDBdiiZD7hLyFlK0woK1Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] Bluetooth: ISO: ensure no dangling hcon references in iso_conn
Date: Fri, 24 Jul 2026 23:20:32 +0300
Message-ID: <589d71aa2a77385c608e0445bd684897831be40f.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After iso_conn_del(), ISO sockets should not dereference the hcon any
more.  Currently, clearing iso_conn::hcon relies on iso_conn_del()
releasing the last reference to the iso_conn.

Simplify this by explicitly clearing conn->hcon in iso_conn_del(), to
avoid more complex reasoning on races about who holds the last
reference.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 0cc08416fde5..bfd39baa8503 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -263,6 +263,7 @@ static void iso_chan_del(struct sock *sk, int err)
 }
 
 static void iso_conn_del(struct hci_conn *hcon, int err)
+	__must_hold(&hcon->hdev->lock)
 {
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
@@ -277,11 +278,10 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	iso_conn_lock(conn);
 	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
-	iso_conn_put(conn);
 
 	if (!sk) {
 		iso_conn_put(conn);
-		return;
+		goto done;
 	}
 
 	iso_sock_disable_timer(sk);
@@ -291,6 +291,15 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	release_sock(sk);
 	iso_sock_kill(sk);
 	sock_put(sk);
+
+done:
+	/* No sk access to conn->hcon any more (lock_sock + hdev->lock) */
+	iso_conn_lock(conn);
+	conn->hcon = NULL;
+	hcon->iso_data = NULL;
+	iso_conn_unlock(conn);
+
+	iso_conn_put(conn);
 }
 
 static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
@@ -306,6 +315,11 @@ static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
 		return -EBUSY;
 	}
 
+	if (!conn->hcon) {
+		BT_ERR("conn->hcon missing");
+		return -EIO;
+	}
+
 	iso_pi(sk)->conn = conn;
 	conn->sk = sk;
 	clear_bit(ISO_CONN_DROPPED, conn->flags);
@@ -2500,6 +2514,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 }
 
 static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
+	__must_hold(&hcon->hdev->lock)
 {
 	if (hcon->type != CIS_LINK && hcon->type != BIS_LINK &&
 	    hcon->type != PA_LINK) {
@@ -2511,8 +2526,10 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 			struct hci_link *link, *t;
 
 			list_for_each_entry_safe(link, t, &hcon->link_list,
-						 list)
+						 list) {
+				lockdep_assert_held(&link->conn->hdev->lock);
 				iso_conn_del(link->conn, bt_to_errno(status));
+			}
 
 			return;
 		}
@@ -2542,6 +2559,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 }
 
 static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
+	__must_hold(&hcon->hdev->lock)
 {
 	if (hcon->type != CIS_LINK && hcon->type !=  BIS_LINK &&
 	    hcon->type != PA_LINK)
-- 
2.55.0

