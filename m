Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/client: Fix crash reading not connected SCO
Date: Wed, 23 Jul 2014 14:34:59 +0300
Message-Id: <1406115301-18812-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When SCO is not connected we get -1 from in_read() HAL function.
---
 android/client/if-sco.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 70e2737..c33b012 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -287,7 +287,7 @@ static void *read_thread(void *data)
 {
 	int (*filbuff_cb) (short*, void*) = feed_from_in;
 	short buffer[buffer_size_in / sizeof(short)];
-	size_t len = 0;
+	ssize_t len = 0;
 	void *cb_data = NULL;
 	FILE *out = data;
 
@@ -311,6 +311,10 @@ static void *read_thread(void *data)
 		pthread_mutex_unlock(&state_mutex);
 
 		len = filbuff_cb(buffer, cb_data);
+		if (len < 0) {
+			haltest_error("Error receiving SCO data");
+			break;
+		}
 
 		haltest_info("Read %zd bytes\n", len);
 
-- 
1.9.1

