Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D931714F;
	Sat, 25 Jul 2026 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976714; cv=none; b=SW49poKweRK6idF65SgJIuXPUd3ptAPwr2onTBdgG7Np3fwFirDVZbvDvq3byLjlxDcXaS/x2gbnZkz2zgj4/4sG2bstHxqTQq6N8xbTGohR++Lyp+D5wrJM5R4JfrqDBtTZk6EvF2g7hOwvaPA3DYm2Lu7Xxq0B7T/ia4TwNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976714; c=relaxed/simple;
	bh=1gIFiFnwwIRR87Vgo4odjrR1jtwuzbe2xGruxwbaHD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CLpmdnhQi47/QvG7+HH8Ww/8oHEnSVNwqIYhGKAig19E2NdnXYULnZOJsKpQ5KyG2LLyqTmOIfoP/YWgZ4BXiCtnY9Pat9hXtPOMiXwFtE8NKSvzHoF/eD8oCZIEWJsbcNYqzkSyYQiDb8m1seQmuo5yl7DxoPNAgDarTZYuApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AAd+LY8/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AAd+LY8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1H
	aUpUAm2Tf2JlulmaptHGpSOvehD8h1D39YtyxHMUM=; b=AAd+LY8/2vyRlBxkUg
	bmVFYEj3zyItUk8c8ap9WRMDrF5NEQYqslewrmVH0EVFqd3pyQDPYMwzsLOyS6xk
	oPuFbWuNuwCHrdmCAmlbkbIzRNUSKzeJQd3cFqljkjV3JD6WiYhOtATAdtCVGl32
	/1pmvD1zdeHsrMdXiuDNLbFwE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCnF_sxlWRqWVwLLg--.7750S2;
	Sat, 25 Jul 2026 18:51:30 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] Bluetooth: ISO: fix UAF in iso_conn_ready
Date: Sat, 25 Jul 2026 18:51:27 +0800
Message-Id: <20260725105127.434136-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnF_sxlWRqWVwLLg--.7750S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xtF1xtrykuFyDCF1UGFg_yoW8tr4fpF
	WrWFWSqw1DJrn3ZF4xCF97WFs5trsakFy3K3yrXrWSyay5Kw43AFW8Kw4jkF1jkrW8Xayj
	yF4DWrZ3KF18AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRQJ5bUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRIlX2pklTIIoQAA3l

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
 net/bluetooth/iso.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2e95a153912c..c8103de41cdd 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2074,7 +2074,7 @@ static bool iso_match_dst(struct sock *sk, void *data)
 static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent = NULL;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 	struct hci_ev_le_big_sync_established *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
@@ -2083,6 +2083,10 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	iso_conn_lock(conn);
+	sk = iso_sock_hold(conn);
+	iso_conn_unlock(conn);
+
 	if (sk) {
 		/* Attempt to update source address in case of BIS Sender if
 		 * the advertisement is using a random address.
@@ -2103,7 +2107,8 @@ static void iso_conn_ready(struct iso_conn *conn)
 			}
 		}
 
-		iso_sock_ready(conn->sk);
+		iso_sock_ready(sk);
+		sock_put(sk);
 	} else {
 		hcon = conn->hcon;
 		if (!hcon)
-- 
2.34.1

