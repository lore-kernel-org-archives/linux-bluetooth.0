Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: bluez-devel@lists.sourceforge.net, cooker@mandrivalinux.org
Content-Type: multipart/mixed; boundary="=-EtBrWx1+Z3vW7VG3bvIo"
Date: Fri, 03 Oct 2008 14:47:09 +0200
Message-Id: <1223038029.6671.5.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] User security mode patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-EtBrWx1+Z3vW7VG3bvIo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

On my cooker box (i still use 3.36 though), with the default hcid.conf
file, i can't pair with my phone unless i comment out the
passkey="BlueZ" line, or apply the joined patch.

The documentation says this passkey should be used only in auto security
mode.

Or am I wrong ?

Regards,

Guillaume B.

--=-EtBrWx1+Z3vW7VG3bvIo
Content-Disposition: attachment;
	filename*0=bluez-utils-3.36-always-request-pin-in-user-security-mode.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name=bluez-utils-3.36-always-request-pin-in-user-security-mode.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

--- bluez-utils-3.36.orig/hcid/security.c	2008-10-03 13:37:17.000000000 +0200
+++ bluez-utils-3.36/hcid/security.c	2008-10-03 13:37:28.000000000 +0200
@@ -500,7 +500,7 @@
 	} else if (pairing == HCID_PAIRING_NONE)
 		goto reject;
 
-	if (hcid.security == HCID_SEC_AUTO && !ci->out) {
+	if ((hcid.security == HCID_SEC_AUTO) && !ci->out) {
 		set_pin_length(sba, hcid.pin_len);
 		memcpy(pr.pin_code, hcid.pin_code, hcid.pin_len);
 		pr.pin_len = hcid.pin_len;

--=-EtBrWx1+Z3vW7VG3bvIo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--=-EtBrWx1+Z3vW7VG3bvIo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-EtBrWx1+Z3vW7VG3bvIo--
