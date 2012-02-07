Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/2] attrib-server: Fix memory leak attaching attribute channels
Date: Tue,  7 Feb 2012 10:33:10 +0100
Message-Id: <1328607191-9550-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Channel is not being released when the channel is attached over
an uninitialized GATT server.
---
 src/attrib-server.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2995167..a23d5d2 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1020,8 +1020,14 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 	}
 
 	server = find_gatt_server(&channel->src);
-	if (server == NULL)
+	if (server == NULL) {
+		char src[18];
+
+		ba2str(&channel->src, src);
+		error("Not GATT server found in %s", src);
+		g_free(channel);
 		return 0;
+	}
 
 	channel->server = server;
 
-- 
1.7.9

