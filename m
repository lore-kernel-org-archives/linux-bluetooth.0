Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	luiz.dentz@gmail.com, Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 1/3] obexd/map: Add support for MAP feature bits
Date: Mon, 20 Oct 2014 20:34:27 +0530
Message-id: <1413817469-4255-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handles MAP supported feature bits as per the
MAP 1.2 specs section 7.1.1.
---
 obexd/client/map.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 44db96c..43b0471 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -100,6 +100,7 @@ struct map_data {
 	GHashTable *messages;
 	int16_t mas_instance_id;
 	uint8_t supported_message_types;
+	uint32_t supported_features;
 };
 
 struct pending_request {
@@ -2003,6 +2004,14 @@ static void parse_service_record(struct map_data *map)
 		map->supported_message_types = *(uint8_t *)data;
 	else
 		DBG("Failed to read supported message types");
+
+	/* Supported Feature Bits */
+	data = obc_session_get_attribute(map->session,
+					SDP_ATTR_MAP_SUPPORTED_FEATURES);
+	if(data != NULL)
+		map->supported_features = *(uint32_t *)data;
+	else
+		map->supported_features = 0x0000001f;
 }
 
 static int map_probe(struct obc_session *session)
-- 
1.9.1

