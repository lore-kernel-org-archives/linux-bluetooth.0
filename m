Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH v2] obexd: restore phonebook driver selection
Date: Wed, 16 Sep 2015 15:29:42 +0200
Message-Id: <1442410182-27831-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When obexd was still a separate component we had a configure switch to
select which drive we use to provide phonebook backend support. This
was lost in when obexd was moved directly into the bluez source tree.
This brings the support back and makes the ebook driver usable again.
---
 Makefile.obexd | 16 ++++++++++++----
 configure.ac   | 26 +++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 2e33cbc..62cffd0 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -39,8 +39,16 @@ obexd_builtin_sources += obexd/plugins/irmc.c
 obexd_builtin_modules += pbap
 obexd_builtin_sources += obexd/plugins/pbap.c \
 				obexd/plugins/vcard.h obexd/plugins/vcard.c \
-				obexd/plugins/phonebook.h \
-				obexd/plugins/phonebook-dummy.c
+				obexd/plugins/phonebook.h
+
+obexd/plugins/phonebook.c: obexd/plugins/@PHONEBOOK_DRIVER@
+	$(AM_V_GEN)$(LN_S) @abs_top_srcdir@/$< $@
+
+obexd_builtin_nodist += obexd/plugins/phonebook.c
+
+EXTRA_DIST += obexd/plugins/phonebook-dummy.c \
+	obexd/plugins/phonebook-ebook.c
+
 endif
 
 obexd_builtin_modules += mas
@@ -81,12 +89,12 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
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
index 92b468d..04e1d8d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -166,13 +166,33 @@ AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 
+phonebook_driver=dummy
+AC_ARG_WITH(phonebook, AC_HELP_STRING([--with-phonebook=DRIVER], [select phonebook driver]), [
+	if (test "${withval}" = "no"); then
+		phonebook_driver=dummy;
+	else
+		phonebook_driver=${withval};
+	fi
+])
+AC_SUBST([PHONEBOOK_DRIVER], [phonebook-${phonebook_driver}.c])
+
 AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
 		[disable OBEX profile support]), [enable_obex=${enableval}])
 if (test "${enable_obex}" != "no"); then
-	PKG_CHECK_MODULES(ICAL, libical, dummy=yes,
+
+	if (test "${phonebook_driver}" = "dummy"); then
+		PKG_CHECK_MODULES(ICAL, libical, dummy=yes,
 					AC_MSG_ERROR(libical is required))
-	AC_SUBST(ICAL_CFLAGS)
-	AC_SUBST(ICAL_LIBS)
+		AC_SUBST(ICAL_CFLAGS)
+		AC_SUBST(ICAL_LIBS)
+	fi
+
+	if (test "${phonebook_driver}" = "ebook"); then
+		PKG_CHECK_MODULES(EBOOK, libebook-1.2, dummy=yes,
+					AC_MSG_ERROR(libebook is required))
+		AC_SUBST(EBOOK_CFLAGS)
+		AC_SUBST(EBOOK_LIBS)
+	fi
 fi
 AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
 
-- 
2.1.4

