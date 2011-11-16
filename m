Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 14/17] btio: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:20:01 -0400
Message-Id: <1321449604-4188-15-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 btio/btio.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 6db1756..a129bf9 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -153,16 +153,18 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 
 	if (cond & G_IO_OUT) {
-		int err = 0, sock = g_io_channel_unix_get_fd(io);
-		socklen_t len = sizeof(err);
+		int err, sk_err = 0, sock = g_io_channel_unix_get_fd(io);
+		socklen_t len = sizeof(sk_err);
 
-		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len) < 0)
-			err = errno;
+		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+			err = -errno;
+		else
+			err = -sk_err;
 
-		if (err)
+		if (err < 0)
 			g_set_error(&gerr, BT_IO_ERROR,
 					BT_IO_ERROR_CONNECT_FAILED, "%s (%d)",
-					strerror(err), err);
+					strerror(-err), -err);
 	} else if (cond & (G_IO_HUP | G_IO_ERR))
 		g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
 				"HUP or ERR on socket");
-- 
1.7.0.4

