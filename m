Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248926;
	b=FCIhBekIStAA9Tngtu8IBTvme8YA2WCeQ6J00U5YC0xgGu+nP0CmRQ5FOJyckLaOQ8/B
	 I6hHmMxKuOYK3yVehEiYSm9b+yYsXvlA1DmoJ3gZMIL2XJVFbOOY9KtltfpmNrCaBMWI6
	 dUca0D8NPPq8ZXuDo89Ml/T8SUcgKwXVlTOzbb14YaRZESNr4O2R9pVhgNXliRx0FBHci
	 AlzsERcj9+0QJVfeLicdiD5/S4v4O2yLqK9Kp5xD6PTO//nPY9FIOeWAq3cNPhj7ESSBX
	 4wRUW7E6Y9myhcT6sxI/DLcswN1/65QyO1iTRVXSxaKuyrGUI7mn+ViU7wqGuHcyEng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=xPQ/Cj17nrhVuMh+39TstPE7Sh6mqTJLTOgDPwxqJp0=;
	b=zSK7FCLjDhQGtiKacQs0lx7P5jKU+wlUI7g7nFa8TFaWsQZDSZuaC22dMc16nd2EzMOx
	 ZYOLGu0o12nMzROiOEV9poIfB3tFthyu87uVv+O0tHs0xIbkSSUTD1ZUiXzIz2PrksAyx
	 xACFpPRtZjswqcMefLTgxUXYcc3wpIz935+5hV7cV5LLRg/NODxoMTO/Yn9Kmn0EGrvC2
	 eGt7RfJ2afaabpTBfeaJKkg6O1LFkQd8uH89U18KvuAVKoeWui+rxxfCjol99+K1SspuQ
	 IiaAb/oDfNPSMrAI5IwxgkQwjGFo5mZL4BK+HTYvUOwVdXqR1Oq+KdaG9Fu8SNTFxjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b="lZZrxPc/";
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698BF606AFD4;
	Mon,  9 Nov 2026 18:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698BF606AFD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=lZZrxPc/
Received: from email.seznam.cz
	by smtpc-mxb-5df7df959f-rrn6r
	(smtpc-mxb-5df7df959f-rrn6r [2a02:598:128:8a00::1000:931])
	id 1badb339ad971e201e22a971;
	Mon, 09 Nov 2026 19:28:26 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1794248906; bh=xPQ/Cj17nrhVuMh+39TstPE7Sh6mqTJLTOgDPwxqJp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=lZZrxPc/tM/e/s1thsKb7FaUi7oo6e0MvkYz0AkGLulgb4/aJH2MUER5NXv7Fft0v
	 DP5IHuH8zODzHaTAaud0bmtUWbTNFi+GIEiBIK9LFVpsBj59urvlBTU7HbqYrH/eyA
	 LIk8otXsFz51ZdLXUK+gmeNJRciQEC96nHA0I32eDoCbbzCk4NeWP998vaaI/stjxY
	 WZ1Wq9qag64VOuVhVvdP24XRR4S/fdBVjUZ0srjNgr/m/Q38APnpIggA2IPns7BKXf
	 m5jPDAdppGXNe1AG8+q6jRyZ7BQMSmd9Gg1jSmv4wojssafiUULRl2O7GHed3J575g
	 vtkJcxyKHeSGw==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-58c9c5bf5f-hp4dt (szn-email-smtpd/2.0.93) with ESMTPA
	id 178c6cae-1c84-4364-a643-41653bb12fe1;
	Mon, 09 Nov 2026 19:28:08 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Mon, 09 Nov 2026 19:28:07 +0100
Subject: [PATCH v3] Bluetooth: find an RPA peer's connection parameters by
 its identity
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
Message-Id: <20261109-for-upstream-le-conn-params-rpa-v3-1-ad1225bb0b8f@podgorny.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQVLDMAxFr9LxGpXIadKEFfdgWMiO0hga2yO7m
 ZZO7k5cNrBj+TX/P727SiyOk3rZ3ZXw4pILfgv1007ZifyJwQ1bVrrSLWKFMAaBS0xZmGY4M9j
 gPUQSmhNIJBh1XR9G0wwDHdVGicKjuz4+vL3/5HQxH2xzwZaGocRghLydyslk8HzNzzOlzFIKk
 0s5yO3huGAB/V9nQUDou67VPVW9sf1rDMMpiL/t7ZcqQov+TTygrrDu9ohtc8RmGwsN/Pl3ta7
 rN1A9TQM5AQAA
X-Change-ID: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

A bonded peer's connection parameters are stored under its identity
address, but hci_conn_params_lookup() matches only the exact address it
is given, so a caller holding the peer's RPA misses the entry.

hci_le_create_conn_sync() is such a caller: hci_connect_le() puts the
peer's cached RPA in conn->dst, and __hci_conn_add() no longer converts
it back when the controller cannot translate an identity address. The
connection is then created with the controller-wide defaults in hdev
instead of the peer's interval, latency and supervision timeout.

Resolve an RPA to its identity in hci_conn_params_lookup(), so every
caller finds the same entry whichever of the peer's addresses it holds.
The identity is looked up instead of the RPA, not after it: Pair Device
creates an entry under the RPA the peer had before bonding, and that
entry stays behind with default parameters. Matching it first would hand
it out for as long as the peer keeps that RPA. Such an entry is no
longer reachable by its RPA once the IRK is known; it is cleared with
the other disabled entries the next time all connection parameters are
loaded. The IRK can be freed by SMP without hdev->lock, so its identity
is copied out under rcu_read_lock().

hci_conn_params_add() and hci_conn_params_del() go through the same
lookup, so given a resolvable RPA they now act on the identity entry.
hci_conn_params_add() also stores a new entry under the identity, or a
later lookup by the identity or by a rotated RPA would miss it.

The returned entry can therefore hold a different address type than
the one the caller passed. load_conn_param() and load_conn_subrate()
look up the connection by the entry's address with the caller's type;
use the entry's type with it.

A connect made to the peer's RPA, through hci_connect_le_scan() from
Pair Device, an L2CAP socket or a CIS, now marks the identity entry for
the explicit connect. When the peer advertises, check_pending_le_conn()
calls hci_connect_le() with the resolved identity, but the scanning
connection is still under the RPA, so the lookup by identity misses it
and a second hci_conn is created. Look the scanning connection up by
the peer's IRK instead, which also finds it after the peer has moved to
a new RPA. Do so whether the host or the controller resolved the
advertisement, and whether or not an RPA is cached for the peer: both
lead to check_pending_le_conn() with the identity. The RPA dialled is
copied out of the IRK under rcu_read_lock() for the same reason as
above.

Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
v3 addresses the issues Sashiko raised on v2:
https://sashiko.dev/#/patchset/20261104120138.1165715-1-radek%40podgorny.cz

Tested on v7.3.1 (the flags test needs &c->flags there) with a
Raspberry Pi CYW43455 central and a peer on a resolvable private
address whose parameters are loaded under its identity: 7 of 7
connects, one Create Connection each to the RPA, each carrying the
identity's parameters. Not exercised: an RPA rotation between
attempts, and the controller-resolved and no-cached-RPA cases of the
scanning-connection lookup, which this controller and peer cannot reach.

Per Documentation/process/generated-content.rst: the patch and this
message were done with the Claude coding assistant (model as in the
Assisted-by trailer). The prompts asked it to fix the issues Sashiko
raised on v2, then to review the result following Sashiko's published
review prompts and fix what that turned up. The author directed the work
and reviewed the result.
---
Changes in v3:
- Look up the identity instead of the RPA, not after it, so an entry
  left under the peer's pre-bonding RPA cannot shadow it
- Copy the identity out of the IRK under rcu_read_lock(), since SMP can
  free the IRK without hdev->lock
- hci_conn_params_add() stores a new entry under the identity
- load_conn_param() and load_conn_subrate(): look up the connection with
  the entry's address type
- hci_connect_le(): find the scanning connection of a connect made to
  the peer's RPA by its IRK, so it is not duplicated once the identity
  entry is pending, even after the peer has moved to a new RPA, and
  also when the controller resolved the advertisement or no RPA is
  cached for the peer. Kept in this patch, since on its own it would
  leave a reference imbalance until the lookup is fixed
- Rebased on bluetooth-next
- Link to v2: https://patch.msgid.link/20261104120138.1165715-1-radek@podgorny.cz

Changes in v2:
- Resolve the RPA inside hci_conn_params_lookup() rather than at the
  hci_le_create_conn_sync() call site, as Luiz suggested, so no other
  caller can miss the entry
- Rebased on bluetooth-next
- Link to v1: https://patch.msgid.link/20261101-for-upstream-le-conn-params-rpa-v1-1-988629a09bc9@podgorny.cz
---
 net/bluetooth/hci_conn.c | 60 ++++++++++++++++++++++++++++++++++++++++--------
 net/bluetooth/hci_core.c | 32 ++++++++++++++++++++++++++
 net/bluetooth/mgmt.c     |  4 ++--
 3 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index eebd73988bf6..fddfeca9b02a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1502,12 +1502,42 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 	return 0;
 }
 
+/* A connect made to one of the peer's RPAs leaves its scanning object under
+ * that RPA when the controller cannot resolve it, and the peer may have
+ * moved to a new RPA since. Match it by the peer's IRK instead of by address.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static struct hci_conn *le_scanning_conn_by_irk(struct hci_dev *hdev,
+						const u8 irk_val[16])
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *c;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != LE_LINK ||
+		    !test_bit(HCI_CONN_SCANNING, c->flags) ||
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
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role, u8 phy, u8 sec_phy)
 {
 	struct hci_conn *conn;
 	struct smp_irk *irk;
+	bdaddr_t rpa;
 	int err;
 
 	/* Let's make sure that le is enabled.*/
@@ -1533,25 +1563,35 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (conn && !test_bit(HCI_CONN_SCANNING, conn->flags))
 		return ERR_PTR(-EBUSY);
 
-	/* Check if the destination address has been resolved by the controller
-	 * since if it did then the identity address shall be used.
-	 */
-	if (!dst_resolved) {
-		/* When given an identity address with existing identity
-		 * resolving key, the connection needs to be established
-		 * to a resolvable random address.
+	rcu_read_lock();
+	irk = hci_find_irk_by_addr(hdev, dst, dst_type);
+	if (irk) {
+		/* A connect made to one of the peer's RPAs is still scanning
+		 * under that RPA, whatever address the peer is seen on now.
+		 */
+		if (!conn)
+			conn = le_scanning_conn_by_irk(hdev, irk->val);
+
+		/* Check if the destination address has been resolved by the
+		 * controller since if it did then the identity address shall
+		 * be used.
+		 *
+		 * Otherwise, when given an identity address with existing
+		 * identity resolving key, the connection needs to be
+		 * established to a resolvable random address.
 		 *
 		 * Storing the resolvable random address is required here
 		 * to handle connection failures. The address will later
 		 * be resolved back into the original identity address
 		 * from the connect request.
 		 */
-		irk = hci_find_irk_by_addr(hdev, dst, dst_type);
-		if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
-			dst = &irk->rpa;
+		if (!dst_resolved && bacmp(&irk->rpa, BDADDR_ANY)) {
+			bacpy(&rpa, &irk->rpa);
+			dst = &rpa;
 			dst_type = ADDR_LE_DEV_RANDOM;
 		}
 	}
+	rcu_read_unlock();
 
 	if (conn) {
 		/* dst may just have been swapped for the peer's RPA above, and
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bfc5bdebc71a..c9f4f4038e0a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2285,11 +2285,37 @@ int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
 	return 0;
 }
 
+/* A peer's connection parameters are kept under its identity address, so
+ * point *addr and *addr_type at the identity behind an RPA we can resolve.
+ * SMP can free the IRK without hdev->lock, so the identity is copied to
+ * @id_addr before leaving the RCU read-side section.
+ */
+static void conn_params_resolve(struct hci_dev *hdev, bdaddr_t **addr,
+				u8 *addr_type, bdaddr_t *id_addr)
+{
+	struct smp_irk *irk;
+
+	if (!hci_bdaddr_is_rpa(*addr, *addr_type))
+		return;
+
+	rcu_read_lock();
+	irk = hci_find_irk_by_rpa(hdev, *addr);
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
 {
 	struct hci_conn_params *params;
+	bdaddr_t id_addr;
+
+	conn_params_resolve(hdev, &addr, &addr_type, &id_addr);
 
 	list_for_each_entry(params, &hdev->le_conn_params, list) {
 		if (bacmp(&params->addr, addr) == 0 &&
@@ -2345,6 +2371,12 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *params;
+	bdaddr_t id_addr;
+
+	/* Store a new entry under the identity too, or lookups by the
+	 * identity or a later RPA would miss it.
+	 */
+	conn_params_resolve(hdev, &addr, &addr_type, &id_addr);
 
 	params = hci_conn_params_lookup(hdev, addr, addr_type);
 	if (params)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 260ef2a45719..3bf62fa2e7c2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8265,7 +8265,7 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			 * a connection update.
 			 */
 			conn = hci_conn_hash_lookup_le(hdev, &hci_param->addr,
-						       addr_type);
+						       hci_param->addr_type);
 			if (conn && conn->role == HCI_ROLE_MASTER &&
 			    (conn->le_conn_min_interval != min ||
 			     conn->le_conn_max_interval != max ||
@@ -8380,7 +8380,7 @@ static int load_conn_subrate(struct sock *sk, struct hci_dev *hdev, void *data,
 
 			conn = hci_conn_hash_lookup_le(hdev,
 						       &hci_param->addr,
-						       addr_type);
+						       hci_param->addr_type);
 			if (conn && conn->state == BT_CONNECTED &&
 			    (conn->le_rate_interval < min ||
 			     conn->le_rate_interval > max ||

---
base-commit: 4c684359d8e17be11c7fdace223dd1801bd0f1b1
change-id: 20261101-for-upstream-le-conn-params-rpa-f2334fb5dda7

-- 
Radek Podgorny <radek@podgorny.cz>

