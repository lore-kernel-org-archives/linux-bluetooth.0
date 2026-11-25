Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649842;
	b=Wa4r5jeAo7wduPo1D8TNMSNFVvAXiHgAvcuejWUpGZCghS6DWJkoHvkj28H8IN8ZvjRW
	 nlVYdA8XhiIkj7RXIceIpxHHSSeTKcv7bJuI5slLXgJ2s9MrfhIcPgRVW5DTqES24TZbA
	 ysmr1GNKpe8tUkTp+Cev3WTIepHntuH7IEB0yBGjHx1TNFTwHDVftqELoQ3bdizLBs8Ok
	 YZLmURhl2iAqe4WUMbJW9/gT8zNX546P5ZCCY0gQw+bOh4BPa6UfnzjTk5VXBW4FLJFAH
	 BotKBwcBeEWVI5Uoqg+HBo00NO8vg/II5sRRYOdFYMU46C8f7SVSRxqMCLPOirn1Qhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=oW1EaG0nC61uki89tRmeCaktZjU+KZagC4yR8cfFS5Q=;
	b=fVirhYrBdKBh7WgeoEvTCKGgKTtDP03xNV21lFc1dlRm25MoFpsPhtVFJoyFwRehU6NG
	 2cGbzhq45TMGqYg9suZQ6hJ9mmxhXok5AmwB/8MWQGlybBZDmn/5KgJdybC0VngOxKVqp
	 XsLNiRt1mHP6gvO8uYTkSyy2+xENcJAUFzY9s2zhEQ6HacP77Vf8CRznWBrFGA5a9Un2g
	 8TD9PNp4NQGO8KkCF9fcgUIBF5LuFrFjQ40ea4Hb/rWKL8XKB6ENHHWyUk1VYSV5uIs4M
	 xkZJIk1usBJ9KVJyzAxLlqfyJ8amjqWJTjvsp5T9uqnPsi1dGXi89nqsBgVnf0o7IpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=bEfLkdtr;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5687606A329;
	Wed, 25 Nov 2026 23:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5687606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=bEfLkdtr
Received: from email.seznam.cz
	by smtpc-mxb-67bf8c997c-nxznx
	(smtpc-mxb-67bf8c997c-nxznx [2a02:598:128:8a00::1000:93f])
	id 46c1d321f0fb7e38434ec969;
	Thu, 26 Nov 2026 00:37:14 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795649834; bh=oW1EaG0nC61uki89tRmeCaktZjU+KZagC4yR8cfFS5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=bEfLkdtrov5G543709csWw8pYWJ0OPZki5Z62EUHY+xAUjAA19RqVlBggdW8iZO8J
	 rGAvnplvPFNM+8SGlsorVExPnKThMNs+ZzU01NWhlU++Iy5e9iFiVF1y+N1RHrehTu
	 trzPg5lnCsV42mCxk4QE5LxNuV3a1AdWwi3/xwXZv7ldjp2ygEuUYWxFx7d0zQhH+y
	 34U5SimzNopsEaVpYzbSyC5wbk2P+2pEtO9HaR2HZXeFf9RLNtDFVd38t+jmnIUgEt
	 q3Gc01djuqhvNSP3GbjQ/KjDzLX88E5OPVJ6Z2UgmZH0K3QLNb6i4TobOTdrocipkP
	 oniZO8PTRhtsw==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-86b589c786-pdzw7 (szn-email-smtpd/2.0.97) with ESMTPA
	id c4433140-c7eb-4bf5-9953-d4d328ffc188;
	Thu, 26 Nov 2026 00:36:53 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Thu, 26 Nov 2026 00:36:51 +0100
Subject: [PATCH v5 4/4] Bluetooth: find an RPA peer's connection parameters
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
Message-Id: <20261126-for-upstream-le-conn-params-rpa-v5-4-b7f015a35023@podgorny.cz>
References: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
In-Reply-To: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

A bonded peer's connection parameters are stored under its identity
address, but hci_conn_params_lookup() matches only the exact address it
is given. hci_le_create_conn_sync() is given the peer's RPA, since
hci_connect_le() dials the cached RPA when the controller cannot
resolve it, so it misses the entry and creates the connection with the
controller-wide defaults instead of the peer's own parameters.

Resolve an RPA to its identity in hci_conn_params_lookup() and in
hci_conn_params_add(), which uses the result both to search and as the
key of a new entry, so every caller finds the same entry whichever of
the peer's addresses it holds. The identity is looked up instead of the
RPA, not after it: Pair Device leaves an entry under the RPA the peer
had before bonding, which matching first would hand out for as long as
the peer keeps that RPA. Such an entry is cleared with the other
disabled ones the next time all connection parameters are loaded.

The entry found can then be under another address type than the one
given; load_conn_subrate() looks the connection up with the entry's.

SMP adds an IRK without hdev->lock, so a caller that resolves twice, in
a lookup and then in an add, can see the two disagree. Such callers
resolve once and use __hci_conn_params_lookup() and a new
__hci_conn_params_add(), which do not resolve again:
hci_explicit_conn_params_set(), given an address hci_connect_le_scan()
has resolved, and Load Connection Parameters. Set Device Flags uses a
single add. hci_conn_params_del() and Unpair Device keep matching
exactly.

What userspace sees, given an RPA:
- Set and Get Device Flags act on the identity's entry, where Set used
  to create a separate one under the RPA and Get failed. The reply
  still carries the address given; Device Flags Changed names the
  identity.
- Load Connection Parameters and Load Connection Subrate store the
  parameters under the identity.
- New Connection Parameter, sent when a connection still under an RPA
  gets new parameters, names the identity whose entry was updated. It
  only carries identity addresses, so it used to be dropped there.

Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 include/net/bluetooth/hci_core.h |  4 +++
 net/bluetooth/hci_conn.c         | 20 ++++++++++++---
 net/bluetooth/hci_core.c         | 55 +++++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_event.c        | 10 ++++++--
 net/bluetooth/mgmt.c             | 44 +++++++++++++++++---------------
 5 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fa2d139574d2..213b3b56aeff 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1906,8 +1906,12 @@ void hci_bdaddr_list_clear(struct list_head *list);
 
 void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
 			 u8 *addr_type, bdaddr_t *id_addr);
+struct hci_conn_params *__hci_conn_params_lookup(struct hci_dev *hdev,
+						 bdaddr_t *addr, u8 addr_type);
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
+struct hci_conn_params *__hci_conn_params_add(struct hci_dev *hdev,
+					      bdaddr_t *addr, u8 addr_type);
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fdebaf3c1982..8150ea0fc21a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -515,8 +515,10 @@ static int le_conn_update_sync(struct hci_dev *hdev, void *data)
 	struct hci_conn *conn = d->conn;
 	struct hci_conn_params *params;
 	struct hci_cp_le_conn_update cp;
+	bdaddr_t addr;
 	u16 timeout;
 	u8 store_hint;
+	u8 addr_type;
 	int err;
 
 	/* Verify connection is still alive and read conn fields under
@@ -554,6 +556,9 @@ static int le_conn_update_sync(struct hci_dev *hdev, void *data)
 	 */
 	hci_dev_lock(hdev);
 
+	bacpy(&addr, &conn->dst);
+	addr_type = conn->dst_type;
+
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
 		params->conn_min_interval = d->min;
@@ -561,13 +566,17 @@ static int le_conn_update_sync(struct hci_dev *hdev, void *data)
 		params->conn_latency = d->latency;
 		params->supervision_timeout = d->to_multiplier;
 		store_hint = 0x01;
+
+		/* Report the entry updated, the identity's for an RPA */
+		bacpy(&addr, &params->addr);
+		addr_type = params->addr_type;
 	} else {
 		store_hint = 0x00;
 	}
 
 	hci_dev_unlock(hdev);
 
-	mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hint,
+	mgmt_new_conn_param(hdev, &addr, addr_type, store_hint,
 			    d->min, d->max, d->latency, d->to_multiplier);
 
 	return 0;
@@ -1699,9 +1708,14 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 	if (is_connected(hdev, addr, addr_type))
 		return -EISCONN;
 
-	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	/* hci_connect_le_scan() has resolved addr already. Resolving it
+	 * again in each of the lookup and the add would let an IRK that
+	 * arrives in between make the add return existing params, which
+	 * would then be taken for new ones.
+	 */
+	params = __hci_conn_params_lookup(hdev, addr, addr_type);
 	if (!params) {
-		params = hci_conn_params_add(hdev, addr, addr_type);
+		params = __hci_conn_params_add(hdev, addr, addr_type);
 		if (!params)
 			return -ENOMEM;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eb48488ab395..32703c4d1ebd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2381,9 +2381,13 @@ void hci_rpa_to_identity(struct hci_dev *hdev, bdaddr_t **addr,
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
+struct hci_conn_params *__hci_conn_params_lookup(struct hci_dev *hdev,
+						 bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *params;
 
@@ -2397,6 +2401,17 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
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
@@ -2436,13 +2451,17 @@ void hci_pend_le_list_add(struct hci_conn_params *param,
 	list_add_rcu(&param->action, list);
 }
 
-/* This function requires the caller holds hdev->lock */
-struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
-					    bdaddr_t *addr, u8 addr_type)
+/* Like hci_conn_params_add(), but without resolving an RPA to its
+ * identity.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+struct hci_conn_params *__hci_conn_params_add(struct hci_dev *hdev,
+					      bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *params;
 
-	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	params = __hci_conn_params_lookup(hdev, addr, addr_type);
 	if (params)
 		return params;
 
@@ -2469,6 +2488,20 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 	return params;
 }
 
+/* This function requires the caller holds hdev->lock */
+struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
+					    bdaddr_t *addr, u8 addr_type)
+{
+	bdaddr_t id_addr;
+
+	/* Resolve once, and use the result both to search and as the key
+	 * of a new entry.
+	 */
+	hci_rpa_to_identity(hdev, &addr, &addr_type, &id_addr);
+
+	return __hci_conn_params_add(hdev, addr, addr_type);
+}
+
 void hci_conn_params_free(struct hci_conn_params *params)
 {
 	hci_pend_le_list_del_init(params);
@@ -2482,12 +2515,16 @@ void hci_conn_params_free(struct hci_conn_params *params)
 	kfree(params);
 }
 
-/* This function requires the caller holds hdev->lock */
+/* Unlike hci_conn_params_lookup() and hci_conn_params_add(), this matches
+ * addr exactly.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *params;
 
-	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	params = __hci_conn_params_lookup(hdev, addr, addr_type);
 	if (!params)
 		return;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6c7f9a9f55a..125795339509 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7580,6 +7580,8 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 
 	if (hcon->role == HCI_ROLE_MASTER) {
 		struct hci_conn_params *params;
+		bdaddr_t *addr = &hcon->dst;
+		u8 addr_type = hcon->dst_type;
 		u8 store_hint;
 
 		params = hci_conn_params_lookup(hdev, &hcon->dst,
@@ -7590,12 +7592,16 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 			params->conn_latency = latency;
 			params->supervision_timeout = timeout;
 			store_hint = 0x01;
+
+			/* Report the entry updated, the identity's */
+			addr = &params->addr;
+			addr_type = params->addr_type;
 		} else {
 			store_hint = 0x00;
 		}
 
-		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type,
-				    store_hint, min, max, latency, timeout);
+		mgmt_new_conn_param(hdev, addr, addr_type, store_hint, min, max,
+				    latency, timeout);
 	}
 
 	cp.handle = ev->handle;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d21538634bc3..41bb8f53f3d7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3422,7 +3422,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	set_bit(HCI_CONN_PARAM_REMOVAL_PEND, conn->flags);
 
 	/* Disable auto-connection parameters if present */
-	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr, addr_type);
+	params = __hci_conn_params_lookup(hdev, &cp->addr.bdaddr, addr_type);
 	if (params) {
 		if (params->explicit_connect)
 			params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
@@ -5492,6 +5492,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_cp_set_device_flags *cp = data;
 	struct bdaddr_list_with_flags *br_params;
 	struct hci_conn_params *params;
+	struct mgmt_addr_info ev_addr = cp->addr;
 	u8 status = MGMT_STATUS_INVALID_PARAMS;
 	u32 supported_flags;
 	u32 current_flags = __le32_to_cpu(cp->current_flags);
@@ -5526,19 +5527,16 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
-					le_addr_type(cp->addr.type));
+	/* Create a new hci_conn_params if it doesn't exist. One add, which
+	 * resolves an RPA once, rather than a lookup and an add that each
+	 * resolve it and can disagree if the IRK arrives in between.
+	 */
+	params = hci_conn_params_add(hdev, &cp->addr.bdaddr,
+				     le_addr_type(cp->addr.type));
 	if (!params) {
-		/* Create a new hci_conn_params if it doesn't exist */
-		params = hci_conn_params_set(hdev, &cp->addr.bdaddr,
-					     le_addr_type(cp->addr.type),
-					     HCI_AUTO_CONN_DISABLED);
-		if (!params) {
-			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
-				    &cp->addr.bdaddr,
-				    le_addr_type(cp->addr.type));
-			goto unlock;
-		}
+		bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
+			    &cp->addr.bdaddr, le_addr_type(cp->addr.type));
+		goto unlock;
 	}
 
 	supported_flags = hdev->conn_flags;
@@ -5552,6 +5550,10 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 	WRITE_ONCE(params->flags, current_flags);
 	status = MGMT_STATUS_SUCCESS;
 
+	/* Given an RPA, the flags changed are the identity's */
+	bacpy(&ev_addr.bdaddr, &params->addr);
+	ev_addr.type = link_to_bdaddr(LE_LINK, params->addr_type);
+
 	/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
 	 * has been set.
 	 */
@@ -5563,7 +5565,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 
 done:
 	if (status == MGMT_STATUS_SUCCESS)
-		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+		device_flags_changed(sk, hdev, &ev_addr.bdaddr, ev_addr.type,
 				     supported_flags, current_flags);
 
 	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_FLAGS, status,
@@ -8392,6 +8394,7 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	for (i = 0; i < param_count; i++) {
 		struct mgmt_conn_param *param = &cp->params[i];
+		bdaddr_t *addr = &param->addr.bdaddr, id_addr;
 		struct hci_conn_params *hci_param;
 		u16 min, max, latency, timeout;
 		bool update = false;
@@ -8422,21 +8425,22 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		/* Resolve once, so the lookup and the add below agree */
+		hci_rpa_to_identity(hdev, &addr, &addr_type, &id_addr);
+
 		/* Detect when the loading is for an existing parameter then
 		 * attempt to trigger the connection update procedure.
 		 */
 		if (!i && param_count == 1) {
-			hci_param = hci_conn_params_lookup(hdev,
-							   &param->addr.bdaddr,
-							   addr_type);
+			hci_param = __hci_conn_params_lookup(hdev, addr,
+							     addr_type);
 			if (hci_param)
 				update = true;
 			else
 				hci_conn_params_clear_disabled(hdev);
 		}
 
-		hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
-						addr_type);
+		hci_param = __hci_conn_params_add(hdev, addr, addr_type);
 		if (!hci_param) {
 			bt_dev_err(hdev, "failed to add connection parameters");
 			continue;
@@ -8571,7 +8575,7 @@ static int load_conn_subrate(struct sock *sk, struct hci_dev *hdev, void *data,
 
 			conn = hci_conn_hash_lookup_le(hdev,
 						       &hci_param->addr,
-						       addr_type);
+						       hci_param->addr_type);
 			if (conn && conn->state == BT_CONNECTED &&
 			    (conn->le_rate_interval < min ||
 			     conn->le_rate_interval > max ||

-- 
2.56.1

