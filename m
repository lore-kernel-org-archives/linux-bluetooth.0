Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] serial: Fix error handling in connect_port()
Date: Fri, 18 Nov 2011 11:08:50 -0400
Message-Id: <1321628930-13493-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321618307-11456-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321618307-11456-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_io_connect() does not set errno on error, instead it uses GError. For
now, simply return -EIO if bt_io_connect() fails. The serial plug-in
code can be changed later to use and set GError appropriately.
---
 serial/port.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index 3b36d44..5b76d14 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -463,10 +463,10 @@ connect:
 				BT_IO_OPT_DEST_BDADDR, &device->dst,
 				BT_IO_OPT_CHANNEL, port->channel,
 				BT_IO_OPT_INVALID);
-	if (port->io)
-		return 0;
+	if (port->io == NULL)
+		return -EIO;
 
-	return -errno;
+	return 0;
 }
 
 static struct serial_port *create_port(struct serial_device *device,
-- 
1.7.0.4

