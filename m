Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v5 8/8] unit/gattrib: Only init log on --verbose
Date: Fri, 31 Oct 2014 11:14:59 -0700
Message-Id: <1414779299-18197-9-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
References: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gattrib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index a1ff530..cd43c3a 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -553,7 +553,8 @@ int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
-	__btd_log_init("*", 0);
+	if (g_test_verbose())
+		__btd_log_init("*", 0);
 
 	/*
 	 * Test the GAttrib API behavior
-- 
2.1.0.rc2.206.gedb03e5

