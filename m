Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] core: Remove unneeded textfile header include
Date: Tue, 29 May 2012 10:55:25 -0300
Message-Id: <1338299726-25822-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0961ff6..7ff09aa 100644
--- a/src/device.c
+++ b/src/device.c
@@ -44,7 +44,6 @@
 #include <gdbus.h>
 
 #include "log.h"
-#include "textfile.h"
 
 #include "att.h"
 #include "hcid.h"
-- 
1.7.8.6

