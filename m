Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix "make distcheck" when libbluetooth is not installed
Date: Wed, 20 Jul 2011 19:23:41 -0300
Message-Id: <1311200621-2073-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Recently, the audio plugin began to include <bluetooth/sdp.h>. This only
works after the symbolic links in lib/bluetooth/ have been created (or
the BlueZ headers are installed on /usr/include). The BUILT_SOURCES
automake variable can be used to force generating these symlinks prior
to other build targets.
---
 Makefile.am |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 52c49fb..9f4e43f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -64,6 +64,7 @@ lib_libbluetooth_la_DEPENDENCIES = $(local_headers)
 
 CLEANFILES += $(local_headers)
 
+BUILT_SOURCES = $(local_headers)
 
 if SBC
 noinst_LTLIBRARIES += sbc/libsbc.la
-- 
1.7.0.4

