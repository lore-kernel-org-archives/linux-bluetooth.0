Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 03/17] android/socket: Add get RFCOMM default channel
Date: Mon, 18 Nov 2013 15:20:40 +0200
Message-Id: <1384780854-20970-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384780854-20970-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

RFCOMM default channel is the same like in other BlueZ code, it is
defined in src/profile.c
---
 android/socket.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index e580036..9c94c03 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -35,13 +35,54 @@
 #include "ipc.h"
 #include "socket.h"
 
+#define OPP_DEFAULT_CHANNEL	9
+#define PBAP_DEFAULT_CHANNEL	15
+
 static bdaddr_t adapter_addr;
 
+static struct {
+	uint8_t uuid[16];
+	uint8_t channel;
+} uuid_to_chan[] = {
+	{
+		.uuid = {
+			0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		},
+		.channel = PBAP_DEFAULT_CHANNEL,
+	}, {
+		.uuid = {
+			0x00, 0x00, 0x11, 0x05, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		  },
+		.channel = OPP_DEFAULT_CHANNEL
+	}
+};
+
+static int get_rfcomm_default_chan(const uint8_t *uuid)
+{
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(uuid_to_chan); i++) {
+		if (!memcmp(uuid_to_chan[i].uuid, uuid, 16))
+			return uuid_to_chan[i].channel;
+	}
+
+	return -ENOENT;
+}
+
 static int handle_listen(void *buf)
 {
-	DBG("Not implemented");
+	int hal_fd;
+	int chan;
 
-	return -1;
+	DBG("");
+
+	chan = get_rfcomm_default_chan(cmd->uuid);
+	if (chan < 0)
+		return chan;
+
+	return hal_fd;
 }
 
 static int handle_connect(void *buf)
-- 
1.7.10.4

