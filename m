Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Removed unused define
Date: Mon, 29 Nov 2010 10:24:13 -0300
Message-Id: <1291037054-22247-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 77353a4..65acc08 100644
--- a/src/device.c
+++ b/src/device.c
@@ -57,7 +57,6 @@
 #include "storage.h"
 #include "btio.h"
 
-#define DEFAULT_XML_BUF_SIZE	1024
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
 
-- 
1.7.3.2

