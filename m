Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] lib/sdp: Add missing Service Class ID for GAP
Date: Fri,  7 Feb 2014 16:14:44 -0400
Message-Id: <1391804086-14428-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also reorder last ID so the list remains ordered.
---
 lib/sdp.c |    3 ++-
 lib/sdp.h |    7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 3b26ec3..0a7cb6f 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -181,8 +181,9 @@ static struct tupla ServiceClass[] = {
 	{ HDP_SVCLASS_ID,			"HDP"				},
 	{ HDP_SOURCE_SVCLASS_ID,		"HDP Source"			},
 	{ HDP_SINK_SVCLASS_ID,			"HDP Sink"			},
-	{ APPLE_AGENT_SVCLASS_ID,		"Apple Agent"			},
+	{ GENERIC_ACCESS_SVCLASS_ID,		"Generic Access"		},
 	{ GENERIC_ATTRIB_SVCLASS_ID,		"Generic Attribute"		},
+	{ APPLE_AGENT_SVCLASS_ID,		"Apple Agent"			},
 	{ 0 }
 };
 
diff --git a/lib/sdp.h b/lib/sdp.h
index c6dfc27..516d75d 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -150,8 +150,9 @@ extern "C" {
 #define HDP_SVCLASS_ID			0x1400
 #define HDP_SOURCE_SVCLASS_ID		0x1401
 #define HDP_SINK_SVCLASS_ID		0x1402
-#define APPLE_AGENT_SVCLASS_ID		0x2112
+#define GENERIC_ACCESS_SVCLASS_ID	0x1800
 #define GENERIC_ATTRIB_SVCLASS_ID	0x1801
+#define APPLE_AGENT_SVCLASS_ID		0x2112
 
 /*
  * Standard profile descriptor identifiers; note these
@@ -224,9 +225,9 @@ extern "C" {
 #define HDP_PROFILE_ID			HDP_SVCLASS_ID
 #define HDP_SOURCE_PROFILE_ID		HDP_SOURCE_SVCLASS_ID
 #define HDP_SINK_PROFILE_ID		HDP_SINK_SVCLASS_ID
-#define APPLE_AGENT_PROFILE_ID		APPLE_AGENT_SVCLASS_ID
-#define GENERIC_ACCESS_PROFILE_ID	0x1800
+#define GENERIC_ACCESS_PROFILE_ID	GENERIC_ACCESS_SVCLASS_ID
 #define GENERIC_ATTRIB_PROFILE_ID	GENERIC_ATTRIB_SVCLASS_ID
+#define APPLE_AGENT_PROFILE_ID		APPLE_AGENT_SVCLASS_ID
 
 /*
  * Compatibility macros for the old MDP acronym
-- 
1.7.9.5

