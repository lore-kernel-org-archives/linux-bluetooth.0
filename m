Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tadas Dailyda <tadas@dailyda.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-6OiPlC0TvjTiVbEnplOP"
Date: Thu, 21 Jun 2007 21:10:21 +0300
Message-Id: <1182449421.10358.3.camel@VAIO>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] bluez-libs patch to include bachk() function
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-6OiPlC0TvjTiVbEnplOP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-6OiPlC0TvjTiVbEnplOP
Content-Disposition: attachment; filename=bachk.patch
Content-Type: text/x-patch; name=bachk.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: include/bluetooth.h
===================================================================
RCS file: /cvsroot/bluez/libs/include/bluetooth.h,v
retrieving revision 1.27
diff -u -r1.27 bluetooth.h
--- include/bluetooth.h	13 Jan 2007 17:50:06 -0000	1.27
+++ include/bluetooth.h	21 Jun 2007 17:45:10 -0000
@@ -125,6 +125,7 @@
 int ba2str(const bdaddr_t *ba, char *str);
 int str2ba(const char *str, bdaddr_t *ba);
 int ba2oui(const bdaddr_t *ba, char *oui);
+int bachk(const char *str);
 
 int baprintf(const char *format, ...);
 int bafprintf(FILE *stream, const char *format, ...);
Index: src/bluetooth.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/bluetooth.c,v
retrieving revision 1.41
diff -u -r1.41 bluetooth.c
--- src/bluetooth.c	20 Jun 2007 15:34:46 -0000	1.41
+++ src/bluetooth.c	21 Jun 2007 17:45:11 -0000
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <malloc.h>
 #include <string.h>
+#include <ctype.h>
 #include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
@@ -110,6 +111,38 @@
 	return sprintf(str, "%2.2X-%2.2X-%2.2X", b[0], b[1], b[2]);
 }
 
+int bachk(const char *str)
+{
+	char tmp[18];
+	char *ptr = tmp;
+
+	if (!str)
+		return -1;
+	if (strlen(str) != 17)
+		return -1;
+
+	memcpy(tmp, str, 18);
+
+	while (*ptr) {
+		*ptr = toupper(*ptr);
+		if (*ptr < '0'|| (*ptr > '9' && *ptr < 'A') || *ptr > 'F')
+			return -1;
+		ptr++;
+		*ptr = toupper(*ptr);
+		if (*ptr < '0'|| (*ptr > '9' && *ptr < 'A') || *ptr > 'F')
+			return -1;
+		ptr++;
+		*ptr = toupper(*ptr);
+		if (*ptr == 0)
+			break;
+		if (*ptr != ':')
+			return -1;
+		ptr++;
+	}
+
+	return 0;
+}
+
 int baprintf(const char *format, ...)
 {
 	va_list ap;

--=-6OiPlC0TvjTiVbEnplOP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-6OiPlC0TvjTiVbEnplOP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-6OiPlC0TvjTiVbEnplOP--
