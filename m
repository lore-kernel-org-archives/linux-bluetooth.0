Return-Path: <cyrus@holtmann.org>
From: Smriti GUPTA <smriti.gupta@stericsson.com>
To: "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Cc: Naresh-kumar GUPTA <naresh.gupta@stericsson.com>,
	"smritigupta2008@gmail.com" <smritigupta2008@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 19 Jan 2012 06:33:13 +0100
Subject: RE: [RFC BlueZ 1/1] Add provision for terminating an ATT connection
Message-ID: <7E02D43720E46647A0E6521055937EC915DAF58D0F@EXDCVYMBSTM005.EQ1STM.local>
References: <1324894570-15226-1-git-send-email-smriti.gupta@stericsson.com>
 <1324894570-15226-2-git-send-email-smriti.gupta@stericsson.com>
In-Reply-To: <1324894570-15226-2-git-send-email-smriti.gupta@stericsson.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Do you have any comments on the below patch.


-----Original Message-----
From: Smriti GUPTA 
Sent: Monday, December 26, 2011 3:46 PM
To: linux-bluetooth@vger.kernel.org
Cc: Naresh-kumar GUPTA; Smriti GUPTA
Subject: [RFC BlueZ 1/1] Add provision for terminating an ATT connection

This patch adds a function for disconnecting an ATT connection
from the client side.
---
 src/device.c |   14 ++++++++++++++
 src/device.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index e49e9bc..552df6e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2880,3 +2880,17 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	return TRUE;
 }
+
+void att_disconnect(struct btd_device *device)
+{
+	GIOChannel *io;
+
+	if (!device)
+		return;
+
+	io = g_attrib_get_channel(device->attrib);
+	if (io) {
+		g_io_channel_shutdown(io, FALSE, NULL);
+		g_io_channel_unref(io);
+	}
+}
diff --git a/src/device.h b/src/device.h
index 13005ae..bd14315 100644
--- a/src/device.h
+++ b/src/device.h
@@ -119,3 +119,4 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 						gboolean update_only);
 int device_unblock(DBusConnection *conn, struct btd_device *device,
 					gboolean silent, gboolean update_only);
+void att_disconnect(struct btd_device *device);
\ No newline at end of file
-- 
1.7.0.4

Regards,
Smriti

