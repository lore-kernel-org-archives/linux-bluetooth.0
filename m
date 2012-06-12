Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 1/3] client: Fix possible unreplied D-Bus message
Date: Tue, 12 Jun 2012 14:10:24 +0200
Message-Id: <1339503026-17276-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If a previous cancel request is in progress, a second cancel request
should fail.

This by the way fixes unreplied D-Bus messages.
---
 client/transfer.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 242d989..0686afe 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -213,6 +213,11 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 				ERROR_INTERFACE ".NotAuthorized",
 				"Not Authorized");
 
+	if (transfer->msg != NULL)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InProgress",
+				"Cancellation already in progress");
+
 	if (!obc_transfer_abort(transfer))
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".Failed",
-- 
1.7.7.6

