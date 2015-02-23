Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] audio/a2dp: Fix queue initialization
Date: Mon, 23 Feb 2015 09:59:43 +0200
Message-Id: <1424678384-25495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After changing GSList to queue initialization was missing.
---
 profiles/audio/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index b024742..ad21df3 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1249,6 +1249,7 @@ static void avdtp_server_destroy(struct avdtp_server *server)
 	g_io_channel_shutdown(server->io, TRUE, NULL);
 	g_io_channel_unref(server->io);
 	btd_adapter_unref(server->adapter);
+	queue_destroy(server->seps, NULL);
 	g_free(server);
 }
 
@@ -1373,6 +1374,7 @@ static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
 	}
 
 	server->adapter = btd_adapter_ref(adapter);
+	server->seps = queue_new();
 
 	avdtp_servers = g_slist_append(avdtp_servers, server);
 
-- 
2.1.0

