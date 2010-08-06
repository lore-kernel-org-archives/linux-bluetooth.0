Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-bluetooth@vger.kernel.org
Date: Fri,  6 Aug 2010 16:18:02 +0200
Message-Id: <1281104283-8792-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/2] list api docs alphabetically and one per line in EXTRA_DIST
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes further changes to the list easier to review

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Makefile.am |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 65d4312..4bb82fe 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -309,11 +309,18 @@ udevdir = $(libexecdir)/udev
 dist_udev_SCRIPTS = scripts/bluetooth_serial
 endif
 
-EXTRA_DIST += doc/manager-api.txt \
-		doc/adapter-api.txt doc/device-api.txt \
-		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
-		doc/serial-api.txt doc/network-api.txt \
-		doc/input-api.txt doc/audio-api.txt doc/control-api.txt
+EXTRA_DIST += \
+	      doc/adapter-api.txt \
+	      doc/agent-api.txt \
+	      doc/attribute-api.txt \
+	      doc/audio-api.txt \
+	      doc/control-api.txt \
+	      doc/device-api.txt \
+	      doc/input-api.txt \
+	      doc/manager-api.txt \
+	      doc/network-api.txt \
+	      doc/serial-api.txt \
+	      doc/service-api.txt \
 
 AM_YFLAGS = -d
 
-- 
1.7.1

