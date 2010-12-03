Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Fix writing to GAttrib socket without POLLOUT event
Date: Fri,  3 Dec 2010 15:28:48 -0300
Message-Id: <1291400928-12114-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the GIOChannel is in the buffered state (the default) the watch
function is called without receiving a POLLOUT from the socket. GLib
adds a G_IO_OUT condition just because there is space in the GIOChannel
internal buffer.

The solution is disabling the internal buffer, which in turn, makes the
call of g_io_channel_flush() useless.
---
 attrib/gattrib.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index ed18168..1083519 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -248,8 +248,6 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 	if (iostat != G_IO_STATUS_NORMAL)
 		return FALSE;
 
-	g_io_channel_flush(io, NULL);
-
 	if (cmd->expected == 0) {
 		g_queue_pop_head(attrib->queue);
 		command_destroy(cmd);
@@ -350,6 +348,7 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	struct _GAttrib *attrib;
 
 	g_io_channel_set_encoding(io, NULL, NULL);
+	g_io_channel_set_buffered(io, FALSE);
 
 	attrib = g_try_new0(struct _GAttrib, 1);
 	if (attrib == NULL)
-- 
1.7.3.2

