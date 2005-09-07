Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431ECC4D.9030302@tcs.hut.fi>
From: Ville Nuorvala <vnuorval@tcs.hut.fi>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------070608020800080108000108"
Subject: [Bluez-devel] [PATCH] Properly replace an existing key value pair in a text file
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
Date: Wed, 07 Sep 2005 14:17:33 +0300

This is a multi-part message in MIME format.
--------------070608020800080108000108
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

textfile_put() was unable to replace a key value pair if it happened to 
be the last entry in a file. I noticed this problem in bluez-utils-2.19, 
but it still seems to exist in the latest CVS code. The patch below 
should fix it...

Index: common/textfile.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/textfile.c,v
retrieving revision 1.6
diff -u -r1.6 textfile.c
--- common/textfile.c   30 Aug 2005 00:35:39 -0000      1.6
+++ common/textfile.c   7 Sep 2005 11:06:43 -0000
@@ -180,8 +180,14 @@
         end += len;

         len = size - (end - map);
-
-       if (len <= 0 || len > size) {
+       if (!len) {
+               munmap(map, size);
+               ftruncate(fd, base);
+               pos = lseek(fd, base, SEEK_SET);
+               err = write_key_value(fd, key, value);
+               goto unlock;
+       }
+       if (len < 0 || len > size) {
                 err = EILSEQ;
                 goto unmap;
         }

Regards,
Ville
-- 
Ville Nuorvala
Research Assistant,
Laboratory for Theoretical Computer Science,
Helsinki University of Technology
email: vnuorval@tcs.hut.fi, phone: +358 (0)9 451 5257

--------------070608020800080108000108
Content-Type: text/x-vcard; charset=utf-8;
 name="vnuorval.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vnuorval.vcf"

begin:vcard
fn:Ville Nuorvala
n:Nuorvala;Ville
adr:;;Helsinginkatu 17 A 18;Helsinki;;FIN-00500;Finland
email;internet:vnuorval@tcs.hut.fi
tel;work:+35894515257
tel;fax:+35894513369
tel;cell:+358405835323
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------070608020800080108000108--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
