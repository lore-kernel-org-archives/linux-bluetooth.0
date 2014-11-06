Return-Path: <cyrus@holtmann.org>
From: Alex Gal <a.gal@miip.ca>
To: linux-bluetooth@vger.kernel.org
Cc: Alex Gal <a.gal@miip.ca>
Subject: [PATCH 1/2] plugins/sixaxis: Add Sony Navigation Controller
Date: Thu,  6 Nov 2014 10:29:13 -0500
Message-Id: <1415287754-868-1-git-send-email-a.gal@miip.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/sixaxis.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index b09404a..ac53ba9 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -60,6 +60,13 @@ static const struct {
 		.pid = 0x0268,
 		.version = 0x0000,
 	},
+	{
+		.name = "Navigation Controller",
+		.source = 0x0002,
+		.vid = 0x054c,
+		.pid = 0x042f,
+		.version = 0x0000,
+	},
 };
 
 struct leds_data {
-- 
2.1.1

