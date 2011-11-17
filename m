Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ] serial: Fix bogus errno usage
Date: Thu, 17 Nov 2011 13:32:40 -0400
Message-Id: <1321551160-8903-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no previous function setting errno, thus the original code may
return a undefined value.
---

NOTE:
Is bt_io_connect() supposed to set errno on error? If yes, then the code is
correct and this patch is invalid.

But in this case, bt_io_connect() needs to be modified as there are at least
two glib library calls before returning, and this may reset errno from the
underlying connect call. So I think it needs to be saved before calling these
library functions.


 serial/port.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index 3b36d44..1ceda7b 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -463,10 +463,8 @@ connect:
 				BT_IO_OPT_DEST_BDADDR, &device->dst,
 				BT_IO_OPT_CHANNEL, port->channel,
 				BT_IO_OPT_INVALID);
-	if (port->io)
-		return 0;
 
-	return -errno;
+	return 0;
 }
 
 static struct serial_port *create_port(struct serial_device *device,
-- 
1.7.0.4

