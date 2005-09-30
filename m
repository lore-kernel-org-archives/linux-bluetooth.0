Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <433D4C45.6080304@ismart.fr>
From: =?ISO-8859-1?Q?Lo=EFc_Lefort?= <loic.lefort@ismart.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------050205070909090302060204"
Subject: [Bluez-devel] Re: DUN lookup on Samsung D500 raises SIGSEGV
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
Date: Fri, 30 Sep 2005 16:31:33 +0200

This is a multi-part message in MIME format.
--------------050205070909090302060204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

here is the patch as an attachment.

Lo=EFc

--=20
Lo=EFc Lefort <loic.lefort@ismart.fr>
iSmart


--------------050205070909090302060204
Content-Type: text/plain;
 name="samsung-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="samsung-patch"

--- bluez-libs-2.19/src/sdp.c	2005-08-06 13:13:58.000000000 +0200
+++ bluez-libs-2.19-patched-for-d500/src/sdp.c	2005-09-29 13:46:38.000000000 +0200
@@ -1526,12 +1526,24 @@
 		return -1;
 	}
 	for (seq = sdpdata->val.dataseq; seq && seq->val.dataseq; seq = seq->next) {
-		sdp_data_t *uuid = seq->val.dataseq;
-		sdp_data_t *pVnum = seq->val.dataseq->next;
-		if (uuid && pVnum) {
+		uuid_t *uuid = NULL;
+		uint16_t version = 0x100;
+
+		if (SDP_IS_UUID(seq->dtd)) {
+			uuid = &seq->val.uuid;
+		} else {
+			sdp_data_t *puuid = seq->val.dataseq;
+			sdp_data_t *pVnum = seq->val.dataseq->next;
+			if (puuid && pVnum) {
+				uuid = &puuid->val.uuid;
+				version = pVnum->val.uint16;
+			}
+		}
+
+		if (uuid != NULL) {
 			profDesc = (sdp_profile_desc_t *)malloc(sizeof(sdp_profile_desc_t));
-			profDesc->uuid = uuid->val.uuid;
-			profDesc->version = pVnum->val.uint16;
+			profDesc->uuid = *uuid;
+			profDesc->version = version;
 #ifdef SDP_DEBUG
 			sdp_uuid_print(&profDesc->uuid);
 			SDPDBG("Vnum : 0x%04x\n", profDesc->version);

--------------050205070909090302060204--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
