Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ 2/2] shared/gatt-client: Fix discovery of discontinuous database
Date: Wed, 21 Mar 2018 18:47:23 +0100
Message-Id: <20180321174723.11463-2-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <20180321174723.11463-1-andrzej.kaczmarek@codecoup.pl>
References: <20180321174723.11463-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If local cache of peer's database has gaps where new services appear
after reconnection, GATT client will attempt to discover all included
services and characteristics definitions between starting handle of
first service and end handle of last service. This means the result
will contain also attributes which are already present in active
services in local database and thus attempting to add them again will
fail.

To fix this, instead of discovering whole range we'll only discover
ranges for missing services - starting with included services then
characteristics. To optimize this process we'll merge ranges of
adjacent services.

This issue can sometimes be observed with iOS devices as ANCS and CTS
services may not be available all the time.
---
 src/shared/gatt-client.c | 75 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f0850e0fe..96b4ee034 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -320,6 +320,7 @@ typedef void (*discovery_op_fail_func_t)(struct discovery_op *op);
 
 struct discovery_op {
 	struct bt_gatt_client *client;
+	struct queue *discov_ranges;
 	struct queue *pending_svcs;
 	struct queue *pending_chrcs;
 	struct queue *ext_prop_desc;
@@ -328,8 +329,6 @@ struct discovery_op {
 	uint16_t start;
 	uint16_t end;
 	uint16_t last;
-	uint16_t svc_first;
-	uint16_t svc_last;
 	unsigned int db_id;
 	int ref_count;
 	discovery_op_complete_func_t complete_func;
@@ -341,6 +340,7 @@ static void discovery_op_free(struct discovery_op *op)
 	if (op->db_id > 0)
 		gatt_db_unregister(op->client->db, op->db_id);
 
+	queue_destroy(op->discov_ranges, free);
 	queue_destroy(op->pending_svcs, NULL);
 	queue_destroy(op->pending_chrcs, free);
 	queue_destroy(op->ext_prop_desc, NULL);
@@ -406,6 +406,7 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	struct discovery_op *op;
 
 	op = new0(struct discovery_op, 1);
+	op->discov_ranges = queue_new();
 	op->pending_svcs = queue_new();
 	op->pending_chrcs = queue_new();
 	op->ext_prop_desc = queue_new();
@@ -477,6 +478,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
 	unsigned int includes_count, i;
+	struct handle_range *range;
 
 	discovery_req_clear(client);
 
@@ -530,12 +532,17 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 	}
 
 next:
+	range = queue_pop_head(op->discov_ranges);
+	if (!range)
+		goto failed;
+
 	client->discovery_req = bt_gatt_discover_characteristics(client->att,
-							op->svc_first,
-							op->svc_last,
+							range->start,
+							range->end,
 							discover_chrcs_cb,
 							discovery_op_ref(op),
 							discovery_op_unref);
+	free(range);
 	if (client->discovery_req)
 		return;
 
@@ -871,6 +878,36 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 		queue_push_tail(op->pending_chrcs, chrc_data);
 	}
 
+next:
+	/*
+	 * Before attempting to process discovered characteristics make sure we
+	 * discovered all missing ranges.
+	 */
+	if (queue_length(op->discov_ranges)) {
+		struct handle_range *range;
+
+		range = queue_peek_head(op->discov_ranges);
+		if (!range)
+			goto failed;
+
+		client->discovery_req =
+			bt_gatt_discover_included_services(client->att,
+							range->start,
+							range->end,
+							discover_incl_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
+		if (client->discovery_req)
+			return;
+
+		util_debug(client->debug_callback, client->debug_data,
+				"Failed to start included services discovery");
+
+		discovery_op_unref(op);
+
+		goto failed;
+	}
+
 	/*
 	 * Sequentially discover descriptors for each characteristic and insert
 	 * the characteristics into the database as we proceed.
@@ -881,7 +918,6 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	if (discovering)
 		return;
 
-next:
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
@@ -900,17 +936,25 @@ static void discovery_found_service(struct discovery_op *op,
 {
 	/* Skip if service already active */
 	if (!gatt_db_service_get_active(attr)) {
+		struct handle_range *range;
+
 		/* Skip if there are no attributes */
 		if (end == start)
 			gatt_db_service_set_active(attr, true);
-		else
+		else {
 			queue_push_tail(op->pending_svcs, attr);
 
-		/* Update discovery range */
-		if (!op->svc_first || op->svc_first > start)
-			op->svc_first = start;
-		if (op->svc_last < end)
-			op->svc_last = end;
+			/* Update discovery range */
+			range = queue_peek_tail(op->discov_ranges);
+			if (!range || (range->end + 1 != start)) {
+				range = new0(struct handle_range, 1);
+				range->start = start;
+				range->end = end;
+				queue_push_tail(op->discov_ranges, range);
+			} else {
+				range->end = end;
+			}
+		}
 	} else
 		/* Remove from pending if active */
 		queue_remove(op->pending_svcs, attr);
@@ -932,6 +976,7 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	uint128_t u128;
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
+	struct handle_range *range;
 
 	discovery_req_clear(client);
 
@@ -991,12 +1036,14 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	}
 
 next:
-	if (queue_isempty(op->pending_svcs) || !op->svc_first)
+	if (queue_isempty(op->pending_svcs) || queue_isempty(op->discov_ranges))
 		goto done;
 
+	range = queue_peek_head(op->discov_ranges);
+
 	client->discovery_req = bt_gatt_discover_included_services(client->att,
-							op->svc_first,
-							op->svc_last,
+							range->start,
+							range->end,
 							discover_incl_cb,
 							discovery_op_ref(op),
 							discovery_op_unref);
-- 
2.16.2

