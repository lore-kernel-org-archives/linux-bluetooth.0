Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 3/7] android/haltest: Fix print device name
Date: Fri,  1 Nov 2013 17:19:15 +0200
Message-Id: <1383319159-13060-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/textconv.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 1dc6ad0..18f60ee 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -253,8 +253,7 @@ char *btproperty2str(const bt_property_t *property)
 	switch (property->type) {
 	case BT_PROPERTY_BDNAME:
 	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
-		sprintf(p, "%*s", property->len,
-					((bt_bdname_t *) property->val)->name);
+		sprintf(p, "%s", ((bt_bdname_t *) property->val)->name);
 		break;
 
 	case BT_PROPERTY_BDADDR:
-- 
1.7.10.4

