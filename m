Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 18/20] build: Add CSCP API document to EXTRA_DIST
Date: Mon, 5 Nov 2012 09:55:03 +0100
Message-ID: <1352105705-13988-19-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 092ac6f..d2dc65e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -412,7 +412,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
 		doc/supported-features.txt doc/alert-api.txt doc/mgmt-api.txt \
 		doc/oob-api.txt doc/proximity-api.txt doc/heartrate-api.txt \
-		doc/thermometer-api.txt
+		doc/thermometer-api.txt doc/cyclingspeed-api.txt
 
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
-- 
1.8.0

