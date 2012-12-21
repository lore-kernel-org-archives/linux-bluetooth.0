Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/4] build: Fix installing udev rules file when $(srcdir) != $(builddir)
Date: Fri, 21 Dec 2012 12:25:03 -0400
Message-Id: <1356107103-18039-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Path to files on source tree should be prefixed with $(srcdir),
otherwise they are not found if $(srcdir) != $(builddir).
---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 350a9e8..8852e04 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -278,7 +278,7 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
 tools/%.rules:
-	$(AM_V_GEN)cp $(subst 97-,,$@) $@
+	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 
 $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
-- 
1.7.9.5

