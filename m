Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] Adding missing test scripts to Makefile.tools
Date: Sun, 15 Dec 2013 12:47:49 +0100
Message-Id: <1387108069-9616-1-git-send-email-sebastianx.chlad@intel.com>
In-Reply-To: <1386880421-19461-2-git-send-email-sebastianx.chlad@intel.com>
References: <1386880421-19461-2-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 78034f5..78bdf80 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -291,4 +291,5 @@ test_scripts += test/sap_client.py test/bluezutils.py \
 		test/service-did.xml test/service-spp.xml test/service-opp.xml \
 		test/service-ftp.xml test/simple-player test/test-nap \
 		test/test-heartrate test/test-alert test/test-hfp \
-		test/test-cyclingspeed
+		test/test-cyclingspeed test/opp-client test/ftp-client \
+		test/pbap-client test/map-client
-- 
1.8.1.2

