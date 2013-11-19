Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 02/19] android/socket: Add get RFCOMM default channel
Date: Tue, 19 Nov 2013 15:29:52 +0200
Message-Id: <1384867809-18135-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

RFCOMM default channel is the same like in other BlueZ code, it is
defined in src/profile.c
---
 android/socket.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 04bb7d1..d4c7674 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -27,19 +27,71 @@
 
 #include <glib.h>
 #include <stdbool.h>
+#include <errno.h>
 
 #include "lib/bluetooth.h"
+#include "btio/btio.h"
+#include "lib/sdp.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
 #include "ipc.h"
 #include "socket.h"
 
+#define OPP_DEFAULT_CHANNEL	9
+#define PBAP_DEFAULT_CHANNEL	15
+
 static bdaddr_t adapter_addr;
 
+static struct profile_info {
+	uint8_t		uuid[16];
+	uint8_t		channel;
+	uint8_t		svc_hint;
+	BtIOSecLevel	sec_level;
+	sdp_record_t *	(*create_record)(uint8_t chan);
+} profiles[] = {
+	{
+		.uuid = {
+			0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		},
+		.channel = PBAP_DEFAULT_CHANNEL
+	}, {
+		.uuid = {
+			0x00, 0x00, 0x11, 0x05, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+		  },
+		.channel = OPP_DEFAULT_CHANNEL
+	}
+};
+
+static struct profile_info *get_profile_by_uuid(const uint8_t *uuid)
+{
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(profiles); i++) {
+		if (!memcmp(profiles[i].uuid, uuid, 16))
+			return &profiles[i];
+	}
+
+	return NULL;
+}
+
 static int handle_listen(void *buf)
 {
-	DBG("Not implemented");
+	struct hal_cmd_sock_listen *cmd = buf;
+	struct profile_info *profile;
+	int chan;
+
+	DBG("");
+
+	profile = get_profile_by_uuid(cmd->uuid);
+	if (!profile)
+		return -1;
+
+	chan = profile->channel;
+
+	DBG("rfcomm channel %d", chan);
 
 	return -1;
 }
-- 
1.7.10.4

