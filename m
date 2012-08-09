Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v2] mgmt-api: Add reason to device disconnect event
Date: Thu,  9 Aug 2012 09:56:20 +0200
Message-Id: <1344498980-2829-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the management API with the disconnect reason, as now reported
by the Kernel in MGMT_EV_DEVICE_DISCONNECTED.
---
Updated userland patch to test the recently submitted Kernel patches regarding ACL disconnect reason.

 doc/mgmt-api.txt  |   16 ++++++++++++++++
 lib/mgmt.h        |    6 ++++++
 monitor/control.c |   19 +++++++++++++++----
 src/mgmt.c        |   13 ++++++++-----
 4 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 51c9b46..c25f377 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -973,12 +973,28 @@ Event Code		0x000C
 Controller Index:	<controller id>
 Event Parameters	Address (6 Octets)
 			Address_Type (1 Octet)
+			Reason (1 Octet)
 
 	Possible values for the Address_Type parameter:
 		0	BR/EDR
 		1	LE Public
 		2	LE Random
 
+	Possible values for the Reason parameter:
+		0	Unspecified
+		1	Connection timeout
+		2	Connection terminated by local host
+		3	Connection terminated by remote host
+
+	Note that the local/remote distinction just determines which side
+	terminated the low-level connection, regardless of the
+	disconnection of the higher-level profiles.
+
+	This can sometimes be misleading and thus must be used with care.
+	For example, some hardware combinations would report a locally
+	initiated disconnection even if the user turned Bluetooth off in
+	the remote side.
+
 
 Connect Failed Event
 ====================
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 83dcd84..a2648bc 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -373,9 +373,15 @@ struct mgmt_ev_device_connected {
 	uint8_t eir[0];
 } __packed;
 
+#define MGMT_DEV_DISCONN_UNKNOWN	0x00
+#define MGMT_DEV_DISCONN_TIMEOUT	0x01
+#define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
+#define MGMT_DEV_DISCONN_REMOTE		0x03
+
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
 struct mgmt_ev_device_disconnected {
 	struct mgmt_addr_info addr;
+	uint8_t reason;
 } __packed;
 
 #define MGMT_EV_CONNECT_FAILED		0x000D
diff --git a/monitor/control.c b/monitor/control.c
index 159ba9d..c799327 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -226,18 +226,29 @@ static void mgmt_device_disconnected(uint16_t len, const void *buf)
 {
 	const struct mgmt_ev_device_disconnected *ev = buf;
 	char str[18];
+	uint8_t reason;
+	uint16_t l;
 
-	if (len < sizeof(*ev)) {
+	if (len < sizeof(struct mgmt_addr_info)) {
 		printf("* Malformed Device Disconnected control\n");
 		return;
 	}
 
+	if (len < sizeof(*ev)) {
+		reason = MGMT_DEV_DISCONN_UNKNOWN;
+		l = len;
+	} else {
+		reason = ev->reason;
+		l = sizeof(*ev);
+	}
+
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Disconnected: %s (%d)\n", str, ev->addr.type);
+	printf("@ Device Disconnected: %s (%d) reason %u\n", str, ev->addr.type,
+									reason);
 
-	buf += sizeof(*ev);
-	len -= sizeof(*ev);
+	buf += l;
+	len -= l;
 
 	packet_hexdump(buf, len);
 }
diff --git a/src/mgmt.c b/src/mgmt.c
index c893972..131fe50 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -510,18 +510,21 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
 								size_t len)
 {
-	struct mgmt_addr_info *ev = buf;
+	struct mgmt_ev_device_disconnected *ev = buf;
 	struct controller_info *info;
 	char addr[18];
 
-	if (len < sizeof(*ev)) {
+	if (len < sizeof(struct mgmt_addr_info)) {
 		error("Too small device_disconnected event");
 		return;
 	}
 
-	ba2str(&ev->bdaddr, addr);
+	if (len < sizeof(*ev))
+		memset((char *) buf + len, 0, sizeof(*ev) - len);
+
+	ba2str(&ev->addr.bdaddr, addr);
 
-	DBG("hci%u device %s disconnected", index, addr);
+	DBG("hci%u device %s disconnected reason %u", index, addr, ev->reason);
 
 	if (index > max_index) {
 		error("Unexpected index %u in device_disconnected event", index);
@@ -530,7 +533,7 @@ static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
 
 	info = &controllers[index];
 
-	btd_event_disconn_complete(&info->bdaddr, &ev->bdaddr);
+	btd_event_disconn_complete(&info->bdaddr, &ev->addr.bdaddr);
 }
 
 static void mgmt_connect_failed(int sk, uint16_t index, void *buf, size_t len)
-- 
1.7.7.6

