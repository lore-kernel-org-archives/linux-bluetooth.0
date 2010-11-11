Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix test-attrib not being listed in EXTRA_DIST
Date: Thu, 11 Nov 2010 16:08:48 +0200
Message-Id: <1289484528-23630-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 Makefile.tools |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 797b53d..d682225 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -191,7 +191,8 @@ EXTRA_DIST += test/apitest test/hsplay test/hsmicro test/dbusdef.py \
 		test/test-network test/simple-agent test/simple-service \
 		test/simple-endpoint test/test-audio test/test-input \
 		test/service-record.dtd test/service-did.xml \
-		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
+		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
+		test/test-attrib
 
 
 if HIDD
-- 
1.7.1

