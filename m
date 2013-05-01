Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 16/16] unit: Get rid of gint
Date: Wed,  1 May 2013 02:28:10 -0300
Message-Id: <1367386090-24633-16-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---
 unit/test-gobex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index e7af4d8..66307c2 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -229,7 +229,7 @@ static gboolean send_nothing(GIOChannel *io, GIOCondition cond,
 }
 
 static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
-				GIOFunc send_rsp_func, gint req_timeout,
+				GIOFunc send_rsp_func, int req_timeout,
 				int transport_type)
 {
 	GError *gerr = NULL;
@@ -269,7 +269,7 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 }
 
 static void send_connect(GObexResponseFunc rsp_func, GIOFunc send_rsp_func,
-					gint req_timeout, int transport_type)
+					int req_timeout, int transport_type)
 {
 	GObexPacket *req;
 	guint8 connect_data[] = { 0x10, 0x00, 0x10, 0x00 };
-- 
1.8.2.2

