Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/8] android/haltest: Fix print device name
Date: Fri,  1 Nov 2013 15:41:38 +0200
Message-Id: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/textconv.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index effd1b3..8e6bdb9 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -258,8 +258,7 @@ char *btproperty2str(const bt_property_t *property)
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

