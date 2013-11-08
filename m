Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 2/8] android/client: Add NELEM macro for count elements
Date: Fri, 8 Nov 2013 13:48:24 +0100
Message-ID: <1383914910-2304-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NELEM macro will be used in several places.
---
 android/client/if-main.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/client/if-main.h b/android/client/if-main.h
index 647162c..dea7237 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -144,6 +144,8 @@ struct method *get_command(const char *name);
 const struct method *get_interface_method(const char *iname,
 							const char *mname);
 
+#define NELEM(x) ((int) (sizeof(x) / sizeof((x)[0])))
+
 /* Helper macro for executing function on interface and printing BT_STATUS */
 #define EXEC(f, ...) \
 	{ \
-- 
1.7.9.5

