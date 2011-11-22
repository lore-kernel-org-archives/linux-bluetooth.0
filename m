Return-Path: <cyrus@holtmann.org>
From: Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez@gmail.com>
Subject: [PATCH] Add missing health test scripts to Makefile.tools
Date: Tue, 22 Nov 2011 16:02:50 +0100
Message-Id: <1321974170-21111-1-git-send-email-jorge.fernandez.gonzalez@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c0a54d0..7fa4269 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -214,7 +214,7 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/simple-service test/simple-endpoint test/test-audio \
 		test/test-input test/test-attrib test/test-proximity \
 		test/test-sap-server test/test-oob test/test-serial-proxy \
-		test/test-thermometer \
+		test/test-thermometer test/test-health test/test-health-sink \
 		test/service-record.dtd test/service-did.xml \
 		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
 
-- 
1.7.4.1

