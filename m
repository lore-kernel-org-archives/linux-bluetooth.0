Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Use BPF to filter packets by index
Date: Thu, 19 Jul 2018 17:04:27 +0300
Message-Id: <20180719140427.23267-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses a BPF filter to filter packets to specific index.
---
 monitor/control.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 monitor/control.h |  1 +
 monitor/packet.c  |  9 ++-------
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 150bdcc44..991dea1c3 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -28,6 +28,7 @@
 
 #include <stdio.h>
 #include <stdbool.h>
+#include <stddef.h>
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -39,6 +40,7 @@
 #include <sys/stat.h>
 #include <termios.h>
 #include <fcntl.h>
+#include <linux/filter.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -58,6 +60,7 @@
 static struct btsnoop *btsnoop_file = NULL;
 static bool hcidump_fallback = false;
 static bool decode_control = true;
+static uint16_t filter_index = HCI_DEV_NONE;
 
 struct control_data {
 	uint16_t channel;
@@ -1028,6 +1031,37 @@ static int open_socket(uint16_t channel)
 	return fd;
 }
 
+static void attach_index_filter(int fd, uint16_t index)
+{
+	struct sock_filter filters[] = {
+		/* Load MGMT index:
+		 * A <- MGMT index
+		 */
+		BPF_STMT(BPF_LD + BPF_B + BPF_ABS,
+					offsetof(struct mgmt_hdr, index)),
+		/* Accept if index is HCI_DEV_NONE:
+		 * A == HCI_DEV_NONE
+		 */
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, HCI_DEV_NONE, 0, 1),
+		/* return */
+		BPF_STMT(BPF_RET|BPF_K, 0x0fffffff), /* pass */
+		/* Accept if index match:
+		 * A == index
+		 */
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, index, 0, 1),
+		/* returns */
+		BPF_STMT(BPF_RET|BPF_K, 0x0fffffff), /* pass */
+		BPF_STMT(BPF_RET|BPF_K, 0), /* reject */
+	};
+	struct sock_fprog fprog = {
+		.len = sizeof(filters) / sizeof(filters[0]),
+		/* casting const away: */
+		.filter = filters,
+	};
+
+	setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &fprog, sizeof(fprog));
+}
+
 static int open_channel(uint16_t channel)
 {
 	struct control_data *data;
@@ -1045,6 +1079,9 @@ static int open_channel(uint16_t channel)
 		return -1;
 	}
 
+	if (filter_index != HCI_DEV_NONE)
+		attach_index_filter(data->fd, filter_index);
+
 	mainloop_add_fd(data->fd, EPOLLIN, data_callback, data, free_data);
 
 	return 0;
@@ -1468,3 +1505,8 @@ void control_disable_decoding(void)
 {
 	decode_control = false;
 }
+
+void control_filter_index(uint16_t index)
+{
+	filter_index = index;
+}
diff --git a/monitor/control.h b/monitor/control.h
index ee28d272f..a9691e32f 100644
--- a/monitor/control.h
+++ b/monitor/control.h
@@ -30,5 +30,6 @@ void control_server(const char *path);
 int control_tty(const char *path, unsigned int speed);
 int control_tracing(void);
 void control_disable_decoding(void);
+void control_filter_index(uint16_t index);
 
 void control_message(uint16_t opcode, const void *data, uint16_t size);
diff --git a/monitor/packet.c b/monitor/packet.c
index d69d6a020..14ce294b7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -107,7 +107,6 @@ static time_t time_offset = ((time_t) -1);
 static int priority_level = BTSNOOP_PRIORITY_INFO;
 static unsigned long filter_mask = 0;
 static bool index_filter = false;
-static uint16_t index_number = 0;
 static uint16_t index_current = 0;
 static uint16_t fallback_manufacturer = UNKNOWN_MANUFACTURER;
 
@@ -261,8 +260,9 @@ void packet_select_index(uint16_t index)
 {
 	filter_mask &= ~PACKET_FILTER_SHOW_INDEX;
 
+	control_filter_index(index);
+
 	index_filter = true;
-	index_number = index;
 }
 
 #define print_space(x) printf("%*c", (x), ' ');
@@ -3837,9 +3837,6 @@ void packet_control(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint16_t opcode,
 					const void *data, uint16_t size)
 {
-	if (index_filter && index_number != index)
-		return;
-
 	control_message(opcode, data, size);
 }
 
@@ -3861,8 +3858,6 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 	const char *ident;
 
 	if (index != HCI_DEV_NONE) {
-		if (index_filter && index_number != index)
-			return;
 		index_current = index;
 	}
 
-- 
2.17.1

