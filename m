Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH] obexd: enable ebook backend conditionally
Date: Wed, 16 Sep 2015 07:54:01 +0200
Message-Id: <1442382841-25729-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EDS support was sitting around but wasn't usable cause it was not included
in the build configuration. It is now put behind an additional configure
switch. By default still the dummy backend is used.
---
 Makefile.obexd | 12 ++++++++----
 configure.ac   | 12 ++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 2e33cbc..16aff59 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -39,8 +39,12 @@ obexd_builtin_sources += obexd/plugins/irmc.c
 obexd_builtin_modules += pbap
 obexd_builtin_sources += obexd/plugins/pbap.c \
 				obexd/plugins/vcard.h obexd/plugins/vcard.c \
-				obexd/plugins/phonebook.h \
-				obexd/plugins/phonebook-dummy.c
+				obexd/plugins/phonebook.h
+if PHONEBOOK_EBOOK
+obexd_builtin_sources += obexd/plugins/phonebook-ebook.c
+else
+obexd_builtin_sources += obexd/plugins/phonebook-dummy.c
+endif
 endif
 
 obexd_builtin_modules += mas
@@ -81,12 +85,12 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/src/map_ap.h
 obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
-			@ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
+			@ICAL_LIBS@ @EBOOK_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
 
 obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
 
 obexd_src_obexd_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
-				@ICAL_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
+				@ICAL_CFLAGS@ @EBOOK_CFLAGS@ -DOBEX_PLUGIN_BUILTIN \
 				-DPLUGINDIR=\""$(obex_plugindir)"\" \
 				-fPIC -D_FILE_OFFSET_BITS=64
 
diff --git a/configure.ac b/configure.ac
index 92b468d..12dffd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -166,6 +166,11 @@ AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 
+AC_ARG_ENABLE(phonebook-ebook, AC_HELP_STRING([--enable-phonebook-ebook],
+		[disable Phonebook support through EDS]),
+		[enable_phonebook_ebook=${enableval}])
+AM_CONDITIONAL(PHONEBOOK_EBOOK, test "${enable_phonebook_ebook}" = "yes")
+
 AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
 		[disable OBEX profile support]), [enable_obex=${enableval}])
 if (test "${enable_obex}" != "no"); then
@@ -173,6 +178,13 @@ if (test "${enable_obex}" != "no"); then
 					AC_MSG_ERROR(libical is required))
 	AC_SUBST(ICAL_CFLAGS)
 	AC_SUBST(ICAL_LIBS)
+
+	if (test "${enable_phonebook_ebook}" = "yes"); then
+		PKG_CHECK_MODULES(EBOOK, libebook-1.2, dummy=yes,
+					AC_MSG_ERROR(libebook is required))
+		AC_SUBST(EBOOK_CFLAGS)
+		AC_SUBST(EBOOK_LIBS)
+	fi
 fi
 AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
 
-- 
2.1.4

