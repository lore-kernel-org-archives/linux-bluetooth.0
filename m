Return-Path: <cyrus@holtmann.org>
From: Sebastian <sebastianchlad@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian <sebastianx.chlad@intel.com>
Subject: [PATCH] Adding missing test scripts to Makefile.tools
Date: Thu, 12 Dec 2013 21:33:41 +0100
Message-Id: <1386880421-19461-2-git-send-email-sebastianx.chlad@intel.com>
In-Reply-To: <1386880421-19461-1-git-send-email-sebastianx.chlad@intel.com>
References: <1386880421-19461-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 78034f5..b306c34 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -289,6 +289,7 @@ test_scripts += test/sap_client.py test/bluezutils.py \
 		test/test-thermometer test/test-profile test/test-health \
 		test/test-health-sink test/service-record.dtd \
 		test/service-did.xml test/service-spp.xml test/service-opp.xml \
-		test/service-ftp.xml test/simple-player test/test-nap \
+		test/opp-client test/service-ftp.xml test/ftp-client \
+		test/simple-player test/test-nap \
 		test/test-heartrate test/test-alert test/test-hfp \
-		test/test-cyclingspeed
+		test/test-cyclingspeed test/pbap-client test/map-client
-- 
1.8.1.2

