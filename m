Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 18/20] build: Add CSCP API document to EXTRA_DIST
Date: Tue, 4 Dec 2012 13:43:44 +0100
Message-ID: <1354625026-29358-19-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d009828..2e0e9b2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -342,7 +342,8 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
 		doc/supported-features.txt doc/alert-api.txt doc/mgmt-api.txt \
 		doc/oob-api.txt doc/proximity-api.txt doc/heartrate-api.txt \
-		doc/thermometer-api.txt doc/audio-telephony-design.txt
+		doc/thermometer-api.txt doc/audio-telephony-design.txt \
+		doc/cyclingspeed-api.txt
 
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
-- 
1.8.0

