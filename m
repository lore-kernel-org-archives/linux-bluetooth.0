Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3] mgmt-api: Add reason to device disconnect event
Date: Fri, 17 Aug 2012 11:10:55 +0200
Message-Id: <1345194655-8453-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the management API with the disconnect reason, as now reported
by the Kernel in MGMT_EV_DEVICE_DISCONNECTED.
---
v3 integrates the changes suggested by Johan with the exception of the type change between uint16_t and size_t in mgmt_device_disconnected().

 doc/mgmt-api.txt  |   16 ++++++++++++++++
 lib/mgmt.h        |    6 ++++++
 monitor/control.c |   19 +++++++++++++++----
 src/mgmt.c        |   16 +++++++++++-----
 tools/btmgmt.c    |   18 +++++++++++++-----
 5 files changed, 61 insertions(+), 14 deletions(-)

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
index 3f5b990..c300ae9 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -226,18 +226,29 @@ static void mgmt_device_disconnected(uint16_t len, const void *buf)
 {
 	const struct mgmt_ev_device_disconnected *ev = buf;
 	char str[18];
+	uint8_t reason;
+	uint16_t consumed_len;
 
-	if (len < sizeof(*ev)) {
+	if (len < sizeof(struct mgmt_addr_info)) {
 		printf("* Malformed Device Disconnected control\n");
 		return;
 	}
 
+	if (len < sizeof(*ev)) {
+		reason = MGMT_DEV_DISCONN_UNKNOWN;
+		consumed_len = len;
+	} else {
+		reason = ev->reason;
+		consumed_len = sizeof(*ev);
+	}
+
 	ba2str(&ev->addr.bdaddr, str);
 
-	printf("@ Device Disconnected: %s (%d)\n", str, ev->addr.type);
+	printf("@ Device Disconnected: %s (%d) reason %u\n", str, ev->addr.type,
+									reason);
 
-	buf += sizeof(*ev);
-	len -= sizeof(*ev);
+	buf += consumed_len;
+	len -= consumed_len;
 
 	packet_hexdump(buf, len);
 }
diff --git a/src/mgmt.c b/src/mgmt.c
index 94b2a04..58aab2d 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -510,18 +510,24 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
 								size_t len)
 {
-	struct mgmt_addr_info *ev = buf;
+	struct mgmt_ev_device_disconnected *ev = buf;
 	struct controller_info *info;
 	char addr[18];
+	uint8_t reason;
 
-	if (len < sizeof(*ev)) {
+	if (len < sizeof(struct mgmt_addr_info)) {
 		error("Too small device_disconnected event");
 		return;
 	}
 
-	ba2str(&ev->bdaddr, addr);
+	if (len < sizeof(*ev))
+		reason = MGMT_DEV_DISCONN_UNKNOWN;
+	else
+		reason = ev->reason;
+
+	ba2str(&ev->addr.bdaddr, addr);
 
-	DBG("hci%u device %s disconnected", index, addr);
+	DBG("hci%u device %s disconnected reason %u", index, addr, reason);
 
 	if (index > max_index) {
 		error("Unexpected index %u in device_disconnected event", index);
@@ -530,7 +536,7 @@ static void mgmt_device_disconnected(int sk, uint16_t index, void *buf,
 
 	info = &controllers[index];
 
-	btd_event_disconn_complete(&info->bdaddr, &ev->bdaddr);
+	btd_event_disconn_complete(&info->bdaddr, &ev->addr.bdaddr);
 }
 
 static void mgmt_connect_failed(int sk, uint16_t index, void *buf, size_t len)
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index c6d48d3..f06f0bf 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -343,9 +343,10 @@ static int mgmt_connected(int mgmt_sk, uint16_t index,
 }
 
 static int mgmt_disconnected(int mgmt_sk, uint16_t index,
-				struct mgmt_addr_info *ev, uint16_t len)
+				struct mgmt_ev_device_disconnected *ev,
+				uint16_t len)
 {
-	if (len != sizeof(*ev)) {
+	if (len < sizeof(struct mgmt_addr_info)) {
 		fprintf(stderr,
 			"Invalid disconnected event length (%u bytes)\n", len);
 		return -EINVAL;
@@ -353,9 +354,16 @@ static int mgmt_disconnected(int mgmt_sk, uint16_t index,
 
 	if (monitor) {
 		char addr[18];
-		ba2str(&ev->bdaddr, addr);
-		printf("hci%u %s type %s disconnected\n", index, addr,
-							typestr(ev->type));
+		uint8_t reason;
+
+		if (len < sizeof(*ev))
+			reason = MGMT_DEV_DISCONN_UNKNOWN;
+		else
+			reason = ev->reason;
+
+		ba2str(&ev->addr.bdaddr, addr);
+		printf("hci%u %s type %s disconnected with reason %u\n",
+				index, addr, typestr(ev->addr.type), reason);
 	}
 
 	return 0;
-- 
1.7.7.6

