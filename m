Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 5/7] android/haltest: Improve EXEC macro robustness
Date: Mon, 30 Dec 2013 23:43:39 +0100
Message-Id: <1388443421-6295-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
References: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Print info about method being NULL instead of crashing.
---
 android/client/if-main.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/client/if-main.h b/android/client/if-main.h
index a83f48b..4a5d4cc 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -147,8 +147,12 @@ const struct method *get_interface_method(const char *iname,
 /* Helper macro for executing function on interface and printing BT_STATUS */
 #define EXEC(f, ...) \
 	{ \
-		int err = f(__VA_ARGS__); \
-		haltest_info("%s: %s\n", #f, bt_status_t2str(err)); \
+		if (f) { \
+			int err = f(__VA_ARGS__); \
+			haltest_info("%s: %s\n", #f, bt_status_t2str(err)); \
+		} else { \
+			haltest_info("%s is NULL\n", #f); \
+		} \
 	}
 
 /* Helper macro for executing void function on interface */
-- 
1.8.5.2

