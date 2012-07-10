Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 5/5] build: Fix make distcheck
Date: Tue, 10 Jul 2012 15:08:24 -0300
Message-Id: <1341943704-23633-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The gstreamer module needs audio/rtp.h to exist in the distribution.
---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 84bf695..ffb57e8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -337,7 +337,7 @@ audio_libgstbluetooth_la_SOURCES = audio/gstbluetooth.c audio/gstpragma.h \
 				audio/gstsbcparse.h audio/gstsbcparse.c \
 				audio/gstavdtpsink.h audio/gstavdtpsink.c \
 				audio/gsta2dpsink.h audio/gsta2dpsink.c \
-				audio/gstsbcutil.h audio/gstsbcutil.c \
+				audio/gstsbcutil.h audio/gstsbcutil.c audio/rtp.h \
 				audio/gstrtpsbcpay.h audio/gstrtpsbcpay.c
 audio_libgstbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
 audio_libgstbluetooth_la_LIBADD = sbc/libsbc.la lib/libbluetooth-private.la \
-- 
1.7.10.4

