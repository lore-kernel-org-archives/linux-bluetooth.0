Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.78.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512675;
	b=f3NQksMEdec+IOdKw3SsWqIii/AWzmE5XM559xrEPP5vS7nel3yKWHj3Q/gL7rA3uLBq
	 rTlN+RbNSu3KmnI35XcCfBvD7mpHxHQR07YgKuZEIbVtNhrvcanrJ8jAcI50788rdze8O
	 kMj13vx/Ob9JRunIfHaPLrSd+pd/sXIRbI6knMzu9v97wNKohdIT0AE5/UwZ62cyNhE4/
	 fJ8IoPqxZbrsbst92sdq4ujKsHDBrjT9S/nRR663tmd2sXt08C+KF77hrBuHjM7UDp05y
	 SWCEhy0eiUesbyBh9aZ7z8gMEchAKFd6izhfL52fb+7tuVa9T4eMkauTR7MxnNlNpUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=jm0pg8mi4c+vKOs4I3fCVMNCqq2U0x5wOZd4jvsZzpo=;
	b=5cPHxgt8Vy0MblMF6+wHq6koSzo7+RTAmQgXS9gk2JCjzRYafn2jQgvuBWzoSAo886AG
	 kG/67MZeSFI9v6NCfTRVo4CEiWeGx3mnB6Kr9XAbvEJjRYC/H3tqyhPfonp8j84l94xUK
	 nl8tdXNQVEKEsM1gLtjveYQmhZTainpngS5xjkRVegKlEryCrOwlIRM5axCC9EfTKzVmC
	 HMM8OKVcpNPBHtFSSheENjrV1S0n5N6rayffO7KwxuQtamftcG6rW7cBsGPrXAM+Floge
	 j9KlaJGtVmuLIT21gAFw8inwfjmSgh/3aQmRTl4g8GhQ2IlTtXxencIky1YwYgIcoBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=W+je61bn;
	arc=none smtp.remote-ip=77.75.78.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B5606A32D;
	Tue, 24 Nov 2026 09:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4B5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=W+je61bn
Received: from email.seznam.cz
	by smtpc-mxb-5bd84c9575-nc5th
	(smtpc-mxb-5bd84c9575-nc5th [2a02:598:64:8a00::1000:947])
	id 083ec157be046c4e0db1db1f;
	Tue, 24 Nov 2026 10:31:02 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795512662; bh=jm0pg8mi4c+vKOs4I3fCVMNCqq2U0x5wOZd4jvsZzpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=W+je61bnNwlWPSDdsDV2KnQBJTHPT5jRfmtHJ9HrDpqqretK199cNpK2oJWDHc7Jb
	 WakhYRLcKGSfNj1MoTlisAJruvzbEjQs3rwBISOhUhdwyeIjJm/HiYC43Suy/YEx5m
	 r4zveCQNjUuVeUo+C8+MBj9BlektwkzV/xwWnjlINMZN45WibyS7mav1Z6R58BmZc6
	 3RhTGUHkSsgUXsGBGq+QfagtPhd1Nrs7S9f3j5Hs8oPLm2uP1ZZpUyaBgfykK6CN+f
	 xO4f8lJRnhyjnbZPEbLnPRCla1BCZWtTt71VI1c6CZIz1lwk2CC7KP6ZEJoYQ4p+8S
	 deP9MVJPpGmxQ==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-584bc557d7-pqx9t (szn-email-smtpd/2.0.97) with ESMTPA
	id c5c0371c-fdd6-47ba-8132-755a04ca86f3;
	Tue, 24 Nov 2026 10:31:01 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Tue, 24 Nov 2026 10:30:58 +0100
Subject: [PATCH v4 2/4] Bluetooth: connect to an RPA as to the identity
 behind it
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
Message-Id: <20261124-for-upstream-le-conn-params-rpa-v4-2-f2dd5eb41f45@podgorny.cz>
References: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
In-Reply-To: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

A connect made to a peer's RPA through hci_connect_le_scan(), from Pair
Device, an L2CAP socket or a CIS, looks for an existing connection by
that RPA only. A bonded peer's established connection is kept under its
identity, so the lookup misses it and a second hci_conn is created
under the RPA, which waits until the connect times out. An L2CAP
connect to the RPA of a connected peer does exactly that on v7.3.5.
The connect also marks params under the RPA for itself, while the
peer's advertising reports are resolved to its identity before
check_pending_le_conn() looks params up, so it is never started either.

Resolve an RPA to the identity first, through a new
hci_rpa_to_identity(), so the connect proceeds as one made to the
identity: it finds the peer's connection and marks the identity's
params. hci_connect_le() still puts the RPA on air when the controller
cannot resolve it. SMP can free the IRK without hdev->lock, so the
identity is copied out under rcu_read_lock().

A connection hci_connect_le() is already creating for the peer is kept
under the RPA it dials, which the lookup by the identity now misses.
Fall back to finding the peer's connection by its IRK, which also finds
it after the peer has moved to a new RPA.

Fixes: f75113a26008 ("Bluetooth: add hci_connect_le_scan")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 57 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         | 20 ++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4aa0b49ae104..28eb79dd51f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1927,6 +1927,8 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 				 u8 type);
 void hci_bdaddr_list_clear(struct list_head *list);
 
+void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
+			 u8 *addr_type, bdaddr_t *id_addr);
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8638b7f8dee3..c1583cb6c28a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1520,6 +1520,54 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 	return 0;
 }
 
+/* A connection to a peer the controller cannot resolve is kept under the
+ * peer's RPA until it completes, and the peer may have moved to a new RPA
+ * since. Match it by the peer's IRK instead of by address.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static struct hci_conn *le_conn_by_irk(struct hci_dev *hdev,
+				       const u8 irk_val[16])
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *c;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != LE_LINK ||
+		    !hci_bdaddr_is_rpa(&c->dst, c->dst_type))
+			continue;
+
+		if (smp_irk_matches(hdev, irk_val, &c->dst)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+/* Find the LE connection of the peer at addr by the peer's IRK, for when it
+ * is kept under one of the peer's RPAs instead of addr.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static struct hci_conn *le_conn_lookup_irk(struct hci_dev *hdev,
+					   bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn *conn = NULL;
+	struct smp_irk *irk;
+
+	rcu_read_lock();
+	irk = hci_find_irk_by_addr(hdev, addr, addr_type);
+	if (irk)
+		conn = le_conn_by_irk(hdev, irk->val);
+	rcu_read_unlock();
+
+	return conn;
+}
+
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role, u8 phy, u8 sec_phy)
@@ -1787,6 +1835,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     enum conn_reasons conn_reason)
 {
 	struct hci_conn *conn;
+	bdaddr_t id_addr;
 
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
@@ -1796,6 +1845,12 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Connect to the peer as if by its identity, under which its
+	 * connection and parameters are kept. hci_connect_le() puts its RPA
+	 * on air when the controller cannot resolve it.
+	 */
+	hci_rpa_to_identity(hdev, &dst, &dst_type, &id_addr);
+
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
@@ -1806,6 +1861,8 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	 * and return the object found.
 	 */
 	conn = hci_conn_hash_lookup_le(hdev, dst, dst_type);
+	if (!conn)
+		conn = le_conn_lookup_irk(hdev, dst, dst_type);
 	if (conn) {
 		if (conn->pending_sec_level < sec_level)
 			conn->pending_sec_level = sec_level;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 024960e9af66..a87c92dccd4f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2359,6 +2359,26 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 	return 0;
 }
 
+/* A peer we hold the IRK of is tracked under its identity address, so
+ * point *addr and *addr_type at the identity behind an RPA we can resolve.
+ * SMP can free the IRK without hdev->lock, so the identity is copied to
+ * @id_addr before leaving the RCU read-side section.
+ */
+void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
+			 u8 *addr_type, bdaddr_t *id_addr)
+{
+	struct smp_irk *irk;
+
+	rcu_read_lock();
+	irk = hci_get_irk(hdev, *addr, *addr_type);
+	if (irk) {
+		bacpy(id_addr, &irk->bdaddr);
+		*addr = id_addr;
+		*addr_type = irk->addr_type;
+	}
+	rcu_read_unlock();
+}
+
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type)

-- 
2.56.1

