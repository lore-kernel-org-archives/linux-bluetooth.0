Return-Path: <cyrus@holtmann.org>
Message-ID: <4C447CCD.60409@aircable.net>
Date: Mon, 19 Jul 2010 13:26:53 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 1/2] Add function call tracing
Content-Type: multipart/mixed;
 boundary="------------010705010401060502080504"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010705010401060502080504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds all the necessary functions and code that allow function 
tracing on the bluetoothd server. This should make race conditions and 
seg faults easy to debug. Off course this is not intendeed for end users.

Signed-off-by: Manuel Naranjo <manuel@aircable.net>



--------------010705010401060502080504
Content-Type: text/plain;
 name="0001-Add-Function-call-tracing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-Function-call-tracing.patch"

>From b0f4d8eeab8ee2dba77247b77ee6ce159b931d7b Mon Sep 17 00:00:00 2001
From: Manuel Francisco Naranjo <manuel@aircable.net>
Date: Mon, 19 Jul 2010 13:15:22 -0300
Subject: [PATCH 1/2] Add Function call tracing

modified:   Makefile.am
modified:   acinclude.m4
* Add an option so configure script can be tell to enable function tracing,
  for good function tracing this options need to be used:
    --enable-trace \
    --enable-debug \
    --disable-optimization \
    --disable-fortify \
    --disable-pie

new file:   src/cyg-profile.c
new file:   src/cyg-profile.h
* Based on code from http://www.logix.cz/michal/devel/CygProfiler this uses
  -finstrument-functions from gcc and adds some function to store the tracing
  to a file, which will be called as bluetoothd-log.$PID

modified:   src/main.c
* Allow users to enable or disable tracing (only available when configured with
  this option).
---
 Makefile.am       |    4 +
 acinclude.m4      |   11 ++++
 src/cyg-profile.c |  169 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/cyg-profile.h |   40 +++++++++++++
 src/main.c        |   15 +++++
 5 files changed, 239 insertions(+), 0 deletions(-)
 create mode 100644 src/cyg-profile.c
 create mode 100644 src/cyg-profile.h

diff --git a/Makefile.am b/Makefile.am
index f4bf87d..b146f3f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -216,6 +216,10 @@ CLEANFILES += src/bluetooth.ver src/bluetooth.exp $(builtin_files)
 
 man_MANS = src/bluetoothd.8
 
+if TRACE
+src_bluetoothd_SOURCES += src/cyg-profile.h src/cyg-profile.c
+endif
+
 if CONFIGFILES
 conf_DATA += src/main.conf
 endif
diff --git a/acinclude.m4 b/acinclude.m4
index f5fdd66..99d9e4d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -154,6 +154,7 @@ AC_DEFUN([AC_PATH_SNDFILE], [
 
 AC_DEFUN([AC_ARG_BLUEZ], [
 	debug_enable=no
+	trace_enable=no
 	optimization_enable=yes
 	fortify_enable=yes
 	pie_enable=yes
@@ -288,6 +289,11 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		debug_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(trace, AC_HELP_STRING([--enable-trace], [enable compiling with function tracing information]), [
+		trace_enable=${enableval}
+	])
+
+
 	AC_ARG_WITH(telephony, AC_HELP_STRING([--with-telephony=DRIVER], [select telephony driver]), [
 		telephony_driver=${withval}
 	])
@@ -311,6 +317,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		CFLAGS="$CFLAGS -g"
 	fi
 
+	if (test "${trace_enable}" = "yes" && test "${ac_cv_prog_cc_g}" = "yes"); then
+		CFLAGS="$CFLAGS -finstrument-functions -DTRACE"
+	fi
+
 	if (test "${optimization_enable}" = "no"); then
 		CFLAGS="$CFLAGS -O0"
 	fi
@@ -333,6 +343,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(TRACER, test "${tracer_enable}" = "yes")
+	AM_CONDITIONAL(TRACE, test "${trace_enable}" = "yes")
 	AM_CONDITIONAL(HIDD, test "${hidd_enable}" = "yes")
 	AM_CONDITIONAL(PAND, test "${pand_enable}" = "yes")
 	AM_CONDITIONAL(DUND, test "${dund_enable}" = "yes")
diff --git a/src/cyg-profile.c b/src/cyg-profile.c
new file mode 100644
index 0000000..20f5597
--- /dev/null
+++ b/src/cyg-profile.c
@@ -0,0 +1,169 @@
+/* 
+ * cyg-profile.c - CygProfiler runtime functions.
+ *
+ * Michal Ludvig <michal@logix.cz>
+ * http://www.logix.cz/michal/devel
+ *
+ * cyg-profile.c
+ * - Compile your program with -finstrument-functions and link 
+ *   together with this code.
+ * - Logging is enabled as soon as your program calls
+ *   cygprofile_enable() and disabled with cygprofile_disable().
+ * - Before logging was enabled you can change the name 
+ *   of a logfile by calling cygprofile_setfilename().
+ */
+
+/* Hint: -finstrument-functions, no_instrument_function */
+
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "cyg-profile.h"
+
+#ifdef TRACE
+
+#define FN_SIZE 100
+#define FN_DEFAULT "bluetoothd-log.%d"
+
+/* Private variables.  */
+static int level=0;
+static FILE *logfile=NULL;
+static int cyg_profile_enabled=0;
+static char cyg_profile_filename[FN_SIZE+1];
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* Static functions. */
+static FILE *openlogfile (const char *filename)
+	__attribute__ ((no_instrument_function));
+static void closelogfile (void)
+	__attribute__ ((no_instrument_function));
+
+/* Note that these are linked internally by the compiler. 
+ * Don't call them directly! */
+void __cyg_profile_func_enter (void *this_fn, void *call_site)
+	__attribute__ ((no_instrument_function));
+void __cyg_profile_func_exit (void *this_fn, void *call_site)
+	__attribute__ ((no_instrument_function));
+
+#ifdef __cplusplus
+};
+#endif
+
+void
+__cyg_profile_func_enter (void *this_fn, void *call_site)
+{
+	if(cyg_profile_enabled)
+		if (logfile || openlogfile(cyg_profile_filename))
+			fprintf(logfile, "+ %d %p %p\n", level++, 
+				this_fn, call_site);
+}
+
+void
+__cyg_profile_func_exit (void *this_fn, void *call_site)
+{
+	if(cyg_profile_enabled)
+		if (logfile || openlogfile(cyg_profile_filename))
+			fprintf(logfile, "- %d %p %p\n", level--, 
+				this_fn, call_site);
+}
+
+void
+cygprofile_enable (void)
+{
+	if (!cyg_profile_filename[0])
+		cygprofile_setfilename (FN_DEFAULT);
+	if (!openlogfile (cyg_profile_filename))
+		return;
+	cyg_profile_enabled = 1;
+}
+
+void
+cygprofile_disable (void)
+{
+	cyg_profile_enabled = 0;
+}
+
+int
+cygprofile_isenabled (void)
+{ return cyg_profile_enabled; }
+
+int 
+cygprofile_setfilename (const char *filename)
+{
+	char *ptr;
+
+	if (cygprofile_isenabled ())
+		return -1;
+
+	if (strlen (filename) > FN_SIZE)
+		return -2;
+
+	ptr = strstr (filename, "%d");
+	if (ptr)
+	{
+		size_t len;
+		len = ptr - filename;
+		snprintf (cyg_profile_filename, len+1, "%s", filename);
+		snprintf (&cyg_profile_filename[len], FN_SIZE - len, 
+			"%d", getpid ());
+		len = strlen (cyg_profile_filename);
+		snprintf (&cyg_profile_filename[len], FN_SIZE - len,
+			"%s", ptr + 2);
+	}
+	else
+		snprintf (cyg_profile_filename, FN_SIZE, "%s", filename);
+
+	if (logfile)
+		closelogfile ();
+
+	return 0;
+}
+
+char *
+cygprofile_getfilename (void)
+{
+	if (!cyg_profile_filename[0])
+		cygprofile_setfilename (FN_DEFAULT);
+	return cyg_profile_filename;
+}
+
+static FILE *
+openlogfile (const char *filename)
+{
+	static int complained = 0;
+	FILE *file;
+	
+	if (complained)
+		return NULL;
+	
+	if (logfile)
+		return logfile;
+
+	file = fopen(filename, "w");
+	if (!file)
+	{
+		fprintf (stderr, "WARNING: Can't open logfile '%s': %s\n", 
+			filename, strerror (errno));
+		complained = 1;
+		return NULL;
+	}
+	
+	setlinebuf (file);
+	logfile = file;
+
+	return file;
+}
+
+static void
+closelogfile (void)
+{
+	if (logfile)
+		fclose (logfile);
+}
+
+#endif //#ifdef TRACE
diff --git a/src/cyg-profile.h b/src/cyg-profile.h
new file mode 100644
index 0000000..97be613
--- /dev/null
+++ b/src/cyg-profile.h
@@ -0,0 +1,40 @@
+/* 
+ * cyg-profile.h - Header file for CygProfiler
+ * 
+ * Michal Ludvig <michal@logix.cz>
+ * http://www.logix.cz/michal/devel
+ *
+ * This source code is a public domain.
+ *
+ * See cyg-profile.c for details on usage.
+ */
+
+#ifndef CYG_PROFILE_H
+#define CYG_PROFILE_H
+
+/* Public functions.  */
+
+#ifdef TRACE
+
+/* Enable/disable CygProfiler.  */
+void cygprofile_enable (void)
+	__attribute__ ((no_instrument_function));
+void cygprofile_disable (void)
+	__attribute__ ((no_instrument_function));
+
+/* Tell whether CygProfiler is enabled/disabled.  */
+int cygprofile_isenabled (void)
+	__attribute__ ((no_instrument_function));
+
+/* Set filename of a logfile.  */
+int cygprofile_setfilename (const char *filename)
+	__attribute__ ((no_instrument_function));
+
+/* Query for a filename of a logfile.  */
+char *cygprofile_getfilename (void)
+	__attribute__ ((no_instrument_function));
+
+
+#endif //#ifdef TRACE
+
+#endif
diff --git a/src/main.c b/src/main.c
index 6113217..23a649e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -60,6 +60,10 @@
 #include <cap-ng.h>
 #endif
 
+#ifdef TRACE
+#include "cyg-profile.h"
+#endif
+
 #define LAST_ADAPTER_EXIT_TIMEOUT 30
 
 struct main_opts main_opts;
@@ -304,6 +308,7 @@ static gchar *option_debug = NULL;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
 static gboolean option_udev = FALSE;
+static gboolean option_trace = FALSE;
 
 static guint last_adapter_timeout = 0;
 
@@ -357,6 +362,10 @@ static GOptionEntry options[] = {
 				"Show version information and exit" },
 	{ "udev", 'u', 0, G_OPTION_ARG_NONE, &option_udev,
 				"Run from udev mode of operation" },
+#ifdef TRACE
+	{ "trace", 't', 0, G_OPTION_ARG_NONE, &option_trace,
+				"Create trace function calls file" },
+#endif
 	{ NULL },
 };
 
@@ -393,6 +402,12 @@ int main(int argc, char *argv[])
 
 	g_option_context_free(context);
 
+#ifdef TRACE
+	if (option_trace == TRUE) {
+	    cygprofile_enable();
+	}
+#endif
+
 	if (option_version == TRUE) {
 		printf("%s\n", VERSION);
 		exit(0);
-- 
1.6.4.4


--------------010705010401060502080504--
