Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 5/6] Bluetooth: Parameters for outgoing SCO connections
Date: Tue, 19 Mar 2013 19:04:14 +0100
Message-Id: <1363716255-21332-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to establish a transparent SCO connection, the correct settings must
be specified in the Setup Synchronous Connection request. For that,
voice_setting is added to ACL connection flags to set up the desired
parameters. If this value is zero, a legacy SCO connection will be requested.
This patch uses T2 settings.
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 69785c2..70e0364 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -328,6 +328,7 @@ struct hci_conn {
 	__u32		passkey_notify;
 	__u8		passkey_entered;
 	__u16		disc_timeout;
+	__u16		voice_setting;
 	unsigned long	flags;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ad551e2..95c69a6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -175,13 +175,22 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	conn->attempt++;
 
 	cp.handle   = cpu_to_le16(handle);
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-	cp.max_latency    = __constant_cpu_to_le16(0xffff);
-	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-	cp.retrans_effort = 0xff;
+
+	if (conn->voice_setting == 0x0003) {
+		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
+							   ~ESCO_2EV3);
+		cp.max_latency    = __constant_cpu_to_le16(0x000d);
+		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
+		cp.retrans_effort = 0x02;
+	} else {
+		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
+		cp.max_latency    = __constant_cpu_to_le16(0xffff);
+		cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
+		cp.retrans_effort = 0xff;
+	}
 
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
@@ -575,6 +584,8 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	hci_conn_hold(sco);
 
+	sco->voice_setting = voice_setting;
+
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
-- 
1.7.9.5

