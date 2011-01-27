Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Add Health API document to distribution package
Date: Thu, 27 Jan 2011 13:35:34 -0200
Message-Id: <1296142534-19809-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5f96975..e6639a7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -354,7 +354,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/health-api.txt doc/assigned-numbers.txt
 
 AM_YFLAGS = -d
 
-- 
1.7.1

