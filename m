Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] mgmt: Add wrapper for Set LE
Date: Tue, 28 Aug 2012 14:38:34 +0200
Message-ID: <1346157514-22119-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346157514-22119-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346157514-22119-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Wrap mgmt_set_mode for Set LE into separate function to be consistent
with other calls and have debug printout.
---
 src/mgmt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 6dc87e1..19e2972 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -251,6 +251,12 @@ static int mgmt_set_ssp(int index, gboolean ssp)
 	return mgmt_set_mode(index, MGMT_OP_SET_SSP, ssp);
 }
 
+static int mgmt_set_low_energy(int index, gboolean le)
+{
+	DBG("index %d le %d", index, le);
+	return mgmt_set_mode(index, MGMT_OP_SET_LE, le);
+}
+
 static inline int mgmt_powered(uint32_t settings)
 {
 	return (settings & MGMT_SETTING_POWERED) != 0;
@@ -343,7 +349,7 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 
 	if (mgmt_low_energy(info->supported_settings) &&
 						!mgmt_low_energy(settings))
-		mgmt_set_mode(index, MGMT_OP_SET_LE, 1);
+		mgmt_set_low_energy(index, TRUE);
 }
 
 static int mgmt_update_powered(struct btd_adapter *adapter,
-- 
1.7.11.3

