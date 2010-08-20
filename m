Return-Path: <cyrus@holtmann.org>
Message-Id: <201008211248.o7LCmYxO023881@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
Date: Fri, 20 Aug 2010 18:32:05 +0200
Subject: [PATCH 2nd version] Makefile.am fixes
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

vcard.[ch] is not related to pbap, but to phonebook backend
---
 Makefile.am |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 07fc27d..fdc4f7e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -52,8 +52,7 @@ builtin_modules += ftp
 builtin_sources += plugins/ftp.c
 
 builtin_modules += pbap
-builtin_sources += plugins/pbap.c plugins/phonebook.h \
-			plugins/vcard.h plugins/vcard.c
+builtin_sources += plugins/pbap.c
 
 builtin_modules += irmc
 builtin_sources += plugins/irmc.c
@@ -61,6 +60,8 @@ builtin_sources += plugins/irmc.c
 builtin_modules += syncevolution
 builtin_sources += plugins/syncevolution.c
 
+builtin_sources += plugins/phonebook.h plugins/vcard.h plugins/vcard.c
+
 builtin_nodist += plugins/phonebook.c
 
 libexec_PROGRAMS += src/obexd
@@ -99,7 +100,6 @@ src/plugin.$(OBJEXT): src/builtin.h
 
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
-
 endif
 
 if CLIENT
-- 
1.7.2.1

