Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/4] Remove PulseAudio plugin leftover
Date: Fri, 30 Dec 2011 15:26:08 -0400
Message-Id: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The .c file and the configure check were not being used anywhere.
---
 acinclude.m4                  |    6 ------
 audio/module-bluetooth-sink.c |   39 ---------------------------------------
 2 files changed, 0 insertions(+), 45 deletions(-)
 delete mode 100644 audio/module-bluetooth-sink.c

diff --git a/acinclude.m4 b/acinclude.m4
index 753b994..e86823a 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -124,12 +124,6 @@ AC_DEFUN([AC_PATH_GSTREAMER], [
 	AC_SUBST(GSTREAMER_PLUGINSDIR)
 ])
 
-AC_DEFUN([AC_PATH_PULSE], [
-	PKG_CHECK_MODULES(PULSE, libpulse, pulse_found=yes, pulse_found=no)
-	AC_SUBST(PULSE_CFLAGS)
-	AC_SUBST(PULSE_LIBS)
-])
-
 AC_DEFUN([AC_PATH_ALSA], [
 	PKG_CHECK_MODULES(ALSA, alsa, alsa_found=yes, alsa_found=no)
 	AC_CHECK_LIB(rt, clock_gettime, ALSA_LIBS="$ALSA_LIBS -lrt", alsa_found=no)
diff --git a/audio/module-bluetooth-sink.c b/audio/module-bluetooth-sink.c
deleted file mode 100644
index a0117c0..0000000
--- a/audio/module-bluetooth-sink.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#if 0
-#include <pulsecore/module.h>
-
-PA_MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>")
-PA_MODULE_DESCRIPTION("Bluetooth sink")
-PA_MODULE_VERSION(VERSION)
-
-int pa__init(pa_core *core, pa_module *module)
-{
-	return 0;
-}
-#endif
-- 
1.7.0.4

