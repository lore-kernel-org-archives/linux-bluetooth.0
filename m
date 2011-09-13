Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: fix possible crash on GetFile
Date: Tue, 13 Sep 2011 11:11:16 +0300
Message-Id: <1315901476-31728-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 8
   at 0x413DA1: get_file_callback (ftp.c:184)
   by 0x40A74E: transfer_complete (gobex-transfer.c:73)
   by 0x40AB91: transfer_response (gobex-transfer.c:172)
   by 0x40847A: handle_response (gobex.c:629)
   by 0x408C06: incoming_data (gobex.c:811)
   by 0x3E01043DBC: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2910.0)
   by 0x3E010445A7: ??? (in /lib64/libglib-2.0.so.0.2910.0)
   by 0x3E01044AF4: g_main_loop_run (in /lib64/libglib-2.0.so.0.2910.0)
   by 0x404CD4: main (main.c:102)
 Address 0x8 is not stack'd, malloc'd or (recently) free'd
---
 client/ftp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 2d1a87c..336fc26 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -305,7 +305,7 @@ static DBusMessage *get_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	if (obc_session_get(session, NULL, source_file,
-			target_file, NULL, 0, get_file_callback, NULL) < 0)
+			target_file, NULL, 0, get_file_callback, ftp) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
-- 
1.7.6.1

