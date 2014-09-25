Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Rename sco_param_wideband table to esco_param_msbc
Date: Thu, 25 Sep 2014 09:48:01 +0300
Message-Id: <1411627681-540-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The sco_param_wideband table represents the eSCO parameters for
specifically mSBC encoding. This patch renames the table to the more
descriptive esco_param_msbc name.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 06047142797c..b9517bd17190 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -52,7 +52,7 @@ static const struct sco_param sco_param_cvsd[] = {
 	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
 };
 
-static const struct sco_param sco_param_wideband[] = {
+static const struct sco_param esco_param_msbc[] = {
 	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
 	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
 };
@@ -207,9 +207,9 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	switch (conn->setting & SCO_AIRMODE_MASK) {
 	case SCO_AIRMODE_TRANSP:
-		if (conn->attempt > ARRAY_SIZE(sco_param_wideband))
+		if (conn->attempt > ARRAY_SIZE(esco_param_msbc))
 			return false;
-		param = &sco_param_wideband[conn->attempt - 1];
+		param = &esco_param_msbc[conn->attempt - 1];
 		break;
 	case SCO_AIRMODE_CVSD:
 		if (lmp_esco_capable(conn->link)) {
-- 
1.9.3

