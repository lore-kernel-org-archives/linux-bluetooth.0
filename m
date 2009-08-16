Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH] Small optimization on audio IPC.
Date: Sat, 15 Aug 2009 23:44:13 -0300
Message-Id: <1250390653-476-2-git-send-email-jprvita@gmail.com>
In-Reply-To: <1250390653-476-1-git-send-email-jprvita@gmail.com>
References: <1250390653-476-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check if we find the device before trying to define an interface,
so if we fail the if comparison plus the strdup are not necessary.
---
 audio/unix.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index 23e2382..e0307e0 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -1257,14 +1257,13 @@ static void handle_getcapabilities_req(struct unix_client *client,
 	str2ba(req->source, &src);
 	str2ba(req->destination, &dst);
 
+	if (!manager_find_device(req->object, &src, &dst, NULL, FALSE))
+		goto failed;
+
 	if (req->transport == BT_CAPABILITIES_TRANSPORT_SCO)
 		client->interface = g_strdup(AUDIO_HEADSET_INTERFACE);
 	else if (req->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
 		client->interface = g_strdup(AUDIO_SINK_INTERFACE);
-
-	if (!manager_find_device(req->object, &src, &dst, NULL, FALSE))
-		goto failed;
-
 	dev = manager_find_device(req->object, &src, &dst, client->interface,
 				TRUE);
 	if (!dev && (req->flags & BT_FLAG_AUTOCONNECT))
-- 
1.6.0.4

