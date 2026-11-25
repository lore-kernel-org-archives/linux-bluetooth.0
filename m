Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.78.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649835;
	b=CcBLWUQt2R/g1ecnJcSTkK6qaKUOnssxhGH3hBaqv5wainN94DQBn4izSddy0+7jkEx3
	 IFBgHqBJUpRvD+ra3cCe7ljeYWglys3b2NZplkZhwSTJcBdmLeN/bNcGqwDBHwGIFugrg
	 dfnE9/w4PDgFjnnkmYZVzVNkDQoAn8ZhNJI9Wgc8hPjSeK4uV9yUdJR1baFaLt/kFO92a
	 2K3VuRbV/QC5ffnr+ihFleWdaD4YbhrI+P9TvPfNo8cabL/zCQzKXgKKkkmzTos4CwGGH
	 S0JzNBqNON4bGdTaftxZWqE/Z6z3DgHFSZO6Y2+O+uC8nLrGpk3q1v2SyIYrumBm4XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649835;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=8oo5nCpeP5sMTgB1uSgxIcfS4aSto2Rv6mc6RR01f+U=;
	b=eoclItJ8ImanVKnN2kSmhshhBkCpHlEseeiabMd5MxA/qgHwU+wX3p5y/sjHqvBkEUf8
	 4tRqJFzKRXwk7kCPfa9cbAOoyBn2F9ph3V2LCBZyNSCwJOeXwryyAVx73cLEODuAkqvdZ
	 yi5eQXI9bB4lleod3nkOZM0TAtL3IcGdJQhPZab6Cf1ouk9Ltr+SGhWFHkuMf6DYjnXKE
	 h3D7ugKdEmiAiBbFbuHDsM3U68+KbPxauP+8WnSwtNs4DI+oX4zl3n3/aTAn0OsPoQpLQ
	 c8SZ4Ntk0nECqWsp8WRNDzwk9dtq9MeBewXlNneGFoUOFH1KNxeXP1Zm8ihAh3bGpmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=eK2BoigL;
	arc=none smtp.remote-ip=77.75.78.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6E606A32C;
	Wed, 25 Nov 2026 23:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54C6E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=eK2BoigL
Received: from email.seznam.cz
	by smtpc-mxb-67bf8c997c-nxznx
	(smtpc-mxb-67bf8c997c-nxznx [2a02:598:128:8a00::1000:93f])
	id 12771acda44db7d417f80085;
	Thu, 26 Nov 2026 00:37:00 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795649820; bh=8oo5nCpeP5sMTgB1uSgxIcfS4aSto2Rv6mc6RR01f+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=eK2BoigLpcPVvOe85ZZmP+Er0vcRTSVDq3nXM640yidwU3JfOIJRYTAIC+pgxLZJ2
	 +mADxHc9hTtAQCwphIHmTGnq1+YXzwffkGxboDppeBtbXqDdRsBhSZueNtGC0oq0PY
	 q+v/mJ0r1PRQEc7UnxvFK1d941bzq+zEehi3bqQf8ksQ7Rl1+SAQsFqcUhddRfOKTx
	 fYTRXulivGaBxNqnDZwoiNuu8V7jkgJLF7TFFz1vREpNEmj2D4/ezvXkjtMHKPSX3p
	 zzGIVqspUEv8mfRoooeb/Ep+RZTtHtitg1uwkuohaZWI9QTIS54wWsSHI1ln6ypvze
	 tqcaVaK9yaeig==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-86b589c786-pdzw7 (szn-email-smtpd/2.0.97) with ESMTPA
	id df72e338-89dd-44c5-a7b7-b04bd5762017;
	Thu, 26 Nov 2026 00:36:52 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Thu, 26 Nov 2026 00:36:49 +0100
Subject: [PATCH v5 2/4] Bluetooth: find a peer's LE connection by its IRK
 as well
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-for-upstream-le-conn-params-rpa-v5-2-b7f015a35023@podgorny.cz>
References: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
In-Reply-To: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

hci_connect_le() creates the connection under the peer's RPA when the
controller cannot resolve it, and the connection stays there until it
completes. hci_conn_hash_lookup_le() given the peer's identity misses it,
and so does every caller looking the peer up by its identity in that
window. hci_connect_le() itself is one: the connection stays BT_OPEN, out
of sight of hci_lookup_le_connect(), until hci_le_create_conn_sync()
runs, and a second advertising report in that window looks the
connection up by the identity, misses it, creates another hci_conn and
overwrites params->conn.

When no connection is kept under the address given, have
hci_conn_hash_lookup_le() find the one under an RPA of the peer whose
identity it is, by the peer's IRK, which also finds it after the peer
has moved to a new RPA. smp_irk_matches() is private to net/bluetooth,
so the function moves out of line. The rcu_read_lock() it already
takes covers the IRK list as well.

hci_connect_le() refuses a connection found this way with -EBUSY, also
while scanning: under an RPA, it has either been started by an earlier
advertising report already, or it belongs to an explicit connect made
before the IRK was known, and so to other params, which taking it over
would hand a reference they do not own. hci_connect_le_scan() reuses
it, as it does one found by address, except in that last case.

That explicit connect, still scanning under the RPA with params of its
own there, is never started, since the peer's advertising reports now
resolve to its identity. Other connects to the peer get -EBUSY until
its owner gives it up. A connection of their own would be dialled to
the same RPA while the peer keeps it, and le_conn_complete_evt(), which
matches a completion by address, would complete the older one and leave
the new one in BT_CONNECT, refusing every LE connect after it.

Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 include/net/bluetooth/hci_core.h | 27 ++------------
 net/bluetooth/hci_conn.c         | 77 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4aa0b49ae104..071131f08c0a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1348,31 +1348,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
 	return NULL;
 }
 
-static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
-						       bdaddr_t *ba,
-						       __u8 ba_type)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != LE_LINK)
-		       continue;
-
-		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return NULL;
-}
+struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev, bdaddr_t *ba,
+					 __u8 ba_type);
 
 static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 							bdaddr_t *ba,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8638b7f8dee3..5676671d813c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1520,6 +1520,59 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 	return 0;
 }
 
+/* A connection to a peer the controller cannot resolve is kept under the
+ * peer's RPA until it completes, and the peer may have moved to a new RPA
+ * since. When there is no connection under the address given, find the one
+ * under an RPA of the peer whose identity it is, by the peer's IRK. A
+ * connection returned is therefore found by IRK only if its dst is not the
+ * address given.
+ *
+ * This function requires the caller holds hdev->lock, or rcu_read_lock()
+ * and req_lock as hci_cmd_sync_work() does: matching by IRK uses
+ * hdev->smp_data, which RCU does not protect, and which is set up and
+ * torn down under hdev->lock with req_lock held.
+ */
+struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev, bdaddr_t *ba,
+					 __u8 ba_type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *c;
+	struct smp_irk *irk;
+
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != LE_LINK)
+			continue;
+
+		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	irk = hci_find_irk_by_addr(hdev, ba, ba_type);
+	if (irk) {
+		list_for_each_entry_rcu(c, &h->list, list) {
+			if (c->type != LE_LINK ||
+			    !hci_bdaddr_is_rpa(&c->dst, c->dst_type))
+				continue;
+
+			if (smp_irk_matches(hdev, irk->val, &c->dst)) {
+				rcu_read_unlock();
+				return c;
+			}
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+EXPORT_SYMBOL(hci_conn_hash_lookup_le);
+
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role, u8 phy, u8 sec_phy)
@@ -1552,6 +1605,17 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (conn && !test_bit(HCI_CONN_SCANNING, conn->flags))
 		return ERR_PTR(-EBUSY);
 
+	/* A connection found by the peer's IRK instead is under one of its
+	 * RPAs. It is refused even while scanning: it has then either been
+	 * started by an earlier advertising report already, or it belongs
+	 * to an explicit connect made before the IRK was known, and so to
+	 * other params. A connection of our own would be dialled to the
+	 * same RPA, and le_conn_complete_evt(), which matches by address,
+	 * would complete the older one.
+	 */
+	if (conn && (conn->dst_type != dst_type || bacmp(&conn->dst, dst)))
+		return ERR_PTR(-EBUSY);
+
 	/* Check if the destination address has been resolved by the controller
 	 * since if it did then the identity address shall be used.
 	 */
@@ -1806,6 +1870,19 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	 * and return the object found.
 	 */
 	conn = hci_conn_hash_lookup_le(hdev, dst, dst_type);
+
+	/* Found by the peer's IRK, still scanning under an RPA with params
+	 * of its own there, this is an explicit connect made to the RPA
+	 * before the IRK was known, which is never started. Refuse, as
+	 * hci_connect_le() does, rather than wait on it or dial a second
+	 * connection to the same RPA.
+	 */
+	if (conn && test_bit(HCI_CONN_SCANNING, conn->flags) &&
+	    (conn->dst_type != dst_type || bacmp(&conn->dst, dst)) &&
+	    hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
+				      conn->dst_type))
+		return ERR_PTR(-EBUSY);
+
 	if (conn) {
 		if (conn->pending_sec_level < sec_level)
 			conn->pending_sec_level = sec_level;

-- 
2.56.1

