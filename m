Return-Path: <cyrus@holtmann.org>
From: Francisco Alecrim <francisco.alecrim@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>
Subject: [PATCH] List with UUIDs per-adapter should be sorted
Date: Thu,  8 Apr 2010 17:35:01 -0400
Message-Id: <1270762501-28643-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c       |    5 +++--
 src/sdpd-database.c |    2 +-
 src/sdpd.h          |    1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8fc47b9..c174793 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1081,8 +1081,9 @@ static void adapter_service_ins_rem(const bdaddr_t *bdaddr, void *rec,
 		adapter = adapters->data;
 
 		if (insert == TRUE)
-			adapter->services = sdp_list_append(adapter->services,
-									rec);
+			adapter->services = sdp_list_insert_sorted(
+							adapter->services, rec,
+							record_sort);
 		else
 			adapter->services = sdp_list_remove(adapter->services,
 									rec);
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 224a4e7..263b16e 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -55,7 +55,7 @@ typedef struct {
  * The service repository is a linked list in sorted order
  * and the service record handle is the sort key
  */
-static int record_sort(const void *r1, const void *r2)
+int record_sort(const void *r1, const void *r2)
 {
 	const sdp_record_t *rec1 = (const sdp_record_t *) r1;
 	const sdp_record_t *rec2 = (const sdp_record_t *) r2;
diff --git a/src/sdpd.h b/src/sdpd.h
index 1f0a229..ce189ca 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -70,6 +70,7 @@ sdp_buf_t *sdp_get_cached_rsp(sdp_cont_state_t *cstate);
 void sdp_cstate_cache_init(void);
 void sdp_cstate_clean_buf(void);
 
+int record_sort(const void *r1, const void *r2);
 void sdp_svcdb_reset(void);
 void sdp_svcdb_collect_all(int sock);
 void sdp_svcdb_set_collectable(sdp_record_t *rec, int sock);
-- 
1.6.3.3

