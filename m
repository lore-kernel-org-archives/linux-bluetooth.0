Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/6] gattrib: Fix ignoring the error message when write fails
Date: Wed, 10 Oct 2012 20:34:58 -0300
Message-Id: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If an error happens during writing to the socket, we should complain
that it failed.
---
 attrib/gattrib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 6f6942f..0806101 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -313,8 +313,14 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 
 	iostat = g_io_channel_write_chars(io, (gchar *) cmd->pdu, cmd->len,
 								&len, &gerr);
-	if (iostat != G_IO_STATUS_NORMAL)
+	if (iostat != G_IO_STATUS_NORMAL) {
+		if (gerr) {
+			error("%s", gerr->message);
+			g_error_free(gerr);
+		}
+
 		return FALSE;
+	}
 
 	if (cmd->expected == 0) {
 		g_queue_pop_head(queue);
-- 
1.7.12.3

