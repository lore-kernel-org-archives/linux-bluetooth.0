Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v1] Makefile: Add simple-player and test-nap
Date: Fri, 30 Mar 2012 14:22:36 +0200
Message-Id: <1333110156-15523-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Add simple-palyer and test-nap to the EXTRA_DIST target.
---
 Makefile.tools |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7b7a43f..e3f2017 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -221,7 +221,8 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-input test/test-sap-server test/test-oob \
 		test/test-serial-proxy test/test-health test/test-health-sink \
 		test/service-record.dtd test/service-did.xml \
-		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
+		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
+		test/simple-player test/test-nap
 
 if GATTMODULES
 EXTRA_DIST += test/test-attrib test/test-proximity test/test-thermometer
-- 
1.7.10.rc3.1.gb3065

