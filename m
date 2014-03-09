Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/3] android: Send confirm name request with mgmt_send
Date: Mon, 10 Mar 2014 00:06:37 +0100
Message-ID: <1394406397-6843-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch improves handling stop disvocery in scenarios when there is a big
inflow of device found events. In such case, number of confirm
name request might block mgmt queses and make stop discovery stack in the queue.

Even we cancel previous confirm name request, there is still possibility that
new incoming device found events produce confirm name request which will
might block stop discovery.
---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 9286c67..158eb2a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1061,7 +1061,7 @@ static unsigned int confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
 	if (!resolve_name)
 		cp.name_known = 1;
 
-	res = mgmt_reply(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter.index,
+	res = mgmt_send(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter.index,
 				sizeof(cp), &cp, confirm_device_name_cb,
 				NULL, NULL);
 	if (!res)
-- 
1.8.4

