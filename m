Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] attrib: Fix crash if g_attrib_new() fails
Date: Fri, 24 Jan 2014 15:57:49 -0400
Message-Id: <1390593469-18511-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If g_attrib_new() fails for some reason (e.g. bt_io_get() fails), it
will return NULL.

Crash reported by Valgrind:

==2845== Invalid read of size 4
==2845==    at 0x40C6CC4: g_io_channel_unix_get_fd (giounix.c:655)
==2845==  Address 0x3c is not stack'd, malloc'd or (recently) free'd
---
 src/attrib-server.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3b94120..61395a5 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1235,6 +1235,9 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 	}
 
 	attrib = g_attrib_new(io);
+	if (!attrib)
+		return;
+
 	attrib_channel_attach(attrib);
 	g_attrib_unref(attrib);
 }
-- 
1.7.9.5

