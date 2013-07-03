Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 20/20] audio/source: Fix not notifying service about connection state
Date: Wed,  3 Jul 2013 18:15:41 +0300
Message-Id: <1372864541-10763-21-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
References: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_service_connecting_complete should be called whenever the service
is connected otherwise the service state will not be consistent.
---
 profiles/audio/source.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 64570a6..c171620 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -163,6 +163,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		source->cb_id = 0;
 		break;
 	case AVDTP_STATE_OPEN:
+		btd_service_connecting_complete(source->service, 0);
 		source_set_state(source, SOURCE_STATE_CONNECTED);
 		break;
 	case AVDTP_STATE_STREAMING:
@@ -211,11 +212,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	source->connect_id = 0;
 
-	if (stream) {
-		DBG("Stream successfully created");
-		btd_service_connecting_complete(source->service, 0);
+	if (stream)
 		return;
-	}
 
 	avdtp_unref(source->session);
 	source->session = NULL;
-- 
1.8.1.4

