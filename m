Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] monitor: Add support for decoding New Connection Parameter event
Date: Tue,  1 Jul 2014 19:26:40 -0300
Message-Id: <1404253600-24211-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1404253600-24211-1-git-send-email-andre.guedes@openbossa.org>
References: <1404253600-24211-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/control.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/monitor/control.c b/monitor/control.c
index 083f65d..c4568d8 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -580,6 +580,33 @@ static void mgmt_device_removed(uint16_t len, const void *buf)
 	packet_hexdump(buf, len);
 }
 
+static void mgmt_new_conn_param(uint16_t len, const void *buf)
+{
+	const struct mgmt_ev_new_conn_param *ev = buf;
+	char addr[18];
+	uint16_t min, max, latency, timeout;
+
+	if (len < sizeof(*ev)) {
+		printf("* Malformed New Connection Parameter control\n");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+	min = le16_to_cpu(ev->min_interval);
+	max = le16_to_cpu(ev->max_interval);
+	latency = le16_to_cpu(ev->latency);
+	timeout = le16_to_cpu(ev->timeout);
+
+	printf("@ New Conn Param: %s (%d) hint %d min 0x%4.4x max 0x%4.4x "
+		"latency 0x%4.4x timeout 0x%4.4x\n", addr, ev->addr.type,
+		ev->store_hint, min, max, latency, timeout);
+
+	buf += sizeof(*ev);
+	len -= sizeof(*ev);
+
+	packet_hexdump(buf, len);
+}
+
 void control_message(uint16_t opcode, const void *data, uint16_t size)
 {
 	switch (opcode) {
@@ -658,6 +685,9 @@ void control_message(uint16_t opcode, const void *data, uint16_t size)
 	case MGMT_EV_DEVICE_REMOVED:
 		mgmt_device_removed(size, data);
 		break;
+	case MGMT_EV_NEW_CONN_PARAM:
+		mgmt_new_conn_param(size, data);
+		break;
 	default:
 		printf("* Unknown control (code %d len %d)\n", opcode, size);
 		packet_hexdump(data, size);
-- 
1.9.1

