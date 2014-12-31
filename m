Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 03/14] unit/gatt: Bugfix small database construction
Date: Tue, 30 Dec 2014 16:32:21 -0800
Message-Id: <1419985952-18334-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Small DB was constructed without noticing that the last characteristic is
not added, and needs two more handles in the service to hold it.

This patch will also cause unit/gatt to assert if characteristics are
not added when expected.
---
 unit/test-gatt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 5f5ad1b..bee8f37 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -149,7 +149,7 @@ struct context {
 
 #define PRIMARY_DISC_SMALL_DB						\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
-		raw_pdu(0x11, 0x06, 0x10, 0xF0, 0x15, 0xF0, 0x00, 0x18,	\
+		raw_pdu(0x11, 0x06, 0x10, 0xF0, 0x17, 0xF0, 0x00, 0x18,	\
 				0xFF, 0xFF, 0xFF, 0xFF, 0x0a, 0x18)
 
 #define SECONDARY_DISC_SMALL_DB						\
@@ -652,6 +652,8 @@ static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
 								NULL, NULL,
 								NULL);
 
+	g_assert(attrib != NULL);
+
 	gatt_db_attribute_write(attrib, 0, value, len, 0x00, NULL, att_write_cb,
 									NULL);
 
@@ -809,7 +811,7 @@ static struct gatt_db *make_test_spec_small_db(void)
 
 	gatt_db_service_set_active(dis_att, true);
 
-	serv_att = add_gap(db, 0xF010, true, 5);
+	serv_att = add_gap(db, 0xF010, true, 7);
 
 	gatt_db_service_add_included(serv_att, dis_att);
 
@@ -1145,7 +1147,7 @@ int main(int argc, char *argv[])
 					0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00,
 					0x80, 0x00, 0x10, 0x00, 0x00, 0x0d,
 					0x18, 0x00, 0x00),
-			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
+			raw_pdu(0x01, 0x06, 0x18, 0x00, 0x0a));
 
 	define_test_att("/TP/GAD/CL/BV-03-C", test_search_included, NULL,
 			NULL,
-- 
2.2.0.rc0.207.ga3a616c

