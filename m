Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared/gatt-server: Fix prepare write queuing
Date: Wed, 18 Apr 2018 10:37:12 +0200
Message-Id: <20180418083712.30846-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180418083712.30846-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180418083712.30846-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Multiple prepare writes may be done for multiple attributes. Queue
mechanism must be aware of handle under which preparation is done.
---
 src/shared/gatt-server.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 4b554f665..20d01fd08 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1190,6 +1190,14 @@ static bool prep_data_new(struct bt_gatt_server *server,
 	return true;
 }
 
+static bool match_prep_attr_handle(const void *data, const void *match_data)
+{
+	const struct prep_write_data *prep_data = data;
+	const uint16_t *match_handle = match_data;
+
+	return prep_data->handle == *match_handle;
+}
+
 static bool store_prep_data(struct bt_gatt_server *server,
 					uint16_t handle, uint16_t offset,
 					uint16_t length, uint8_t *value)
@@ -1200,7 +1208,9 @@ static bool store_prep_data(struct bt_gatt_server *server,
 	 * Now lets check if prep write is a continuation of long write
 	 * If so do aggregation of data
 	 */
-	prep_data = queue_peek_tail(server->prep_queue);
+	prep_data = queue_find(server->prep_queue, match_prep_attr_handle,
+								&handle);
+
 	if (prep_data && (prep_data->handle == handle) &&
 			(offset == (prep_data->length + prep_data->offset)))
 		return append_prep_data(prep_data, handle, length, value);
-- 
2.13.6

