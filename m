Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 3/9] client: deny cancel when no agent present
Date: Tue, 21 Feb 2012 09:46:17 +0100
Message-Id: <1329813983-26707-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The authorization check should consider the scenario of no agent being
assigned to the transfer.
---
 client/transfer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 157811d..4054799 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -168,7 +168,7 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 	DBusMessage *reply;
 
 	sender = dbus_message_get_sender(message);
-	if (g_str_equal(transfer->agent, sender) == FALSE)
+	if (g_strcmp0(transfer->agent, sender) != 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
-- 
1.7.6.5

