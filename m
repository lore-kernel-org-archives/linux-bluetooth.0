Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/17] SAP: Remove not needed NULL pointer checks from send_message
Date: Wed, 6 Jun 2012 15:19:16 +0200
Message-ID: <1338988767-19467-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both conn and buff are always passed as valid pointers. No need to
double check them.
---
 sap/server.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 8612d0d..f66e23f 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -244,9 +244,6 @@ static int send_message(struct sap_connection *conn, void *buf, size_t size)
 	GError *gerr = NULL;
 	GIOStatus gstatus;
 
-	if (!conn || !buf)
-		return -EINVAL;
-
 	SAP_VDBG("conn %p, size %zu", conn, size);
 
 	gstatus = g_io_channel_write_chars(conn->io, buf, size, &written,
-- 
on behalf of ST-Ericsson

