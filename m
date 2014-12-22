Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/scpp: Fix using freed memory
Date: Mon, 22 Dec 2014 13:49:13 +0200
Message-Id: <1419248953-31147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes use after free memory bug.
req is assigned to user_data and then freed with destroy_gatt_req(req)
---
 android/scpp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index 77f48cd..9f60c9f 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -301,8 +301,6 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 	uint16_t start, end;
 	bt_uuid_t uuid;
 
-	destroy_gatt_req(req);
-
 	if (status) {
 		error("Scan Refresh %s", att_ecode2str(status));
 		return;
@@ -329,6 +327,8 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 
 	discover_desc(scan, scan->attrib, start, end, &uuid,
 					discover_descriptor_cb, user_data);
+
+	destroy_gatt_req(req);
 }
 
 static void iwin_discovered_cb(uint8_t status, GSList *chars, void *user_data)
-- 
2.1.0

