Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/4] android: Fix printing not NULL terminated strings
Date: Mon,  4 Nov 2013 15:22:38 +0200
Message-Id: <1383571358-4942-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383571358-4942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZLUUPkLM_b2DDb=mxc5-QqLrwN9in7XmZGpV+xQ-DpzzQ@mail.gmail.com>
 <1383571358-4942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android passes not NULL terminated strings.
---
 android/client/textconv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index 8e6bdb9..9a2f7e6 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -258,7 +258,8 @@ char *btproperty2str(const bt_property_t *property)
 	switch (property->type) {
 	case BT_PROPERTY_BDNAME:
 	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
-		sprintf(p, "%s", ((bt_bdname_t *) property->val)->name);
+		snprintf(p, property->len + 1, "%s",
+					((bt_bdname_t *) property->val)->name);
 		break;
 
 	case BT_PROPERTY_BDADDR:
-- 
1.7.10.4

