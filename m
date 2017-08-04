Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, josephsih@chromium.org,
        dmitrygr@google.com, Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH] shared/gatt-db: Fix memory comparison error
Date: Fri,  4 Aug 2017 14:25:52 -0700
Message-Id: <20170804212552.185384-1-mcchou@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Miao-chen Chou <mcchou@chromium.org>

This fixes the use of memcmp where the length of comparison is longer than the
memories to be compared. Since unit/test-gatt make use of gatt-db, if compiled
with ASan, unit/test-gatt would fail.
---
 src/shared/gatt-db.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8ef6f3bca..b7bbaed93 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1013,10 +1013,15 @@ static void find_by_type(void *data, void *user_data)
 			continue;

 		/* TODO: fix for read-callback based attributes */
-		if (search_data->value && memcmp(attribute->value,
-							search_data->value,
-							search_data->value_len))
-			continue;
+		if (search_data->value) {
+			if (search_data->value_len != attribute->value_len)
+				continue;
+
+			if (memcmp(attribute->value, search_data->value,
+					search_data->value_len)) {
+				 continue;
+			}
+		}

 		search_data->num_of_res++;
 		search_data->func(attribute, search_data->user_data);
--
2.14.0.rc1.383.gd1ce394fe2-goog

