Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: Fix possible memory leak on pbap module
Date: Wed, 18 Apr 2012 16:51:51 +0300
Message-Id: <1334757111-19982-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

16 bytes in 1 blocks are definitely lost in loss record 26 of 146
   at 0x4A075B2: realloc (vg_replace_malloc.c:525)
   by 0x3B5104B76D: g_realloc (in /lib64/libglib-2.0.so.0.3000.2)
   by 0x3B51064A96: ??? (in /lib64/libglib-2.0.so.0.3000.2)
   by 0x3B51065156: g_string_insert_len (in /lib64/libglib-2.0.so.0.3000.2)
   by 0x3B510305BC: ??? (in /lib64/libglib-2.0.so.0.3000.2)
   by 0x3B51031BE7: g_build_filename (in /lib64/libglib-2.0.so.0.3000.2)
   by 0x416FEE: pbap_select (pbap.c:254)
   by 0x406CCE: process_message (object.c:224)
   by 0x3B5301D9A0: ??? (in /lib64/libdbus-1.so.3.5.6)
   by 0x3B5300F92F: dbus_connection_dispatch (in /lib64/libdbus-1.so.3.5.6)
---
 client/pbap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 85f970b..f8a72b0 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -979,6 +979,7 @@ static void pbap_free(void *data)
 	struct pbap_data *pbap = data;
 
 	obc_session_unref(pbap->session);
+	g_free(pbap->path);
 	g_free(pbap);
 }
 
-- 
1.7.7.6

