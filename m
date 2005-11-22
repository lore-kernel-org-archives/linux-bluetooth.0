Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Victor Shchebatyuk <victor@win.tue.nl>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-t6aNxIKbQ+BNXDDY0j+z"
Message-Id: <1132691970.9887.14.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] [Patch] Samsung D600 (sdp, service discovery deadlocks)
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
Date: Tue, 22 Nov 2005 21:39:30 +0100


--=-t6aNxIKbQ+BNXDDY0j+z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,

We experienced some deadlock in the bluez library for Samsund-D600 phone
during service discovery. This is due to incorrect SDP record set
returned on service inquiry request. The response from the SDP server
contains service records + some rubbish at the end. So when it tries to
parse it, sdp_extract_pdu() returns 0 recsize and locks the while()
loop.
Samsung is informed, but I do not know if they will come up with
something (have no idea who provides the stack for them, they have a
Broadcom chip in there)

The patch is attached.

Regards,
    Victor.

P.S. I do not have the phone with me now, otherwise I would send in
hcidump output. It reports errors when trying to parse at the end of
response.

--=-t6aNxIKbQ+BNXDDY0j+z
Content-Disposition: attachment; filename=sdp-samsungd600.patch
Content-Type: text/x-patch; name=sdp-samsungd600.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: src/sdp.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/sdp.c,v
retrieving revision 1.30
diff -u -r1.30 sdp.c
--- src/sdp.c	29 Oct 2005 19:25:43 -0000	1.30
+++ src/sdp.c	22 Nov 2005 20:24:12 -0000
@@ -3115,6 +3115,10 @@
 					status = -1;
 					goto end;
 				}
+				if (!recsize) {
+					sdp_record_free(rec);
+					break;
+				}
 				scanned += recsize;
 				pdata += recsize;
 

--=-t6aNxIKbQ+BNXDDY0j+z--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
