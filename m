Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] unit/avctp: Cleanup code, remove fragmentation support
Date: Wed,  5 Feb 2014 17:28:22 +0200
Message-Id: <1391614102-21639-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391614102-21639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391614102-21639-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-avctp.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 9d94ae0..be1dfd7 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -42,7 +42,6 @@
 
 struct test_pdu {
 	bool valid;
-	bool fragmented;
 	const uint8_t *data;
 	size_t size;
 };
@@ -71,14 +70,6 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
-#define frg_pdu(args...)					\
-	{							\
-		.valid = true,					\
-		.fragmented = true,				\
-		.data = data(args),				\
-		.size = sizeof(data(args)),			\
-	}
-
 #define define_test(name, function, args...)				\
 	do {								\
 		const struct test_pdu pdus[] = {			\
@@ -133,9 +124,6 @@ static gboolean send_pdu(gpointer user_data)
 
 	g_assert_cmpint(len, ==, pdu->size);
 
-	if (pdu->fragmented)
-		return send_pdu(user_data);
-
 	context->process = 0;
 	return FALSE;
 }
@@ -180,8 +168,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
 
-	if (!pdu->fragmented)
-		context_process(context);
+	context_process(context);
 
 	return TRUE;
 }
-- 
1.8.3.2

