Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] input: add error message when auth fails
Date: Fri, 20 Apr 2012 14:36:15 -0300
Message-Id: <1334943375-23475-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/server.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/input/server.c b/input/server.c
index cea08d1..ed09a73 100644
--- a/input/server.c
+++ b/input/server.c
@@ -176,6 +176,8 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 	if (ret == 0)
 		return;
 
+	error("Authorization failed(%d): %s", -ret, strerror(-ret));
+
 	g_io_channel_unref(server->confirm);
 	server->confirm = NULL;
 
-- 
1.7.10

