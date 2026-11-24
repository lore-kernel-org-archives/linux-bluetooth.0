Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512682;
	b=JahueIjPdsmP9xXQVP8fsMxjpIXm7tl0xeeTPwV2gKWSoQLPTxIk8N8rboAN75Aas0Vj
	 rzCFid2RBqxHxrWNkLdrqlXt82KhNiinHjZV1OzImpNKBdszrxDrwo3kkZn2ozhR3EcCP
	 vX2uN+s3HtGF0K/JvY82gGb76csHCd4mh2cCGxk+4WYuN5jghPWrqlSPhYg4/Het6Ie5J
	 uQ+THQnZEH0g4BOA41EV/HbNrLrivlhm8ned32w6VkoB7kG70GNriDSkgsd6gHITBbZwR
	 zBnYYiMtQpOZJRVVtgdN8FMs9n9GzzQpzcliTx9vDRqx9icRtSb/7G7k3aKDTE1fX4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512682;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=FzbVfcPRNou4tA4fnO7EvJRFEff/xs4EhP8qiIC3aCw=;
	b=moXDrXPyidsCJYnETPLwvalXXSOV0v9SWCpoA8EYtv9oHuZB6CaiLccUz9oH/XFaY5Dv
	 lSgfZf0SVAjhO6GrraemxXH3NwR48SJzuaFJE5hZTu5JD1gva/5yAnRiT63eTH5vZ3+Yd
	 O++jZvVqfl5Yrq9+Z8BzsvZzXP4DoVHeKTOJ3CyEE9XyGEeg9ENL9e543M45BW3wWdqXV
	 IfwvIP2QIEw/3MgyEeYR+KSsJMJvgD3RfmgLO4Ohw1i3KYn36NokgfgL4f73axn8gP++U
	 rG5xrBgzB3kkB0RZmsieWWAnGUG6ZOX2CObDs/aKWdGCYI299nElmkbKK8iBCwfmmJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=qfaWiWU1;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E3606A33B;
	Tue, 24 Nov 2026 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C11E3606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=qfaWiWU1
Received: from email.seznam.cz
	by smtpc-mxb-5bd84c9575-j92sp
	(smtpc-mxb-5bd84c9575-j92sp [2a02:598:96:8a00::1200:505])
	id 1c64b775aa5e1a6c19ebad3d;
	Tue, 24 Nov 2026 10:31:06 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795512666; bh=FzbVfcPRNou4tA4fnO7EvJRFEff/xs4EhP8qiIC3aCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=qfaWiWU1HGsnaq2+4N9gbwOXww5ihu98bNyOjswZSVX/iNv4gCi74Kz7DyzJxshv4
	 AYB5VB42oAg7cNklFM/58OQTDqYebJpZ5JeGul1QGdYiK6Z/3ztlb5nR42TkIj5kH1
	 gMDb9YGdTOCIxXZiMEPf0iTY3UTc5ouVP1LcNsp1F3kLr1cWZ5///5yNJeyr9/Wq5J
	 QHzPmSqursKLWv4nNiqx29I+rSV2aK4ky1ovB70SQMzIGp8PUsGtE1OSOCeot5Xvjp
	 ZKyGhd9u8YwDur2G+y5ZRYcY+XIlc6u3P0ztCINDSiz+Pdu4k9xPvUdkIORKvK+Kmj
	 zCYjFI7z3RNRA==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-584bc557d7-pqx9t (szn-email-smtpd/2.0.97) with ESMTPA
	id 049b94d3-d632-4051-91ef-bdac6b7bd993;
	Tue, 24 Nov 2026 10:31:02 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Tue, 24 Nov 2026 10:31:00 +0100
Subject: [PATCH v4 4/4] Bluetooth: find an RPA peer's connection parameters
 by its identity
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
Message-Id: <20261124-for-upstream-le-conn-params-rpa-v4-4-f2dd5eb41f45@podgorny.cz>
References: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
In-Reply-To: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
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
loaded.

hci_conn_params_del() goes through the same lookup, so given a
resolvable RPA it now acts on the identity entry. hci_conn_params_add()
resolves the address once and uses the result both to look for an
existing entry and as the key of a new one, so a new entry is created
under the identity and a later lookup by the identity or by a rotated
RPA finds it. hci_connect_le_scan_cleanup() and le_conn_complete_evt()
free the explicit connect's entry they already hold instead of deleting
it by address, since that lookup now resolves the address again and
could reach another entry if the IRK arrived in between.

The returned entry can therefore hold a different address type than
the one the caller passed. load_conn_param() and load_conn_subrate()
look up the connection by the entry's address with the caller's type;
use the entry's type with it.

Set Device Flags and Get Device Flags given an RPA now act on the
identity's entry, where Set used to create a separate one under the RPA,
which only a lookup by that same RPA could find, and Get failed. Their
reply and the Device Flags Changed event still carry the address the
caller gave, as other mgmt commands do.

Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 net/bluetooth/hci_conn.c  |  3 ++-
 net/bluetooth/hci_core.c  | 30 ++++++++++++++++++++++++++----
 net/bluetooth/hci_event.c |  4 ++--
 net/bluetooth/mgmt.c      |  4 ++--
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 791df930650e..c37271586345 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -117,7 +117,8 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 
 	switch (params->auto_connect) {
 	case HCI_AUTO_CONN_EXPLICIT:
-		hci_conn_params_del(hdev, bdaddr, bdaddr_type);
+		hci_conn_params_free(params);
+		hci_update_passive_scan(hdev);
 		/* return instead of break to avoid duplicate scan update */
 		return;
 	case HCI_AUTO_CONN_DIRECT:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a87c92dccd4f..568c99bf86db 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2379,9 +2379,14 @@ void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
 	rcu_read_unlock();
 }
 
-/* This function requires the caller holds hdev->lock */
-struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
-					       bdaddr_t *addr, u8 addr_type)
+/* Like hci_conn_params_lookup(), but without resolving an RPA to its
+ * identity.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static struct hci_conn_params *__hci_conn_params_lookup(struct hci_dev *hdev,
+							bdaddr_t *addr,
+							u8 addr_type)
 {
 	struct hci_conn_params *params;
 
@@ -2395,6 +2400,17 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
+/* This function requires the caller holds hdev->lock */
+struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
+					       bdaddr_t *addr, u8 addr_type)
+{
+	bdaddr_t id_addr;
+
+	hci_rpa_to_identity(hdev, &addr, &addr_type, &id_addr);
+
+	return __hci_conn_params_lookup(hdev, addr, addr_type);
+}
+
 /* This function requires the caller holds hdev->lock or rcu_read_lock */
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr, u8 addr_type)
@@ -2439,8 +2455,14 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *params;
+	bdaddr_t id_addr;
 
-	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	/* Resolve once, and use the result both to search and as the key
+	 * of a new entry.
+	 */
+	hci_rpa_to_identity(hdev, &addr, &addr_type, &id_addr);
+
+	params = __hci_conn_params_lookup(hdev, addr, addr_type);
 	if (params)
 		return params;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6c7f9a9f55a..f7dbfb484d01 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6551,8 +6551,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 			switch (params->auto_connect) {
 			case HCI_AUTO_CONN_EXPLICIT:
-				hci_conn_params_del(hdev, &conn->dst,
-						    conn->dst_type);
+				hci_conn_params_free(params);
+				hci_update_passive_scan(hdev);
 				break;
 			case HCI_AUTO_CONN_REPORT:
 				hci_pend_le_list_add(params,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d21538634bc3..64886b0a9091 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8456,7 +8456,7 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			 * a connection update.
 			 */
 			conn = hci_conn_hash_lookup_le(hdev, &hci_param->addr,
-						       addr_type);
+						       hci_param->addr_type);
 			if (conn && conn->role == HCI_ROLE_MASTER &&
 			    (conn->le_conn_min_interval != min ||
 			     conn->le_conn_max_interval != max ||
@@ -8571,7 +8571,7 @@ static int load_conn_subrate(struct sock *sk, struct hci_dev *hdev, void *data,
 
 			conn = hci_conn_hash_lookup_le(hdev,
 						       &hci_param->addr,
-						       addr_type);
+						       hci_param->addr_type);
 			if (conn && conn->state == BT_CONNECTED &&
 			    (conn->le_rate_interval < min ||
 			     conn->le_rate_interval > max ||

-- 
2.56.1

