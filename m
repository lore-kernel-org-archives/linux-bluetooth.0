Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430606F9.3060906@hasborg.com>
From: Joshua Wright <jwright@hasborg.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Reset card
References: <43038D0B.1060209@hasborg.com>	 <20050819092419.715FE479@arbetsmyra.dyndns.org>	 <4305A63E.7020507@soft.uni-linz.ac.at> <1124462989.6398.8.camel@notepaq>
In-Reply-To: <1124462989.6398.8.camel@notepaq>
Content-Type: multipart/mixed;
 boundary="------------000605070505040803070405"
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
Date: Fri, 19 Aug 2005 12:21:13 -0400

This is a multi-part message in MIME format.
--------------000605070505040803070405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
> feel free to send me a patch for the bccmd tool that I can include 
> into the bluez-utils distribution.

Thanks to all who replied.  Simon's code was exactly what was needed,
and the CSR BCCMD documentation was very helpful.

Attached is a patch to automatically reset CSR cards after changing the
BD_ADDR with the bdaddr utility.

Thanks,

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

iD8DBQFDBgb4TS8i9jZYpL8RAqOoAKCPXtduODADCFt6bOt2xofhVEG6oQCg8Bx6
2zYqq5VehC3FpOhPYwyiFgE=
=9B88
-----END PGP SIGNATURE-----

--------------000605070505040803070405
Content-Type: text/plain;
 name="bdaddr-csr-reset.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bdaddr-csr-reset.diff"

--- bdaddr.c	2005-05-09 14:33:24.000000000 -0400
+++ bdaddr-jlw.c	2005-08-19 12:15:03.000000000 -0400
@@ -103,6 +103,40 @@
 }
 #endif
 
+static int csr_cold_reset(int dd)
+{
+	unsigned char cmd[] = { 0x02, 0x00, /* message type */
+				0x09, 0x00, /* message length */
+				0x00, 0x00, /* seqno for pairing response */
+				0x01, 0x40, /* varid for cold reset */
+				0x00, 0x00, /* status */
+				/* payload follows, must be at least at least
+				   4 uint16s in length accordind to BCCMD */
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
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
+	if (hci_send_req(dd, &rq, 2000) < 0)
+		return -1;
+
+	return 0;
+}
+
+
 static int csr_write_bd_addr(int dd, bdaddr_t *bdaddr)
 {
 	unsigned char cmd[] = { 0x02, 0x00, 0x0c, 0x00, 0x11, 0x47, 0x03, 0x70,
@@ -291,7 +325,16 @@
 				exit(1);
 			}
 
-			printf("Address changed - Reset device now\n");
+			if (ver.manufacturer == 10) { /* CSR devices */
+				if (csr_cold_reset(dd) != 0) {
+					fprintf(stderr, "Error resetting card, remove and insert manually.\n");
+					exit(1);
+				} else {
+					printf("Address changed - card reset successfully\n");
+				}
+			} else { /* non-CSR devices */
+				printf("Address changed - Reset device now\n");
+			}
 
 			//ioctl(dd, HCIDEVRESET, dev);
 			//ioctl(dd, HCIDEVDOWN, dev);

--------------000605070505040803070405--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
