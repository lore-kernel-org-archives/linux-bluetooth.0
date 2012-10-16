Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/8] mgmt: Make mgmt_update_powered return void
Date: Tue, 16 Oct 2012 12:12:53 +0200
Message-ID: <1350382379-30489-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mgmt_update_powered always returned 0 and this was never checked by
caller.

---
 src/mgmt.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 2a66be2..8caabe8 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -352,7 +352,7 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 		mgmt_set_low_energy(index, TRUE);
 }
 
-static int mgmt_update_powered(struct btd_adapter *adapter,
+static void mgmt_update_powered(struct btd_adapter *adapter,
 						struct controller_info *info,
 						uint32_t settings)
 {
@@ -363,14 +363,12 @@ static int mgmt_update_powered(struct btd_adapter *adapter,
 		info->pending_uuid = FALSE;
 		info->pending_class = FALSE;
 		info->pending_cod_change = FALSE;
-		return 0;
+		return;
 	}
 
 	btd_adapter_start(adapter);
 
 	update_settings(adapter, settings);
-
-	return 0;
 }
 
 static int mode_changed(uint32_t s1, uint32_t s2)
-- 
1.7.9.5

