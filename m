Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/bluetooth: Update bonding state after receiving new CSRK.
Date: Tue, 17 Jun 2014 08:54:50 +0200
Message-Id: <1402988090-15544-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1402988090-15544-1-git-send-email-marcin.kraglak@tieto.com>
References: <1402988090-15544-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set bonded state if received new CSRK.
---
 android/bluetooth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 092bdd7..56c1282 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1992,6 +1992,9 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	update_device_state(dev, ev->key.addr.type, HAL_STATUS_SUCCESS, false,
+							true, !!ev->store_hint);
+
 	if (ev->store_hint)
 		store_csrk(dev);
 }
-- 
1.9.3

