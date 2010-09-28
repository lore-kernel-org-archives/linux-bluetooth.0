Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix emitting TransferCompleted twice
Date: Tue, 28 Sep 2010 16:19:22 +0300
Message-Id: <1285679962-10367-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This is caused by REQDONE and latter disconnect generating duplicate
signals in case of opp.

To fix this now we check if the object is valid before proceeding.
---
 src/manager.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 78a329c..80140b6 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -648,7 +648,8 @@ void manager_emit_transfer_progress(struct obex_session *os)
 
 void manager_emit_transfer_completed(struct obex_session *os)
 {
-	emit_transfer_completed(os->cid, !os->aborted);
+	if (os->object)
+		emit_transfer_completed(os->cid, !os->aborted);
 }
 
 DBusConnection *obex_dbus_get_connection(void)
-- 
1.7.1

