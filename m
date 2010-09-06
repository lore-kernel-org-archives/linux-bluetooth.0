Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Make the path to oui.txt a compile-time option
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-O5Tov7ODVEfsNoW6Emrb"
Date: Mon, 06 Sep 2010 15:47:12 +0100
Message-ID: <1283784432.7529.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-O5Tov7ODVEfsNoW6Emrb
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

We've been carrying a similar (but hard-coded) patch in Fedora for a
long while, and it would be nice if we could do this properly upstream
instead.

Patch attached with explanations.

Cheers

--=-O5Tov7ODVEfsNoW6Emrb
Content-Disposition: attachment; filename="0001-Make-the-path-to-oui.txt-a-compile-time-option.patch"
Content-Type: text/x-patch; name="0001-Make-the-path-to-oui.txt-a-compile-time-option.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From b96d9394aa850be86ca368aeaeec3bc24c00bce1 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 6 Sep 2010 15:43:48 +0100
Subject: [PATCH] Make the path to oui.txt a compile-time option

This avoids bluetoothd trying to load oui.txt from multiple locations
and cause SELinux AVC denials by accessing files it's not supposed
to touch.
---
 acinclude.m4 |    8 ++++++++
 configure.ac |    1 +
 src/oui.c    |   14 +++-----------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index b34f08d..a4e5e2f 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -152,6 +152,14 @@ AC_DEFUN([AC_PATH_SNDFILE], [
 	AC_SUBST(SNDFILE_LIBS)
 ])
 
+AC_DEFUN([AC_PATH_OUI], [
+	AC_ARG_WITH(ouifile,
+		    AS_HELP_STRING([--with-ouifile=PATH],[Path to the oui.txt file @<:@auto@:>@]),
+		    [ac_with_ouifile=$withval],
+		    [ac_with_ouifile="/var/lib/misc/oui.txt"])
+	AC_DEFINE_UNQUOTED(OUIFILE, ["$ac_with_ouifile"], [Define the OUI file path])
+])
+
 AC_DEFUN([AC_ARG_BLUEZ], [
 	debug_enable=no
 	optimization_enable=yes
diff --git a/configure.ac b/configure.ac
index e8abfe9..74acf31 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,7 @@ AC_PATH_ALSA
 AC_PATH_GSTREAMER
 AC_PATH_USB
 AC_PATH_SNDFILE
+AC_PATH_OUI
 
 AC_ARG_BLUEZ
 
diff --git a/src/oui.c b/src/oui.c
index 1096d20..80bb3d3 100644
--- a/src/oui.c
+++ b/src/oui.c
@@ -38,23 +38,15 @@
 
 /* http://standards.ieee.org/regauth/oui/oui.txt */
 
-#define OUIFILE "/var/lib/misc/oui.txt"
-
 char *ouitocomp(const char *oui)
 {
 	struct stat st;
 	char *str, *map, *off, *end;
 	int fd;
 
-	fd = open("oui.txt", O_RDONLY);
-	if (fd < 0) {
-		fd = open(OUIFILE, O_RDONLY);
-		if (fd < 0) {
-			fd = open("/usr/share/misc/oui.txt", O_RDONLY);
-			if (fd < 0)
-				return NULL;
-		}
-	}
+	fd = open(OUIFILE, O_RDONLY);
+	if (fd < 0)
+		return NULL;
 
 	if (fstat(fd, &st) < 0) {
 		close(fd);
-- 
1.7.0.1


--=-O5Tov7ODVEfsNoW6Emrb--

