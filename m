Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2 2/3] Fix return value in send_message
Date: Mon, 30 May 2011 11:59:34 +0200
Message-ID: <1306749575-21119-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

send_message returns the number of sent bytes and -EIO in case of
IO error now
---
 sap/server.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index c5ea97c..d166173 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -254,22 +254,24 @@ static int send_message(struct sap_connection *conn, void *buf, size_t size)
 	if (!conn || !buf)
 		return -EINVAL;
 
-	DBG("size %zu", size);
+	DBG("conn %p, size %zu", conn, size);
 
 	gstatus = g_io_channel_write_chars(conn->io, buf, size, &written,
-						&gerr);
+									&gerr);
 	if (gstatus != G_IO_STATUS_NORMAL) {
 		if (gerr)
 			g_error_free(gerr);
 
 		error("write error (0x%02x).", gstatus);
-		return -EINVAL;
+		return -EIO;
 	}
 
-	if (written != size)
-		error("write error.(written %zu size %zu)", written, size);
+	if (written != size) {
+		error("written %zu bytes out of %zu", written, size);
+		return -EIO;
+	}
 
-	return 0;
+	return written;
 }
 
 static int disconnect_ind(void *sap_device, uint8_t disc_type)
-- 
1.7.4.1

