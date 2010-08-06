Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-bluetooth@vger.kernel.org
Date: Fri,  6 Aug 2010 16:18:03 +0200
Message-Id: <1281104283-8792-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1281104283-8792-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281104283-8792-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 2/2] add three missing api documents to EXTRA_DIST
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

there are still a few files in bluez.git/doc that are not listed in EXTRA_DIST:

 - bluez-docs.xml
 - gtk-doc.make
 - version.xml.in

I didn't know if I should add these, too, so I just point that out.

Best regards
Uwe

 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4bb82fe..7007026 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -316,9 +316,12 @@ EXTRA_DIST += \
 	      doc/audio-api.txt \
 	      doc/control-api.txt \
 	      doc/device-api.txt \
+	      doc/health-api.txt \
+	      doc/hfp-api.txt \
 	      doc/input-api.txt \
 	      doc/manager-api.txt \
 	      doc/network-api.txt \
+	      doc/node-api.txt \
 	      doc/serial-api.txt \
 	      doc/service-api.txt \
 
-- 
1.7.1

