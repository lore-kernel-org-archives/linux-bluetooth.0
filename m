Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd] opp: Emit TransferStarted signal only if stream start is
 success
Date: Mon, 30 Apr 2012 16:41:41 +0530
Message-id: <1335784301-7606-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even if obex_put_stream_start() fails TransferStarted signal will be
emitted where as transfer start is actually failed.
---
 plugins/opp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/opp.c b/plugins/opp.c
index fa3ee91..c7ddc63 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -154,12 +154,15 @@ skip_auth:
 
 	path = g_build_filename(folder, name, NULL);
 
-	manager_emit_transfer_started(os);
-
 	err = obex_put_stream_start(os, path);
 
 	g_free(path);
 
+	if (err < 0)
+		goto failed;
+
+	manager_emit_transfer_started(os);
+
 failed:
 	g_free(folder);
 	g_free(name);
-- 
1.7.1

