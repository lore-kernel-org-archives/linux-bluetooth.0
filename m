Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] unit: Reuse define_test() macro for /TP/SERVER/BRW/* tests
Date: Wed,  9 Jan 2013 11:19:20 -0400
Message-Id: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is made possible by adding the mtu parameter, given
/TP/SERVER/BRW/* tests use MTU of 672.
---
 unit/test-sdp.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 315a5cd..e9cbcdf 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -68,34 +68,22 @@ struct test_data {
 		.cont_len = cont,				\
 	}
 
-#define define_test(name, args...) \
+#define define_test(name, _mtu, args...) \
 	do {								\
 		const struct sdp_pdu pdus[] = {				\
 			args, { }, { }					\
 		};							\
 		static struct test_data data;				\
-		data.mtu = 48;						\
+		data.mtu = _mtu;					\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, test_sdp);		\
 	} while (0)
 
-#define define_ss(name, args...) define_test("/TP/SERVER/SS/" name, args)
-#define define_sa(name, args...) define_test("/TP/SERVER/SA/" name, args)
-#define define_ssa(name, args...) define_test("/TP/SERVER/SSA/" name, args)
-
-#define define_brw(name, args...) \
-	do {								\
-		const struct sdp_pdu pdus[] = {				\
-			args, { }, { }					\
-		};							\
-		static struct test_data data;				\
-		data.mtu = 672;						\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
-		g_test_add_data_func("/TP/SERVER/BRW/" name,		\
-						&data, test_sdp);	\
-	} while (0)
+#define define_ss(name, args...) define_test("/TP/SERVER/SS/" name, 48, args)
+#define define_sa(name, args...) define_test("/TP/SERVER/SA/" name, 48, args)
+#define define_ssa(name, args...) define_test("/TP/SERVER/SSA/" name, 48, args)
+#define define_brw(name, args...) define_test("/TP/SERVER/BRW/" name, 672, args)
 
 struct context {
 	GMainLoop *main_loop;
-- 
1.7.9.5

