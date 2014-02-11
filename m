Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 08/11] android/socket: Register SDP record for application service
Date: Tue, 11 Feb 2014 17:58:18 +0100
Message-ID: <1392137901-3403-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds SDP record for services registered from application
(other than built-in services).
---
 android/socket.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index e560609..9175bf3 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -350,6 +350,22 @@ static sdp_record_t *create_spp_record(uint8_t chan, const char *svc_name)
 	return record;
 }
 
+static sdp_record_t *create_app_record(uint8_t chan,
+						const uint8_t *app_uuid,
+						const char *svc_name)
+{
+	sdp_record_t *record;
+	uuid_t uuid;
+
+	sdp_uuid128_create(&uuid, app_uuid);
+
+	record = create_rfcomm_record(chan, &uuid, svc_name, false);
+	if (!record)
+		return NULL;
+
+	return record;
+}
+
 static const struct profile_info {
 	uint8_t		uuid[16];
 	uint8_t		channel;
@@ -396,19 +412,24 @@ static const struct profile_info {
 	},
 };
 
-static uint32_t sdp_service_register(const struct profile_info *profile,
-							const void *svc_name)
+static uint32_t sdp_service_register(uint8_t channel, const uint8_t *uuid,
+					const struct profile_info *profile,
+					const void *svc_name)
 {
-	sdp_record_t *record;
-
-	if (!profile || !profile->create_record)
-		return 0;
+	sdp_record_t *record = NULL;
+	uint8_t svc_hint = 0;
+
+	if (profile && profile->create_record) {
+		record = profile->create_record(channel, svc_name);
+		svc_hint = profile->svc_hint;
+	} else if (uuid) {
+		record = create_app_record(channel, uuid, svc_name);
+	}
 
-	record = profile->create_record(profile->channel, svc_name);
 	if (!record)
 		return 0;
 
-	if (bt_adapter_add_record(record, profile->svc_hint) < 0) {
+	if (bt_adapter_add_record(record, svc_hint) < 0) {
 		error("Failed to register on SDP record");
 		sdp_record_free(record);
 		return 0;
@@ -782,7 +803,8 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 		goto failed;
 	}
 
-	rfsock->service_handle = sdp_service_register(profile, name);
+	rfsock->service_handle = sdp_service_register(chan, uuid, profile,
+									name);
 
 	servers[chan].rfsock = rfsock;
 
-- 
1.8.5.3

