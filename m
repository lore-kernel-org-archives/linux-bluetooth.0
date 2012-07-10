Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 4/5] build: Fix make distcheck
Date: Tue, 10 Jul 2012 15:08:23 -0300
Message-Id: <1341943704-23633-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"proximity/proximity.conf" doesn't exist anymore, it was moved to
"profiles/proximity/proximity.conf".
---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index f9caeb8..84bf695 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,7 +319,7 @@ endif
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
 			src/main.conf profiles/network/network.conf \
-			profiles/input/input.conf proximity/proximity.conf \ \
+			profiles/input/input.conf profiles/proximity/proximity.conf \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
 			audio/telephony-maemo6.c profiles/sap/sap-dummy.c \
-- 
1.7.10.4

