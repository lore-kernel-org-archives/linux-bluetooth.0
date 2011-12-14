Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/4] hdp.c: Fix include paths
Date: Wed, 14 Dec 2011 11:11:51 +0100
Message-Id: <1323857512-5626-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1323857512-5626-2-git-send-email-sancane@gmail.com>
References: <1323857512-5626-1-git-send-email-sancane@gmail.com>
 <1323857512-5626-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index bcb6ef4..cf6ec76 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -36,7 +36,7 @@
 #include <mcap_lib.h>
 #include <bluetooth/l2cap.h>
 #include <sdpd.h>
-#include "../src/dbus-common.h"
+#include "dbus-common.h"
 #include <unistd.h>
 
 #ifndef DBUS_TYPE_UNIX_FD
-- 
1.7.8

