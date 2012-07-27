Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 14/14] core: Re-connect for ECONNRESET or ECONNABORTED
Date: Fri, 27 Jul 2012 19:29:58 -0300
Message-Id: <1343428198-23621-15-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch keeps scanning and re-connections active if the disconnection
reason is ECONNRESET(Remote Initiated Disconnection).

Re-connection is a behaviour determined by Profiles or by the upper
layer(user actions). For instance, HoG requires re-connection always
active, no matter if the previous disconnection reason was page timeout
or remote initiated disconnection (ECONNRESET). Some devices disconnects
after some idle time, connectable advertises are sent by the peripheral
when commanded by the user(eg: key pressed). Disconnection can be also
triggered by the local host (ECONNABORTED) using command line tools or
Disconnect method in the Device interface.

The peripheral dictates the re-connection controlling the connectable
advertises, BlueZ(central) needs to keep the scanning always active to
able to detect the advertises and trigger the connection.
---
 src/device.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index d9c6708..1b01a8c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1810,10 +1810,18 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
 
-	if (device->auto_connect == FALSE || err != ETIMEDOUT)
+	if (device->auto_connect == FALSE) {
+		DBG("Automatic connection disabled");
 		goto done;
+	}
 
-	adapter_connect_list_add(device_get_adapter(device), device);
+	/*
+	 * Keep scanning/re-connection active if disconnection reason
+	 * is page timeout, remote user terminated connection or local
+	 * initiated disconnection.
+	 */
+	if (err == ETIMEDOUT || err == ECONNRESET || err == ECONNABORTED)
+		adapter_connect_list_add(device_get_adapter(device), device);
 
 done:
 	attio_cleanup(device);
-- 
1.7.10.4

