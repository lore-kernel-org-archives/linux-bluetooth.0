Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] build: Add missing documentation files to EXTRA_DIST
Date: Tue, 9 Oct 2012 15:51:47 +0200
Message-ID: <1349790707-8464-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds missing documentation files to EXTRA_DIST variable so they
are included when creating tarball.
---
 Makefile.am | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 3b08f9a..dbbd794 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -401,7 +401,9 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
 		doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
-		doc/supported-features.txt doc/alert-api.txt
+		doc/supported-features.txt doc/alert-api.txt doc/mgmt-api.txt \
+		doc/oob-api.txt doc/proximity-api.txt doc/heartrate-api.txt \
+		doc/thermometer-api.txt
 
 AM_YFLAGS = -d
 
-- 
1.7.11.3

