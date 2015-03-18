Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Add missing docs to EXTRA_DIST
Date: Wed, 18 Mar 2015 23:04:46 +0200
Message-Id: <1426712691-5048-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds doc/gatt-api.txt and doc/input-api.txt to EXTRA_DIST so they
get included in make dist tarball.
---
 Makefile.am | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index cb8f2f5..90bb86b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -243,11 +243,13 @@ EXTRA_DIST += doc/mgmt-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
 		doc/agent-api.txt doc/profile-api.txt \
 		doc/network-api.txt doc/media-api.txt \
-		doc/health-api.txt doc/sap-api.txt
+		doc/health-api.txt doc/sap-api.txt \
+		doc/input-api.txt
 
 EXTRA_DIST += doc/alert-api.txt \
 		doc/proximity-api.txt doc/heartrate-api.txt \
-		doc/thermometer-api.txt doc/cyclingspeed-api.txt
+		doc/thermometer-api.txt doc/cyclingspeed-api.txt \
+		doc/gatt-api.txt
 
 EXTRA_DIST += doc/obex-api.txt doc/obex-agent-api.txt
 
-- 
2.1.0

