Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 3/8] android/hal: Print full property in debug
Date: Wed, 30 Oct 2013 14:16:41 +0200
Message-Id: <1383135406-23658-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Instead of printing property type print type and value. Use exported
function from hal test tool.
---
 android/hal-bluetooth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 2237063..89535ed 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -321,7 +321,7 @@ static int set_adapter_property(const bt_property_t *property)
 	char buf[sizeof(struct hal_cmd_set_adapter_prop) + property->len];
 	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
 
-	DBG("prop: %s", bt_property_type_t2str(property->type));
+	DBG("prop: %s", btproperty2str(property));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
-- 
1.7.10.4

