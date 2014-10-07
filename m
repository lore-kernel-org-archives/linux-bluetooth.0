Return-Path: <cyrus@holtmann.org>
From: Alex Gal <a.gal@miip.ca>
To: linux-bluetooth@vger.kernel.org
Cc: Alex Gal <a.gal@miip.ca>
Subject: [PATCH] Adds Sony Move Navigation controller.
Date: Tue,  7 Oct 2014 12:04:37 -0400
Message-Id: <1412697877-7508-1-git-send-email-a.gal@miip.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Alex <a.gal@miip.ca>
---
 plugins/sixaxis.c       | 7 +++++++
 profiles/input/server.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index b09404a..6f7893e 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -60,6 +60,13 @@ static const struct {
 		.pid = 0x0268,
 		.version = 0x0000,
 	},
+	{
+		.name = "PLAYSTATION(R)3 Controller", /* Move Navigation */
+		.source = 0x0002,
+		.vid = 0x054c,
+		.pid = 0x042f,
+		.version = 0x0000,
+	},
 };
 
 struct leds_data {
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 307db96..5463311 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -140,6 +140,10 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 	if (vid == 0x054c && pid == 0x05c4)
 		return true;
 
+    /* Move Navigation */
+	if (vid == 0x054c && pid == 0x042f)
+		return true;
+
 	return false;
 }
 
-- 
2.1.0

