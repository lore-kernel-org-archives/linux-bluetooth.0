Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] wiimote: add new documented device IDs
Date: Fri, 18 Oct 2013 16:13:47 +0200
Message-Id: <1382105627-22344-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add some new device IDs for the LEGO wiimote and Wii U Pro Controllers.
Also add comments for each ID so we can track them better.
---
 plugins/wiimote.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index beda307..6cc21ee 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -59,14 +59,16 @@
  */
 
 static uint16_t wii_ids[][2] = {
-	{ 0x057e, 0x0306 },
-	{ 0x057e, 0x0330 },
+	{ 0x057e, 0x0306 },		/* 1st gen */
+	{ 0x054c, 0x0306 },		/* LEGO wiimote */
+	{ 0x057e, 0x0330 },		/* 2nd gen */
 };
 
 static const char *wii_names[] = {
-	"Nintendo RVL-CNT-01",
-	"Nintendo RVL-CNT-01-TR",
-	"Nintendo RVL-WBC-01",
+	"Nintendo RVL-CNT-01",		/* 1st gen */
+	"Nintendo RVL-CNT-01-TR",	/* 2nd gen */
+	"Nintendo RVL-CNT-01-UC",	/* Wii U Pro Controller */
+	"Nintendo RVL-WBC-01",		/* Balance Board */
 };
 
 static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
-- 
1.8.4

