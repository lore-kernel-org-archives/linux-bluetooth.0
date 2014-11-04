Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 1/4] unit-gattrib: Fix uninitialized variable
Date: Tue,  4 Nov 2014 13:19:56 -0800
Message-Id: <1415135999-8792-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1415135999-8792-1-git-send-email-jamuraa@chromium.org>
References: <1415135999-8792-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gattrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 9ced45c..228ef5b 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -124,7 +124,7 @@ static void destroy_canary_increment(gpointer data)
 static void test_refcount(struct context *cxt, gconstpointer unused)
 {
 	GAttrib *extra_ref;
-	int destroy_canary;
+	int destroy_canary = 0;
 
 	g_attrib_set_destroy_function(cxt->att, destroy_canary_increment,
 							       &destroy_canary);
-- 
2.1.0.rc2.206.gedb03e5

