Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi,
	anderson.lizardo@openbossa.org, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/1] Fix Min MTU to reflect values for both L2CAP & LE
Date: Wed, 16 Feb 2011 13:16:24 -0800
Message-Id: <1297890984-7809-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1297890984-7809-1-git-send-email-bgix@codeaurora.org>
References: <1297890984-7809-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 1e2a8db..38636f9 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -44,8 +44,9 @@
 #include "gatt.h"
 #include "gatttool.h"
 
-/* Minimum MTU for L2CAP connections over BR/EDR */
-#define ATT_MIN_MTU_L2CAP 48
+/* Minimum MTU for ATT connections */
+#define ATT_MIN_MTU_LE		23
+#define ATT_MIN_MTU_L2CAP	48
 
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
@@ -93,9 +94,9 @@ GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb)
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
-	if (opt_mtu != 0 && opt_mtu < ATT_MIN_MTU_L2CAP) {
+	if (opt_mtu != 0 && opt_mtu < (le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP)) {
 		g_printerr("MTU cannot be smaller than %d\n",
-							ATT_MIN_MTU_L2CAP);
+				(le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP));
 		return NULL;
 	}
 
-- 
1.7.1

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
