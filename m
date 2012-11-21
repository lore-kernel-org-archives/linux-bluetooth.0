Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [PATCH] Bluetooth:  Provide definitions for CSA2 audio commands
Date: Wed, 21 Nov 2012 14:22:00 +0100
Message-Id: <1353504120-5208-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/hci.c b/lib/hci.c
index 66b2d5f..fd27f1a 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -590,6 +590,15 @@ static hci_map commands_map[] = {
 	{ "LE Test End",				230 },
 	{ "Reserved",					231 },
 
+	{ "Reserved",						232 },
+	{ "Reserved",						233 },
+	{ "Reserved",						234 },
+	{ "Enhanced Setup Synchronous Connection",		235 },
+	{ "Enhanced Accept Synchronous Connection Request",	236 },
+	{ "Read Local Supported Codecs",			237 },
+	{ "Reserved",						238 },
+	{ "Reserved",						239 },
+
 	{ NULL }
 };
 
-- 
1.7.9.5

