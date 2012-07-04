Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] network: fix network Connect() method parameters
Date: Wed,  4 Jul 2012 10:17:19 +0200
Message-Id: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 network/connection.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/network/connection.c b/network/connection.c
index 544ec3a..59423a9 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -554,7 +554,9 @@ static void path_unregister(void *data)
 
 static const GDBusMethodTable connection_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect",
-			NULL, NULL, connection_connect) },
+				GDBUS_ARGS({"uuid", "s"}),
+				GDBUS_ARGS({"interface", "s"}),
+				connection_connect) },
 	{ GDBUS_METHOD("Disconnect",
 			NULL, NULL, connection_disconnect) },
 	{ GDBUS_METHOD("GetProperties",
-- 
1.7.10.2

