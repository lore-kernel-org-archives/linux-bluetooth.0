Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699F3542CF;
	Mon,  7 Sep 2026 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823292; cv=none; b=fRoSCwfe8Zkx62pftQiG2PBHpVJPKv+/Gev96oeW/FBWXV0/j54ODn0Tfbc+i/gpPQ6/v2KbjYxoyrhRwDrE1WFexGnilbrelL5eSIOFEH44Hda/8arga7VLEkDvg3kl2u88SwpWVXGCIaelcApxJ6NVozQ/5klgIst8g2Ym/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823292; c=relaxed/simple;
	bh=3k2fYtZmisRGK/iQ1S+/j61Zj4a0rLHIRAVjNmbByVk=;
	h=From:Subject:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNdU8Coqx/SllxHlDJSdroptziL+XNFoVWHuoz/PZpLT22cEdTT+NDZiuSYBoWOYo32HAzgjmSdBCL36so4fCDf61KRuWugx+rD3OGmWxyNnOLiWw45HSH5DqK78euu/64kUDR7MnDLXDM0aXB5L7M+DEXfnl8teuEsfWRFZxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=AgKRPZsY; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="AgKRPZsY"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-b5z24
	(smtpc-mxb-7db765f675-b5z24 [2a02:598:96:8a00::1200:50a])
	id 3d0331cd8b399cd4388c2b85;
	Tue, 08 Sep 2026 01:21:24 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788823284;
	bh=rIhXw37Y4+4tJiek4ZkeJonQ3pGSRZ6agkr7gyoscdk=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=AgKRPZsYQtetC83+DT4s8v5LJN3Sinyx7QpfKsNoddpamsJVLHgz/sm66qxFZEEcP
	 U2gdog61s1r4CWjkWdS9n94ap28287IhKda7YcYvmHtSLj33V+MXnDZXrc7ua0IRTL
	 hWKkLtgwg1nqzUsO29RjJ3623yz7L87XO9Jb4G2iiD3LqTywa3istIOyifhu+36j3f
	 kH11AAkhkVKUNhW5JhiIjXitkqqMs7oO1nXRQySiNcx3kgUXQjCsq9P4Vcdf+NE+zb
	 TiFzTcL229/WV+EJyz3EXG60ziwo9C1YUdDyBHQ4pT3nxHoNGfaJKJIV2bDcyybI5v
	 fiT9UTPzL+Ulg==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-57659868b8-2vb45 (szn-email-smtpd/2.0.82) with ESMTPA
	id 5bd250e8-8f10-4a49-9d84-dfbdeff74077;
	Tue, 08 Sep 2026 01:20:50 +0200
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH 2/2] Bluetooth: put the peer's on-air address on air when we
 cannot resolve
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radek Podgorny <radek@podgorny.cz>
Date: Tue, 08 Sep 2026 01:20:48 +0200
Message-ID: <20260908012048.3681904-4-radek@podgorny.cz>
In-Reply-To: <20260908012048.3681904-2-radek@podgorny.cz>
References: <20260908012048.3681904-2-radek@podgorny.cz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailer: python-smtplib (git format-patch body verbatim)

An identity address only reaches a peer that is advertising an RPA if the
controller resolves on our behalf. Where it cannot, the host has to put the
peer's on-air address on air itself.

hci_connect_le() used to do exactly that, swapping the caller's identity
address for the peer's cached RPA before creating the connection:

	irk = hci_find_irk_by_addr(hdev, dst, dst_type);
	if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
		dst = &irk->rpa;
		dst_type = ADDR_LE_DEV_RANDOM;
	}

__hci_conn_add() now resolves that RPA back to the identity address when it
stores it, so the swap no longer survives into conn->dst and the identity
address is what goes out. Storing the identity is right for host
bookkeeping, but nothing translates it again on the way to the controller.

A peer advertising an RPA cannot answer an identity address, so the attempt
burns a full create-connection timeout. That is not merely a slow connect:
a controller without extended scanning cannot scan while it is initiating,
so every dead attempt also takes the scanner off the air for the whole
timeout.

Measured on a CYW43438, which reports neither LL Privacy nor extended
advertising (LE features 3f 00 00 08 00 00 00 00), against a peer
advertising a resolvable private address the host holds the IRK for, with
the connection requested on the peer's identity address:

  before: LE Create Connection to the identity address, public type
          1.61s -> 22.07s, then LE Create Connection Cancel
          LE Connection Complete: Unknown Connection Identifier (0x02)
  after:  LE Create Connection to the peer's RPA, random type
          LE Connection Complete: Success

Advertising reports reaching the host per second, same window, same five
unrelated devices on the adapter:

  before   1s:2   [nothing from 2s through 21s]   22s:5  23s:3
  after    0s:11 1s:5 2s:2 3s:5 4s:3 5s:4 ... 21s:2 22s:1 23s:2

One dead connect costs twenty seconds of scanning for every device on the
adapter, not just the one being dialled. Enough of them in a row and the
host's advertisement monitor sees nothing for long enough to power-cycle
the adapter, dropping every link on it.

Choose the address to dial rather than assuming conn->dst:

  - if the controller is resolving and this peer's IRK is programmed, the
    identity address is correct and the resolving list translates it.
    Testing ll_privacy_capable() alone is not enough: it reports the
    feature bit, not whether resolution is switched on and not whether this
    peer is in the list. Resolution is cleared with the other volatile
    flags on power-off and switched off again while suspend pauses
    scanning, and a peer's IRK is only programmed along the accept list
    path, so a direct-connect target, a peer without
    HCI_CONN_FLAG_ADDRESS_RESOLUTION, and one that did not fit in a full
    list are all absent from it;
  - a dst that is already a private address is what the peer is on air with
    and needs no translation;
  - otherwise use the last RPA resolved for this peer, while it is still
    fresh. A stale RPA is worse than none: the peer has already rotated
    away from it.

The first branch was measured on an Intel controller that does report LL
Privacy. With the peer's IRK programmed into the controller's resolving
list the host puts the identity address on air and the controller
translates it, reporting Resolved Public with the peer's RPA
6D:CA:DB:24:14:E9 in LE Enhanced Connection Complete. With the peer
absent from the list the same setup dials that RPA itself.

The address is chosen once in hci_le_create_conn_sync() and handed to
whichever command builder runs, the same way own_addr_type already is, so
the two paths cannot disagree.

Store the chosen address in conn->dst when it is not already there. The
connection complete event names the address that was dialled and
hci_conn_hash_lookup_role() finds a connection by conn->dst, so leaving the
identity address behind would make the event miss this connection and add a
second one while this one waits out its timeout. le_conn_complete_evt()
resolves the address back to the identity once the link is up, which is the
same round trip hci_connect_le() has always relied on.

Fixes: 14b06c3a88f7 ("Bluetooth: HCI: Always use the identity address when initializing a connection")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 net/bluetooth/hci_sync.c | 82 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5376ade2cdc1..136d801baa85 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6794,8 +6794,60 @@ static void set_ext_conn_params(struct hci_conn *conn,
 	p->max_ce_len = cpu_to_le16(0x0000);
 }
 
+/* An RPA resolved more recently than this is taken to still be what the peer
+ * is on air with. The spec-recommended rotation period is the best estimate
+ * the host has; a stale RPA costs one failed connect, while falling back to an
+ * identity address the controller cannot translate costs a full
+ * create-connection timeout that cannot succeed.
+ */
+#define HCI_RPA_FRESH_TIMEOUT secs_to_jiffies(HCI_DEFAULT_RPA_TIMEOUT)
+
+/* Pick the address to put on air for an outgoing LE connection.
+ *
+ * hci_conn_add() stores the peer identity address whenever an IRK resolves,
+ * which is what host bookkeeping wants but not what reaches the peer: an
+ * identity address only gets there if the controller resolves on our behalf.
+ * Prefer an address the peer has actually been seen using.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static void hci_conn_select_peer_addr(struct hci_dev *hdev,
+				      struct hci_conn *conn,
+				      bdaddr_t *peer_addr, u8 *peer_addr_type)
+{
+	struct smp_irk *irk;
+
+	/* conn->dst is right both when the controller translates it for us and
+	 * when it is already a private address.
+	 */
+	bacpy(peer_addr, &conn->dst);
+	*peer_addr_type = conn->dst_type;
+
+	/* Supporting LL Privacy is not enough: resolution has to be switched on
+	 * and this peer's IRK actually programmed, which only happens along the
+	 * accept list path.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
+	    hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, &conn->dst,
+					    conn->dst_type))
+		return;
+
+	if (hci_bdaddr_is_rpa(&conn->dst, conn->dst_type))
+		return;
+
+	irk = hci_find_irk_by_addr(hdev, &conn->dst, conn->dst_type);
+	if (!irk || !bacmp(&irk->rpa, BDADDR_ANY) ||
+	    !time_before(jiffies, READ_ONCE(irk->rpa_jiffies) +
+				  HCI_RPA_FRESH_TIMEOUT))
+		return;
+
+	bacpy(peer_addr, &irk->rpa);
+	*peer_addr_type = ADDR_LE_DEV_RANDOM;
+}
+
 static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
-				       struct hci_conn *conn, u8 own_addr_type)
+				       struct hci_conn *conn, u8 own_addr_type,
+				       bdaddr_t *peer_addr, u8 peer_addr_type)
 {
 	struct hci_cp_le_ext_create_conn *cp;
 	struct hci_cp_le_ext_conn_param *p;
@@ -6807,8 +6859,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 
 	memset(cp, 0, sizeof(*cp));
 
-	bacpy(&cp->peer_addr, &conn->dst);
-	cp->peer_addr_type = conn->dst_type;
+	bacpy(&cp->peer_addr, peer_addr);
+	cp->peer_addr_type = peer_addr_type;
 	cp->own_addr_type = own_addr_type;
 
 	plen = sizeof(*cp);
@@ -6849,7 +6901,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_create_conn cp;
 	struct hci_conn_params *params;
-	u8 own_addr_type;
+	u8 own_addr_type, peer_addr_type;
+	bdaddr_t peer_addr;
 	int err;
 	struct hci_conn *conn = data;
 
@@ -6927,9 +6980,24 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	 */
 	set_bit(HCI_CONN_CREATE, &conn->flags);
 
+	hci_dev_lock(hdev);
+	hci_conn_select_peer_addr(hdev, conn, &peer_addr, &peer_addr_type);
+
+	/* The connection complete event names the address that was dialled and
+	 * hci_conn_hash_lookup_role() finds a connection by conn->dst, so
+	 * leaving the identity address there would make the event miss this
+	 * connection and build a second one. Follow the dialled address
+	 * instead; le_conn_complete_evt() resolves it back once the link is
+	 * up.
+	 */
+	bacpy(&conn->dst, &peer_addr);
+	conn->dst_type = peer_addr_type;
+	hci_dev_unlock(hdev);
+
 	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
-		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
+		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type,
+						  &peer_addr, peer_addr_type);
 		goto done;
 	}
 
@@ -6938,8 +7006,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_int_connect);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window_connect);
 
-	bacpy(&cp.peer_addr, &conn->dst);
-	cp.peer_addr_type = conn->dst_type;
+	bacpy(&cp.peer_addr, &peer_addr);
+	cp.peer_addr_type = peer_addr_type;
 	cp.own_address_type = own_addr_type;
 	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
 	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-- 
2.55.0

