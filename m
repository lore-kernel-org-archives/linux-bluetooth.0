Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13403CB2D4;
	Tue, 21 Jul 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625605; cv=pass; b=a8DWbErpw9NA9OGKgzdj2qLwW4rr7DlkrIrAPEJ563y225AfOwtuScuNyhi7iXPNRcjgKkwZrTmhZR6P5WH8g1J/V2mj5Zgu6XL4PF1kkgRaDKl7os30pJo+CSlnkZVunKGJ63vepeOTXi5feSa1VCeb/RkvvIxpMYJxVYmoThE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625605; c=relaxed/simple;
	bh=kQdtEFDtQWRxyq7862Qymvi8w8zvKII6uKF+COdRYRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmF/oSuxsR/0Pj/RCBJSAIg6l33AadIagHZHJ683DTgFEerD1YxXi+9TpeaqJv19lT62Zm5OVP8P+lMd9Y4xYjiIHtmQMy8M2f2lTS3uq4o18zZy/ieRlFukNCdDDOWiHRppRRNOzA7E0og5uARLEugN/reh9hrl0jNoKncoQFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=TVzhiMhI; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="TVzhiMhI"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h4Bg31xkJzyVm;
	Tue, 21 Jul 2026 12:19:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784625600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pd7Npr+u9nLgFCKIKRgO9/wao0EniJkp9ElHKDLHt1E=;
	b=TVzhiMhIAyDVlCIpn79xwsnwre//uWaFHCewJIHbKThYF2guNR4gzlhXrHgGNpCiLU5Oao
	JnEVfPT/90wRPr/iV5oNjkP+CeglvXuFZtZ4B+2OjjOh8arAN9Vnr1/YGw9MlPChCLXGDG
	9rQEBXjGuaOLm5LJ6P9vhQyw8+pSvbI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784625600;
	b=ye8FUXZd68tU/JAcFspWXpEc+dkpzDoh8acnVVEuHs2zkoZeF9N7NXKPK4wYRsvdfP9a3M
	MkuMcY5ohCBYNg4umu62KlAePY9hbZbKvqjJ63jqsQ/opQAv8pkvN6iFUGKfL7DqsXh7iP
	1C5iV+5P4T6CHGg4zPOjO8DrArb90RY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784625600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pd7Npr+u9nLgFCKIKRgO9/wao0EniJkp9ElHKDLHt1E=;
	b=hD+Ja76tyGN6AvDwCfsGe7hSJPhar5Zkaqy8rnfbPbkahkKWZWBZKqhdGN7lLhIpSAgyB4
	bMy6AAAGldc2+WUe/wzSY/KtvrEA4UUUAqdBy9zdmy6N/RLfeKXTGngLrBmLH1Z1FVcHIS
	qbIoX1O6fPJzSJ3weCIDVkpzjdk5ZHE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: ISO: fix UAF on socket close before shutdown completes
Date: Tue, 21 Jul 2026 12:19:54 +0300
Message-ID: <fbd9dd573bb1ce5f38370128dd35447e2ddfed9c.1784625576.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_disconn() aims to disconnect the hcon by dropping it, which
triggers iso_conn_del() to tear down the iso_conn once the HCI operation
completes, which requires valid hcon->iso_data.  iso_sock_disconn() sets
conn->hcon = NULL to avoid a second drop, but also preventing clearing
hcon->iso_data on socket release. Closing the socket before
iso_conn_del() runs then results to UAF.

Fix by using a separate flag to track the hcon drop status, instead of
clearing conn->hcon.

Log: (BlueZ iso-tester ISO Connect Close - Success)
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero
...
 iso_conn_hold_unless_zero (net/bluetooth/iso.c:138)
 iso_conn_del (net/bluetooth/iso.c:270)
 hci_conn_failed (net/bluetooth/hci_conn.c:1408)
 hci_abort_conn_sync (net/bluetooth/hci_sync.c:5817)

Allocated by task 34:
 iso_conn_add (net/bluetooth/iso.c:216)
 iso_connect_cis (net/bluetooth/iso.c:507)
 iso_sock_connect (net/bluetooth/iso.c:1211)
 __sys_connect (net/socket.c:2148)

Freed by task 34:
 iso_chan_del (net/bluetooth/iso.c:248)
 iso_sock_close (net/bluetooth/iso.c:885)
 iso_sock_release (net/bluetooth/iso.c:2022)
 sock_close (net/socket.c:722)

Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - use test_and_set_bit() instead of lock + bool
    v2:
    - use flag to track dropping instead of detaching sk
      in iso_sock_disconn()
    
    On previous Sashiko comment (IIUC this note text is included in the
    context, maybe generates better review): iso_connect_cfm() with status
    != 0 or iso_disconn_cfm() is guaranteed to be called before the ISO
    hci_conn is deleted. It should then go to iso_conn_del() which is
    supposed to limit the lifetime of the associated iso_conn to be shorter
    than hci_conn.
    
    hci_conn::iso_data is not associated with iso_conn refcount, but
    iso_pi(sk)->conn is supposed to hold one when non-NULL.

 net/bluetooth/iso.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2e95a153912c..5dc2915f7b32 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -24,8 +24,14 @@ static struct bt_sock_list iso_sk_list = {
 };
 
 /* ---- ISO connections ---- */
+enum {
+	ISO_CONN_DROPPED,
+	__ISO_CONN_NUM_FLAGS
+};
+
 struct iso_conn {
 	struct hci_conn	*hcon;
+	DECLARE_BITMAP(flags, __ISO_CONN_NUM_FLAGS);
 
 	/* @lock: spinlock protecting changes to iso_conn fields */
 	spinlock_t	lock;
@@ -107,7 +113,8 @@ static void iso_conn_free(struct kref *ref)
 
 	if (conn->hcon) {
 		conn->hcon->iso_data = NULL;
-		hci_conn_drop(conn->hcon);
+		if (!test_and_set_bit(ISO_CONN_DROPPED, conn->flags))
+			hci_conn_drop(conn->hcon);
 	}
 
 	/* Ensure no more work items will run since hci_conn has been dropped */
@@ -306,6 +313,7 @@ static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
 
 	iso_pi(sk)->conn = conn;
 	conn->sk = sk;
+	clear_bit(ISO_CONN_DROPPED, conn->flags);
 
 	if (parent)
 		bt_accept_enqueue(parent, sk, true);
@@ -835,10 +843,8 @@ static void iso_sock_disconn(struct sock *sk)
 	}
 
 	sk->sk_state = BT_DISCONN;
-	iso_conn_lock(iso_pi(sk)->conn);
-	hci_conn_drop(iso_pi(sk)->conn->hcon);
-	iso_pi(sk)->conn->hcon = NULL;
-	iso_conn_unlock(iso_pi(sk)->conn);
+	if (!test_and_set_bit(ISO_CONN_DROPPED, iso_pi(sk)->conn->flags))
+		hci_conn_drop(iso_pi(sk)->conn->hcon);
 }
 
 static void __iso_sock_close(struct sock *sk)
-- 
2.55.0

