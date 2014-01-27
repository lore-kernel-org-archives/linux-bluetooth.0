Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] unit/avdtp: trivial: Remove empty line
Date: Mon, 27 Jan 2014 18:01:43 +0200
Message-Id: <1390838504-25456-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-avdtp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 4726c4b..8fe5ce3 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -216,7 +216,6 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	return TRUE;
 }
 
-
 static struct context *context_new(uint16_t version, uint16_t imtu,
 					uint16_t omtu, gconstpointer data)
 {
-- 
1.8.3.2

