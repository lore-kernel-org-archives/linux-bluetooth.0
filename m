Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/3] input: Fix compilation errors on 32 bit machine
Date: Wed, 14 May 2014 21:49:07 +0200
Message-Id: <1400096949-18895-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix following with GCC version 4.8.2 (Debian 4.8.2-21):

  CC       profiles/input/bluetoothd-device.o
profiles/input/device.c: In function ‘uhid_send_feature_answer’:
profiles/input/device.c:232:8: error: format ‘%lu’ expects argument
  of type ‘long unsigned int’, but argument 3 has type ‘unsigned int’
   [-Werror=format=]
        len, sizeof(ev));
        ^
profiles/input/device.c: In function ‘uhid_send_input_report’:
profiles/input/device.c:274:8: error: format ‘%lu’ expects argument of
   type ‘long unsigned int’, but argument 3 has type ‘unsigned int’
   [-Werror=format=]
        len, sizeof(ev));
        ^
---
 profiles/input/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 3e89e2d..52222ea 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -228,7 +228,7 @@ static bool uhid_send_feature_answer(struct input_device *idev,
 
 	/* uHID kernel driver does not handle partial writes */
 	if ((size_t) len < sizeof(ev)) {
-		error("uHID dev write error: partial write (%zd of %lu bytes)",
+		error("uHID dev write error: partial write (%zd of %zu bytes)",
 							len, sizeof(ev));
 		return false;
 	}
@@ -270,7 +270,7 @@ static bool uhid_send_input_report(struct input_device *idev,
 
 	/* uHID kernel driver does not handle partial writes */
 	if ((size_t) len < sizeof(ev)) {
-		error("uHID dev write error: partial write (%zd of %lu bytes)",
+		error("uHID dev write error: partial write (%zd of %zu bytes)",
 							len, sizeof(ev));
 		return false;
 	}
-- 
2.0.0.rc2

