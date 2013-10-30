Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 6/8] android/hal: Print adapter property in callback
Date: Wed, 30 Oct 2013 14:16:44 +0200
Message-Id: <1383135406-23658-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383135406-23658-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-bluetooth.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 0908f06..1d5b04f 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -59,6 +59,8 @@ static void repack_properties(bt_property_t *send_props,
 
 		p += sizeof(*hal_prop) + hal_prop->len;
 		hal_prop = p;
+
+		DBG("prop[%d]: %s", i, btproperty2str(&send_props[i]));
 	}
 }
 
-- 
1.7.10.4

