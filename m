Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 8/8] android/client: Add ssp key confirmation helper
Date: Fri, 8 Nov 2013 13:48:30 +0100
Message-ID: <1383914910-2304-9-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of ssp_request_cb that prints prompt
asking user if pass key matches. User does not need to type:
bluetooth ssp_reply address BT_SSP_VARIANT_PASSKEY_CONFIRMATION 1 key
---
 android/client/if-bt.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 0a580e1..10ae125 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -239,10 +239,26 @@ static void pin_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 	terminal_prompt_for("Enter pin: ", pin_request_answer);
 }
 
+/* Variables to store information from ssp_request_cb used for ssp_reply */
+static bt_bdaddr_t ssp_request_addr;
+static bt_ssp_variant_t ssp_request_variant;
+static uint32_t ssp_request_pask_key;
+
+/* Called when user hit enter on prompt for confirmation */
+static void ssp_request_yes_no_answer(char *reply)
+{
+	int accept = *reply == 0 || *reply == 'y' || *reply == 'Y';
+
+	if_bluetooth->ssp_reply(&ssp_request_addr, ssp_request_variant, accept,
+							ssp_request_pask_key);
+}
+
 static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 				uint32_t cod, bt_ssp_variant_t pairing_variant,
 				uint32_t pass_key)
 {
+	static char prompt[50];
+
 	/* Store for command completion */
 	bt_bdaddr_t2str(remote_bd_addr, last_remote_addr);
 	last_ssp_variant = pairing_variant;
@@ -250,6 +266,16 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 	haltest_info("%s: remote_bd_addr=%s bd_name=%s cod=%06x pairing_variant=%s pass_key=%d\n",
 			__func__, last_remote_addr, bd_name->name, cod,
 			bt_ssp_variant_t2str(pairing_variant), pass_key);
+
+	if (pairing_variant == BT_SSP_VARIANT_PASSKEY_CONFIRMATION) {
+		sprintf(prompt, "Does other device show %d [Y/n] ?", pass_key);
+
+		ssp_request_addr = *remote_bd_addr;
+		ssp_request_variant = pairing_variant;
+		ssp_request_pask_key = pass_key;
+
+		terminal_prompt_for(prompt, ssp_request_yes_no_answer);
+	}
 }
 
 static void bond_state_changed_cb(bt_status_t status,
-- 
1.7.9.5

