Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4321BDC2.70404@tcs.hut.fi>
From: Ville Nuorvala <vnuorval@tcs.hut.fi>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------000504040705060206090604"
Subject: [Bluez-devel] [PATCH] Fix infinite loops in textfile.c
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 09 Sep 2005 19:52:18 +0300

This is a multi-part message in MIME format.
--------------000504040705060206090604
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

both textfile_put() and textfile_get() go into inifinite loops if a 
string matching the search key is found anywhere except at the beginning 
of a line.

Both functions may also get false positive matches if the search key 
forms a substring of some other key in the same file.

The attached patch fixes both problems, but I can split it up into two 
separate parts if you wish.

Regards,
Ville
-- 
Ville Nuorvala
Research Assistant,
Laboratory for Theoretical Computer Science,
Helsinki University of Technology
email: vnuorval@tcs.hut.fi, phone: +358 (0)9 451 5257

--------------000504040705060206090604
Content-Type: text/x-patch;
 name="infinite_loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="infinite_loop.patch"

Index: common/textfile.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/textfile.c,v
retrieving revision 1.7
diff -u -r1.7 textfile.c
--- common/textfile.c	7 Sep 2005 17:31:56 -0000	1.7
+++ common/textfile.c	9 Sep 2005 15:31:10 -0000
@@ -113,6 +113,15 @@
 	return err;
 }
 
+static inline char *find_key(char *map, char *key, size_t len)
+{
+	char *off = strstr(map, key);
+
+	while (off && ((off > map && *(off - 1) != '\r' && *(off - 1) != '\n') || *(off + len) != ' '))
+		off = strstr(off + len, key);
+	return off;
+}
+
 int textfile_put(char *pathname, char *key, char *value)
 {
 	struct stat st;
@@ -148,7 +157,7 @@
 		goto unlock;
 	}
 
-	off = strstr(map, key);
+	off = find_key(map, key, strlen(key));
 	if (!off) {
 		munmap(map, size);
 		pos = lseek(fd, size, SEEK_SET);
@@ -156,18 +165,6 @@
 		goto unlock;
 	}
 
-	if (off > map) {
-		while (*(off - 1) != '\r' && *(off - 1) != '\n') {
-			off = strstr(off, key);
-			if (!off) {
-				munmap(map, size);
-				pos = lseek(fd, size, SEEK_SET);
-				err = write_key_value(fd, key, value);
-				goto unlock;
-			}
-		}
-	}
-
 	base = off - map;
 
 	end = strpbrk(off, "\r\n");
@@ -254,29 +251,19 @@
 		goto unlock;
 	}
 
-	off = strstr(map, key);
+	len = strlen(key);
+	off = find_key(map, key, len);
 	if (!off) {
 		err = EILSEQ;
 		goto unmap;
 	}
 
-	if (off > map) {
-		while (*(off - 1) != '\r' && *(off - 1) != '\n') {
-			off = strstr(off, key);
-			if (!off) {
-				err = EILSEQ;
-				goto unmap;
-			}
-		}
-	}
-
 	end = strpbrk(off, "\r\n");
 	if (!end) {
 		err = EILSEQ;
 		goto unmap;
 	}
 
-	len = strlen(key);
 	str = malloc(end - off - len);
 	if (!str) {
 		err = EILSEQ;

--------------000504040705060206090604--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
