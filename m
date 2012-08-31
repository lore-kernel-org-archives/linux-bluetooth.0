Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 08/15] monitor: Fix compilation errors due to unaligned memory access
Date: Fri, 31 Aug 2012 14:40:04 +0200
Message-ID: <1346416811-23484-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following compilation errors on ARM.

  CC     monitor/hcidump.o
monitor/hcidump.c: In function device_callback:
monitor/hcidump.c:147:11: error: cast increases required alignment of
	target type [-Werror=cast-align]
monitor/hcidump.c:150:10: error: cast increases required alignment of
	target type [-Werror=cast-align]
monitor/hcidump.c: In function stack_internal_callback:
monitor/hcidump.c:348:9: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [monitor/hcidump.o] Error 1
make: *** [all] Error 2

  CC     monitor/hcidump.o
monitor/hcidump.c: In function stack_internal_callback:
monitor/hcidump.c:357:9: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [monitor/hcidump.o] Error 1
make: *** [all] Error 2

  CC     monitor/control.o
monitor/control.c: In function data_callback:
monitor/control.c:574:10: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [monitor/control.o] Error 1
make: *** [all] Error 2

---
 monitor/control.c |    7 +++++--
 monitor/hcidump.c |   23 ++++++++++++++++-------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index c300ae9..c5ff26b 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -555,6 +555,7 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 	while (1) {
 		struct cmsghdr *cmsg;
 		struct timeval *tv = NULL;
+		struct timeval ctv;
 		uint16_t opcode, index, pktlen;
 		ssize_t len;
 
@@ -570,8 +571,10 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 			if (cmsg->cmsg_level != SOL_SOCKET)
 				continue;
 
-			if (cmsg->cmsg_type == SCM_TIMESTAMP)
-				tv = (struct timeval *) CMSG_DATA(cmsg);
+			if (cmsg->cmsg_type == SCM_TIMESTAMP) {
+				memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
+				tv = &ctv;
+			}
 		}
 
 		opcode = btohs(hdr.opcode);
diff --git a/monitor/hcidump.c b/monitor/hcidump.c
index 373d2f5..8653446 100644
--- a/monitor/hcidump.c
+++ b/monitor/hcidump.c
@@ -130,8 +130,10 @@ static void device_callback(int fd, uint32_t events, void *user_data)
 	while (1) {
 		struct cmsghdr *cmsg;
 		struct timeval *tv = NULL;
-		int *dir = NULL;
+		struct timeval ctv;
+		bool dir = false;
 		ssize_t len;
+		bool dir_present = false;
 
 		len = recvmsg(fd, &msg, MSG_DONTWAIT);
 		if (len < 0)
@@ -144,15 +146,19 @@ static void device_callback(int fd, uint32_t events, void *user_data)
 
 			switch (cmsg->cmsg_type) {
 			case HCI_DATA_DIR:
-				dir = (int *) CMSG_DATA(cmsg);
+				dir = !!bt_get_32(CMSG_DATA(cmsg));
+				dir_present = true;
+
 				break;
 			case HCI_CMSG_TSTAMP:
-				tv = (struct timeval *) CMSG_DATA(cmsg);
+				memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
+				tv = &ctv;
+
 				break;
 			}
 		}
 
-		if (!dir || len < 1)
+		if (!dir_present || len < 1)
 			continue;
 
 		switch (buf[0]) {
@@ -163,11 +169,11 @@ static void device_callback(int fd, uint32_t events, void *user_data)
 			packet_hci_event(tv, data->index, buf + 1, len - 1);
 			break;
 		case HCI_ACLDATA_PKT:
-			packet_hci_acldata(tv, data->index, !!(*dir),
+			packet_hci_acldata(tv, data->index, dir,
 							buf + 1, len - 1);
 			break;
 		case HCI_SCODATA_PKT:
-			packet_hci_scodata(tv, data->index, !!(*dir),
+			packet_hci_scodata(tv, data->index, dir,
 							buf + 1, len - 1);
 			break;
 		}
@@ -314,6 +320,7 @@ static void stack_internal_callback(int fd, uint32_t events, void *user_data)
 	evt_stack_internal *si;
 	evt_si_device *sd;
 	struct timeval *tv = NULL;
+	struct timeval ctv;
 	uint8_t type = 0xff, bus = 0xff;
 	char str[18], name[8] = "";
 	bdaddr_t bdaddr;
@@ -345,7 +352,9 @@ static void stack_internal_callback(int fd, uint32_t events, void *user_data)
 
 		switch (cmsg->cmsg_type) {
 		case HCI_CMSG_TSTAMP:
-			tv = (struct timeval *) CMSG_DATA(cmsg);
+			memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
+			tv = &ctv;
+
 			break;
 		}
 	}
-- 
1.7.9.5

