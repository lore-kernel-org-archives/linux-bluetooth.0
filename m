Return-Path: <cyrus@holtmann.org>
From: Zygo Blaxell <zygo.blaxell@xandros.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zygo Blaxell <zygo.blaxell@xandros.com>
Subject: [PATCH] Add test-network to dist
Date: Thu,  4 Jun 2009 16:05:38 -0400
Message-Id: <1244145939-32456-2-git-send-email-zygo.blaxell@xandros.com>
In-Reply-To: <1244145939-32456-1-git-send-email-zygo.blaxell@xandros.com>
References: <1244145939-32456-1-git-send-email-zygo.blaxell@xandros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index a9247a0..12d560a 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -44,7 +44,7 @@ INCLUDES = -I$(top_srcdir)/common
 EXTRA_DIST = apitest hsplay hsmicro bdaddr.8 dbusdef.py monitor-bluetooth \
 		list-devices test-discovery test-manager test-adapter \
 		test-device test-service test-serial test-telephony \
-		simple-agent simple-service  service-record.dtd \
+		test-network simple-agent simple-service  service-record.dtd \
 		service-did.xml service-spp.xml service-opp.xml service-ftp.xml
 
 MAINTAINERCLEANFILES = Makefile.in
-- 
1.5.6.5

