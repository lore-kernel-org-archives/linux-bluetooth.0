Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] android: Update HAL with device info on incoming connection
Date: Fri, 8 Nov 2013 16:48:30 +0100
Message-ID: <1383925711-26374-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure Android have information about connecting remote device. This
is needed for example to show device name on incoming bonding request.
---
 android/adapter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index d63352e..cd820df 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -842,8 +842,9 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 		return;
 	}
 
-	/* TODO: Update device */
-
+	/* Update HAL library with device info */
+	update_found_device(&ev->addr.bdaddr, ev->addr.type, 0, false,
+					&ev->eir[0], btohs(ev->eir_len));
 	hal_ev.status = HAL_STATUS_SUCCESS;
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
-- 
1.8.4

