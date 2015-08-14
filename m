Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] audio: Fix service state
Date: Fri, 14 Aug 2015 18:48:38 +0300
Message-Id: <1439567318-23918-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439567318-23918-1-git-send-email-luiz.dentz@gmail.com>
References: <1439567318-23918-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When profile .disconnect is called the state of the service is already
set to disconnecting this is make no sense to call
btd_service_connect_complete as it will do nothing and the state will
never be updated to disconnected as it should.
---
 profiles/audio/sink.c   | 2 +-
 profiles/audio/source.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 3af8e0f..ac7237b 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -410,7 +410,7 @@ int sink_disconnect(struct btd_service *service)
 	if (sink->connect_id > 0) {
 		a2dp_cancel(sink->connect_id);
 		sink->connect_id = 0;
-		btd_service_connecting_complete(sink->service, -ECANCELED);
+		btd_service_disconnecting_complete(sink->service, 0);
 
 		avdtp_unref(sink->session);
 		sink->session = NULL;
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index c036208..372b132 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -402,7 +402,7 @@ int source_disconnect(struct btd_service *service)
 	if (source->connect_id > 0) {
 		a2dp_cancel(source->connect_id);
 		source->connect_id = 0;
-		btd_service_connecting_complete(source->service, -ECANCELED);
+		btd_service_disconnecting_complete(source->service, 0);
 
 		avdtp_unref(source->session);
 		source->session = NULL;
-- 
2.4.3

