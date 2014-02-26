Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 17/17] android: Send confirm name request with mgmt_send
Date: Wed, 26 Feb 2014 02:57:28 +0100
Message-ID: <1393379848-4031-18-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is needed in scenarios when there is a big inflow of device found
events and we want to cancel discovery. In such case number of confirm
name commands might block mgmt queses and don't let stop discovery to pass
thru.

Even we cancel previous confirm name commands, stop discovery might
still get on the end of line.
---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index fb33976..5cb0e78 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1051,7 +1051,7 @@ static unsigned int confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
 	if (!resolve_name)
 		cp.name_known = 1;
 
-	res = mgmt_reply(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter.index,
+	res = mgmt_send(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter.index,
 				sizeof(cp), &cp, confirm_device_name_cb,
 				NULL, NULL);
 	if (!res)
-- 
1.8.4

