Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v3 07/15] build: add advertising-api.txt to docs distributed
Date: Thu, 19 Mar 2015 10:34:29 -0700
Message-Id: <1426786477-27229-8-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
References: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add doc/advertising-api.txt to the docs.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 1ddf3f2..db2978e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -250,7 +250,7 @@ EXTRA_DIST += doc/mgmt-api.txt \
 EXTRA_DIST += doc/alert-api.txt \
 		doc/proximity-api.txt doc/heartrate-api.txt \
 		doc/thermometer-api.txt doc/cyclingspeed-api.txt \
-		doc/gatt-api.txt
+		doc/gatt-api.txt doc/advertising-api.txt
 
 EXTRA_DIST += doc/obex-api.txt doc/obex-agent-api.txt
 
-- 
2.2.0.rc0.207.ga3a616c

