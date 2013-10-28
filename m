Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/4] android/hal: Print full property in debug
Date: Mon, 28 Oct 2013 12:44:06 +0200
Message-Id: <1382957047-31775-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Instead of printing property type print type and value. Use exported
function from hal test tool.
---
 android/hal-bluetooth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5929fff..da96202 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -226,7 +226,7 @@ static int set_adapter_property(const bt_property_t *property)
 	char buf[sizeof(struct hal_cmd_set_adapter_prop) + property->len];
 	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
 
-	DBG("prop: %s", bt_property_type_t2str(property->type));
+	DBG("prop: %s", btproperty2str(property));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
-- 
1.7.10.4

