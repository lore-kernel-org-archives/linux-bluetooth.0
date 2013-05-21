Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] profile: Fix incoming connections without SDP record
Date: Tue, 21 May 2013 17:26:24 +0200
Message-Id: <1369149984-1953-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

After commit 7bd3626b6715ac6a117d56b95b455960f7cf34de, incoming connections
require the service being available from SDP. This is not always guaranteed
because some services might not be listed in SDP (like MNS).
---
 src/profile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/profile.c b/src/profile.c
index 8fd0424..9f98d65 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1056,6 +1056,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 		return NULL;
 	}
 
+	btd_device_add_uuid(device, server->ext->remote_uuid);
 	service = btd_device_get_service(device, server->ext->remote_uuid);
 	if (service == NULL) {
 		ba2str(dst, addr);
-- 
1.8.2.3

