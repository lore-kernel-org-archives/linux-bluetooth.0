Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/2] monitor: Add support for analyzing index info
Date: Tue, 26 Apr 2016 22:52:12 +0200
Message-Id: <1461703933-18073-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Will now show vendor name if it was provided in snoop file.
---
 monitor/analyze.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 0f2d19a..197c7f9 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -29,6 +29,8 @@
 #include <stdio.h>
 #include <string.h>
 
+#include "lib/bluetooth.h"
+
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/btsnoop.h"
@@ -45,6 +47,7 @@ struct hci_dev {
 	unsigned long num_evt;
 	unsigned long num_acl;
 	unsigned long num_sco;
+	uint16_t manufacturer;
 };
 
 static struct queue *dev_list;
@@ -67,9 +70,14 @@ static void dev_destroy(void *data)
 	}
 
 	printf("Found %s controller with index %u\n", str, dev->index);
-	printf("  BD_ADDR %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
+	printf("  BD_ADDR %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
 			dev->bdaddr[5], dev->bdaddr[4], dev->bdaddr[3],
 			dev->bdaddr[2], dev->bdaddr[1], dev->bdaddr[0]);
+	if (dev->manufacturer != 0xffff)
+		printf(" (%s)", bt_compidtostr(dev->manufacturer));
+	printf("\n");
+
+
 	printf("  %lu commands\n", dev->num_cmd);
 	printf("  %lu events\n", dev->num_evt);
 	printf("  %lu ACL packets\n", dev->num_acl);
@@ -90,6 +98,7 @@ static struct hci_dev *dev_alloc(uint16_t index)
 	}
 
 	dev->index = index;
+	dev->manufacturer = 0xffff;
 
 	return dev;
 }
@@ -251,6 +260,22 @@ static void sco_pkt(struct timeval *tv, uint16_t index,
 	dev->num_sco++;
 }
 
+static void info_index(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	const struct btsnoop_opcode_index_info *hdr = data;
+	struct hci_dev *dev;
+
+	data += sizeof(*hdr);
+	size -= sizeof(*hdr);
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->manufacturer = hdr->manufacturer;
+}
+
 void analyze_trace(const char *path)
 {
 	struct btsnoop *btsnoop_file;
@@ -312,6 +337,9 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_OPEN_INDEX:
 		case BTSNOOP_OPCODE_CLOSE_INDEX:
 			break;
+		case BTSNOOP_OPCODE_INDEX_INFO:
+			info_index(&tv, index, buf, pktlen);
+			break;
 		default:
 			fprintf(stderr, "Wrong opcode %u\n", opcode);
 			goto done;
-- 
2.6.2

