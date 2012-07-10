Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/5] build: Fix typo
Date: Tue, 10 Jul 2012 15:08:20 -0300
Message-Id: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"profiles_sap" should be "profiles/sap".
---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d922f2f..d65b28c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -168,7 +168,7 @@ builtin_nodist += profiles/sap/sap.c
 
 noinst_LIBRARIES += profiles/sap/libsap.a
 
-profiles_sap_libsap_a_SOURCES = profiles_sap/sap.h profiles/sap/sap-dummy.c \
+profiles_sap_libsap_a_SOURCES = profiles/sap/sap.h profiles/sap/sap-dummy.c \
 				profiles/sap/sap-u8500.c
 endif
 
-- 
1.7.10.4

