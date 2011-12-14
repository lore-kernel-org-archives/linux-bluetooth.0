Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/4] mcap_sync.c: Fix include paths
Date: Wed, 14 Dec 2011 11:11:50 +0100
Message-Id: <1323857512-5626-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1323857512-5626-1-git-send-email-sancane@gmail.com>
References: <1323857512-5626-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap_sync.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/health/mcap_sync.c b/health/mcap_sync.c
index 5545cea..e2d7715 100644
--- a/health/mcap_sync.c
+++ b/health/mcap_sync.c
@@ -28,8 +28,8 @@
 #include <stdlib.h>
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
-#include "../src/adapter.h"
-#include "../src/manager.h"
+#include <adapter.h>
+#include <manager.h>
 #include <sys/ioctl.h>
 
 #include "config.h"
-- 
1.7.8

