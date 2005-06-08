Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42A6893A.1050708@debian.org.tw>
From: Rex Tsai <chihchun@debian.org.tw>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFFE2D6D8A1FEA55F96D6F8EB"
Subject: [Bluez-devel] patch for read number of supported iac
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
Date: Wed, 08 Jun 2005 13:59:22 +0800

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFFE2D6D8A1FEA55F96D6F8EB
Content-Type: multipart/mixed;
 boundary="------------000109000100090808090505"

This is a multi-part message in MIME format.
--------------000109000100090808090505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
  The API is missing. I don't know why. The attachments are my patches.
regards
-Rex

--------------000109000100090808090505
Content-Type: text/x-patch;
 name="nosiac-libs-2.17.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nosiac-libs-2.17.diff"

--- bluez-libs-2.17.orig/src/hci.c
+++ bluez-libs-2.17/src/hci.c
@@ -1298,6 +1298,29 @@
 	return hci_send_req(dd, &rq, to);
 }
 
+int hci_read_number_of_supported_iac(int dd, uint8_t *num_iac, int to)
+{
+        read_number_of_supported_iac_rp rp;
+	struct hci_request rq;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_NUMBER_OF_SUPPORTED_IAC;
+	rq.rparam = &rp;
+	rq.rlen   = READ_NUMBER_OF_SUPPORTED_IAC_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (rp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	*num_iac = rp.num_support_iac;
+	return 0;
+}
+
 int hci_read_current_iac_lap(int dd, uint8_t *num_iac, uint8_t *lap, int to)
 {
 	read_current_iac_lap_rp rp;
--- bluez-libs-2.17.orig/include/hci_lib.h
+++ bluez-libs-2.17/include/hci_lib.h
@@ -84,6 +84,7 @@
 int hci_write_class_of_dev(int dd, uint32_t cls, int to);
 int hci_read_voice_setting(int dd, uint16_t *vs, int to);
 int hci_write_voice_setting(int dd, uint16_t vs, int to);
+int hci_read_number_of_supported_iac(int dd, uint8_t *num_iac, int to);
 int hci_read_current_iac_lap(int dd, uint8_t *num_iac, uint8_t *lap, int to);
 int hci_write_current_iac_lap(int dd, uint8_t num_iac, uint8_t *lap, int to);
 int hci_read_stored_link_key(int dd, bdaddr_t *bdaddr, uint8_t all, int to);
--- bluez-libs-2.17.orig/include/hci.h
+++ bluez-libs-2.17/include/hci.h
@@ -808,6 +808,13 @@
 #define WRITE_LINK_SUPERVISION_TIMEOUT_RP_SIZE 3
 
 #define MAX_IAC_LAP 0x40
+#define OCF_READ_NUMBER_OF_SUPPORTED_IAC        0x0038
+typedef struct {
+	uint8_t		status;
+	uint8_t		num_support_iac;
+} __attribute__ ((packed)) read_number_of_supported_iac_rp;
+#define READ_NUMBER_OF_SUPPORTED_IAC_RP_SIZE 2
+
 #define OCF_READ_CURRENT_IAC_LAP	0x0039
 typedef struct {
 	uint8_t		status;

--------------000109000100090808090505
Content-Type: text/x-patch;
 name="nosiac-utils-2.17.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nosiac-utils-2.17.diff"

--- bluez-utils-2.17.orig/tools/hciconfig.c
+++ bluez-utils-2.17/tools/hciconfig.c
@@ -143,6 +143,27 @@
 	}
 }
 
+static void cmd_nosiac(int ctl, int hdev, char *opt)
+{
+	int s = hci_open_dev(hdev);
+
+        if (s < 0) {
+            fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
+                    hdev, strerror(errno), errno);
+            exit(1);
+        }
+        {
+            uint8_t n;
+            if (hci_read_number_of_supported_iac(s, &n, 1000) < 0) {
+                printf("Failed to read IAC from hci%d: %s\n", hdev, strerror(errno));
+                exit(1);
+            }
+            print_dev_hdr(&di);
+            printf("\tNumber of supported IAC: %d\n", n);
+        }
+        close(s);
+}
+
 static void cmd_iac(int ctl, int hdev, char *opt)
 {
 	int s = hci_open_dev(hdev);
@@ -1323,6 +1344,7 @@
 	{ "name",	cmd_name,	"[name]",	"Get/Set local name" },
 	{ "class",	cmd_class,	"[class]",	"Get/Set class of device" },
 	{ "voice",	cmd_voice,	"[voice]",	"Get/Set voice setting" },
+	{ "nosiac",	cmd_nosiac,	0,              "Display number of supported inquiry access code" },
 	{ "iac",	cmd_iac,	"[iac]",	"Get/Set inquiry access code" },
 	{ "inqmode",	cmd_inq_mode,	"[mode]",	"Get/set inquiry mode" },
 	{ "inqparms",	cmd_inq_parms,	"[win:int]",	"Get/Set inquiry scan window and interval" },

--------------000109000100090808090505--

--------------enigFFE2D6D8A1FEA55F96D6F8EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCpok9Ol4Wbdx2/rkRAun8AJ4mNFJHaYY2pkwWoSTRjoqdR+XXnQCeP4Vo
X8L7ha/jD2qXqtDqktigxN4=
=CDf1
-----END PGP SIGNATURE-----

--------------enigFFE2D6D8A1FEA55F96D6F8EB--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
