Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430A2579.2060609@hasborg.com>
From: Joshua Wright <jwright@hasborg.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Reset card
References: <43038D0B.1060209@hasborg.com>	 <20050819092419.715FE479@arbetsmyra.dyndns.org>	 <4305A63E.7020507@soft.uni-linz.ac.at> <1124462989.6398.8.camel@notepaq>	 <430606F9.3060906@hasborg.com> <1124632986.6260.9.camel@notepaq>
In-Reply-To: <1124632986.6260.9.camel@notepaq>
Content-Type: multipart/mixed;
 boundary="------------030604090403030501030105"
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
Date: Mon, 22 Aug 2005 15:20:25 -0400

This is a multi-part message in MIME format.
--------------030604090403030501030105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
> I modified it a little bit to make it more generic, but it is in the CVS
> now. Feel free to test it. Do I get also a patch for bccmd for a reset
> command and a patch for decoding this command in hcidump?

Why, yes!  Attached is a patch to add decoding for hcidump, and a few
extras for bccmd.  I added "disabletx", "enabletx" and "rand", as well
as "coldreset" to bccmd.

Note that coldreset will be decoded in hcidump properly, but hcidump
dies shortly afterward when it isn't getting a response from the card
during reset.

Thanks!

- -Josh
- --
- -Joshua Wright
jwright@hasborg.com

2005-2006 pgpkey: http://802.11ninja.net/pgpkey.htm
fingerprint: F00E 7A42 8375 0C55 964F E5A4 4D2F 22F6 3658 A4BF

Today I stumbled across the world's largest hotspot.  The SSID is "linksys".
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDCiV3TS8i9jZYpL8RAusWAKC6bYjtEyvQDTvzulJNWdH2h6gyyQCeNtrI
L+FfgUfB+pCBKi8ZWfCYKDY=
=XBJy
-----END PGP SIGNATURE-----

--------------030604090403030501030105
Content-Type: text/plain;
 name="bccmd-extras.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bccmd-extras.diff"

diff -ru bluez-utils-2.19/tools/bccmd.c bluez-utils-2.19-jlw/tools/bccmd.c
--- bluez-utils-2.19/tools/bccmd.c	2005-07-03 19:12:08.000000000 -0400
+++ bluez-utils-2.19-jlw/tools/bccmd.c	2005-08-22 14:42:31.000000000 -0400
@@ -129,16 +129,53 @@
 	return 0;
 }
 
+static int cmd_disabletx(int dd, int argc, char *argv[])
+{
+	return csr_write_varid_uint16(dd, 0, CSR_VARID_DISABLE_TX, 0, 0);
+}
+	
+static int cmd_enabletx(int dd, int argc, char *argv[])
+{
+	return csr_write_varid_uint16(dd, 0, CSR_VARID_ENABLE_TX, 0, 0);
+}
+	
+static int cmd_coldreset(int dd, int argc, char *argv[])
+{
+	return csr_write_varid_uint16(dd, 0, CSR_VARID_COLD_RESET, 0, 0);
+}
+	
+static int cmd_rand(int dd, int argc, char *argv[])
+{
+	uint16_t error = 0;
+	int err;
+
+	err = csr_read_varid_uint16(dd, 5, CSR_VARID_RAND, &error);
+	if (err < 0) {
+		errno = -err;
+		return -1;
+	}
+
+	printf("Random number: 0x%02x (%d)\n", error, error);
+
+	return 0;
+}
+
+
+
 static struct {
 	char *str;
 	int (*func)(int dd, int argc, char **argv);
 	char *arg;
 	char *doc;
 } commands[] = {
-	{ "keylen",   cmd_keylen,   "<handle>", "Get current crypt key length" },
-	{ "clock",    cmd_clock,    "",         "Get local Bluetooth clock"    },
-	{ "panicarg", cmd_panicarg, "",         "Get panic code argument"      },
-	{ "faultarg", cmd_faultarg, "",         "Get fault code argument"      },
+	{ "keylen",    cmd_keylen,    "<handle>", "Get current crypt key length" },
+	{ "clock",     cmd_clock,     "",         "Get local Bluetooth clock"    },
+	{ "panicarg",  cmd_panicarg,  "",         "Get panic code argument"      },
+	{ "faultarg",  cmd_faultarg,  "",         "Get fault code argument"      },
+    { "coldreset", cmd_coldreset, "",         "Perform cold reset"           },
+    { "disabletx", cmd_disabletx, "",         "Disable TX on the device"     },
+    { "enabletx",  cmd_enabletx,  "",         "Enable TX on the device"      },
+    { "rand",      cmd_rand,      "",         "Obtain a random number"       },
 	{ NULL },
 };
 
diff -ru bluez-utils-2.19/tools/csr.c bluez-utils-2.19-jlw/tools/csr.c
--- bluez-utils-2.19/tools/csr.c	2005-07-18 20:12:37.000000000 -0400
+++ bluez-utils-2.19-jlw/tools/csr.c	2005-08-22 14:41:47.000000000 -0400
@@ -668,3 +668,53 @@
 
 	return 0;
 }
+
+
+int csr_write_varid_uint16(int dd, uint16_t seqnum, uint16_t varid, uint16_t value, int chkresp)
+{
+	unsigned char cmd[] = { 0x02, 0x00, 
+				0x09, 0x00,
+				seqnum & 0xff, seqnum >> 8, 
+				varid & 0xff, varid >> 8, 
+				0x00, 0x00,	  // status
+				0x00, 0x00,	  // payload
+				0x00, 0x00, 
+				0x00, 0x00, 
+				0x00, 0x00 };
+
+	unsigned char cp[254], rp[254];
+	struct hci_request rq;
+
+	memset(&cp, 0, sizeof(cp));
+	cp[0] = 0xc2;
+	memcpy(cp + 1, cmd, sizeof(cmd));
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf	= OGF_VENDOR_CMD;
+	rq.ocf	= 0x00;
+	rq.event  = EVT_VENDOR;
+	rq.cparam = cp;
+	rq.clen   = sizeof(cmd) + 1;
+	rq.rparam = rp;
+	rq.rlen   = sizeof(rp);
+
+	/* Only check for a response if the BCCMD warrants it.  Reset does not. */
+	if (chkresp) {
+		if (hci_send_req(dd, &rq, 2000) < 0)
+		return -1;
+
+		if (rp[0] != 0xc2) {
+			errno = EIO;
+			return -1;
+		}
+
+		if ((rp[9] + (rp[10] << 8)) != 0) {
+			errno = ENXIO;
+			return -1;
+		}
+	} else {
+		hci_send_req(dd, &rq, 2000);
+	}
+
+	return 0;
+}
diff -ru bluez-utils-2.19/tools/csr.h bluez-utils-2.19-jlw/tools/csr.h
--- bluez-utils-2.19/tools/csr.h	2005-07-03 17:19:51.000000000 -0400
+++ bluez-utils-2.19-jlw/tools/csr.h	2005-08-22 14:37:26.000000000 -0400
@@ -81,3 +81,4 @@
 int csr_read_pskey_complex(int dd, uint16_t seqnum, uint16_t pskey, uint8_t *value, uint16_t length);
 int csr_read_pskey_uint16(int dd, uint16_t seqnum, uint16_t pskey, uint16_t *value);
 int csr_write_pskey_uint16(int dd, uint16_t seqnum, uint16_t pskey, uint16_t value);
+int csr_write_varid_uint16(int dd, uint16_t seqnum, uint16_t varid, uint16_t value, int chkresp);

--------------030604090403030501030105
Content-Type: text/plain;
 name="hcidump-bccmd-extras.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump-bccmd-extras.diff"

Only in bluez-hcidump-1.24-jlw/: Makefile
Only in bluez-hcidump-1.24-jlw/: config.h
Only in bluez-hcidump-1.24-jlw/: config.log
Only in bluez-hcidump-1.24-jlw/: config.status
Only in bluez-hcidump-1.24-jlw/parser: .csr.c.swp
Only in bluez-hcidump-1.24-jlw/parser: Makefile
diff -ru bluez-hcidump-1.24/parser/csr.c bluez-hcidump-1.24-jlw/parser/csr.c
--- bluez-hcidump-1.24/parser/csr.c	2005-07-03 17:19:51.000000000 -0400
+++ bluez-hcidump-1.24-jlw/parser/csr.c	2005-08-22 15:05:24.000000000 -0400
@@ -214,6 +214,15 @@
 	case 0x3008:
 		handle_length_dump(level + 1, "CRYPT_KEY_LENGTH", frm);
 		break;
+	case 0x4001:
+		uint16_dump(level + 1, "COLD_RESET", frm);
+		break;
+	case 0x4007:
+		uint16_dump(level + 1, "ENABLE_TX", frm);
+		break;
+	case 0x4008:
+		uint16_dump(level + 1, "DISABLE_TX", frm);
+		break;
 	case 0x481c:
 		uint16_dump(level + 1, "MAP_SCO_PCM", frm);
 		break;
Only in bluez-hcidump-1.24-jlw/src: Makefile
Only in bluez-hcidump-1.24-jlw/: stamp-h1

--------------030604090403030501030105--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
