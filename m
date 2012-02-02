Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 4/4] obex: Fix file not getting deleted when a push is
 aborted
Date: Thu, 02 Feb 2012 17:04:17 +0530
Message-id: <1328182457-14924-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Problem: Even if transfer is aborted file will be saved with partial content.

Fix: In os_reset_session() os->cmd is checked for PUT before calling
driver->remove(), but os->cmd is never assigned.This fix sets os->cmd
wit respective opcode
---
 src/obex.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 5b580d3..b14e0e0 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -457,6 +457,8 @@ static void cmd_connect(GObex *obex, GObexPacket *req, void *user_data)
 		return;
 	}
 
+	os->cmd = G_OBEX_OP_CONNECT;
+
 	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
 
 	parse_authchal(os, req, rsp);
@@ -481,6 +483,8 @@ static void cmd_disconnect(GObex *obex, GObexPacket *req, void *user_data)
 
 	print_event(G_OBEX_OP_DISCONNECT, -1);
 
+	os->cmd = G_OBEX_OP_DISCONNECT;
+
 	os_set_response(os, 0);
 }
 
@@ -806,6 +810,8 @@ static void cmd_get(GObex *obex, GObexPacket *req, gpointer user_data)
 		return;
 	}
 
+	os->cmd = G_OBEX_OP_GET;
+
 	parse_name(os, req);
 
 	parse_apparam(os, req);
@@ -836,6 +842,8 @@ static void cmd_setpath(GObex *obex, GObexPacket *req, gpointer user_data)
 		goto done;
 	}
 
+	os->cmd = G_OBEX_OP_SETPATH;
+
 	parse_name(os, req);
 
 	os->nonhdr = g_obex_packet_get_data(req, &os->nonhdr_len);
@@ -975,6 +983,8 @@ static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
 		return;
 	}
 
+	os->cmd = G_OBEX_OP_PUT;
+
 	parse_name(os, req);
 	parse_length(os, req);
 	parse_time(os, req);
@@ -1054,6 +1064,8 @@ static void cmd_action(GObex *obex, GObexPacket *req, gpointer user_data)
 		goto done;
 	}
 
+	os->cmd = G_OBEX_OP_ACTION;
+
 	parse_name(os, req);
 	parse_destname(os, req);
 	parse_action(os, req);
-- 
1.7.1

