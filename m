Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	johan.hedberg@gmail.com
Subject: [PATCH BlueZ] build: Fix 'make distcheck'
Date: Thu,  6 Dec 2012 21:24:05 -0300
Message-Id: <1354839845-28686-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The test script of the cycling speed profile should be
'test-cyclingspeed' instead of 'test-cycling'.
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 90b35d5..a6ce5b2 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -221,4 +221,4 @@ EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro test/bluezutils.py \
 		test/service-did.xml test/service-spp.xml test/service-opp.xml \
 		test/service-ftp.xml test/simple-player test/test-nap \
 		test/test-heartrate test/test-alert test/test-hfp \
-		test/test-cycling
+		test/test-cyclingspeed
-- 
1.8.0.1

