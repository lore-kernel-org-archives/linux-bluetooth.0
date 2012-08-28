Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] mgmt: Add wrapper for Set SSP
Date: Tue, 28 Aug 2012 14:38:33 +0200
Message-ID: <1346157514-22119-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Wrap mgmt_set_mode for Set SSP into separate function to be consistent
with other calls and have debug printout.
---
 src/mgmt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 58aab2d..6dc87e1 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -245,6 +245,12 @@ int mgmt_set_pairable(int index, gboolean pairable)
 	return mgmt_set_mode(index, MGMT_OP_SET_PAIRABLE, pairable);
 }
 
+static int mgmt_set_ssp(int index, gboolean ssp)
+{
+	DBG("index %d ssp %d", index, ssp);
+	return mgmt_set_mode(index, MGMT_OP_SET_SSP, ssp);
+}
+
 static inline int mgmt_powered(uint32_t settings)
 {
 	return (settings & MGMT_SETTING_POWERED) != 0;
@@ -333,7 +339,7 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 		mgmt_set_pairable(index, pairable);
 
 	if (mgmt_ssp(info->supported_settings) && !mgmt_ssp(settings))
-		mgmt_set_mode(index, MGMT_OP_SET_SSP, 1);
+		mgmt_set_ssp(index, TRUE);
 
 	if (mgmt_low_energy(info->supported_settings) &&
 						!mgmt_low_energy(settings))
-- 
1.7.11.3

