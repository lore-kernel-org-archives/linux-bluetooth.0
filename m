Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] Makefile: Add simple-player and test-nap
Date: Thu, 29 Mar 2012 16:14:21 +0200
Message-Id: <1333030461-28221-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
Hi,

it seems that these two scripts are missing in the list
of test scripts. 

cheers,
daniel

 Makefile.tools |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index f997a3f..7a8be0e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -222,7 +222,8 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-sap-server test/test-oob test/test-serial-proxy \
 		test/test-thermometer test/test-health test/test-health-sink \
 		test/service-record.dtd test/service-did.xml \
-		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
+		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
+		test/simple-player test/test-nap
 
 
 if HIDD
-- 
1.7.9.3.362.g71319

