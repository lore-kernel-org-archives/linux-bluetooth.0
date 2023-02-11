Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F5C636CC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 19:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjBKT4E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 14:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKT4C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 14:56:02 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4D16327
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:55:59 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6E474240027
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 20:55:58 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDhDY6KGJz9rxF;
        Sat, 11 Feb 2023 20:55:57 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] shared/bap: fix local endpoint state to be per-client
Date:   Sat, 11 Feb 2023 19:55:52 +0000
Message-Id: <a0b0c0b71c0bbf0e200fd01619901bc5fa00e531.1676145318.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ASCS v1.0 Sec. 4.1: "For each ASE characteristic (distinguished by their
attribute handles), the server shall expose separate ASE characteristic
values for each client."  In shared/bap.c, the ASE chrc value is
contained in bt_bap_endpoint struct.

As implemented currently, the same local ASE chrc value is shared
between all clients, in contradiction with the above.  Namely, the
bt_bap_endpoint is looked up based on the gatt_db_attribute handles, in
bap_get_endpoint and bap_get_endpoint_id, but the handles correspond to
the ASCS registrations, and do not depend on which client is in
question.

Fix this by moving the endpoint states to the bt_bap BAP session struct,
so that the ASE state is associated with the sessions, and each session
has separate state.
---

Notes:
    Inserting
    
    DBG(bap, "bap:%p ep:%p -> id:%d state:%d", bap, ep, rsp.id, rsp.state);
    
    at the end of ascs_ase_read on BlueZ running on the BAP server and see
    the following:
    
    Client A connects and starts streaming:
    
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x603000042f70 -> id:1 state:0
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x603000043330 -> id:2 state:0
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x6030000436c0 -> id:3 state:0
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x603000043a50 -> id:4 state:0
    
    Client B connects (does not start streaming):
    
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x603000042f70 -> id:1 state:4
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x603000043330 -> id:2 state:0
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x6030000436c0 -> id:3 state:4
    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x603000043a50 -> id:4 state:0
    
    btmon for client B:
    
    > ACL Data RX: Handle 16 flags 0x02 dlen 9            #347 [hci1] 52.809304
          Channel: 64 len 5 sdu 3 [PSM 39 mode LE Flow Control (0x80)] {chan 0}
          ATT: Read Response (0x0b) len 2
            Value: 0104
            Handle: 0x0052 Type: Sink ASE (0x2bc4)
                ASE ID: 1
                State: Streaming (0x04)
                CIG ID: invalid size
    
    The endpoints are the same for both sessions, and client B found out
    that ASEs for client A were in streaming state, which appears to not be
    per spec.
    
    With this patch, the different bap sessions get different endpoints, and
    client B starts with ASEs in idle state, while client A is still
    streaming.
    
    In theory, the code appears to otherwise be structured so that
    everything should work for multiple clients.  However, I don't have
    enough CIS capable devices at hand now to do full testing of
    simultaneous streaming from multiple clients.

 src/shared/bap.c | 65 +++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 22f2e6714..f16ba1832 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -114,7 +114,6 @@ struct bt_bap_db {
 	struct bt_ascs *ascs;
 	struct queue *sinks;
 	struct queue *sources;
-	struct queue *endpoints;
 };
 
 struct bt_bap_req {
@@ -165,6 +164,8 @@ struct bt_bap {
 	struct queue *pending;
 	struct queue *notify;
 	struct queue *streams;
+	struct queue *local_eps;
+	struct queue *remote_eps;
 
 	struct queue *pac_cbs;
 	struct queue *ready_cbs;
@@ -615,7 +616,8 @@ static struct bt_bap_endpoint *bap_endpoint_new(struct bt_bap_db *bdb,
 	return ep;
 }
 
-static struct bt_bap_endpoint *bap_get_endpoint(struct bt_bap_db *db,
+static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
+						struct bt_bap_db *db,
 						struct gatt_db_attribute *attr)
 {
 	struct bt_bap_endpoint *ep;
@@ -623,7 +625,7 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct bt_bap_db *db,
 	if (!db || !attr)
 		return NULL;
 
-	ep = queue_find(db->endpoints, bap_endpoint_match, attr);
+	ep = queue_find(endpoints, bap_endpoint_match, attr);
 	if (ep)
 		return ep;
 
@@ -631,7 +633,7 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct bt_bap_db *db,
 	if (!ep)
 		return NULL;
 
-	queue_push_tail(db->endpoints, ep);
+	queue_push_tail(endpoints, ep);
 
 	return ep;
 }
@@ -644,23 +646,22 @@ static bool bap_endpoint_match_id(const void *data, const void *match_data)
 	return (ep->id == id);
 }
 
-static struct bt_bap_endpoint *bap_get_endpoint_id(struct bt_bap *bap,
-						struct bt_bap_db *db,
-						uint8_t id)
+static struct bt_bap_endpoint *bap_get_local_endpoint_id(struct bt_bap *bap,
+								uint8_t id)
 {
 	struct bt_bap_endpoint *ep;
 	struct gatt_db_attribute *attr = NULL;
 	size_t i;
 
-	if (!bap || !db)
+	if (!bap)
 		return NULL;
 
-	ep = queue_find(db->endpoints, bap_endpoint_match_id, UINT_TO_PTR(id));
+	ep = queue_find(bap->local_eps, bap_endpoint_match_id, UINT_TO_PTR(id));
 	if (ep)
 		return ep;
 
-	for (i = 0; i < ARRAY_SIZE(db->ascs->ase); i++) {
-		struct bt_ase *ase = db->ascs->ase[i];
+	for (i = 0; i < ARRAY_SIZE(bap->ldb->ascs->ase); i++) {
+		struct bt_ase *ase = bap->ldb->ascs->ase[i];
 
 		if (id) {
 			if (ase->id != id)
@@ -669,7 +670,7 @@ static struct bt_bap_endpoint *bap_get_endpoint_id(struct bt_bap *bap,
 			break;
 		}
 
-		ep = queue_find(db->endpoints, bap_endpoint_match, ase->attr);
+		ep = queue_find(bap->local_eps, bap_endpoint_match, ase->attr);
 		if (!ep) {
 			attr = ase->attr;
 			break;
@@ -679,12 +680,12 @@ static struct bt_bap_endpoint *bap_get_endpoint_id(struct bt_bap *bap,
 	if (!attr)
 		return NULL;
 
-	ep = bap_endpoint_new(db, attr);
+	ep = bap_endpoint_new(bap->ldb, attr);
 	if (!ep)
 		return NULL;
 
 	ep->id = id;
-	queue_push_tail(db->endpoints, ep);
+	queue_push_tail(bap->local_eps, ep);
 
 	return ep;
 }
@@ -696,7 +697,8 @@ static void ascs_ase_read(struct gatt_db_attribute *attrib,
 {
 	struct bt_ase *ase = user_data;
 	struct bt_bap *bap = bap_get_session(att, ase->ascs->bdb->db);
-	struct bt_bap_endpoint *ep = bap_get_endpoint(bap->ldb, attrib);
+	struct bt_bap_endpoint *ep = bap_get_endpoint(bap->local_eps,
+							bap->ldb, attrib);
 	struct bt_ascs_ase_status rsp;
 
 	if (!ase || !bap || !ep) {
@@ -1470,7 +1472,7 @@ static uint8_t ascs_config(struct bt_ascs *ascs, struct bt_bap *bap,
 	DBG(bap, "codec 0x%02x phy 0x%02x latency %u", req->codec.id, req->phy,
 							req->latency);
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
+	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
 		DBG(bap, "Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
@@ -1552,7 +1554,7 @@ static uint8_t ascs_qos(struct bt_ascs *ascs, struct bt_bap *bap,
 			req->cig, req->cis, qos.interval, qos.framing, qos.phy,
 			qos.sdu, qos.rtn, qos.latency, qos.delay);
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
+	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
 		DBG(bap, "%s: Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
@@ -1675,7 +1677,7 @@ static uint8_t ascs_enable(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	req = util_iov_pull_mem(iov, sizeof(*req));
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->meta.ase);
+	ep = bap_get_local_endpoint_id(bap, req->meta.ase);
 	if (!ep) {
 		DBG(bap, "Invalid ASE ID 0x%02x", req->meta.ase);
 		ascs_ase_rsp_add(rsp, req->meta.ase,
@@ -1739,7 +1741,7 @@ static uint8_t ascs_start(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	req = util_iov_pull_mem(iov, sizeof(*req));
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
+	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
 		DBG(bap, "Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
@@ -1811,7 +1813,7 @@ static uint8_t ascs_disable(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	req = util_iov_pull_mem(iov, sizeof(*req));
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
+	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
 		DBG(bap, "Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
@@ -1886,7 +1888,7 @@ static uint8_t ascs_stop(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	req = util_iov_pull_mem(iov, sizeof(*req));
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
+	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
 		DBG(bap, "Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
@@ -1951,7 +1953,7 @@ static uint8_t ascs_metadata(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	req = util_iov_pull_mem(iov, sizeof(*req));
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
+	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
 		DBG(bap, "Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
@@ -1995,7 +1997,7 @@ static uint8_t ascs_release(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	req = util_iov_pull_mem(iov, sizeof(*req));
 
-	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
+	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
 		DBG(bap, "Invalid ASE ID 0x%02x", req->ase);
 		ascs_ase_rsp_add(rsp, req->ase,
@@ -2181,7 +2183,6 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 	bdb->db = gatt_db_ref(db);
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
-	bdb->endpoints = queue_new();
 
 	if (!bap_db)
 		bap_db = queue_new();
@@ -2513,7 +2514,6 @@ static void bap_db_free(void *data)
 
 	queue_destroy(bdb->sinks, bap_pac_free);
 	queue_destroy(bdb->sources, bap_pac_free);
-	queue_destroy(bdb->endpoints, free);
 	gatt_db_unref(bdb->db);
 
 	free(bdb->pacs);
@@ -2574,6 +2574,8 @@ static void bap_free(void *data)
 	queue_destroy(bap->pac_cbs, pac_changed_free);
 	queue_destroy(bap->ready_cbs, bap_ready_free);
 	queue_destroy(bap->state_cbs, bap_state_free);
+	queue_destroy(bap->local_eps, free);
+	queue_destroy(bap->remote_eps, free);
 
 	queue_destroy(bap->reqs, bap_req_free);
 	queue_destroy(bap->pending, NULL);
@@ -2656,6 +2658,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bap->ready_cbs = queue_new();
 	bap->streams = queue_new();
 	bap->state_cbs = queue_new();
+	bap->local_eps = queue_new();
 
 	if (!rdb)
 		goto done;
@@ -2664,9 +2667,9 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bdb->db = gatt_db_ref(rdb);
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
-	bdb->endpoints = queue_new();
 
 	bap->rdb = bdb;
+	bap->remote_eps = queue_new();
 
 done:
 	return bt_bap_ref(bap);
@@ -3670,7 +3673,7 @@ static void foreach_ascs_char(struct gatt_db_attribute *attr, void *user_data)
 			!bt_uuid_cmp(&uuid, &uuid_source)) {
 		struct bt_bap_endpoint *ep;
 
-		ep = bap_get_endpoint(bap->rdb, attr);
+		ep = bap_get_endpoint(bap->remote_eps, bap->rdb, attr);
 		if (!ep)
 			return;
 
@@ -3792,7 +3795,7 @@ clone:
 			}
 		}
 
-		queue_foreach(bap->rdb->endpoints, bap_endpoint_foreach, bap);
+		queue_foreach(bap->remote_eps, bap_endpoint_foreach, bap);
 
 		bap_cp_attach(bap);
 
@@ -4192,7 +4195,7 @@ struct bt_bap_stream *bt_bap_config(struct bt_bap *bap,
 	struct match_pac match;
 	int id;
 
-	if (!bap || !bap->rdb || queue_isempty(bap->rdb->endpoints))
+	if (!bap || !bap->rdb || queue_isempty(bap->remote_eps))
 		return NULL;
 
 	if (lpac && rpac) {
@@ -4233,10 +4236,10 @@ struct bt_bap_stream *bt_bap_config(struct bt_bap *bap,
 	match.rpac = rpac;
 
 	/* Check for existing stream */
-	ep = queue_find(bap->rdb->endpoints, find_ep_pacs, &match);
+	ep = queue_find(bap->remote_eps, find_ep_pacs, &match);
 	if (!ep) {
 		/* Check for unused ASE */
-		ep = queue_find(bap->rdb->endpoints, find_ep_unused, &match);
+		ep = queue_find(bap->remote_eps, find_ep_unused, &match);
 		if (!ep) {
 			DBG(bap, "Unable to find unused ASE");
 			return NULL;
-- 
2.39.1

