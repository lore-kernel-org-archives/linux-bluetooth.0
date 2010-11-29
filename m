Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] hcid header cleanup
Date: Mon, 29 Nov 2010 10:24:14 -0300
Message-Id: <1291037054-22247-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1291037054-22247-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291037054-22247-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/hcid.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/hcid.h b/src/hcid.h
index a9484a6..2e16328 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -23,9 +23,6 @@
  *
  */
 
-#include <bluetooth/hci.h>
-#include <bluetooth/hci_lib.h>
-
 /*
  * Scanning modes, used by DEV_SET_MODE
  * off: remote devices are not allowed to find or connect to this device
@@ -62,8 +59,6 @@ struct main_opts {
 	uint8_t		mode;
 	uint8_t		discov_interval;
 	char		deviceid[15]; /* FIXME: */
-
-	int		sock;
 };
 
 enum {
-- 
1.7.3.2

