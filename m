Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vinicius.gomes@openbossa.org,
	claudio.takahasi@openbossa.org, luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v2 01/11] transport: Initialize the "Volume" property
Date: Mon, 14 Jan 2013 13:10:29 -0300
Message-Id: <1358179829-29684-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <CAAngNMa=ZS0d-yWhpEVUGD3FZaWb_E6awVnwJoO68tje2fdEtA@mail.gmail.com>
References: <CAAngNMa=ZS0d-yWhpEVUGD3FZaWb_E6awVnwJoO68tje2fdEtA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/transport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a4370a5..8defc6f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -787,7 +787,6 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 		struct a2dp_transport *a2dp;
 
 		a2dp = g_new0(struct a2dp_transport, 1);
-		a2dp->volume = -1;
 
 		transport->resume = resume_a2dp;
 		transport->suspend = suspend_a2dp;
@@ -795,14 +794,17 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 		transport->data = a2dp;
 		transport->destroy = destroy_a2dp;
 
-		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0)
+		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
+			a2dp->volume = -1;
 			transport->sink_watch = sink_add_state_cb(
 							sink_state_changed,
 							transport);
-		else
+		} else {
+			a2dp->volume = 127;
 			transport->source_watch = source_add_state_cb(
 							source_state_changed,
 							transport);
+		}
 	} else
 		goto fail;
 
-- 
1.7.11.7

