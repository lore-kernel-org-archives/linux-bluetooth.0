Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] obexd: Remove msg from MAP session structure
Date: Fri, 13 Sep 2013 17:28:36 +0200
Message-Id: <1379086116-22617-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The D-Bus message for a pending method call is now stored in the
pending_request struct.
---
 obexd/client/map.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 8b56143..9fe872d 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -95,7 +95,6 @@ static const char * const filter_list[] = {
 
 struct map_data {
 	struct obc_session *session;
-	DBusMessage *msg;
 	GHashTable *messages;
 	int16_t mas_instance_id;
 	uint8_t supported_message_types;
-- 
1.8.3.4

