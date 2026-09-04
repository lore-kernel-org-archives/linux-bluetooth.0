Received: from outbound.ms.icloud.com (ms-2006f-snip4-4.eps.apple.com [57.103.75.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565B3BFE34
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.75.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546527; cv=none; b=OOMZYT34KzpPvufr8ViaQ9I/4e7GymrwarDoWdyr3smok59eacZI1JTdYWmnjJtJl4T4PS8oUUj/+0H2ZeOR6q5e3+7QlSR4n950+llXzWdbmwicCV5AzkYXIKKqMQreMKvkSRJl7D4iU8mIWgBV6Lq07/EwcDzQPebr7oYPk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546527; c=relaxed/simple;
	bh=RT44BmgJoJp+urgFbTQAyC3v6Z/gfQh3onQXSGYDNEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4ce6Kl5CYqpmejtN+YTes9MnhcQkxS43ZpR7M7FvVsFFo1GnqI7tR5ybM2yG9m6vohKT1ZkkNziCMA7FUqr3w7iIf3KPhLB+naQhs/pdocdykZZTOlD4GLjDfZN6k6XPEWc4vWnpnv5iKpkwOuVHJ02NPHLzfhxbR4f8+10VXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev; spf=pass smtp.mailfrom=proxy-alt.dev; dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b=cQT166DP; arc=none smtp.client-ip=57.103.75.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b="cQT166DP"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPS id 6B7EE1800884;
	Fri, 04 Sep 2026 18:28:37 +0000 (UTC)
X-ICL-RepId: 01a06dae-097e-718b-955e-819b5d30399f
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHV8DXRxCCkodXAFbEhVdRUMfWBNLXVgURy1HGV0IQFVSAUNFVhVPWFUJChtAH0EBHgxbHxwUXA4TH1RWAFBRHV8CCgRHBFsXRgNTRV8DFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDwBLF0sUGgpeBBccVhsXBlsUBEQBXQVdAkkJTAJVBVMBQxdNClsFXx9BFAhBAk8SHxFVDHMdRQRKCRQZXxkZD1cGB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proxy-alt.dev; s=sig1; t=1788546519; x=1791138519; bh=CrxzoYBGcPAERz90B2vyo5BX/X6PG1NOoAWXqNYAoZY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=cQT166DP7PMtnXW/CTVfInZJ3V53QA/bIagPtPdi4gGarHHgOa8jotQZG1p6i1EHJ7CLblpZviXtbHL96sEAOPBcbxC7nTnF1KzUJLyL8VLEmj8cAzN1eN4CQ4Hwf2h0/nrTsUVr5qWUt7fSseqKtl18YVvLDNo9OgJQ3ETA1WDe8oRX0aIdE5Fem0OfqdLzzTNg/unbQZRNcCzONYIoSacy3cuOpW0LfS8e70JiJIfeCuiWccW00xhe4OewKKQJprKfdByRLKKwa8eTA3Nvs6wbYjt0UlKYCGv0hiLhZhpDZ+jzVwdfodeYU7BfvX7lYEtKfrxrocMLGAmVA/zmsA==
mail-alias-created-date: 1786144344056
Received: from localhost.localdomain (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPSA id A778718004BA;
	Fri, 04 Sep 2026 18:28:36 +0000 (UTC)
From: Proxy alt <proxy-alt@proxy-alt.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Proxy <proxy-alt@proxy-alt.dev>
Subject: [PATCH BlueZ v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it
Date: Fri,  4 Sep 2026 14:28:33 -0400
Message-ID: <20260904182833.59624-1-proxy-alt@proxy-alt.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE2OSBTYWx0ZWRfX5KRwhFqMUK5M
 Sw6/V4TT5FBWGVCL0CSlrisZ/stDXqxv4caqeASJiAxj3hBivMvb/ql9TIiuVXGUAROm2ZkUKRI
 xOvDt4MaK5J88n1DnE2L1qLALbzWT/suFTDyhMwk6tIAZ5RoUItgQLSjKRNmHeQTlLNqGyXClJG
 KmfdLQseCE7Tc3GB7+5VApUHKEFyRdfnRl6wvlX3pVIdDrI437DoNWxTF4GFQpJ1z0qrvp2+XpT
 yC1xVTQJSgxXBuzUYK6r3om/VsmnfTEH1CHOcYZgpYd5lhhW/pFNiafjZc0WoJZ/tI/uhXbuvTr
 nXwbntxNdCJfP6FdH9nyGyMQ9l5GPuvuV70jlWaN+ZgU6tECvGOhfETHfcFpvM=
X-Authority-Info-Out: v=2.4 cv=e7kLiKp/ c=1 sm=1 tr=0 ts=6a9b0dd5
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=29R3oGkwAbzQOjyomxwA:9
X-Proofpoint-GUID: x8W2XvE726e-pwazzue3UlViE4yRxWwK
X-Proofpoint-ORIG-GUID: x8W2XvE726e-pwazzue3UlViE4yRxWwK
X-JNJ: AAAAAAABrtyd2S7XtIOBIU6PQONyw/sqpSpq7k2wkcBoVT1fa8tdYKwz8UxVHNaHZgdoBVElSlwpjCrcbgOhJ531lf78WqA65pFpYNs++2v/O0NLDGsZ/YYORaNJSPH6Jt3dx7anNVO92XX85zLBJxX4W7iDGdROH0lAOueLlMQTUFLk4hiS8xszqPmWfyjAdeVrBHOq3DaW+OlrpBKN6n2L5Un1DZU9e1DilBdx6o3VkeX7/OAlbjxI64NpA/+AWiIBvx9cltVRmvAemYjX0iLJThCz8ECQazz6PEYiMvxGAH9G6XZAwKIZeccAhNI0P4sNWUjZKT2J6gqTPft9yRDg13YU586YWDMzGiBe/RHMTCgrmtPA+XcGSKBT7WMSSsUWEw719leu0vCAw/1hoX9whotMpcgCRmSQUhLWQBtyhBoW+5Cev1Xhw3Z/Ahx7ia34Nc7c1Cx5uiIKBMGWfn11LqS1JCn5trHRCzwP0zaCo6oqNVWR9PjqXta2QAw9iZfCy60OvJmvrdcfQxusZyv/clL5qZvKrtOwXO6UFkcn0PusQo2KOFGLRH8owz2khNSp+NTbrGey6FEoyaTPWPzlZbBARQv5kNNT8KaVzkD8zNyc1Kk28fzyVtx7fc51pIvBP02MNu/sM8BszD61f6IJyEkMykHHU432d0kpWWH4siosbXDkqIEWH9jY+oL3i7SSmSACmxs/P1h6xRFCq/tNg1pmroEagAdC5U/Fnh7uPrZaJN008dDPwBbXxlcY66ELmT2Ns6cikpM4/mQWGIAk+cii5vw1fQEznCXgXHfzqqj2UUmbQabKnu8GXumRfGMdz8RD09iP5zs5AAyE4VRixYtpME97n1ew6UOi/dRtFy1FAsB7AmuEHokvmirCWK+YeStCF5HrB8WQlyVNghaGgpK8qr7tjQXlfLlzyEzBYqGAaFJZGMVO6vetkCBiybcquq6fy7ymczRdRmFmnONreos8gG6
 lCTUJlyO7XZ2AyMGby5+s+Zc5rw8yWSHCHkFBR2xMcz0tv5DOlaBZR66/FPE0suHv5gz9HQeQIJ0sOb0c3xmqviVaK0FM9hl/4Kpg2q0jfVC6RU4hwFSHzLBLcB/yoII3poSPz/KSuSoVlFdOUsuyHwc=

From: Proxy <proxy-alt@proxy-alt.dev>

discover_descs() still synthesizes a 0x2902 for a notify/indicate
characteristic's lone descriptor without ever asking the peer - that
part is unchanged, since always discovering costs a round trip on
every characteristic for the sake of devices that violate Vol 3, Part
G 3.3.1.1. What changes is register_notify(): before it writes to a
handle discover_descs() only guessed at, it now issues one
single-handle FIND_INFORMATION to let the peer answer for itself, and
only after that answer confirms a real 0x2902 does the CCC write
happen at all.

If the peer's answer is anything else - a different UUID, or no
answer - chrc->ccc_handle is cleared instead of written to.
register_notify() already handles a characteristic with no CCC
correctly (gatt_db_attribute_get_ccc() returning NULL takes the same
path), so this reaches that existing, correct behaviour instead of
writing 0x0100 into an attribute the peer never claimed was a CCC.

Cost: one extra FIND_INFORMATION per notify/indicate characteristic
whose sole descriptor was synthesized, the first time register_notify()
is called for it.

v2 of the patch attached to this issue fixes a real bug the first
version had: unverified_ccc lived on struct bt_gatt_client, but
discover_descs() only ever runs on the root client, while
register_notify() is commonly called through a clone
(bt_gatt_client_clone(), used by src/gatt-client.c per D-Bus consumer)
- whose own copy of that queue is always empty. The result was that
the verify step silently never triggered and the original blind write
still happened. Fixed by adding root_client(), a two-line walk up
->parent, and using root_client(client)->unverified_ccc at both call
sites instead of client->unverified_ccc directly.

Tested against real hardware this time, and traced end to end. Built
and ran as bluetoothd itself (not a test harness) on plain Debian, no
containers, connected to a real Cync device (F4:BC:DA:39:03:D4) whose
notify characteristic's descriptor discovery skips 0x0013 exactly as
this issue describes - discover_descs_cb() finds 0x0004/0x0016/0x0019/
0x001c as 0x2901 and never queries 0x0013 at all. Calling StartNotify
on that characteristic with v1 of the patch reproduced the original
bug unchanged: a WRITE_REQ to 0x0013 that timed out after 30s
(src/shared/att.c:timeout_cb() ... 0x12) and tore down a connection
that was otherwise healthy - which is what led to finding the clone
bug above. With that fixed and the identical scenario repeated:

  verify_ccc_cb() handle 0x0013 confirmed is not a CCC descriptor

StartNotify's D-Bus method call returns success immediately, no write
is sent to 0x0013, and the connection stays up (confirmed via
Device1.Connected afterward). This is the same device, same
characteristic, same daemon build, same session - only the
root_client() fix differs between the failing and passing runs.

Fixes: https://github.com/bluez/bluez/issues/2383
Signed-off-by: Proxy <proxy-alt@proxy-alt.dev>
---
 src/shared/gatt-client.c | 182 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a6abe8a..8c50131 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -86,6 +86,14 @@ struct bt_gatt_client {
 	int next_reg_id;
 	unsigned int disc_id, nfy_id, nfy_mult_id, ind_id;
 
+	/*
+	 * Handles of CCC descriptors that were synthesized rather than
+	 * discovered (discover_descs() assumed a lone descriptor on a
+	 * notify/indicate characteristic must be the CCC). Consulted by
+	 * register_notify() before it writes to one of these handles.
+	 */
+	struct queue *unverified_ccc;
+
 	/*
 	 * Handles of the GATT Service and the Service Changed characteristic
 	 * value handle. These will have the value 0 if they are not present on
@@ -112,6 +120,23 @@ struct bt_gatt_client {
 	uint16_t pending_error_handle;
 };
 
+/*
+ * discover_descs() only ever runs on the root (non-cloned) client, since
+ * clones share the parent's gatt_db rather than discovering it themselves
+ * (see bt_gatt_client_clone()). unverified_ccc must therefore live on the
+ * root: a clone's own copy is always empty, and register_notify() is
+ * commonly called through a clone (src/gatt-client.c takes one per D-Bus
+ * consumer), so checking client->unverified_ccc directly there would never
+ * see anything discover_descs() recorded.
+ */
+static struct bt_gatt_client *root_client(struct bt_gatt_client *client)
+{
+	while (client->parent)
+		client = client->parent;
+
+	return client;
+}
+
 struct request {
 	struct bt_gatt_client *client;
 	bool long_write;
@@ -219,10 +244,20 @@ struct notify_chrc {
 	int notify_count;  /* Reference count of registered notify callbacks */
 
 	/* Pending calls to register_notify are queued here so that they can be
-	 * processed after a write that modifies the CCC descriptor.
+	 * processed after a write that modifies the CCC descriptor, or after
+	 * a pending ccc_verify_req below is resolved.
 	 */
 	struct queue *reg_notify_queue;
 	unsigned int ccc_write_id;
+
+	/*
+	 * Set if ccc_handle names a descriptor discover_descs() synthesized
+	 * rather than discovered. register_notify() must confirm it with the
+	 * peer before writing to it; ccc_verify_req is the outstanding
+	 * confirmation request, if any.
+	 */
+	bool ccc_unverified;
+	struct bt_gatt_request *ccc_verify_req;
 };
 
 struct notify_data {
@@ -283,6 +318,11 @@ static void notify_chrc_free(void *data)
 	if (chrc->notify_id)
 		gatt_db_attribute_unregister(chrc->attr, chrc->notify_id);
 
+	if (chrc->ccc_verify_req) {
+		bt_gatt_request_cancel(chrc->ccc_verify_req);
+		bt_gatt_request_unref(chrc->ccc_verify_req);
+	}
+
 	queue_destroy(chrc->reg_notify_queue, notify_data_unref);
 	free(chrc);
 }
@@ -334,9 +374,19 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 	}
 
 	ccc = gatt_db_attribute_get_ccc(attr);
-	if (ccc)
+	if (ccc) {
 		chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
 
+		/*
+		 * If discover_descs() never actually asked the peer about
+		 * this handle, don't trust it until register_notify() has
+		 * confirmed it.
+		 */
+		if (queue_remove(root_client(client)->unverified_ccc,
+					UINT_TO_PTR(chrc->ccc_handle)))
+			chrc->ccc_unverified = true;
+	}
+
 	chrc->client = client;
 	chrc->attr = attr;
 	chrc->value_handle = value_handle;
@@ -789,6 +839,16 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							&ccc_uuid, 0, NULL,
 							NULL, NULL);
 			if (attr) {
+				/*
+				 * The peer was never asked about this handle.
+				 * register_notify() will issue a single-handle
+				 * FIND_INFORMATION before it writes here, in
+				 * case this device is one of the ones that
+				 * declares notify/indicate without actually
+				 * having a CCC descriptor.
+				 */
+				queue_push_tail(root_client(client)->unverified_ccc,
+						UINT_TO_PTR(desc_start));
 				free(chrc_data);
 				continue;
 			}
@@ -1747,6 +1807,102 @@ static bool match_notify_chrc_value_handle(const void *a, const void *b)
 	return chrc->value_handle == value_handle;
 }
 
+/*
+ * Resumes register_notify() for notify_data once ccc_unverified has been
+ * settled, taking the same branch register_notify() itself would have taken
+ * had the answer been known up front.
+ */
+static void resume_after_ccc_verify(struct notify_data *notify_data)
+{
+	struct notify_chrc *chrc = notify_data->chrc;
+
+	if (chrc->notify_count > 1 || !chrc->ccc_handle ||
+							!notify_data->callback) {
+		complete_notify_request(notify_data);
+		return;
+	}
+
+	if (!notify_data_write_ccc(notify_data, true, enable_ccc_callback))
+		complete_notify_request(notify_data);
+}
+
+static void verify_ccc_cb(bool success, uint8_t att_ecode,
+					struct bt_gatt_result *result,
+					void *user_data)
+{
+	struct notify_data *notify_data = user_data;
+	struct notify_chrc *chrc = notify_data->chrc;
+	struct bt_gatt_client *client = notify_data->client;
+	struct bt_gatt_iter iter;
+	uint16_t handle;
+	uint128_t u128;
+	bt_uuid_t uuid, ccc_uuid;
+	bool is_ccc = false;
+
+	chrc->ccc_verify_req = NULL;
+	chrc->ccc_unverified = false;
+
+	bt_uuid16_create(&ccc_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	if (success && result && bt_gatt_iter_init(&iter, result) &&
+			bt_gatt_iter_next_descriptor(&iter, &handle,
+								u128.data)) {
+		bt_uuid128_create(&uuid, u128);
+
+		if (handle == chrc->ccc_handle && !bt_uuid_cmp(&uuid,
+								&ccc_uuid))
+			is_ccc = true;
+	}
+
+	DBG(client, "handle 0x%04x confirmed %s a CCC descriptor",
+				chrc->ccc_handle, is_ccc ? "is" : "is not");
+
+	/*
+	 * The peer just answered for itself: the earlier guess was wrong.
+	 * Undo it so nothing downstream (including a later notify_count > 1
+	 * fast path) treats this characteristic as having a CCC to write.
+	 */
+	if (!is_ccc)
+		chrc->ccc_handle = 0;
+
+	resume_after_ccc_verify(notify_data);
+
+	if (is_ccc)
+		return;
+
+	/*
+	 * No write is coming to drive enable_ccc_callback's usual flush of
+	 * reg_notify_queue, so do it here instead.
+	 */
+	queue_remove_all(chrc->reg_notify_queue, notify_set_ecode,
+				UINT_TO_PTR(0), complete_notify_request);
+}
+
+/*
+ * Issues a single-handle FIND_INFORMATION for chrc->ccc_handle to confirm
+ * it is really a CCC descriptor before register_notify() writes to it.
+ * Returns false only on the kind of immediate failure register_notify()
+ * already treats as a failed registration.
+ */
+static bool verify_ccc_handle(struct notify_data *notify_data)
+{
+	struct notify_chrc *chrc = notify_data->chrc;
+	struct bt_gatt_client *client = notify_data->client;
+
+	chrc->ccc_verify_req = bt_gatt_discover_descriptors(client->att,
+						chrc->ccc_handle,
+						chrc->ccc_handle,
+						verify_ccc_cb,
+						notify_data_ref(notify_data),
+						notify_data_unref);
+	if (!chrc->ccc_verify_req) {
+		notify_data_unref(notify_data);
+		return false;
+	}
+
+	return true;
+}
+
 static unsigned int register_notify(struct bt_gatt_client *client,
 				uint16_t handle,
 				bt_gatt_client_register_callback_t callback,
@@ -1800,10 +1956,11 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	__sync_fetch_and_add(&notify_data->chrc->notify_count, 1);
 
 	/*
-	 * If a write to the CCC descriptor is in progress, then queue this
+	 * If a write to the CCC descriptor is in progress, or a synthesized
+	 * CCC handle is still being confirmed with the peer, then queue this
 	 * request.
 	 */
-	if (chrc->ccc_write_id) {
+	if (chrc->ccc_write_id || chrc->ccc_verify_req) {
 		queue_push_tail(chrc->reg_notify_queue, notify_data);
 		return notify_data->id;
 	}
@@ -1817,6 +1974,21 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 		return notify_data->id;
 	}
 
+	/*
+	 * ccc_handle was never actually discovered - confirm it with the
+	 * peer before writing to it. resume_after_ccc_verify() takes the
+	 * write-or-complete branch below once the answer is known.
+	 */
+	if (chrc->ccc_unverified) {
+		if (!verify_ccc_handle(notify_data)) {
+			queue_remove(client->notify_list, notify_data);
+			free(notify_data);
+			return 0;
+		}
+
+		return notify_data->id;
+	}
+
 	/* Write to the CCC descriptor */
 	if (!notify_data_write_ccc(notify_data, true, enable_ccc_callback)) {
 		queue_remove(client->notify_list, notify_data);
@@ -2291,6 +2463,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 
 	queue_destroy(client->notify_chrcs, notify_chrc_free);
 	queue_destroy(client->notify_list, notify_data_cleanup);
+	queue_destroy(client->unverified_ccc, NULL);
 
 	queue_destroy(client->ready_cbs, ready_destroy);
 	queue_destroy(client->idle_cbs, idle_destroy);
@@ -2507,6 +2680,7 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 	client->svc_chngd_queue = queue_new();
 	client->notify_list = queue_new();
 	client->notify_chrcs = queue_new();
+	client->unverified_ccc = queue_new();
 	client->pending_requests = queue_new();
 
 	client->nfy_id = bt_att_register(att, BT_ATT_OP_HANDLE_NFY,
-- 
2.54.0 (Apple Git-157)

