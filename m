Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 06/18] Handle missing randomizer in mgmt_add_remote_oob_data
Date: Fri, 21 Sep 2012 14:36:23 +0200
Message-ID: <1348230995-8967-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Randomizer is optional. Handling missing randomizer in
mgmt_add_remote_oob_data is easy and will simplify caller code.

---
 plugins/dbusoob.c |    7 -------
 src/mgmt.c        |    4 +++-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index b49e68d..ba04830 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -232,13 +232,6 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 	adapter_get_address(adapter, &local);
 
 	if (data->hash) {
-		uint8_t empty_randomizer[16];
-
-		if (!data->randomizer) {
-			memset(empty_randomizer, 0, sizeof(empty_randomizer));
-			data->randomizer = empty_randomizer;
-		}
-
 		if (btd_adapter_add_remote_oob_data(adapter, &bdaddr,
 					data->hash, data->randomizer) < 0)
 			return FALSE;
diff --git a/src/mgmt.c b/src/mgmt.c
index 2accf24..a3f31dd 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -2425,7 +2425,9 @@ int mgmt_add_remote_oob_data(int index, bdaddr_t *bdaddr,
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
 	memcpy(cp->hash, hash, 16);
-	memcpy(cp->randomizer, randomizer, 16);
+
+	if (randomizer)
+		memcpy(cp->randomizer, randomizer, 16);
 
 	if (write(mgmt_sock, &buf, sizeof(buf)) < 0)
 		return -errno;
-- 
1.7.9.5

