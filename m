Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/2] btio: Connect callback errors handling cleanup
Date: Thu, 26 Jul 2012 11:11:09 -0300
Message-Id: <1343311869-5179-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1343311869-5179-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1343311869-5179-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Condition verification is not required for this watch since the
condition to watch for was previously informed when it was added
in the mainloop.
---
 btio/btio.c |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 792123f..730bdb3 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -162,27 +162,15 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 	if ((cond & G_IO_NVAL) || check_nval(io))
 		return FALSE;
 
-	if (cond & G_IO_OUT) {
-		sock = g_io_channel_unix_get_fd(io);
-
-		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
-			err = -errno;
-		else
-			err = -sk_err;
-
-		if (err < 0)
-			ERROR_FAILED(&gerr, "connect", -err);
-	} else if (cond & (G_IO_HUP | G_IO_ERR)) {
-		sock = g_io_channel_unix_get_fd(io);
+	sock = g_io_channel_unix_get_fd(io);
 
-		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
-			err = -errno;
-		else
-			err = -sk_err;
+	if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
 
-		if (err < 0)
-			ERROR_FAILED(&gerr, "HUP or ERR on socket", -err);
-	}
+	if (err < 0)
+		ERROR_FAILED(&gerr, "connect error", -err);
 
 	conn->connect(io, gerr, conn->user_data);
 
-- 
1.7.8.6

