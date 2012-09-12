Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, johan.hedberg@gmail.com,
	floe@butterbrot.org
Subject: [PATCH] wiimote: add Wii Balance Board detection
Date: Wed, 12 Sep 2012 23:32:53 +0200
Message-Id: <1347485573-23623-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the name of the Wii Balance Board so it can be paired with BlueZ like
any other Wii Remote. Reported by Florian Echtler.
---
 plugins/wiimote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 337d408..3d16966 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -76,6 +76,7 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 	name[sizeof(name) - 1] = 0;
 
 	if (g_str_equal(name, "Nintendo RVL-CNT-01") ||
+	    g_str_equal(name, "Nintendo RVL-WBC-01") ||
 				(vendor == 0x057e && product == 0x0306)) {
 		DBG("Forcing fixed pin on detected wiimote %s", addr);
 		memcpy(pinbuf, &sba, 6);
-- 
1.7.12

