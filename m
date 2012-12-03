Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/3] input: Remove leftover defines
Date: Mon,  3 Dec 2012 13:41:18 -0300
Message-Id: <1354552880-31864-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/device.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 8464062..c2db6d1 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -55,14 +55,6 @@
 
 #include "sdp-client.h"
 
-#define INPUT_DEVICE_INTERFACE "org.bluez.Input"
-
-#define BUF_SIZE		16
-
-#define UPDOWN_ENABLED		1
-
-#define FI_FLAG_CONNECTED	1
-
 struct pending_connect {
 	struct btd_profile *profile;
 	btd_profile_cb cb;
-- 
1.7.11.7

