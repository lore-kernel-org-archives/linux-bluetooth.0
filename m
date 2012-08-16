Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v3 10/14] core: Remove leftover define
Date: Thu, 16 Aug 2012 18:28:40 -0300
Message-Id: <1345152524-13404-11-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
References: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1f64d20..645a2b7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -67,8 +67,6 @@
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
 
-#define AUTO_CONNECTION_INTERVAL	5 /* Next connection attempt */
-
 #define APPEARANCE_CHR_UUID 0x2a01
 
 struct btd_disconnect_data {
-- 
1.7.11.2

