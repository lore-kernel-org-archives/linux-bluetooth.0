Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056D3C0605;
	Mon, 27 Jul 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142828; cv=none; b=uWhXDRUbHizr425a5QRvTMyVIHj5S1Dn6+kMSYlHlgwNEE3op0o/gJ9DLEe/rsR7UVByND3r7Ha79/meiRsfn+cpJCF6m3MVqj8QxgUD3R/cN3dQybgQ+ozQYYZi9LBDXGUtfgxDD+5rlhl7NZx64ocEhBWRRq9mgVU3D9NiHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142828; c=relaxed/simple;
	bh=LrQXs0GOqtxyA2Xl6R+ECfSxkc3ZOWEd/fhTRhuoq3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CAb0obMGDO5SkEDSrTOA6GFjL53Uo7FzJ0WI370Z6C4Q9tDhIyZuCfB6Hc/CLEFL9sRX+0B6S/OE2uikZFMD49nq4E8GmeF9vmd4Zx+Iaubg7O+sbJTATSa4hnyvFEs49+YI20h2chxa7Klx2xDFaKyisCFMUslQ68gt5gYk75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ITrdcOzv; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ITrdcOzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pP
	MyitIqaMRdMhH88cBJZyl5EP0AemZ5DvN7+Ly8/wc=; b=ITrdcOzvMmNZ82eDgA
	vYT3XFRz00DK4ddpwMI3c4hh9sYDYk2Rg/ORAQVen3DSMg+xKNlvR71M4D7ZQ4yU
	S9xvNAPltBkUNHE/kU81K5OwFvM/gweaHoOkGGye19QdHcEHFCiFmqXNHA/W+tPq
	2yMrodxAcAHPGt2Oo5UFyYUxc=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3Sj8dHmdqxv4GIA--.1581S2;
	Mon, 27 Jul 2026 17:00:14 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH v2] Bluetooth: ISO: fix UAF in iso_conn_ready
Date: Mon, 27 Jul 2026 17:00:11 +0800
Message-Id: <20260727090011.2814616-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3Sj8dHmdqxv4GIA--.1581S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF13Kr43GFW3Jr1kuFy8Xwb_yoWrXr1kpF
	W5WF4fXw4UJF93Xr4fAF97ursYyrnakry3K3yjqrWfAa45G34aqayDta1jyF4UtrZ2qrW3
	AF4UWa93KF4UAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRQJ5bUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B4DPWpnHh76sAAA3X

When iso_connect_cfm() calls iso_conn_ready(), the latter reads
conn->sk without holding a reference. A concurrent close() on the
ISO socket triggers iso_sock_kill() which frees sk, leading to a
use-after-free when iso_conn_ready() subsequently accesses the
freed sk via lock_sock() and iso_sock_ready().

This was triggered by a vhci-based PoC that races
LE Setup ISO Data Path (0x206e) command completion against
close() on the ISO socket. The crash manifests as a KASAN
null-ptr-deref in iso_connect_cfm() at offset 0x3c from a NULL
pointer, with the call trace:

 iso_connect_cfm+0x311/0x15f0
 hci_cc_le_setup_iso_path+0x46d/0x6f0
 hci_cmd_complete_evt+0x26d/0x990
 hci_event_packet+0x468/0xb40
 hci_rx_work+0x255/0x6e0

Fix by replacing the bare pointer read with iso_sock_hold(conn)
under iso_conn_lock, which atomically elevates the refcount,
and add sock_put() on the exit path where the hold succeeded.

Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
V1 -> V2: Re-check conn->sk after acquiring lock_sock to avoid state
          transition on closed socket. Moved conn->sk = NULL in
          iso_sock_kill() under lock_sock protection. Adjusted
          iso_sock_ready() to require caller holds lock_sock with
          lockdep_assert, and added BT_DISCONN/BT_CLOSED state guard.
---
 net/bluetooth/iso.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2e95a153912c..9a5628f3940e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -797,11 +797,13 @@ static void iso_sock_kill(struct sock *sk)
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
 	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
+	lock_sock(sk);
 	if (iso_pi(sk)->conn) {
 		iso_conn_lock(iso_pi(sk)->conn);
 		iso_pi(sk)->conn->sk = NULL;
 		iso_conn_unlock(iso_pi(sk)->conn);
 	}
+	release_sock(sk);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&iso_sk_list, sk);
@@ -2037,14 +2039,17 @@ static void iso_sock_ready(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
-	if (!sk)
+	lockdep_assert(lockdep_sock_is_held(sk));
+
+	switch (sk->sk_state) {
+	case BT_DISCONN:
+	case BT_CLOSED:
 		return;
+	}
 
-	lock_sock(sk);
 	iso_sock_clear_timer(sk);
 	sk->sk_state = BT_CONNECTED;
 	sk->sk_state_change(sk);
-	release_sock(sk);
 }
 
 static bool iso_match_big(struct sock *sk, void *data)
@@ -2074,7 +2079,7 @@ static bool iso_match_dst(struct sock *sk, void *data)
 static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent = NULL;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 	struct hci_ev_le_big_sync_established *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
@@ -2083,7 +2088,22 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	iso_conn_lock(conn);
+	sk = iso_sock_hold(conn);
+	iso_conn_unlock(conn);
+
 	if (sk) {
+		lock_sock(sk);
+
+		/* conn->sk may have become NULL if racing with sk close, but
+		 * due to held hdev->lock, it can't become different sk.
+		 */
+		if (!conn->sk) {
+			release_sock(sk);
+			sock_put(sk);
+			return;
+		}
+
 		/* Attempt to update source address in case of BIS Sender if
 		 * the advertisement is using a random address.
 		 */
@@ -2096,14 +2116,15 @@ static void iso_conn_ready(struct iso_conn *conn)
 			adv = hci_find_adv_instance(bis->hdev,
 						    bis->iso_qos.bcast.bis);
 			if (adv && bacmp(&adv->random_addr, BDADDR_ANY)) {
-				lock_sock(sk);
 				iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
 				bacpy(&iso_pi(sk)->src, &adv->random_addr);
-				release_sock(sk);
 			}
 		}
 
-		iso_sock_ready(conn->sk);
+		iso_sock_ready(sk);
+
+		release_sock(sk);
+		sock_put(sk);
 	} else {
 		hcon = conn->hcon;
 		if (!hcon)
-- 
2.34.1

