Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/4] monitor: add filter support
Date: Tue, 22 May 2012 02:40:26 -0300
Message-Id: <1337665227-7228-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337665227-7228-2-git-send-email-gustavo@padovan.org>
References: <1337665227-7228-1-git-send-email-gustavo@padovan.org>
 <1337665227-7228-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

the packet code receives the data parsed from the filter file and apply
the proper filters to the devices.
---
 monitor/config_file.c |    4 +-
 monitor/config_file.h |    1 +
 monitor/main.c        |   21 +++++-----
 monitor/packet.c      |  108 ++++++++++++++++++++++++++++++++++++++++---------
 monitor/packet.h      |    4 +-
 5 files changed, 106 insertions(+), 32 deletions(-)

diff --git a/monitor/config_file.c b/monitor/config_file.c
index 6fb50f9..464fe4f 100644
--- a/monitor/config_file.c
+++ b/monitor/config_file.c
@@ -79,7 +79,7 @@ static struct filter_options {
 
 struct controller *controller;
 
-static void free_controllers_list(struct list *controllers_l)
+void controllers_list_free(struct list *controllers_l)
 {
 	struct list *l, *tmp;
 
@@ -318,7 +318,7 @@ struct list *parse_config(char *file)
 	return controllers_l;
 
 error:
-	free_controllers_list(controllers_l);
+	controllers_list_free(controllers_l);
 	fclose(f);
 	return NULL;
 }
diff --git a/monitor/config_file.h b/monitor/config_file.h
index 9190e01..dd5fe79 100644
--- a/monitor/config_file.h
+++ b/monitor/config_file.h
@@ -28,3 +28,4 @@ struct controller {
 };
 
 struct list *parse_config(char *file);
+void controllers_list_free(struct list *controllers_l);
diff --git a/monitor/main.c b/monitor/main.c
index 1379839..c429333 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -68,8 +68,9 @@ static const struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
-	unsigned long filter_mask = 0;
+	struct list *filter_l = NULL;
 	sigset_t mask;
+	int err;
 
 	mainloop_init();
 
@@ -82,7 +83,8 @@ int main(int argc, char *argv[])
 
 		switch (opt) {
 		case 'f':
-			if (!parse_config(optarg))
+			filter_l = parse_config(optarg);
+			if (!filter_l)
 				return EXIT_FAILURE;
 			break;
 		case 'b':
@@ -105,18 +107,19 @@ int main(int argc, char *argv[])
 
 	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
 
-	filter_mask |= PACKET_FILTER_SHOW_INDEX;
-	filter_mask |= PACKET_FILTER_SHOW_TIME;
-	filter_mask |= PACKET_FILTER_SHOW_ACL_DATA;
-
-	packet_set_filter(filter_mask);
+	packet_set_filter(filter_l);
 
 	printf("Bluetooth monitor ver %s\n", VERSION);
 
 	if (control_tracing() < 0) {
-		if (hcidump_tracing() < 0)
+		if (hcidump_tracing() < 0) {
+			controllers_list_free(filter_l);
 			return EXIT_FAILURE;
+		}
 	}
 
-	return mainloop_run();
+	err = mainloop_run();
+
+	controllers_list_free(filter_l);
+	return err;
 }
diff --git a/monitor/packet.c b/monitor/packet.c
index 0f14ea6..bdc9705 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -43,18 +43,74 @@
 #include "control.h"
 #include "btsnoop.h"
 #include "packet.h"
+#include "config_file.h"
 
-static unsigned long filter_mask = 0;
+#define MAX_INDEX 16
+
+struct monitor_new_index {
+	uint8_t  type;
+	uint8_t  bus;
+	bdaddr_t bdaddr;
+	char     name[8];
+} __attribute__((packed));
 
-void packet_set_filter(unsigned long filter)
+struct index_filter {
+	unsigned long filter;
+	uint8_t ignore;
+};
+
+static struct monitor_new_index index_list[MAX_INDEX];
+static struct index_filter index_filter[MAX_INDEX];
+static struct list *filter_l;
+
+void packet_set_filter(struct list *filter)
 {
-	filter_mask = filter;
+	filter_l = filter;
+}
+
+static int filter_bacmp(char *str1, char *str2)
+{
+	int i, max;
+
+	max = strlen(str1) < 18 ? strlen(str1) : 18;
+
+	for (i = 0 ; i < max ; i++) {
+		if (str1[i] == '*')
+			return 1;
+		if (str1[i] != str2[i])
+			return 0;
+	}
+
+	return 1;
+}
+
+static void packet_set_index_filter(int index)
+{
+	char str[18];
+	struct list *l;
+
+	index_filter[index].ignore = 0;
+	index_filter[index].filter = ~0UL;
+
+	ba2str(&index_list[index].bdaddr, str);
+
+	for (l = filter_l->next ; l != filter_l ; l = l->next) {
+		if (filter_bacmp(l->controller->value, str)) {
+			index_filter[index].ignore = l->controller->ignore;
+			index_filter[index].filter = l->controller->filter;
+		}
+	}
+}
+
+static int filter_check_flag(uint16_t index, int flag)
+{
+	return (index_filter[index].filter & flag);
 }
 
 static void print_channel_header(struct timeval *tv, uint16_t index,
 							uint16_t channel)
 {
-	if (filter_mask & PACKET_FILTER_SHOW_INDEX) {
+	if (filter_check_flag(index, PACKET_FILTER_SHOW_INDEX)) {
 		switch (channel) {
 		case HCI_CHANNEL_CONTROL:
 			printf("{hci%d} ", index);
@@ -71,11 +127,11 @@ static void print_channel_header(struct timeval *tv, uint16_t index,
 
 		localtime_r(&t, &tm);
 
-		if (filter_mask & PACKET_FILTER_SHOW_DATE)
+		if (filter_check_flag(index, PACKET_FILTER_SHOW_DATE))
 			printf("%04d-%02d-%02d ", tm.tm_year + 1900,
 						tm.tm_mon + 1, tm.tm_mday);
 
-		if (filter_mask & PACKET_FILTER_SHOW_TIME)
+		if (filter_check_flag(index, PACKET_FILTER_SHOW_TIME))
 			printf("%02d:%02d:%02d.%06lu ", tm.tm_hour,
 					tm.tm_min, tm.tm_sec, tv->tv_usec);
 	}
@@ -128,6 +184,9 @@ void packet_hexdump(const unsigned char *buf, uint16_t len)
 void packet_control(struct timeval *tv, uint16_t index, uint16_t opcode,
 					const void *data, uint16_t size)
 {
+	if (index_filter[index].ignore)
+		return
+
 	print_channel_header(tv, index, HCI_CHANNEL_CONTROL);
 
 	control_message(opcode, data, size);
@@ -142,33 +201,30 @@ void packet_control(struct timeval *tv, uint16_t index, uint16_t opcode,
 #define MONITOR_SCO_TX_PKT	6
 #define MONITOR_SCO_RX_PKT	7
 
-struct monitor_new_index {
-	uint8_t  type;
-	uint8_t  bus;
-	bdaddr_t bdaddr;
-	char     name[8];
-} __attribute__((packed));
-
 #define MONITOR_NEW_INDEX_SIZE 16
 
 #define MONITOR_DEL_INDEX_SIZE 0
 
-#define MAX_INDEX 16
-
-static struct monitor_new_index index_list[MAX_INDEX];
-
 void packet_monitor(struct timeval *tv, uint16_t index, uint16_t opcode,
 					const void *data, uint16_t size)
 {
 	const struct monitor_new_index *ni;
 	char str[18];
 
+	if (index_filter[index].ignore)
+		return;
+
 	switch (opcode) {
 	case MONITOR_NEW_INDEX:
 		ni = data;
 
-		if (index < MAX_INDEX)
+		if (index < MAX_INDEX) {
 			memcpy(&index_list[index], ni, MONITOR_NEW_INDEX_SIZE);
+			packet_set_index_filter(index);
+		}
+
+		if (index_filter[index].ignore)
+			break;
 
 		ba2str(&ni->bdaddr, str);
 		packet_new_index(tv, index, str, ni->type, ni->bus, ni->name);
@@ -573,6 +629,9 @@ void packet_hci_command(struct timeval *tv, uint16_t index,
 
 	btsnoop_write(tv, index, 0x02, data, size);
 
+	if (!filter_check_flag(index, PACKET_FILTER_SHOW_HCI))
+		return;
+
 	print_header(tv, index);
 
 	if (size < HCI_COMMAND_HDR_SIZE) {
@@ -596,6 +655,9 @@ void packet_hci_event(struct timeval *tv, uint16_t index,
 
 	btsnoop_write(tv, index, 0x03, data, size);
 
+	if (!filter_check_flag(index, PACKET_FILTER_SHOW_HCI))
+		return;
+
 	print_header(tv, index);
 
 	if (size < HCI_EVENT_HDR_SIZE) {
@@ -622,6 +684,9 @@ void packet_hci_acldata(struct timeval *tv, uint16_t index, bool in,
 
 	btsnoop_write(tv, index, in ? 0x01 : 0x00, data, size);
 
+	if (!filter_check_flag(index, PACKET_FILTER_SHOW_ACL))
+		return;
+
 	print_header(tv, index);
 
 	if (size < HCI_ACL_HDR_SIZE) {
@@ -635,7 +700,7 @@ void packet_hci_acldata(struct timeval *tv, uint16_t index, bool in,
 	data += HCI_ACL_HDR_SIZE;
 	size -= HCI_ACL_HDR_SIZE;
 
-	if (filter_mask & PACKET_FILTER_SHOW_ACL_DATA)
+	if (filter_check_flag(index, PACKET_FILTER_SHOW_ACL_DATA))
 		packet_hexdump(data, size);
 }
 
@@ -646,6 +711,9 @@ void packet_hci_scodata(struct timeval *tv, uint16_t index, bool in,
 	uint16_t handle = btohs(hdr->handle);
 	uint8_t flags = acl_flags(handle);
 
+	if (!filter_check_flag(index, PACKET_FILTER_SHOW_SCO))
+		return;
+
 	print_header(tv, index);
 
 	if (size < HCI_SCO_HDR_SIZE) {
@@ -659,6 +727,6 @@ void packet_hci_scodata(struct timeval *tv, uint16_t index, bool in,
 	data += HCI_SCO_HDR_SIZE;
 	size -= HCI_SCO_HDR_SIZE;
 
-	if (filter_mask & PACKET_FILTER_SHOW_SCO_DATA)
+	if (filter_check_flag(index, PACKET_FILTER_SHOW_SCO_DATA))
 		packet_hexdump(data, size);
 }
diff --git a/monitor/packet.h b/monitor/packet.h
index c8d011d..aa113df 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -26,6 +26,8 @@
 #include <stdint.h>
 #include <sys/time.h>
 
+#include "list.h"
+
 #define PACKET_FILTER_SHOW_INDEX	(1 << 0)
 #define PACKET_FILTER_SHOW_DATE		(1 << 1)
 #define PACKET_FILTER_SHOW_TIME		(1 << 2)
@@ -35,7 +37,7 @@
 #define PACKET_FILTER_SHOW_ACL_DATA	(1 << 6)
 #define PACKET_FILTER_SHOW_SCO_DATA	(1 << 7)
 
-void packet_set_filter(unsigned long filter);
+void packet_set_filter(struct list *filter);
 
 void packet_hexdump(const unsigned char *buf, uint16_t len);
 
-- 
1.7.10.1

