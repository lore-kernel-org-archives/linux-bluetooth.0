Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 7/8] android/client: Add pin handling for bind
Date: Fri, 8 Nov 2013 13:48:29 +0100
Message-ID: <1383914910-2304-8-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch ask user for ping in pin_request_cb, which does
what otherwise would be required to manually type
bluetooth pin_reply address pin.
---
 android/client/if-bt.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4c501a5..0a580e1 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -16,6 +16,7 @@
  */
 
 #include "if-main.h"
+#include "terminal.h"
 
 const bt_interface_t *if_bluetooth;
 
@@ -209,14 +210,33 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 static char last_remote_addr[MAX_ADDR_STR_LEN];
 static bt_ssp_variant_t last_ssp_variant = (bt_ssp_variant_t) -1;
 
+static bt_bdaddr_t pin_request_addr;
+static void pin_request_answer(char *reply)
+{
+	bt_pin_code_t pin;
+	int accept = 0;
+	int pin_len = strlen(reply);
+
+	if (pin_len > 0) {
+		accept = 1;
+		if (pin_len > 16)
+			pin_len = 16;
+		memcpy(&pin.pin, reply, pin_len);
+	}
+
+	EXEC(if_bluetooth->pin_reply, &pin_request_addr, accept, pin_len, &pin);
+}
+
 static void pin_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 								uint32_t cod)
 {
 	/* Store for command completion */
 	bt_bdaddr_t2str(remote_bd_addr, last_remote_addr);
+	pin_request_addr = *remote_bd_addr;
 
 	haltest_info("%s: remote_bd_addr=%s bd_name=%s cod=%06x\n", __func__,
 					last_remote_addr, bd_name->name, cod);
+	terminal_prompt_for("Enter pin: ", pin_request_answer);
 }
 
 static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
-- 
1.7.9.5

