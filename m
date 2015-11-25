Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] agent: Change default IO capability to KeyboardDisplay
Date: Wed, 25 Nov 2015 14:27:07 +0200
Message-Id: <1448454427-13266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The intention of the DisplayYesNo default capability was originally to
provide the richest possible option available. However with LE there
is a new even more capable option, namely KeyboardDisplay. When
applied to BR/EDR connections this gets implicitly downgraded to
DisplayYesNo since KeyboardDisplay is LE-specific.
---
I'm sending this to the list for comments since in principle it's changing
the behavior of a non-experimental D-Bus API.

 doc/agent-api.txt | 2 +-
 src/agent.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 2e70931a04bf..801ccb665450 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -37,7 +37,7 @@ Object path	/org/bluez
 			agent.
 
 			If an empty string is used it will fallback to
-			"DisplayYesNo".
+			"KeyboardDisplay".
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
diff --git a/src/agent.c b/src/agent.c
index 12e369ac2b19..ff44d575583e 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -924,7 +924,7 @@ static void agent_destroy(gpointer data)
 static uint8_t parse_io_capability(const char *capability)
 {
 	if (g_str_equal(capability, ""))
-		return IO_CAPABILITY_DISPLAYYESNO;
+		return IO_CAPABILITY_KEYBOARDDISPLAY;
 	if (g_str_equal(capability, "DisplayOnly"))
 		return IO_CAPABILITY_DISPLAYONLY;
 	if (g_str_equal(capability, "DisplayYesNo"))
-- 
2.5.0

