Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 11/11] plugins/autopair: Don't try to pair PS3 Keypad
Date: Wed, 18 Oct 2017 03:58:15 +0200
Message-Id: <20171018015815.10045-11-hadess@hadess.net>
In-Reply-To: <20171018015815.10045-1-hadess@hadess.net>
References: <20171018015815.10045-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The keypad doesn't use pairing. Don't type your passwords on this...
---
 plugins/autopair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 6980b0a64..863b8d736 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -78,6 +78,10 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 	if (name != NULL && strstr(name, "iCade") != NULL)
 		return 0;
 
+	/* The PS3 Wireless Keypad doesn't need pairing */
+	if (name != NULL && g_str_equal(name, "Wireless Keypad"))
+		return 0;
+
 	/* This is a class-based pincode guesser. Ignore devices with an
 	 * unknown class.
 	 */
-- 
2.14.2

