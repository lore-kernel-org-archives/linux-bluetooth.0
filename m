Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 1/3] android/sco: Fix for disconnect SCO
Date: Wed,  3 Dec 2014 11:42:24 +0100
Message-Id: <1417603346-6442-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417603346-6442-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417603346-6442-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should just shutdown io and wait for disconnect callback in
disconnect function, otherwise we might get some races e.g. when doing
connect/disconnect SCO. This patch fix that.
---
 android/sco.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/android/sco.c b/android/sco.c
index 7dd7013..e8ac685 100644
--- a/android/sco.c
+++ b/android/sco.c
@@ -310,18 +310,8 @@ void bt_sco_disconnect(struct bt_sco *sco)
 	if (!sco)
 		return;
 
-	if (sco->watch) {
-		g_source_remove(sco->watch);
-		sco->watch = 0;
-	}
-
-	if (sco->io) {
+	if (sco->io)
 		g_io_channel_shutdown(sco->io, TRUE, NULL);
-		g_io_channel_unref(sco->io);
-		sco->io = NULL;
-	}
-
-	clear_remote_address(sco);
 }
 
 bool bt_sco_get_fd_and_mtu(struct bt_sco *sco, int *fd, uint16_t *mtu)
-- 
1.8.4

