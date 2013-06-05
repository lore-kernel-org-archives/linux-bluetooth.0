Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] bluetooth: Fix using 8 kbs for tx/rx bandwidth in SCO/eSCO connections
Date: Wed,  5 Jun 2013 09:33:50 +0700
Message-Id: <1370399630-2368-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The expected sample rate is 8 khz but each sample is at least 8 bits so
the minimal bandwidth should be at least 64 kbps.

The suggested fix is to use don't care value (0xfffffffff) which should
let the controller do the estimation and is aligned with max latency
which normally is set to don't care too.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
This is currently based on [PATCH v7 0/8] sco: SCO socket option for
voice_setting therefore it probably doesn't apply on bluetooth-next

 net/bluetooth/hci_conn.c  | 4 ++--
 net/bluetooth/hci_event.c | 4 ++--
 net/bluetooth/sco.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f4aa8b2..609a72d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -206,8 +206,8 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	cp.handle   = cpu_to_le16(handle);
 
-	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
+	cp.tx_bandwidth   = __constant_cpu_to_le32(0xffffffff);
+	cp.rx_bandwidth   = __constant_cpu_to_le32(0xffffffff);
 
 	switch (hci_sco_airmode(conn->setting)) {
 	case SCO_AIRMODE_TRANSP:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6659af8..f206dd8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1753,8 +1753,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			bacpy(&cp.bdaddr, &ev->bdaddr);
 			cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
-			cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-			cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
+			cp.tx_bandwidth   = __constant_cpu_to_le32(0xffffffff);
+			cp.rx_bandwidth   = __constant_cpu_to_le32(0xffffffff);
 			cp.max_latency    = __constant_cpu_to_le16(0xffff);
 			cp.content_format = cpu_to_le16(hdev->voice_setting);
 			cp.retrans_effort = 0xff;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3b353ee..f880a91 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -674,8 +674,8 @@ static void sco_conn_defer_accept(struct hci_conn *conn, int setting)
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
-		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
+		cp.tx_bandwidth   = __constant_cpu_to_le32(0xffffffff);
+		cp.rx_bandwidth   = __constant_cpu_to_le32(0xffffffff);
 
 		switch (hci_sco_airmode(setting)) {
 		case SCO_AIRMODE_TRANSP:
-- 
1.8.1.4

