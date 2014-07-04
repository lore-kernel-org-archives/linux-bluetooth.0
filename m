Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/12] android/haltest: Auto-accept pairing
Date: Fri,  4 Jul 2014 16:43:54 +0300
Message-Id: <1404481441-734-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Simplify PTS testing by asking for pairing consent.
---
 android/client/if-bt.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4d6ff83..218e254 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -266,7 +266,8 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 			__func__, last_remote_addr, bd_name->name, cod,
 			bt_ssp_variant_t2str(pairing_variant), pass_key);
 
-	if (pairing_variant == BT_SSP_VARIANT_PASSKEY_CONFIRMATION) {
+	switch (pairing_variant) {
+	case BT_SSP_VARIANT_PASSKEY_CONFIRMATION:
 		sprintf(prompt, "Does other device show %d [Y/n] ?", pass_key);
 
 		ssp_request_addr = *remote_bd_addr;
@@ -274,6 +275,19 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 		ssp_request_pask_key = pass_key;
 
 		terminal_prompt_for(prompt, ssp_request_yes_no_answer);
+		break;
+	case BT_SSP_VARIANT_CONSENT:
+		sprintf(prompt, "Consent pairing [Y/n] ?");
+
+		ssp_request_addr = *remote_bd_addr;
+		ssp_request_variant = pairing_variant;
+		ssp_request_pask_key = 0;
+
+		terminal_prompt_for(prompt, ssp_request_yes_no_answer);
+		break;
+	default:
+		haltest_info("Not automatically handled\n");
+		break;
 	}
 }
 
-- 
1.9.1

