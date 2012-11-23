Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] monitor: Fix build errors due to unaligned memory access
Date: Fri, 23 Nov 2012 11:09:13 +0100
Message-ID: <1353665354-32178-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
References: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following compilation errors on ARM.

  CC     monitor/hcidump.o
monitor/hcidump.c: In function ‘device_callback’:
monitor/hcidump.c:147:11: error: cast increases required alignment of
	target type [-Werror=cast-align]
monitor/hcidump.c:150:10: error: cast increases required alignment of
	target type [-Werror=cast-align]
monitor/hcidump.c: In function ‘stack_internal_callback’:
monitor/hcidump.c:348:9: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [monitor/hcidump.o] Error 1

  CC     monitor/control.o
monitor/control.c: In function ‘data_callback’:
monitor/control.c:584:10: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [monitor/control.o] Error 1
---
 monitor/control.c |    7 +++++--
 monitor/hcidump.c |   18 +++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 3447b7a..9b76038 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -565,6 +565,7 @@ static void data_callback(int fd, uint32_t events, void *user_data)
 	while (1) {
 		struct cmsghdr *cmsg;
 		struct timeval *tv = NULL;
+		struct timeval ctv;
 		uint16_t opcode, index, pktlen;
 		ssize_t len;
 
@@ -580,8 +581,10 @@ static void data_callback(int fd, uint32_t events, void *user_data)
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
index e69bcb1..9881bb3 100644
--- a/monitor/hcidump.c
+++ b/monitor/hcidump.c
@@ -130,7 +130,8 @@ static void device_callback(int fd, uint32_t events, void *user_data)
 	while (1) {
 		struct cmsghdr *cmsg;
 		struct timeval *tv = NULL;
-		int *dir = NULL;
+		struct timeval ctv;
+		int dir = -1;
 		ssize_t len;
 
 		len = recvmsg(fd, &msg, MSG_DONTWAIT);
@@ -144,15 +145,16 @@ static void device_callback(int fd, uint32_t events, void *user_data)
 
 			switch (cmsg->cmsg_type) {
 			case HCI_DATA_DIR:
-				dir = (int *) CMSG_DATA(cmsg);
+				memcpy(&dir, CMSG_DATA(cmsg), sizeof(dir));
 				break;
 			case HCI_CMSG_TSTAMP:
-				tv = (struct timeval *) CMSG_DATA(cmsg);
+				memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
+				tv = &ctv;
 				break;
 			}
 		}
 
-		if (!dir || len < 1)
+		if (dir < 0 || len < 1)
 			continue;
 
 		switch (buf[0]) {
@@ -163,11 +165,11 @@ static void device_callback(int fd, uint32_t events, void *user_data)
 			packet_hci_event(tv, data->index, buf + 1, len - 1);
 			break;
 		case HCI_ACLDATA_PKT:
-			packet_hci_acldata(tv, data->index, !!(*dir),
+			packet_hci_acldata(tv, data->index, !!dir,
 							buf + 1, len - 1);
 			break;
 		case HCI_SCODATA_PKT:
-			packet_hci_scodata(tv, data->index, !!(*dir),
+			packet_hci_scodata(tv, data->index, !!dir,
 							buf + 1, len - 1);
 			break;
 		}
@@ -314,6 +316,7 @@ static void stack_internal_callback(int fd, uint32_t events, void *user_data)
 	evt_stack_internal *si;
 	evt_si_device *sd;
 	struct timeval *tv = NULL;
+	struct timeval ctv;
 	uint8_t type = 0xff, bus = 0xff;
 	char str[18], name[8] = "";
 	bdaddr_t bdaddr;
@@ -345,7 +348,8 @@ static void stack_internal_callback(int fd, uint32_t events, void *user_data)
 
 		switch (cmsg->cmsg_type) {
 		case HCI_CMSG_TSTAMP:
-			tv = (struct timeval *) CMSG_DATA(cmsg);
+			memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
+			tv = &ctv;
 			break;
 		}
 	}
-- 
1.7.9.5

