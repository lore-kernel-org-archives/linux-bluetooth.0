Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 10 Jun 2016 15:21:39 +0200
From: Miroslav Koskar <mk@mkoskar.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] core/service: Allow disconnected -> connected state change
Message-ID: <20160610132139.GA2514@mkoskar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By ignoring case where service->state == BTD_SERVICE_STATE_DISCONNECTED
in btd_service_connecting_complete(), state_callbacks don't get
executed. Such case occurs when e.g., phone using a2dp-source profile
connects to the bluez. Because no state_callbacks are executed
(including one added by policy plugin) no reconnection is attempted
after connection timeout, although if situation is reversed (bluez
connects to the phone) reconnection works.
---
 src/service.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index f7912f5..0da14ab 100644
--- a/src/service.c
+++ b/src/service.c
@@ -353,7 +353,8 @@ bool btd_service_remove_state_cb(unsigned int id)
 
 void btd_service_connecting_complete(struct btd_service *service, int err)
 {
-	if (service->state != BTD_SERVICE_STATE_CONNECTING)
+	if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
+			service->state != BTD_SERVICE_STATE_CONNECTING)
 		return;
 
 	if (err == 0)

