Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 10/14] core: Remove leftover define
Date: Fri, 27 Jul 2012 19:29:54 -0300
Message-Id: <1343428198-23621-11-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/device.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index a0dc5a0..d81976e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -67,8 +67,6 @@
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
 
-#define AUTO_CONNECTION_INTERVAL	5 /* Next connection attempt */
-
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
 
-- 
1.7.10.4

