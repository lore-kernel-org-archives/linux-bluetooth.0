Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Robert=20Luba=C5=9B?= <robert.lubas@silvair.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Robert=20Luba=C5=9B?= <robert.lubas@silvair.com>
Subject: [PATCH BlueZ v2] Mesh: Fix proxy PDU SAR msg length
Date: Mon, 19 Mar 2018 11:58:41 +0100
Message-Id: <20180319105841.32436-1-robert.lubas@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In read_pipe function there was a mishandled case when the msg has
more than one segment. As a result e.g. after provisioning the
capabilities discovery was incorrect parsed.
---
 mesh/gatt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mesh/gatt.c b/mesh/gatt.c
index 9116a9de1..693577a3a 100644
--- a/mesh/gatt.c
+++ b/mesh/gatt.c
@@ -383,7 +383,7 @@ static bool pipe_read(struct io *io, bool prov, void *user_data)
 	uint8_t buf[512];
 	uint8_t *res;
 	int fd = io_get_fd(io);
-	ssize_t len;
+	ssize_t len, len_sar;
 
 	if (io != notify_io)
 		return true;
@@ -393,14 +393,14 @@ static bool pipe_read(struct io *io, bool prov, void *user_data)
 			break;
 
 		res = buf;
-		mesh_gatt_sar(&res, len);
-
-		if (prov)
-			prov_data_ready(node, res, len);
-		else
-			net_data_ready(res, len);
+		len_sar = mesh_gatt_sar(&res, len);
+		if (len_sar) {
+			if (prov)
+				prov_data_ready(node, res, len_sar);
+			else
+				net_data_ready(res, len_sar);
+		}
 	}
-
 	return true;
 }
 
-- 
2.11.0

