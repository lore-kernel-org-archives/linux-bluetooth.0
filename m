Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/11] unit/test-gatt: Use auto security
Date: Tue, 23 Jun 2015 15:53:29 +0300
Message-Id: <1435064017-8178-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
References: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the test don't expect any errors to happen use set security to auto so
bt_att will take care of elevating the security whenever needed.
---
 unit/test-gatt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index bb6a270..9a9fa60 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -630,6 +630,10 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	if (context->data->step) {
 		const struct test_step *step = context->data->step;
 
+		/* Auto elevate security for test that don't expect error */
+		if (!step->expected_att_ecode)
+			bt_att_set_security(context->att, BT_ATT_SECURITY_AUTO);
+
 		step->func(context);
 		return;
 	}
-- 
2.1.0

