Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v7 8/8] Bluetooth: Add support for fallback between CVSD recommended settings
Date: Thu, 16 May 2013 19:34:05 +0200
Message-Id: <1368725646-4593-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When CVSD is requested and eSCO is supported, try to establish eSCO connection
using S3 settings. If it fails, fallback in sequence to S2, S1, D1, D0 settings.
These settings are described in Bluetooth HFP 1.6 specification p. 101.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 net/bluetooth/hci_conn.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8d71d73..f4aa8b2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -42,6 +42,14 @@ static const struct sco_param sco_param_wideband[] = {
 	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008, 0 },
 };
 
+static const struct sco_param sco_param_cvsd[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a, 1 },
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007, 2 },
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007, 3 },
+	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff, 4 },
+	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff, 0 },
+};
+
 static void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -212,10 +220,13 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 		conn->fallback    = param->next;
 		break;
 	case SCO_AIRMODE_CVSD:
-		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
-		cp.max_latency    = __constant_cpu_to_le16(0xffff);
-		cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
+		param = &sco_param_cvsd[conn->fallback];
+		cp.pkt_type       = __constant_cpu_to_le16(param->pkt_type);
+		cp.max_latency    = __constant_cpu_to_le16(param->max_latency);
+		cp.voice_setting  = __constant_cpu_to_le16(conn->setting);
+		cp.retrans_effort = 0x01;
+
+		conn->fallback    = param->next;
 		break;
 	}
 
-- 
1.7.9.5

