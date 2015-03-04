Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/4] core/gatt: Fix crash in gatt-database destructor
Date: Wed,  4 Mar 2015 13:57:49 -0800
Message-Id: <1425506271-20775-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1425506271-20775-1-git-send-email-armansito@chromium.org>
References: <1425506271-20775-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an invalid access that occurs during daemon shutdown
if at least one external GATT service has been registered:

==4764== Invalid read of size 8
==4764==    at 0x4C8812: queue_foreach (queue.c:241)
==4764==    by 0x47A29C: send_notification_to_devices (gatt-database.c:904)
==4764==    by 0x47BAB8: send_service_changed (gatt-database.c:932)
==4764==    by 0x47BB3D: gatt_db_service_removed (gatt-database.c:972)
==4764==    by 0x4D5CA1: handle_notify (gatt-db.c:264)
==4764==    by 0x4C888F: queue_foreach (queue.c:251)
==4764==    by 0x4D675B: notify_service_changed (gatt-db.c:281)
==4764==    by 0x4D680C: gatt_db_service_destroy (gatt-db.c:292)
==4764==    by 0x4D6889: gatt_db_remove_service (gatt-db.c:424)
==4764==    by 0x47B237: service_free (gatt-database.c:347)
==4764==    by 0x4C8C4F: queue_remove_all (queue.c:387)
==4764==    by 0x4C8CB4: queue_destroy (queue.c:76)
==4764==  Address 0x5e9d0f8 is 8 bytes inside a block of size 32 free'd
==4764==    at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==4764==    by 0x4C8488: queue_unref (queue.c:53)
==4764==    by 0x4C8CC4: queue_destroy (queue.c:78)
==4764==    by 0x47C2E5: gatt_database_free (gatt-database.c:394)
==4764==    by 0x47D21D: btd_gatt_database_destroy (gatt-database.c:2203)
==4764==    by 0x48809F: adapter_remove (adapter.c:4595)
==4764==    by 0x495D42: adapter_cleanup (adapter.c:7486)
==4764==    by 0x40BBDD: main (main.c:666)
==4764==
==4764== Invalid read of size 8
==4764==    at 0x4C8812: queue_foreach (queue.c:241)
==4764==    by 0x47BB56: gatt_db_service_removed (gatt-database.c:974)
==4764==    by 0x4D5CA1: handle_notify (gatt-db.c:264)
==4764==    by 0x4C888F: queue_foreach (queue.c:251)
==4764==    by 0x4D675B: notify_service_changed (gatt-db.c:281)
==4764==    by 0x4D680C: gatt_db_service_destroy (gatt-db.c:292)
==4764==    by 0x4D6889: gatt_db_remove_service (gatt-db.c:424)
==4764==    by 0x47B237: service_free (gatt-database.c:347)
==4764==    by 0x4C8C4F: queue_remove_all (queue.c:387)
==4764==    by 0x4C8CB4: queue_destroy (queue.c:76)
==4764==    by 0x47C2FB: gatt_database_free (gatt-database.c:395)
==4764==    by 0x47D21D: btd_gatt_database_destroy (gatt-database.c:2203)
==4764==  Address 0x5e9d0f8 is 8 bytes inside a block of size 32 free'd
==4764==    at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==4764==    by 0x4C8488: queue_unref (queue.c:53)
==4764==    by 0x4C8CC4: queue_destroy (queue.c:78)
==4764==    by 0x47C2E5: gatt_database_free (gatt-database.c:394)
==4764==    by 0x47D21D: btd_gatt_database_destroy (gatt-database.c:2203)
==4764==    by 0x48809F: adapter_remove (adapter.c:4595)
==4764==    by 0x495D42: adapter_cleanup (adapter.c:7486)
==4764==    by 0x40BBDD: main (main.c:666)
==4764==
---
 src/gatt-database.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index a68bb4f..21c9e95 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -391,14 +391,16 @@ static void gatt_database_free(void *data)
 		adapter_service_remove(database->adapter, database->gap_handle);
 
 	/* TODO: Persistently store CCC states before freeing them */
+	gatt_db_unregister(database->db, database->db_id);
+
 	queue_destroy(database->device_states, device_state_free);
 	queue_destroy(database->services, service_free);
 	queue_destroy(database->ccc_callbacks, ccc_cb_free);
 	database->device_states = NULL;
 	database->ccc_callbacks = NULL;
 
-	gatt_db_unregister(database->db, database->db_id);
 	gatt_db_unref(database->db);
+
 	btd_adapter_unref(database->adapter);
 	free(database);
 }
-- 
2.2.0.rc0.207.ga3a616c

