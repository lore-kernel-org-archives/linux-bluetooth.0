Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/2] build: Do not set CFLAGS/LDFLAGS directly
Date: Wed,  9 May 2012 09:06:17 -0300
Message-Id: <1336565177-1532-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1336565177-1532-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336565177-1532-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Set a separate variable for adding warning flags, optimization, etc.
Build systems are not supposed to change CFLAGS and LDFLAGS, these are
user variables.

Doing so we guarantee CFLAGS and LDFLAGS from environment is appended
to the flags used during build. One useful use-case is to temporarily
disable -Werror when using --enable-maintainer-mode, without completely
loosing the warning flags and other parameters in CFLAGS (like -fPIC).

Without this patch, fiddling with CFLAGS/LDFLAGS after configure may
result in errors like below:

/usr/bin/ld: tools/rfcomm.o: relocation R_X86_64_32 against `.bss' can
not be used when making a shared object; recompile with -fPIC
tools/rfcomm.o: could not read symbols: Bad value
collect2: error: ld returned 1 exit status
make[1]: *** [tools/rfcomm] Error 1
make: *** [all] Error 2

Reference: http://www.gnu.org/software/automake/manual/html_node/Flag-Variables-Ordering.html
---

This is a similar patch to what has been landed in kmod and systemd recently:

http://git.kernel.org/?p=utils/kernel/kmod/kmod.git;a=commitdiff;h=e48f37657dc03aee9aace60bf14ef9af489bf47c
http://cgit.freedesktop.org/systemd/systemd/commit/?id=eb2e280f9c59b66965c9316eadc4c113a13ca744

 Makefile.am  |   22 ++++++++++++++--------
 acinclude.m4 |   38 ++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 1d8eea2..a912104 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -25,6 +25,9 @@ includedir = @includedir@/bluetooth
 
 include_HEADERS =
 
+AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS)
+AM_LDFLAGS = $(MISC_LDFLAGS)
+
 if DATAFILES
 dbusdir = $(sysconfdir)/dbus-1/system.d
 
@@ -70,7 +73,7 @@ lib_LTLIBRARIES += lib/libbluetooth.la
 
 lib_libbluetooth_la_SOURCES = $(lib_headers) \
 				lib/bluetooth.c lib/hci.c lib/sdp.c lib/uuid.c
-lib_libbluetooth_la_LDFLAGS = -version-info 15:0:12
+lib_libbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -version-info 15:0:12
 lib_libbluetooth_la_DEPENDENCIES = $(local_headers)
 
 noinst_LTLIBRARIES += lib/libbluetooth-private.la
@@ -270,7 +273,8 @@ endif
 if MAINTAINER_MODE
 plugin_LTLIBRARIES += plugins/external-dummy.la
 plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
-plugins_external_dummy_la_LDFLAGS = -module -avoid-version -no-undefined
+plugins_external_dummy_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
+				    -no-undefined
 plugins_external_dummy_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
 
@@ -301,7 +305,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/oob.h src/oob.c src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl -lrt
-src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
+src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-private.la
@@ -338,14 +342,16 @@ alsa_LTLIBRARIES = audio/libasound_module_pcm_bluetooth.la \
 
 audio_libasound_module_pcm_bluetooth_la_SOURCES = audio/pcm_bluetooth.c \
 					audio/rtp.h audio/ipc.h audio/ipc.c
-audio_libasound_module_pcm_bluetooth_la_LDFLAGS = -module -avoid-version #-export-symbols-regex [_]*snd_pcm_.*
+audio_libasound_module_pcm_bluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module \
+						  -avoid-version
 audio_libasound_module_pcm_bluetooth_la_LIBADD = sbc/libsbc.la \
 					lib/libbluetooth-private.la @ALSA_LIBS@
 audio_libasound_module_pcm_bluetooth_la_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@
 
 audio_libasound_module_ctl_bluetooth_la_SOURCES = audio/ctl_bluetooth.c \
 					audio/rtp.h audio/ipc.h audio/ipc.c
-audio_libasound_module_ctl_bluetooth_la_LDFLAGS = -module -avoid-version #-export-symbols-regex [_]*snd_ctl_.*
+audio_libasound_module_ctl_bluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module \
+						  -avoid-versionv
 audio_libasound_module_ctl_bluetooth_la_LIBADD = \
 					lib/libbluetooth-private.la @ALSA_LIBS@
 audio_libasound_module_ctl_bluetooth_la_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@
@@ -372,12 +378,12 @@ audio_libgstbluetooth_la_SOURCES = audio/gstbluetooth.c audio/gstpragma.h \
 				audio/gstsbcutil.h audio/gstsbcutil.c \
 				audio/gstrtpsbcpay.h audio/gstrtpsbcpay.c \
 				audio/rtp.h audio/ipc.h audio/ipc.c
-audio_libgstbluetooth_la_LDFLAGS = -module -avoid-version
+audio_libgstbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
 audio_libgstbluetooth_la_LIBADD = sbc/libsbc.la lib/libbluetooth-private.la \
 						@DBUS_LIBS@ @GSTREAMER_LIBS@ \
 						-lgstaudio-0.10 -lgstrtp-0.10
 audio_libgstbluetooth_la_CFLAGS = -fvisibility=hidden -fno-strict-aliasing \
-				$(AM_CFLAGS) @DBUS_CFLAGS@ @GSTREAMER_CFLAGS@
+                               $(AM_CFLAGS) @DBUS_CFLAGS@ @GSTREAMER_CFLAGS@
 endif
 endif
 
@@ -420,7 +426,7 @@ EXTRA_DIST += doc/manager-api.txt \
 
 AM_YFLAGS = -d
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@
+AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@
 
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
diff --git a/acinclude.m4 b/acinclude.m4
index dcf9a48..6505ad3 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -11,19 +11,19 @@ AC_DEFUN([AC_PROG_CC_PIE], [
 ])
 
 AC_DEFUN([COMPILER_FLAGS], [
-	if (test "${CFLAGS}" = ""); then
-		CFLAGS="-Wall -O2"
-	fi
+	with_cflags=""
 	if (test "$USE_MAINTAINER_MODE" = "yes"); then
-		CFLAGS="$CFLAGS -Werror -Wextra"
-		CFLAGS="$CFLAGS -Wno-unused-parameter"
-		CFLAGS="$CFLAGS -Wno-missing-field-initializers"
-		CFLAGS="$CFLAGS -Wdeclaration-after-statement"
-		CFLAGS="$CFLAGS -Wmissing-declarations"
-		CFLAGS="$CFLAGS -Wredundant-decls"
-		CFLAGS="$CFLAGS -Wcast-align"
-		CFLAGS="$CFLAGS -DG_DISABLE_DEPRECATED"
+		with_cflags="$with_cflags -Wall -Werror -Wextra"
+		with_cflags="$with_cflags -Wno-unused-parameter"
+		with_cflags="$with_cflags -Wno-missing-field-initializers"
+		with_cflags="$with_cflags -Wdeclaration-after-statement"
+		with_cflags="$with_cflags -Wmissing-declarations"
+		with_cflags="$with_cflags -Wredundant-decls"
+		with_cflags="$with_cflags -Wcast-align"
+		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
 	fi
+
+	AC_SUBST([WARNING_CFLAGS], $with_cflags)
 ])
 
 AC_DEFUN([AC_FUNC_PPOLL], [
@@ -339,23 +339,29 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		gatt_enable=${enableval}
 	])
 
+	misc_cflags=""
+	misc_ldflags=""
+
 	if (test "${fortify_enable}" = "yes"); then
-		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
+		misc_cflags="$misc_cflags -D_FORTIFY_SOURCE=2"
 	fi
 
 	if (test "${pie_enable}" = "yes" && test "${ac_cv_prog_cc_pie}" = "yes"); then
-		CFLAGS="$CFLAGS -fPIC"
-		LDFLAGS="$LDFLAGS -pie"
+		misc_cflags="$misc_cflags -fPIC"
+		misc_ldflags="$misc_ldflags -pie"
 	fi
 
 	if (test "${debug_enable}" = "yes" && test "${ac_cv_prog_cc_g}" = "yes"); then
-		CFLAGS="$CFLAGS -g"
+		misc_cflags="$misc_cflags -g"
 	fi
 
 	if (test "${optimization_enable}" = "no"); then
-		CFLAGS="$CFLAGS -O0"
+		misc_cflags="$misc_cflags -O0"
 	fi
 
+	AC_SUBST([MISC_CFLAGS], $misc_cflags)
+	AC_SUBST([MISC_LDLAGS], $misc_ldlags)
+
 	if (test "${usb_enable}" = "yes" && test "${usb_found}" = "yes"); then
 		AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])
 	fi
-- 
1.7.10.1

