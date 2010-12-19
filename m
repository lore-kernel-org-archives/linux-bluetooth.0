Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix memory leak in adapter_service_ins_rem()
Date: Sat, 18 Dec 2010 21:56:24 -0400
Message-Id: <1292723784-10338-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5118306..407522f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -980,7 +980,7 @@ static void adapter_service_ins_rem(const bdaddr_t *bdaddr, void *rec,
 							gboolean insert)
 {
 	struct btd_adapter *adapter;
-	GSList *adapters;
+	GSList *l, *adapters;
 
 	adapters = NULL;
 
@@ -995,8 +995,8 @@ static void adapter_service_ins_rem(const bdaddr_t *bdaddr, void *rec,
 		/* Emit D-Bus msg to all adapters */
 		adapters = manager_get_adapters();
 
-	for (; adapters; adapters = adapters->next) {
-		adapter = adapters->data;
+	for (l = adapters; l; l = l->next) {
+		adapter = l->data;
 
 		if (insert == TRUE)
 			adapter->services = sdp_list_insert_sorted(
@@ -1008,6 +1008,9 @@ static void adapter_service_ins_rem(const bdaddr_t *bdaddr, void *rec,
 
 		adapter_emit_uuids_updated(adapter);
 	}
+
+	if (bacmp(bdaddr, BDADDR_ANY) != 0)
+		g_slist_free(adapters);
 }
 
 void adapter_service_insert(const bdaddr_t *bdaddr, void *rec)
-- 
1.7.0.4

