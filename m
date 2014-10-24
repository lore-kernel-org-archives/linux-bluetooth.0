Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/io: Remove disconnect handler in io_destoy
Date: Fri, 24 Oct 2014 13:16:19 +0200
Message-Id: <1414149379-2497-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Diconnect callback may be called after destroying IO in next
mainloop iteration (it leada to reading freed data). Removing
disconnect handler prevents that situation.
---
 src/shared/io-glib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index a2ada66..5ebde3d 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -115,6 +115,11 @@ void io_destroy(struct io *io)
 		io->write_watch = 0;
 	}
 
+	if (io->disconnect_watch > 0) {
+		g_source_remove(io->disconnect_watch);
+		io->disconnect_watch = 0;
+	}
+
 	g_io_channel_unref(io->channel);
 	io->channel = NULL;
 
-- 
1.9.3

