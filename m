Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] unit: Replace use of g_malloc+memcpy with gmemdup
Date: Fri, 27 Mar 2015 10:49:54 +0200
Message-Id: <1427446194-5646-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
References: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This seems to fix problems of make check not working in 32 bit systems
with gcc 5.0.
---
 unit/test-avctp.c | 3 +--
 unit/test-avdtp.c | 3 +--
 unit/test-avrcp.c | 3 +--
 unit/test-gatt.c  | 3 +--
 unit/test-hfp.c   | 6 ++----
 unit/test-hog.c   | 3 +--
 unit/test-sdp.c   | 3 +--
 unit/test-uhid.c  | 3 +--
 8 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 689a825..3bc3569 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -77,8 +77,7 @@ struct context {
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 58628a7..dd8aed7 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -80,8 +80,7 @@ struct test_data {
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 024e38e..a610ad5 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -109,8 +109,7 @@ struct context {
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 92ab6dc..5cb2e9f 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -102,8 +102,7 @@ struct context {
 		data.uuid = bt_uuid;					\
 		data.step = test_step;					\
 		data.source_db = db;					\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index face9a4..66966ce 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -95,9 +95,8 @@ struct test_data {
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		data.result_func = result_function;			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
 		data.test_handler = test_handler;			\
 	} while (0)
@@ -110,10 +109,9 @@ struct test_data {
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		data.hf_result_func = result_func;			\
 		data.response_func = response_function;			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
 		data.test_handler = test_hf_handler;			\
 	} while (0)
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 2a25d09..778f087 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -81,8 +81,7 @@ struct context {
 		};		\
 		static struct test_data data;      \
 		data.test_name = g_strdup(name);   \
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		tester_add(name, &data, NULL, function, NULL);     \
 	} while (0)
 
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index a89dbfc..b4ef4d1 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -77,8 +77,7 @@ struct test_data {
 		};							\
 		static struct test_data data;				\
 		data.mtu = _mtu;					\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, test_sdp);		\
 	} while (0)
 
diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 85e1356..b48e0fa 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -73,8 +73,7 @@ struct context {
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
-		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
 	} while (0)
 
-- 
2.1.0

