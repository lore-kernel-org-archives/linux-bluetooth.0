Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4430C7C3.5050205@service2media.com>
From: Herman Meerlo <herman@service2media.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------050501020907030302010300"
Subject: [Bluez-devel] Segmentation fault hcid in textfile.c
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
Date: Mon, 03 Apr 2006 08:59:15 +0200

This is a multi-part message in MIME format.
--------------050501020907030302010300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

this weekend I have been testing with a directional antenna and 
therefore I have seen a lot of bluetooth devices. I have witnessed a 
segmentation fault in common/textfile.c twice. After examining the core 
file of the hcid I found out where the problem is and I have made a 
patch for it.
The problem is that the textfile is mapped into memory with an mmap call 
on line 153, but the file I was writing to (once it was the lastseen 
file and once the names file) was exactly 8192 bytes. So an exact 
multiple of the page size. Therefore there is no terminating NULL 
character in the memory map and the find_key call on line 159, which 
uses a strstr, will read beyond the boundaries of the memory mapped 
segment -> SEGV.
I have made a change to the find_key call and added an extra parameter 
to indicate the length of the map. It works fine for me but maybe it is 
not an optimal solution. I have attached the patch.

Regards,
Herman Meerlo

--------------050501020907030302010300
Content-Type: text/plain;
 name="hcid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid.patch"

Index: textfile.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/textfile.c,v
retrieving revision 1.16
diff -u -r1.16 textfile.c
--- textfile.c	24 Mar 2006 14:36:28 -0000	1.16
+++ textfile.c	3 Apr 2006 06:58:46 -0000
@@ -86,9 +86,17 @@
 	return 0;
 }
 
-static inline char *find_key(char *map, const char *key, size_t len)
+static inline char *find_key(char *map, size_t maplen, const char *key, size_t len)
 {
-	char *off = strstr(map, key);
+	char *off = NULL;
+	int start=0;
+	while (start < (maplen - len)) {
+		if (0 == strncmp(map+start, key, len)) {
+			off = map + start;
+			break;
+		}
+		start++;
+	}
 
 	while (off && ((off > map && *(off - 1) != '\r' &&
 				*(off - 1) != '\n') || *(off + len) != ' '))
@@ -156,7 +164,7 @@
 		goto unlock;
 	}
 
-	off = find_key(map, key, strlen(key));
+	off = find_key(map, size, key, strlen(key));
 	if (!off) {
 		if (value) {
 			munmap(map, size);
@@ -265,7 +273,7 @@
 	}
 
 	len = strlen(key);
-	off = find_key(map, key, len);
+	off = find_key(map, size, key, len);
 	if (!off) {
 		err = EILSEQ;
 		goto unmap;

--------------050501020907030302010300--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
