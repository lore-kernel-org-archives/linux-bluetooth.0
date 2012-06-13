Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH obexd 3/7] client: Fix error returning in obc_transfer_put
Date: Wed, 13 Jun 2012 22:49:19 +0200
Message-Id: <1339620563-25161-3-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Always set error on failure in obc_transfer_put. This is expected by
callers and will avoid possible NULL pointer dereference.

Also fix improper use of errno variable (calling error may modify it)
and some dead assignments to perr.
---
 client/transfer.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index cb7c26c..76f6681 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -419,12 +419,15 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
 
 		w = write(transfer->fd, contents, size);
 		if (w < 0) {
-			error("write(): %s(%d)", strerror(errno), errno);
-			perr = -errno;
+			perr = errno;
+			error("write(): %s(%d)", strerror(perr), perr);
+			g_set_error(err, OBC_TRANSFER_ERROR, -perr,
+						"Writing to file failed");
 			goto fail;
 		} else if ((size_t) w != size) {
 			error("Unable to write all contents to file");
-			perr = -EFAULT;
+			g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
+					"Writing all contents to file failed");
 			goto fail;
 		}
 	} else {
@@ -432,10 +435,10 @@ struct obc_transfer *obc_transfer_put(const char *type, const char *name,
 			goto fail;
 	}
 
-	perr = fstat(transfer->fd, &st);
-	if (perr < 0) {
-		error("fstat(): %s(%d)", strerror(errno), errno);
-		g_set_error(err, OBC_TRANSFER_ERROR, -errno,
+	if (fstat(transfer->fd, &st) < 0) {
+		perr = errno;
+		error("fstat(): %s(%d)", strerror(perr), perr);
+		g_set_error(err, OBC_TRANSFER_ERROR, -perr,
 						"Unable to get file status");
 		goto fail;
 	}
-- 
1.7.10.4


