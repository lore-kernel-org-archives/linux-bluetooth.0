Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/2] shared/uhid: Use uhid_copy.h instead of system header
Date: Sat, 24 May 2014 20:53:58 +0200
Message-Id: <1400957638-18418-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1400957638-18418-1-git-send-email-szymon.janc@gmail.com>
References: <1400957638-18418-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/uhid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index fcf5379..459a249 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -23,7 +23,8 @@
 
 #include <stdbool.h>
 #include <stdint.h>
-#include <linux/uhid.h>
+
+#include "profiles/input/uhid_copy.h"
 
 struct bt_uhid;
 
-- 
2.0.0.rc4

