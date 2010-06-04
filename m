Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 4/4] Adjust define name to the name of the file
Date: Fri,  4 Jun 2010 07:16:53 -0300
Message-Id: <1275646613-32639-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275646613-32639-3-git-send-email-gustavo@padovan.org>
References: <1275646613-32639-1-git-send-email-gustavo@padovan.org>
 <1275646613-32639-2-git-send-email-gustavo@padovan.org>
 <1275646613-32639-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/log.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/log.h b/src/log.h
index 235430e..7a5942c 100644
--- a/src/log.h
+++ b/src/log.h
@@ -21,8 +21,8 @@
  *
  */
 
-#ifndef __LOGGING_H
-#define __LOGGING_H
+#ifndef __LOG_H
+#define __LOG_H
 
 extern int debug_enabled;
 
@@ -61,4 +61,4 @@ struct btd_debug_desc {
                                         __FILE__, __FUNCTION__ , ## arg); \
 } while (0)
 
-#endif /* __LOGGING_H */
+#endif /* __LOG_H */
-- 
1.7.1

