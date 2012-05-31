Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Fix compile warning in l2cap_core.c
Date: Thu, 31 May 2012 20:39:16 -0300
Message-Id: <1338507556-10920-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the following warning reported by gcc 4.7.0:

net/bluetooth/l2cap_core.c: In function 'l2cap_config_rsp':
net/bluetooth/l2cap_core.c:3302:13: warning: 'rfc.max_pdu_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.max_pdu_size' was declared here
net/bluetooth/l2cap_core.c:3298:25: warning: 'rfc.monitor_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.monitor_timeout' was declared here
net/bluetooth/l2cap_core.c:3297:25: warning: 'rfc.retrans_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.retrans_timeout' was declared here
net/bluetooth/l2cap_core.c:3295:2: warning: 'rfc.mode' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.mode' was declared here

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f9bffe3..6df27cd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3270,6 +3270,14 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 	if ((chan->mode != L2CAP_MODE_ERTM) && (chan->mode != L2CAP_MODE_STREAMING))
 		return;
 
+	/* Use sane default values in case a misbehaving remote device
+	 * do not send an RFC option.
+	 */
+	rfc.mode = chan->mode;
+	rfc.retrans_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
+	rfc.monitor_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
+	rfc.max_pdu_size = cpu_to_le16(chan->imtu);
+
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
 
@@ -3281,14 +3289,6 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		}
 	}
 
-	/* Use sane default values in case a misbehaving remote device
-	 * did not send an RFC option.
-	 */
-	rfc.mode = chan->mode;
-	rfc.retrans_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
-	rfc.monitor_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
-	rfc.max_pdu_size = cpu_to_le16(chan->imtu);
-
 	BT_ERR("Expected RFC option was not found, using defaults");
 
 done:
-- 
1.7.10.2

