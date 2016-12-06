Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, brn@deako.com,
        Don Zickus <dzickus@redhat.com>
Subject: [RFC 2/3] core/adapter: Add le_duplicates flag to management interface
Date: Tue,  6 Dec 2016 16:39:59 -0500
Message-Id: <1481060400-7088-3-git-send-email-dzickus@redhat.com>
In-Reply-To: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
References: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow the ability to disable duplicate filtering on the adapater
from the management interface.

This patch just adds the appropriate hooks to communicate with the
kernel interface.  The following patches will utilize it.

The reason for doing something like this is to allow dynamic LE
scan data to be constantly updated. For example, RSSI changes can
now be seen frequently.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 lib/mgmt.h    |  1 +
 src/adapter.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 798a05e..d9d6cc0 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -452,6 +452,7 @@ struct mgmt_cp_start_service_discovery {
 	int8_t rssi;
 	uint16_t uuid_count;
 	uint8_t uuids[0][16];
+	uint8_t le_duplicates;
 } __packed;
 
 #define MGMT_OP_READ_LOCAL_OOB_EXT_DATA	0x003B
diff --git a/src/adapter.c b/src/adapter.c
index d951307..ddf0d11 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -155,6 +155,7 @@ struct discovery_filter {
 	uint16_t pathloss;
 	int16_t rssi;
 	GSList *uuids;
+	bool le_duplicates;
 };
 
 struct watch_client {
@@ -1529,8 +1530,9 @@ static gboolean start_discovery_timeout(gpointer user_data)
 	/* Filtered discovery is required */
 	sd_cp = adapter->current_discovery_filter;
 
-	DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
-				sd_cp->rssi, sd_cp->type, sd_cp->uuid_count);
+	DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d %d %d",
+				sd_cp->rssi, sd_cp->type, sd_cp->uuid_count,
+				sd_cp->le_duplicates);
 
 	mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
 		  adapter->dev_id, sizeof(*sd_cp) + sd_cp->uuid_count * 16,
@@ -1772,7 +1774,8 @@ static void extract_unique_uuids(gpointer data, gpointer user_data)
  * Returns 1 if there was no filtered scan, 0 otherwise.
  */
 static int merge_discovery_filters(struct btd_adapter *adapter, int *rssi,
-					uint8_t *transport, GSList **uuids)
+					uint8_t *transport, GSList **uuids,
+					bool *le_duplicates)
 {
 	GSList *l;
 	bool empty_uuid = false;
@@ -1791,6 +1794,7 @@ static int merge_discovery_filters(struct btd_adapter *adapter, int *rssi,
 		has_filtered_discovery = true;
 
 		*transport |= item->type;
+		*le_duplicates |= item->le_duplicates;
 
 		/*
 		 * Rule for merging rssi and pathloss into rssi field of kernel
@@ -1877,10 +1881,12 @@ static int discovery_filter_to_mgmt_cp(struct btd_adapter *adapter,
 	int rssi = DISTANCE_VAL_INVALID;
 	int uuid_count;
 	uint8_t discovery_type = 0;
+	bool le_duplicates = 0;
 
 	DBG("");
 
-	if (merge_discovery_filters(adapter, &rssi, &discovery_type, &uuids)) {
+	if (merge_discovery_filters(adapter, &rssi, &discovery_type, &uuids,
+				    &le_duplicates)) {
 		/* There are only regular scans, run just regular scan. */
 		*cp_ptr = NULL;
 		return 0;
@@ -1898,6 +1904,7 @@ static int discovery_filter_to_mgmt_cp(struct btd_adapter *adapter,
 	cp->type = discovery_type;
 	cp->rssi = rssi;
 	cp->uuid_count = uuid_count;
+	cp->le_duplicates = le_duplicates;
 	populate_mgmt_filter_uuids(cp->uuids, uuids);
 
 	g_slist_free(uuids);
-- 
1.8.3.1

