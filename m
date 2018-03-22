Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ v2 2/3] shared/gatt-client: Fix discovery of discontinuous database
Date: Thu, 22 Mar 2018 16:21:00 +0100
Message-Id: <20180322152101.9871-3-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
References: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
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
adjacent services and any empty spaces in between - the result is
basically set of ranges without any known service. In most cases this
works the same or very similar to current implementation.

This issue can sometimes be observed with iOS devices as ANCS and CTS
services may not be available all the time.
---
 src/shared/gatt-client.c | 116 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 10 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f0850e0fe..b7cf91820 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -320,6 +320,7 @@ typedef void (*discovery_op_fail_func_t)(struct discovery_op *op);
 
 struct discovery_op {
 	struct bt_gatt_client *client;
+	struct queue *discov_ranges;
 	struct queue *pending_svcs;
 	struct queue *pending_chrcs;
 	struct queue *ext_prop_desc;
@@ -341,6 +342,7 @@ static void discovery_op_free(struct discovery_op *op)
 	if (op->db_id > 0)
 		gatt_db_unregister(op->client->db, op->db_id);
 
+	queue_destroy(op->discov_ranges, free);
 	queue_destroy(op->pending_svcs, NULL);
 	queue_destroy(op->pending_chrcs, free);
 	queue_destroy(op->ext_prop_desc, NULL);
@@ -404,8 +406,10 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 				discovery_op_fail_func_t failure_func)
 {
 	struct discovery_op *op;
+	struct handle_range *range;
 
 	op = new0(struct discovery_op, 1);
+	op->discov_ranges = queue_new();
 	op->pending_svcs = queue_new();
 	op->pending_chrcs = queue_new();
 	op->ext_prop_desc = queue_new();
@@ -415,6 +419,8 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op->start = start;
 	op->end = end;
 	op->last = gatt_db_isempty(client->db) ? 0 : UINT16_MAX;
+	op->svc_first = UINT16_MAX;
+	op->svc_last = 0;
 
 	/* Load existing services as pending */
 	gatt_db_foreach_service_in_range(client->db, NULL,
@@ -429,6 +435,11 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 						discovery_service_changed,
 						op, NULL);
 
+	range = new0(struct handle_range, 1);
+	range->start = start;
+	range->end = end;
+	queue_push_tail(op->discov_ranges, range);
+
 	return op;
 }
 
@@ -477,6 +488,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
 	unsigned int includes_count, i;
+	struct handle_range *range;
 
 	discovery_req_clear(client);
 
@@ -530,12 +542,17 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
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
 
@@ -871,6 +888,36 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
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
@@ -881,7 +928,6 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	if (discovering)
 		return;
 
-next:
 	/* Done with the current service */
 	gatt_db_service_set_active(op->cur_svc, true);
 
@@ -894,6 +940,46 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+static bool match_handle_range(const void *data, const void *match_data)
+{
+	const struct handle_range *range = data;
+	const struct handle_range *match_range = match_data;
+
+	return (match_range->start >= range->start) &&
+					(match_range->start <= range->end);
+}
+
+static void remove_discov_range(struct discovery_op *op, uint16_t start,
+								uint16_t end)
+{
+	struct handle_range match_range;
+	struct handle_range *range, *new_range;
+
+	match_range.start = start;
+	match_range.end = end;
+
+	range = queue_find(op->discov_ranges, match_handle_range, &match_range);
+	if (!range)
+		return;
+
+	if ((range->start == start) && (range->end == end)) {
+		queue_remove(op->discov_ranges, range);
+		free(range);
+	} else if (range->start == start)
+		range->start = end + 1;
+	else if (range->end == end)
+		range->end = start - 1;
+	else {
+		new_range = new0(struct handle_range, 1);
+		new_range->start = end + 1;
+		new_range->end = range->end;
+
+		queue_push_after(op->discov_ranges, range, new_range);
+
+		range->end = start - 1;
+	}
+}
+
 static void discovery_found_service(struct discovery_op *op,
 					struct gatt_db_attribute *attr,
 					uint16_t start, uint16_t end)
@@ -906,15 +992,17 @@ static void discovery_found_service(struct discovery_op *op,
 		else
 			queue_push_tail(op->pending_svcs, attr);
 
-		/* Update discovery range */
-		if (!op->svc_first || op->svc_first > start)
+		if (start < op->svc_first)
 			op->svc_first = start;
-		if (op->svc_last < end)
+		if (end > op->svc_last)
 			op->svc_last = end;
-	} else
+	} else {
 		/* Remove from pending if active */
 		queue_remove(op->pending_svcs, attr);
 
+		remove_discov_range(op, start, end);
+	}
+
 	/* Update last handle */
 	if (end > op->last)
 		op->last = end;
@@ -932,6 +1020,7 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	uint128_t u128;
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
+	struct handle_range *range;
 
 	discovery_req_clear(client);
 
@@ -991,12 +1080,19 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	}
 
 next:
-	if (queue_isempty(op->pending_svcs) || !op->svc_first)
+	if (queue_isempty(op->pending_svcs) || queue_isempty(op->discov_ranges))
 		goto done;
 
+	if (op->svc_first > 0x0001)
+		remove_discov_range(op, 1, op->svc_first - 1);
+	if (op->svc_last < 0xffff)
+		remove_discov_range(op, op->svc_last + 1, 0xffff);
+
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

