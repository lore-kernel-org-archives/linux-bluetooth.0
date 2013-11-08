Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 3/8] android/client: Initialize all interfaces at start
Date: Fri, 8 Nov 2013 13:48:25 +0100
Message-ID: <1383914910-2304-4-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch adds function that initializes all HAL interfaces.
---
 android/client/haltest.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index f511025..107dfec 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -318,11 +318,47 @@ static void stdin_handler(struct pollfd *pollfd)
 	}
 }
 
+static void init(void)
+{
+	static const char * const inames[] = {
+		BT_PROFILE_HANDSFREE_ID,
+		BT_PROFILE_ADVANCED_AUDIO_ID,
+		BT_PROFILE_HEALTH_ID,
+		BT_PROFILE_HIDHOST_ID,
+		BT_PROFILE_PAN_ID,
+#if PLATFORM_SDK_VERSION > 17
+		BT_PROFILE_GATT_ID,
+#endif
+		BT_PROFILE_SOCKETS_ID
+	};
+	const struct method *m;
+	const char *argv[4];
+	char init_line[] = "bluetooth init";
+	uint32_t i;
+
+	process_line(init_line);
+	m = get_interface_method("bluetooth", "get_profile_interface");
+
+	for (i = 0; i < NELEM(inames); ++i) {
+		argv[2] = inames[i];
+		m->func(3, argv);
+	}
+
+	/* Init what is available to init */
+	for (i = 1; i < NELEM(interfaces) - 1; ++i) {
+		m = get_interface_method(interfaces[i]->name, "init");
+		if (m != NULL)
+			m->func(2, argv);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	struct stat rcstat;
 
 	terminal_setup();
+	init();
+
 	history_restore(".haltest_history");
 
 	fd_stack[fd_stack_pointer++] = 0;
-- 
1.7.9.5

