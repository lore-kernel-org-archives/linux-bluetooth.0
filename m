Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779F5C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBKK5Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjBKK5M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:12 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D596A75
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:10 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 1ADD924072C
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:09 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGr561Dz9rxD;
        Sat, 11 Feb 2023 11:57:08 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 8/9] shared/bap: support client-only case
Date:   Sat, 11 Feb 2023 10:53:52 +0000
Message-Id: <e06482dca2dc887b224c94d8ab5e82d6561be06a.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When client-only, skip registering ASCS and PACS in the local GATT DB.

The data structures used to track the local ASE & PAC registrations and
ASE state are then also not needed, and are set to NULL in this case.

In this case, local "endpoints" exist only in the form of locally added
bt_bap_pac PAC data. These usually are in 1-to-1 correspondence with the
Media1 API endpoints registered by media applications.
---

Notes:
    v2:
    * Use named boolean flag for client-only in bt_bap_db instead of just
      NULL field values, maybe makes the intent a bit clearer.
    * Add bt_bap_set_client_only for setting the client-only flag on
      databases, instead of exposing bt_bap_db.
    
    The client-only state cannot be indicated to bt_bap_new by passing in
    ldb==NULL, because the local PACs are in the ldb and we need to know
    which adapter the bt_bap is for.
    
    So instead use a separate function that sets the flag. It cannot make
    already peripheral-enabled DB client-only (currently), but this is not
    needed now, and maybe not in the future either.

 src/shared/bap.c | 42 +++++++++++++++++++++++++++++++++---------
 src/shared/bap.h |  2 ++
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 22f2e6714..e85815d8d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -109,6 +109,7 @@ struct bt_ascs {
 };
 
 struct bt_bap_db {
+	bool client_only;
 	struct gatt_db *db;
 	struct bt_pacs *pacs;
 	struct bt_ascs *ascs;
@@ -620,7 +621,7 @@ static struct bt_bap_endpoint *bap_get_endpoint(struct bt_bap_db *db,
 {
 	struct bt_bap_endpoint *ep;
 
-	if (!db || !attr)
+	if (!db || !attr || db->client_only)
 		return NULL;
 
 	ep = queue_find(db->endpoints, bap_endpoint_match, attr);
@@ -652,7 +653,7 @@ static struct bt_bap_endpoint *bap_get_endpoint_id(struct bt_bap *bap,
 	struct gatt_db_attribute *attr = NULL;
 	size_t i;
 
-	if (!bap || !db)
+	if (!bap || !db || db->client_only)
 		return NULL;
 
 	ep = queue_find(db->endpoints, bap_endpoint_match_id, UINT_TO_PTR(id));
@@ -2170,7 +2171,7 @@ static struct bt_ascs *ascs_new(struct gatt_db *db)
 	return ascs;
 }
 
-static struct bt_bap_db *bap_db_new(struct gatt_db *db)
+static struct bt_bap_db *bap_db_new(struct gatt_db *db, bool client_only)
 {
 	struct bt_bap_db *bdb;
 
@@ -2178,19 +2179,23 @@ static struct bt_bap_db *bap_db_new(struct gatt_db *db)
 		return NULL;
 
 	bdb = new0(struct bt_bap_db, 1);
+	bdb->client_only = client_only;
 	bdb->db = gatt_db_ref(db);
 	bdb->sinks = queue_new();
 	bdb->sources = queue_new();
-	bdb->endpoints = queue_new();
 
 	if (!bap_db)
 		bap_db = queue_new();
 
-	bdb->pacs = pacs_new(db);
-	bdb->pacs->bdb = bdb;
+	if (!client_only) {
+		bdb->endpoints = queue_new();
+
+		bdb->pacs = pacs_new(db);
+		bdb->pacs->bdb = bdb;
 
-	bdb->ascs = ascs_new(db);
-	bdb->ascs->bdb = bdb;
+		bdb->ascs = ascs_new(db);
+		bdb->ascs->bdb = bdb;
+	}
 
 	queue_push_tail(bap_db, bdb);
 
@@ -2205,7 +2210,20 @@ static struct bt_bap_db *bap_get_db(struct gatt_db *db)
 	if (bdb)
 		return bdb;
 
-	return bap_db_new(db);
+	return bap_db_new(db, false);
+}
+
+int bt_bap_set_client_only(struct gatt_db *db)
+{
+	struct bt_bap_db *bdb;
+
+	bdb = queue_find(bap_db, bap_db_match, db);
+	if (bdb)
+		return bdb->client_only ? 0 : -EINVAL;
+
+	bap_db_new(db, true);
+
+	return 0;
 }
 
 static struct bt_pacs *bap_get_pacs(struct bt_bap *bap)
@@ -2328,6 +2346,9 @@ static void bap_add_sink(struct bt_bap_pac *pac)
 
 	queue_push_tail(pac->bdb->sinks, pac);
 
+	if (pac->bdb->client_only)
+		return;
+
 	memset(value, 0, sizeof(value));
 
 	iov.iov_base = value;
@@ -2346,6 +2367,9 @@ static void bap_add_source(struct bt_bap_pac *pac)
 
 	queue_push_tail(pac->bdb->sources, pac);
 
+	if (pac->bdb->client_only)
+		return;
+
 	memset(value, 0, sizeof(value));
 
 	iov.iov_base = value;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 47a15636c..90d373e35 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -111,6 +111,8 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *data,
 					struct iovec *metadata);
 
+int bt_bap_set_client_only(struct gatt_db *db);
+
 struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			struct bt_bap_pac_qos *qos,
-- 
2.39.1

