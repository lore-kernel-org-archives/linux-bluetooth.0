Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0] audio: Fix missing gateway state check on Connect
Date: Tue,  2 Oct 2012 19:46:40 +0200
Message-Id: <1349200000-2696-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If the gateway is already connected (or connecting) when Connect() is
called, an error should be returned, exactly as other interfaces do.
---
 audio/gateway.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/gateway.c b/audio/gateway.c
index a9a576e..b4d96f0 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -572,6 +572,11 @@ static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
 	struct gateway *gw = au_dev->gateway;
 	int err;
 
+	if (gw->state == GATEWAY_STATE_CONNECTING)
+		return btd_error_in_progress(msg);
+	else if (gw->state > GATEWAY_STATE_CONNECTING)
+		return btd_error_already_connected(msg);
+
 	if (!gw->agent)
 		return btd_error_agent_not_available(msg);
 
-- 
1.7.11.4

