Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi,
	anderson.lizardo@openbossa.org, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/1] Fix gatttool to use existing MTU defines
Date: Wed, 16 Feb 2011 14:25:46 -0800
Message-Id: <1297895146-20873-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1297895146-20873-1-git-send-email-bgix@codeaurora.org>
References: <1297895146-20873-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 38636f9..7391eb3 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -44,10 +44,6 @@
 #include "gatt.h"
 #include "gatttool.h"
 
-/* Minimum MTU for ATT connections */
-#define ATT_MIN_MTU_LE		23
-#define ATT_MIN_MTU_L2CAP	48
-
 static gchar *opt_src = NULL;
 static gchar *opt_dst = NULL;
 static gchar *opt_value = NULL;
@@ -94,9 +90,10 @@ GIOChannel *do_connect(gchar *dst, gboolean le, BtIOConnect connect_cb)
 
 	/* This check is required because currently setsockopt() returns no
 	 * errors for MTU values smaller than the allowed minimum. */
-	if (opt_mtu != 0 && opt_mtu < (le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP)) {
+	if (opt_mtu != 0 &&
+		opt_mtu < (le ? ATT_DEFAULT_LE_MTU : ATT_DEFAULT_L2CAP_MTU)) {
 		g_printerr("MTU cannot be smaller than %d\n",
-				(le ? ATT_MIN_MTU_LE : ATT_MIN_MTU_L2CAP));
+				le ? ATT_DEFAULT_LE_MTU : ATT_DEFAULT_L2CAP_MTU);
 		return NULL;
 	}
 
-- 
1.7.1

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
