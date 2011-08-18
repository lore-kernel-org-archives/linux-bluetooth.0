Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 3/5] serial: use port->msg to track rfcomm connection procedure
Date: Thu, 18 Aug 2011 17:10:01 -0300
Message-Id: <1313698203-13201-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1313698203-13201-2-git-send-email-padovan@profusion.mobi>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
 <1313698203-13201-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Use port->msg has the same effect of using port->io.
---
 serial/port.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index 3f041a6..bc4b4ea 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -149,7 +149,7 @@ static int port_release(struct serial_port *port)
 	int err = 0;
 
 	if (port->id < 0) {
-		if (port->io) {
+		if (port->msg) {
 			g_io_channel_shutdown(port->io, TRUE, NULL);
 			g_io_channel_unref(port->io);
 			port->io = NULL;
-- 
1.7.6

