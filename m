Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/handsfree: Refactor handle_dial()
Date: Tue, 26 Aug 2014 16:43:21 +0300
Message-Id: <1409060601-14384-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Call callback only once.
---
 android/hal-handsfree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 0f5e1d7..986e745 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -86,6 +86,7 @@ static void handle_dial(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_dial *ev = buf;
 	uint16_t num_len = ev->number_len;
+	char *number = NULL;
 
 	if (len != sizeof(*ev) + num_len ||
 			(num_len != 0 && ev->number[num_len - 1] != '\0')) {
@@ -97,9 +98,9 @@ static void handle_dial(void *buf, uint16_t len, int fd)
 		return;
 
 	if (ev->number_len)
-		cbs->dial_call_cmd_cb((char *) ev->number);
-	else
-		cbs->dial_call_cmd_cb(NULL);
+		number = (char *) ev->number;
+
+	cbs->dial_call_cmd_cb(number);
 }
 
 static void handle_dtmf(void *buf, uint16_t len, int fd)
-- 
1.9.1

