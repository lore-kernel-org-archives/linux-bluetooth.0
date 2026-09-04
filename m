Received: from outbound.st.icloud.com (st-2006b-snip4-7.eps.apple.com [57.103.76.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECD37F324
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538881; cv=none; b=Jy2xjDHXa3DTXbxPdPjxPycXTjuIEczyMZCaAVeYJ4U5ch0u3sml3faawbK8vcEDT+P7CbOfL6QhPsMRk8tx+Q7jLbfKKxZ4iJ2kNwaszQBeFsvkTaWJv14w3YyW37MYMBUr1aybbxQeKtL+G51JUbxAEBjQyMXiF6FWNkrAuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538881; c=relaxed/simple;
	bh=oCpiEUpYkuCd4rXWtrPrsEMNwrqS54awj16Aytnb0hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Us6MHOpwqZlyOtxFNT3ANRkhjVqBG6ErGLSfyOshpJgKXSXR3BrVw8XLBIy6YV8Pz/t/2864PPBxQa2MMQ06Siowmml2pgJy/WeGXMrhGX9H51j8KQhVYbvbzBdST1lPiswRH+rJ/9Aw+0VbLZQCSSVrwN6PSez+XwmgJWSTdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev; spf=pass smtp.mailfrom=proxy-alt.dev; dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b=XlqXhnWi; arc=none smtp.client-ip=57.103.76.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b="XlqXhnWi"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id 64FCB180047C;
	Fri, 04 Sep 2026 16:21:16 +0000 (UTC)
X-ICL-RepId: 01a06d39-71be-7dd6-8672-67723d78e6fa
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHV8DXRxCCkodXAFbEhVdRUMfWBNLXVgURy1HGV0IQFVSAUNFVhVPWFUJChtAH0EBHgxbHxwUXA4TH1RWAFBRHV8CCgRHBFsXRgNTRUEEFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDwBLF0sUGgpeBBccVhsXBlsUBEQBXQVdAkkJTAJbBVoCSBdNBVwCXx9BFAhBAk8SHxFVDHMdRQRKCRQZXxkZD1cGB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proxy-alt.dev; s=sig1; t=1788538876; x=1791130876; bh=xFTS50pBLkVZKzQdNzjBuXM4Vg8ZLSHXzGioUA1Q6A8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=XlqXhnWiczsDoTyLNWbEAS+ozH3FTdJOb2eq/f69NBxD2fl5p1iwjAnaSO+tWk4l9ptOfTDq5RDj47CEc3Z/kxEtwRCxmGkPDTJvtkTNoD2fjJE+YPas3iKdKEqYuwUziLFN4OCa946V2OOzgLTGIG//Pn5ehnSN92C99yWr5R7VPxEhoHLpw1eSb/71BOj7B6XybsjfDFOnIsLTb62NIGM8Bj5h7YxGUB1i2/TcCcqg/8bZ7ulR40slbGd7HZgvZzOIQNouSYz6Ia5kTHGZS2HIOP3V454f8qKtqWg2bd18/19tsWUAupNU0jp72SA3sWcSljD0Qu8/MxVlmlkEsQ==
mail-alias-created-date: 1786144344056
Received: from localhost.localdomain (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id EB5F81800467;
	Fri, 04 Sep 2026 16:21:15 +0000 (UTC)
From: Proxy alt <proxy-alt@proxy-alt.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Proxy <proxy-alt@proxy-alt.dev>
Subject: [PATCH BlueZ v2] shared/gatt-client: confirm a synthesized CCC handle before writing to it
Date: Fri,  4 Sep 2026 12:21:08 -0400
Message-ID: <20260904162108.56154-1-proxy-alt@proxy-alt.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AsHjHe9P c=1 sm=1 tr=0 ts=6a9aeffc
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=29R3oGkwAbzQOjyomxwA:9
X-Proofpoint-GUID: Jde_4KaHasxviRTWbZ2kw_zLgo7L8iDo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfXzzU+ALO0ZaTl
 XiyxUGeim2ho3ipgyZu+wbiXxtalU3pNx6QR18j/43bcYAApAYvUIJl/ojcwmN5xeD9leor7ZCG
 P8FSamH5L/odf7fAAS4uQ5mDOWcOG6yHF901iiLbjwCQKCm7EUthgyqKRhE+azFTtRBbYRc+Bfm
 Nz9349nGWvGlhIqnUC3hzHEsCLFk/D05C6dYlIk+Wgf8adj0vv4vTBmhHMJ1r/CTGrR1c+zuroX
 ITU2MKx/hJpIBvzSuJyX3Zbl9pZE2xjtXsHkOoqg1wCNN7Bqr+2d62hRxVGJdW23RgMnI6g0/Bi
 QI+k10gRcMY4SSw3dkvSKDkYQlKfGWmjs206nI2UIL9S2wjlb7T/cz+BsoBy4s=
X-Proofpoint-ORIG-GUID: Jde_4KaHasxviRTWbZ2kw_zLgo7L8iDo
X-JNJ: AAAAAAABy3QSEPczzfGlnnQ+FJ8UpMrpnx4PMVJV00rTbHI2EmrkPSvTIivUnNUIDiiJyRRdhkECDdHl2nk++rcaJ6ev6di8zs2qVxlRrDaQTzOGOyQYp0eASkhn/MZAJyBHH34jgsm8Z3PupyRX40tMaQET5Vs0jwC1RLwD0V1R+66hNgVdVYnpMAj3DEA4FWAUDmnAV223QKq2jd4E6LLCPWRYrKycjuuZPJVVs1dPkv4ipiKPx4WQqHa2q9bfqfUoVSmu5fynGs15Ccn/mwwDEOf8/wvmutt1MD+76fw8BL6zPb7x6/VKU57vY/TqSMz+LUy21D8P2GIerjUoRFxM+VDPw69d9ngzHGW8S1uGT5oLk1YN8N4Rg186BPade20wDLwzQp0ZXXjqzfXrv61Y6c8/+hvLifqRx/HSDbGUIPDueQC/FeRr616GIx8XnUgD13xK1UoErW2fmR9jCUGIrmfIZLpdGPGI7u8tXF23IhMhrG7dYaOntSu+AuExP+Glht4FlP5ziZQISfQo/ooupyhmw67m8eFu+n6CVBkUabDyZowuAS4FtV8+KE5z284RNsKh5/C1ZRG5MuDrRj5APsm3M19tLtWGa3iui2d6o+zPgNQ/L5Gb76AuLImpUV/2WJ5R85SymCKmhNpOHVE2cegXJnslilQiAZUEG80w9sudQV2tSDe0bKgilMEpbyTvkiMaGiNaUJQTEX1HCaRPKYJCO7CEOkJGYz+8O2V5G5MXwLwY6s8jG56+0IqqIKLV5ecxyyjALl/Fo+VBlmiX0zBfaGGi41hO6LIUjih0AKJ8V+Rj8RSgGFqMetQ3rugc1QuMZ53WGA/utfIgjoxyHERdLZzOP6f+yE4rUMkk9OQcS3Ix7z0HDQA/fnfD5kMe6+YojQ0Mba09TCqZT3Sz3fvFXvqmZzYg+yhAgEvvjibqmGqtNcOlh8qULliQfXiXVEtvOvwuA73dBmdzBGykBwaM13H
 GnkVnpYGh4GNPBF9Cyw+Pgg9/z3ju2LQLDT2QHpuTbO5Jml0HmLSoJyUB0AY6kDzZjH4b/mN3OZyngWwwnC3jrpBb7XgRzJRyTp/0iwPkkzp3FQzThmEc26SR0bCHn/Mkxre+1E3hifaEJNXcn5GiauY9fzbhtwrqVev048I3Qcip2gIPxuA0I5PSJDN8G58kftnjVoM3SsdmuVvE7i26tqeVyFBl7kpKePk4DCBqlagZTm2ffZQ=

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
index f8ebab3..cce73e6 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -94,6 +94,14 @@ struct bt_gatt_client {
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
@@ -116,6 +124,23 @@ struct bt_gatt_client {
 	unsigned int mtu_req_id;
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
@@ -223,10 +248,20 @@ struct notify_chrc {
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
@@ -287,6 +322,11 @@ static void notify_chrc_free(void *data)
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
@@ -338,9 +378,19 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
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
@@ -793,6 +843,16 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
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
@@ -1751,6 +1811,102 @@ static bool match_notify_chrc_value_handle(const void *a, const void *b)
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
@@ -1804,10 +1960,11 @@ static unsigned int register_notify(struct bt_gatt_client *client,
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
@@ -1821,6 +1978,21 @@ static unsigned int register_notify(struct bt_gatt_client *client,
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
@@ -2295,6 +2467,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 
 	queue_destroy(client->notify_chrcs, notify_chrc_free);
 	queue_destroy(client->notify_list, notify_data_cleanup);
+	queue_destroy(client->unverified_ccc, NULL);
 
 	queue_destroy(client->ready_cbs, ready_destroy);
 	queue_destroy(client->idle_cbs, idle_destroy);
@@ -2361,6 +2534,7 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 	client->svc_chngd_queue = queue_new();
 	client->notify_list = queue_new();
 	client->notify_chrcs = queue_new();
+	client->unverified_ccc = queue_new();
 	client->pending_requests = queue_new();
 
 	client->nfy_id = bt_att_register(att, BT_ATT_OP_HANDLE_NFY,
-- 
2.54.0 (Apple Git-157)

