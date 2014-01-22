Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit/sdp: Remove extra zero table entry
Date: Wed, 22 Jan 2014 14:14:58 +0200
Message-Id: <1390392898-3678-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It is enough to have one zero table entry at the end of the table.
---
 unit/test-sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 6d699e2..9b82343 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -72,7 +72,7 @@ struct test_data {
 #define define_test(name, _mtu, args...) \
 	do {								\
 		const struct sdp_pdu pdus[] = {				\
-			args, { }, { }					\
+			args, { }					\
 		};							\
 		static struct test_data data;				\
 		data.mtu = _mtu;					\
-- 
1.8.3.2

