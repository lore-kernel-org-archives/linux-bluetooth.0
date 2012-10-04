Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/2] build-sys: Don't use deprecated INCLUDES variable
Date: Thu,  4 Oct 2012 03:37:10 -0300
Message-Id: <1349332630-8901-2-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349332630-8901-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349332630-8901-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Makefile.am:410: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
---
 Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index dea207e..3b08f9a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,13 +407,13 @@ AM_YFLAGS = -d
 
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 
-INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
+AM_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
 			-I$(srcdir)/attrib -I$(srcdir)/btio -I$(srcdir)/tools \
 			-I$(builddir)/tools -I$(srcdir)/monitor
 
 if MCAP
-INCLUDES += -I$(builddir)/health
+AM_CPPFLAGS += -I$(builddir)/health
 endif
 
 unit_objects =
-- 
1.7.12.2

