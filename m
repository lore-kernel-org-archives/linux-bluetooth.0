Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036C38E11A;
	Fri, 24 Jul 2026 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924451; cv=pass; b=Io0Xn9b3wfd+SGZ5gl3lePqKoR12b0GENSYHa7Q0uAAVV5PeesP8A4yp4LvT78PEKJ97O0LFFrgKH1m1tQt+9PZecypKpZyeVLRgjlNeZSS0GUuHOskfG6wrD4BVfkGU5PW7AswIfKZqY1xipoaa9I83xlREZXvQgtURbQOnz5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924451; c=relaxed/simple;
	bh=sJmTyEermAhBWh1DBtQKsgekpmah+gX4k4+EUtQvrKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqsmtY8YghcYB0Eb4zaHGiyA7beWgP1XWsVOAk7LOqbd6DAvUX/K4wPHLecrTr4xvUJubuisusIdpFQKg6zVI7+dAcRodgzIeTX8Z379IMTB/Oqp4GoFjn6eq94Iq99XrSJW7TwjWiHBz7h1vgcvIsIxAFI7oacHjuREErq/D+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mDQ6VEXl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mDQ6VEXl"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KB15PmKzyVm;
	Fri, 24 Jul 2026 23:20:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYo35VvXbcvCZTkQ9fLtntLwksh1qmIBWoVZSEABaVw=;
	b=mDQ6VEXlEN8Lh4oAETCnJIb1vG1bsaVnR9jW48YvPgMz7THu6ix6l+9cpAqiww/ECyQAlU
	LFwxQEmFsZLIjescEYm2LPLrJneg8DwXy4fd4mvTUwWRnidy64O+0R12RZyaxA/7rJuPdu
	GHRIvpGGqiyOuDXEPMvKWPKes4vQE00=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924442;
	b=aAu/ELXpX4Lpjg4l75gcvtpMJSAch8RWQJIS9YgIh2cvLXXEoxfgbo/S+kUR7+v3DsePOX
	OchBMd7xjDS0AxBtHIRA7yCpgwIDC615heKXPcwXCABFuLqfj1JAXOVqaIis9hCcsYMW1B
	Xsw2/90HR8NG6VYfdYYmMXdGuoHw8Hw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYo35VvXbcvCZTkQ9fLtntLwksh1qmIBWoVZSEABaVw=;
	b=e29qeXBzZPfsb6YKeRUAZqpzVrfOy8Y1Z4e2bZXQlJkxE1lBl64qo2YeOCKqO0pB8wM/jA
	b8n3u0F131ZA/Nomq/y0VlpWFJOCe6cJAIJcpPV+SEidxLN9Jp6KvcujuVExDXMZ/Hpap3
	UVPPMF+VzfXG1n6gi1lJqGFRLHENSDE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
Date: Fri, 24 Jul 2026 23:20:24 +0300
Message-ID: <0a86ca1839556192d402317eba371d6cba3660cc.1784923689.git.pav@iki.fi>
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

Commit e824c0bbe0ec ("Bluetooth: ISO: clear iso_data always when detaching conn from hcon")
merged a version of the UAF fix that breaks releasing connected
ISO sockets. Since hci_conn::iso_data is set to NULL, iso_chan_del() won't
be called when the hci_conn disconnects, and the ISO socket does not emit
POLLHUP correctly.

Fix by retaining full hci_conn <-> iso_conn association while in
BT_DISCONNECT state, so that local disconnect via shutdown() follows
similar ISO socket code path as remote disconnect.  Use a separate flag
to track whether hci_conn_drop() is needed, instead of setting
iso_conn::hcon = NULL

In iso_sock_ready(), disallow disconnecting socket going BT_CONNECTED,
in case hcon connects while its drop is pending.

Fixes: e824c0bbe0ec ("Bluetooth: ISO: clear iso_data always when detaching conn from hcon")
Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This is rebased version of and supercedes
    
    https://lore.kernel.org/linux-bluetooth/fbd9dd573bb1ce5f38370128dd35447e2ddfed9c.1784625576.git.pav@iki.fi/

 net/bluetooth/iso.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index babba61eb335..299a9336b5e1 100644
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
@@ -835,11 +843,8 @@ static void iso_sock_disconn(struct sock *sk)
 	}
 
 	sk->sk_state = BT_DISCONN;
-	iso_conn_lock(iso_pi(sk)->conn);
-	hci_conn_drop(iso_pi(sk)->conn->hcon);
-	iso_pi(sk)->conn->hcon->iso_data = NULL;
-	iso_pi(sk)->conn->hcon = NULL;
-	iso_conn_unlock(iso_pi(sk)->conn);
+	if (!test_and_set_bit(ISO_CONN_DROPPED, iso_pi(sk)->conn->flags))
+		hci_conn_drop(iso_pi(sk)->conn->hcon);
 }
 
 static void __iso_sock_close(struct sock *sk)
@@ -2042,9 +2047,18 @@ static void iso_sock_ready(struct sock *sk)
 		return;
 
 	lock_sock(sk);
+
+	switch (sk->sk_state) {
+	case BT_DISCONN:
+	case BT_CLOSED:
+		release_sock(sk);
+		return;
+	}
+
 	iso_sock_clear_timer(sk);
 	sk->sk_state = BT_CONNECTED;
 	sk->sk_state_change(sk);
+
 	release_sock(sk);
 }
 
-- 
2.55.0

