Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 02/18] Fix memory leaks in the attrib-server
Date: Tue, 21 Dec 2010 19:26:24 -0200
Message-Id: <1292966800-6264-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 18759e7..cbc01ee 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -724,6 +724,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 
 	channel->attrib = g_attrib_new(io);
 	channel->mtu = ATT_DEFAULT_MTU;
+	g_io_channel_unref(io);
 
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
 				channel_handler, channel, NULL);
@@ -803,6 +804,11 @@ failed:
 	g_io_channel_unref(l2cap_io);
 	l2cap_io = NULL;
 
+	if (le_io) {
+		g_io_channel_unref(le_io);
+		le_io = NULL;
+	}
+
 	return -1;
 }
 
-- 
1.7.3.4

