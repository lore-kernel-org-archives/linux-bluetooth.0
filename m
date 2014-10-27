Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 6/7] shared/gatt-db: Fix range handling in read by grp type.
Date: Mon, 27 Oct 2014 07:35:41 -0700
Message-Id: <1414420542-15336-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1414420542-15336-1-git-send-email-armansito@chromium.org>
References: <1414420542-15336-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes bug in gatt_db_read_by_grp_type in which the range end handle
was being ignored. This caused incorrect results to be sent for a database
where services exists beyond the end handle provided in the request.
---
 src/shared/gatt-db.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b3f95d2..65c5759 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -428,6 +428,7 @@ static void read_by_group_type(void *data, void *user_data)
 {
 	struct read_by_group_type_data *search_data = user_data;
 	struct gatt_db_service *service = data;
+	uint16_t grp_start, grp_end;
 
 	if (!service->active)
 		return;
@@ -439,7 +440,15 @@ static void read_by_group_type(void *data, void *user_data)
 	if (bt_uuid_cmp(&search_data->uuid, &service->attributes[0]->uuid))
 		return;
 
-	if (service->attributes[0]->handle < search_data->start_handle)
+	grp_start = service->attributes[0]->handle;
+	grp_end = grp_start + service->num_handles - 1;
+
+	if (grp_end < search_data->start_handle ||
+				grp_start > search_data->end_handle)
+		return;
+
+	if (service->attributes[0]->handle < search_data->start_handle ||
+		service->attributes[0]->handle > search_data->end_handle)
 		return;
 
 	/* Remember size of uuid */
-- 
2.1.0.rc2.206.gedb03e5

