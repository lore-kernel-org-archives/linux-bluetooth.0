Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit/avdtp: Remove extra zero table entry
Date: Wed, 22 Jan 2014 14:21:26 +0200
Message-Id: <1390393286-4210-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove not needed table entry copied, probably, from unit/sdp
---
 unit/test-avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 6e51313..4726c4b 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -71,7 +71,7 @@ struct test_data {
 #define define_test(name, function, args...) \
 	do {								\
 		const struct test_pdu pdus[] = {			\
-			args, { }, { }					\
+			args, { }					\
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
-- 
1.8.3.2

