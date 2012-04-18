Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] Makefile: Always add all test scripts to EXTRA_DIST
Date: Wed, 18 Apr 2012 10:53:37 +0200
Message-Id: <1334739217-17509-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

With commit e407e9ac6d8bfde31f95ed5d7e7bcecf0cfe48ed
test-attrib, test-proximity and test-thermometer are only packaged
when "./configure --enable-gatt && make dist" is called.

The dist target should be independant on the configure flags.
---
 Makefile.tools |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index e3f2017..cb0d1d0 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -219,15 +219,12 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-telephony test/test-network test/simple-agent \
 		test/simple-service test/simple-endpoint test/test-audio \
 		test/test-input test/test-sap-server test/test-oob \
+		test/test-attrib test/test-proximity test/test-thermometer \
 		test/test-serial-proxy test/test-health test/test-health-sink \
 		test/service-record.dtd test/service-did.xml \
 		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
 		test/simple-player test/test-nap
 
-if GATTMODULES
-EXTRA_DIST += test/test-attrib test/test-proximity test/test-thermometer
-endif
-
 if HIDD
 bin_PROGRAMS += compat/hidd
 
-- 
1.7.10.130.g36e6c

