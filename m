Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431F0F7C.9090006@tcs.hut.fi>
From: Ville Nuorvala <vnuorval@tcs.hut.fi>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Properly replace an existing key value
 pair in a text file
References: <431ECC4D.9030302@tcs.hut.fi> <1126094276.10631.22.camel@blade>
In-Reply-To: <1126094276.10631.22.camel@blade>
Content-Type: multipart/mixed;
 boundary="------------020909090404040003010802"
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
Date: Wed, 07 Sep 2005 19:04:12 +0300

This is a multi-part message in MIME format.
--------------020909090404040003010802
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> Hi Ville,
> 
> 
>>textfile_put() was unable to replace a key value pair if it happened to 
>>be the last entry in a file. I noticed this problem in bluez-utils-2.19, 
>>but it still seems to exist in the latest CVS code. The patch below 
>>should fix it...
> 
> 
> I though that I fixed this. Are you sure that problem is still present?

Yes. I located the problem in Gentoo's bluez-utils-2.19 and since it 
hasn't yet been fixed in the CVS repository, I'm quite certain it still 
is present ;-)

I noticed the problem when hcid just wouldn't update the link key in 
var/lib/bluetooth/<hwaddr>/linkkeys, even though the debug statements 
claimed otherwise. The textfile_put() function clearly works incorrectly 
since zero is a valid value for the len variable, but the if (len <= 0 
|| ..) check causes the the function to exit before anything is written.

Btw, I resend the patch as a separate attachement since the tabs got 
screwed up last time.

Regards,
Ville
-- 
Ville Nuorvala
Research Assistant,
Laboratory for Theoretical Computer Science,
Helsinki University of Technology
email: vnuorval@tcs.hut.fi, phone: +358 (0)9 451 5257

--------------020909090404040003010802
Content-Type: text/x-patch;
 name="replace_key_value.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="replace_key_value.patch"

Index: common/textfile.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/textfile.c,v
retrieving revision 1.6
diff -u -r1.6 textfile.c
--- common/textfile.c	30 Aug 2005 00:35:39 -0000	1.6
+++ common/textfile.c	7 Sep 2005 11:06:43 -0000
@@ -180,8 +180,14 @@
 	end += len;
 
 	len = size - (end - map);
-
-	if (len <= 0 || len > size) {
+	if (!len) {
+		munmap(map, size);
+		ftruncate(fd, base);
+		pos = lseek(fd, base, SEEK_SET);
+		err = write_key_value(fd, key, value);
+		goto unlock;
+	}
+	if (len < 0 || len > size) {
 		err = EILSEQ;
 		goto unmap;
 	}

--------------020909090404040003010802--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
