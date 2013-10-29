Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 6/9] android/hal: Print adapter property in callback
Date: Tue, 29 Oct 2013 14:57:36 +0200
Message-Id: <1383051459-29495-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-bluetooth.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 4d467ee..cc63bd9 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -65,6 +65,8 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 
 		p += sizeof(*hal_prop) + hal_prop->len;
 		hal_prop = p;
+
+		DBG("prop[%d]: %s", i, btproperty2str(&props[i]));
 	}
 
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
-- 
1.7.10.4

