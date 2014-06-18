Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/11] android/haltest: Auto-accept pairing
Date: Wed, 18 Jun 2014 16:33:50 +0300
Message-Id: <1403098434-28193-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Simplify PTS testing by automatically auto accept Just Works pairing.
---
 android/client/if-bt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4d6ff83..764979e 100644
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
@@ -274,6 +275,14 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 		ssp_request_pask_key = pass_key;
 
 		terminal_prompt_for(prompt, ssp_request_yes_no_answer);
+		break;
+	case BT_SSP_VARIANT_CONSENT:
+		EXEC(if_bluetooth->ssp_reply, remote_bd_addr, pairing_variant,
+								1, 0);
+		break;
+	default:
+		haltest_info("Not automatically handled\n");
+		break;
 	}
 }
 
-- 
1.8.3.2

