Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] attrib-server: Fix invalid read
Date: Thu,  9 Feb 2012 13:02:21 -0300
Message-Id: <1328803341-28049-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an invalid read for incoming connections when
the remote initiates the link disconnection.
---
 src/attrib-server.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5137bdc..6268fe4 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1124,7 +1124,6 @@ static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
 
 	attrib = g_attrib_new(io);
 	attrib_channel_attach(attrib);
-	g_io_channel_unref(io);
 	g_attrib_unref(attrib);
 }
 
-- 
1.7.8.4

