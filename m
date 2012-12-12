Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/16] a2dp: Convert a2dp_add_sep to accept struct btd_adapter
Date: Wed, 12 Dec 2012 11:27:59 +0100
Message-ID: <1355308088-9080-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass btd_adapter directly or use getters to get needed data from
adapter object.
---
 profiles/audio/a2dp.c  |  4 ++--
 profiles/audio/a2dp.h  |  2 +-
 profiles/audio/media.c | 12 ++----------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c145ca4..51119b7 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1253,7 +1253,7 @@ void a2dp_unregister(struct btd_adapter *adapter)
 	g_free(server);
 }
 
-struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
+struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
 				struct a2dp_endpoint *endpoint,
 				void *user_data, GDestroyNotify destroy,
@@ -1265,7 +1265,7 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 	uint32_t *record_id;
 	sdp_record_t *record;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter_get_address(adapter));
 	if (server == NULL) {
 		if (err)
 			*err = -EPROTONOSUPPORT;
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index f45e40d..dab9195 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -68,7 +68,7 @@ int a2dp_source_register(struct btd_adapter *adapter, GKeyFile *config);
 int a2dp_sink_register(struct btd_adapter *adapter, GKeyFile *config);
 void a2dp_unregister(struct btd_adapter *adapter);
 
-struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
+struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
 				struct a2dp_endpoint *endpoint,
 				void *user_data, GDestroyNotify destroy,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c18dc4e..905538e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -552,11 +552,7 @@ static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
 						gboolean delay_reporting,
 						int *err)
 {
-	const bdaddr_t *src;
-
-	src = adapter_get_address(endpoint->adapter->btd_adapter);
-
-	endpoint->sep = a2dp_add_sep(src,
+	endpoint->sep = a2dp_add_sep(endpoint->adapter->btd_adapter,
 					AVDTP_SEP_TYPE_SOURCE, endpoint->codec,
 					delay_reporting, &a2dp_endpoint,
 					endpoint, a2dp_destroy_endpoint, err);
@@ -570,11 +566,7 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 						gboolean delay_reporting,
 						int *err)
 {
-	const bdaddr_t *src;
-
-	src = adapter_get_address(endpoint->adapter->btd_adapter);
-
-	endpoint->sep = a2dp_add_sep(src,
+	endpoint->sep = a2dp_add_sep(endpoint->adapter->btd_adapter,
 					AVDTP_SEP_TYPE_SINK, endpoint->codec,
 					delay_reporting, &a2dp_endpoint,
 					endpoint, a2dp_destroy_endpoint, err);
-- 
1.8.0

