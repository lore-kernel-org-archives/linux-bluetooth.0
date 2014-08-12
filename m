Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/5] monitor: Use common maximum packet size definition
Date: Tue, 12 Aug 2014 15:46:32 +0300
Message-Id: <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20140812090449.GA18519@t440s.ger.corp.intel.com>
References: <20140812090449.GA18519@t440s.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/bluetoothd-snoop.c | 4 +---
 monitor/analyze.c          | 4 +---
 monitor/control.c          | 6 ++----
 src/shared/btsnoop.h       | 2 ++
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index 57f97f4..dc34869 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -42,10 +42,8 @@
 
 #define DEFAULT_SNOOP_FILE "/sdcard/btsnoop_hci.log"
 
-#define MAX_PACKET_SIZE (1486 + 4)
-
 static struct btsnoop *snoop = NULL;
-static uint8_t monitor_buf[MAX_PACKET_SIZE];
+static uint8_t monitor_buf[BTSNOOP_MAX_PACKET_SIZE];
 static int monitor_fd = -1;
 
 static void signal_callback(int signum, void *user_data)
diff --git a/monitor/analyze.c b/monitor/analyze.c
index 5288cf3..b027b3c 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -35,8 +35,6 @@
 #include "monitor/bt.h"
 #include "analyze.h"
 
-#define MAX_PACKET_SIZE		(1486 + 4)
-
 struct hci_dev {
 	uint16_t index;
 	uint8_t type;
@@ -282,7 +280,7 @@ void analyze_trace(const char *path)
 	}
 
 	while (1) {
-		unsigned char buf[MAX_PACKET_SIZE];
+		unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
 		struct timeval tv;
 		uint16_t index, opcode, pktlen;
 
diff --git a/monitor/control.c b/monitor/control.c
index 8ee4431..36ebcbc 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -52,12 +52,10 @@
 static struct btsnoop *btsnoop_file = NULL;
 static bool hcidump_fallback = false;
 
-#define MAX_PACKET_SIZE		(1486 + 4)
-
 struct control_data {
 	uint16_t channel;
 	int fd;
-	unsigned char buf[MAX_PACKET_SIZE];
+	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
 	uint16_t offset;
 };
 
@@ -1005,7 +1003,7 @@ bool control_writer(const char *path)
 
 void control_reader(const char *path)
 {
-	unsigned char buf[MAX_PACKET_SIZE];
+	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
 	uint16_t pktlen;
 	uint32_t type;
 	struct timeval tv;
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 2c55d02..9675980 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -44,6 +44,8 @@
 #define BTSNOOP_OPCODE_SCO_TX_PKT	6
 #define BTSNOOP_OPCODE_SCO_RX_PKT	7
 
+#define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
+
 struct btsnoop_opcode_new_index {
 	uint8_t  type;
 	uint8_t  bus;
-- 
1.9.1

