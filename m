Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] monitor: Display all events type in analyze
Date: Tue, 26 Apr 2016 22:52:13 +0200
Message-Id: <1461703933-18073-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1461703933-18073-1-git-send-email-szymon.janc@codecoup.pl>
References: <1461703933-18073-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add support for counting all event types in analyze.
---
 monitor/analyze.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 197c7f9..94f0c57 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -47,6 +47,9 @@ struct hci_dev {
 	unsigned long num_evt;
 	unsigned long num_acl;
 	unsigned long num_sco;
+	unsigned long vendor_diag;
+	unsigned long system_note;
+	unsigned long user_log;
 	uint16_t manufacturer;
 };
 
@@ -82,6 +85,9 @@ static void dev_destroy(void *data)
 	printf("  %lu events\n", dev->num_evt);
 	printf("  %lu ACL packets\n", dev->num_acl);
 	printf("  %lu SCO packets\n", dev->num_sco);
+	printf("  %lu vendor diagnostics\n", dev->vendor_diag);
+	printf("  %lu system notes\n", dev->system_note);
+	printf("  %lu user logs\n", dev->user_log);
 	printf("\n");
 
 	free(dev);
@@ -276,6 +282,42 @@ static void info_index(struct timeval *tv, uint16_t index,
 	dev->manufacturer = hdr->manufacturer;
 }
 
+static void vendor_diag(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->vendor_diag++;
+}
+
+static void system_note(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->system_note++;
+}
+
+static void user_log(struct timeval *tv, uint16_t index,
+					const void *data, uint16_t size)
+{
+	struct hci_dev *dev;
+
+	dev = dev_lookup(index);
+	if (!dev)
+		return;
+
+	dev->user_log++;
+}
+
 void analyze_trace(const char *path)
 {
 	struct btsnoop *btsnoop_file;
@@ -340,6 +382,15 @@ void analyze_trace(const char *path)
 		case BTSNOOP_OPCODE_INDEX_INFO:
 			info_index(&tv, index, buf, pktlen);
 			break;
+		case BTSNOOP_OPCODE_VENDOR_DIAG:
+			vendor_diag(&tv, index, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_SYSTEM_NOTE:
+			system_note(&tv, index, buf, pktlen);
+			break;
+		case BTSNOOP_OPCODE_USER_LOGGING:
+			user_log(&tv, index, buf, pktlen);
+			break;
 		default:
 			fprintf(stderr, "Wrong opcode %u\n", opcode);
 			goto done;
-- 
2.6.2

