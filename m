Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFF18871F;
	Mon, 20 Jul 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572257; cv=pass; b=UQJkXn7B+EETPMY2ofjS/H+T/0Ez27BXD2qERidCZlssXyjCk+VLRcs88JTF22e8iGB7BEoZu6V5ahNuSX0HDF6u9XLJgkGGRjUhmiICo4bqfsvv2mpsH40zve6v8CrDcPUuX/7XHfLRSee546UluGzGvCnbJNH+WcluNCps7T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572257; c=relaxed/simple;
	bh=I4UotuX6+wTHkhknqMtLPBgdQryv5RGbx8gXoT0LZd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GznZBQ2K/RiUF3OH2GxqsfcXBbaHOV92q5fde+pXu1i3qjIrl5+CMbE9h5jX3yG0EdJ4I2KWV4LOwThJ7wp3VmCNak6IEm0BX+zDGjrGx8+LeHpVmn9e2pe7F/LUDJdATfdoHmB4zad1PYKMRXmQ5b6MU0DqlCGu+AXuemKo8J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=m1Cb3s50; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="m1Cb3s50"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h3px75jfGzyVG;
	Mon, 20 Jul 2026 21:30:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784572252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Zl/lLY4zvwdVCBXGAFk2YxXL2BgBhSjDoLGRfcTcMI=;
	b=m1Cb3s50Wl/5wyhD2/06nnMzXhMMEZCNEgBTi9g+CQVXmSVyeVd8R4y2IAZuV+CzCKMm0b
	ou+V1AAeBcllCO2katM/Y1Hr73DBeIxO5qUAUFNSCPDBtiahperoJpzpp7/yto7/ylo3Ng
	hXpW1dUP869Ylka5NXU76pIEVgiSSsg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784572252;
	b=Q9j5uqKGaQEvhsHU6fENQRHrP55Gc9MZ/PmgXFXZZnsSIq7lmjStxTSJ70rf76b1eulx3t
	boJgVGsh5qiuG2jg5DrA2W6Nw1aR4Zx7+5H7IofsbwWNuzXRPFCDVrfm3JdzxZeSeoG6zr
	eibQtppsUBCs3tZ327WWUy/fxbrpCSc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784572252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Zl/lLY4zvwdVCBXGAFk2YxXL2BgBhSjDoLGRfcTcMI=;
	b=nyyImZQq4mJ5nSTZVGJlBKP9eTQ4PxiHHUQ29w3hS0RTsz/XIsDmrSBl87KH5/4hfxfZwo
	RQG9PAlEKU9jkoXbep7/R9EGmFF3LvpXOJ2u3283Fa4rA8aIoPROpbc9XHXwKwk+BK4I+T
	3Qn1qUS5WzBq4uytzq4CsNP4cObUiXU=
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
Subject: [PATCH v2] Bluetooth: ISO: fix UAF on socket close before shutdown completes
Date: Mon, 20 Jul 2026 21:30:42 +0300
Message-ID: <4d96c545ad1a2fed02440a3478905853286aa0c7.1784571683.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_disconn() aims to disconnect the hcon by dropping it, which
triggers iso_conn_del() once the HCI operation completes, requiring
valid hcon->iso_data to do socket cleanup.  iso_sock_disconn() sets
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
 net/bluetooth/iso.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2e95a153912c..6abc2b1f59bc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -30,6 +30,7 @@ struct iso_conn {
 	/* @lock: spinlock protecting changes to iso_conn fields */
 	spinlock_t	lock;
 	struct sock	*sk;
+	bool		hcon_dropped;
 
 	struct delayed_work	timeout_work;
 
@@ -107,7 +108,8 @@ static void iso_conn_free(struct kref *ref)
 
 	if (conn->hcon) {
 		conn->hcon->iso_data = NULL;
-		hci_conn_drop(conn->hcon);
+		if (!conn->hcon_dropped)
+			hci_conn_drop(conn->hcon);
 	}
 
 	/* Ensure no more work items will run since hci_conn has been dropped */
@@ -306,6 +308,7 @@ static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
 
 	iso_pi(sk)->conn = conn;
 	conn->sk = sk;
+	conn->hcon_dropped = false;
 
 	if (parent)
 		bt_accept_enqueue(parent, sk, true);
@@ -836,8 +839,10 @@ static void iso_sock_disconn(struct sock *sk)
 
 	sk->sk_state = BT_DISCONN;
 	iso_conn_lock(iso_pi(sk)->conn);
-	hci_conn_drop(iso_pi(sk)->conn->hcon);
-	iso_pi(sk)->conn->hcon = NULL;
+	if (!iso_pi(sk)->conn->hcon_dropped) {
+		iso_pi(sk)->conn->hcon_dropped = true;
+		hci_conn_drop(iso_pi(sk)->conn->hcon);
+	}
 	iso_conn_unlock(iso_pi(sk)->conn);
 }
 
-- 
2.55.0

