Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 05/27] network: Fail if multiple profile instances
Date: Fri, 26 Apr 2013 08:17:01 +0200
Message-Id: <1366957043-2383-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Considerable parts codebase are assuming that there is one single
instance of each UUID and therefore return an error during probe instead
of silently ignoring duplicated entries.
---
 profiles/network/connection.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 3a913cf..3ccd211 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -698,8 +698,11 @@ int connection_register(struct btd_device *device, uint16_t id)
 	}
 
 	nc = find_connection(peer->connections, id);
-	if (nc)
-		return 0;
+	if (nc) {
+		error("Device %s has multiple connection instances of %d",
+						device_get_path(device), id);
+		return -1;
+	}
 
 	nc = g_new0(struct network_conn, 1);
 	nc->id = id;
-- 
1.8.1.4

