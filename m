Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] hog: Fix report_value_cb() signature
Message-Id: <20140509183001.C4557100D85@puck.mtv.corp.google.com>
Date: Fri,  9 May 2014 11:30:01 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix report_value_cb() signature to match GAttribNotifyFunc.
---
 profiles/input/hog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 12bc19a..9f10fa4 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -105,8 +105,7 @@ struct report {
 static gboolean suspend_supported = FALSE;
 static GSList *devices = NULL;
 
-static void report_value_cb(const uint8_t *pdu, uint16_t len,
-							gpointer user_data)
+static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
 	struct hog_device *hogdev = report->hogdev;
-- 
1.9.1.423.g4596e3a

