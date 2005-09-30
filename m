Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <433D16A7.5030805@inelis.org>
From: =?ISO-8859-1?Q?Lo=EFc_Lefort?= <loic.lefort@inelis.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 30 Sep 2005 12:42:47 +0200

Here is a patch to fix the SEGV when doing DUN lookup on Samsung phones
(at least D500 and E720).
The diagnostic for the bug is here:
http://sourceforge.net/mailarchive/message.php?msg_id=3D11057684
The problem is that the Samsung phones return a sequence of uuid for
BTProfileDescList instead
of a sequence of (sequence uuid version).

The patch detects the "sequence of uuid" case and uses a default version
number of 0x100,
as recommended in:
http://sourceforge.net/mailarchive/message.php?msg_id=3D11202759
The other case is unchanged.

Tested with these phones: Samsung D500 and E720, Nokia 6680.

--- bluez-libs-2.19/src/sdp.c   2005-08-06 13:13:58.000000000 +0200
+++ bluez-libs-2.19-patched-for-d500/src/sdp.c  2005-09-29
13:46:38.000000000 +0 200
@@ -1526,12 +1526,24 @@
                return -1;
        }
        for (seq =3D sdpdata->val.dataseq; seq && seq->val.dataseq; seq =3D
seq->nex t) {
-               sdp_data_t *uuid =3D seq->val.dataseq;
-               sdp_data_t *pVnum =3D seq->val.dataseq->next;
-               if (uuid && pVnum) {
+               uuid_t *uuid =3D NULL;
+               uint16_t version =3D 0x100;
+
+               if (SDP_IS_UUID(seq->dtd)) {
+                       uuid =3D &seq->val.uuid;
+               } else {
+                       sdp_data_t *puuid =3D seq->val.dataseq;
+                       sdp_data_t *pVnum =3D seq->val.dataseq->next;
+                       if (puuid && pVnum) {
+                               uuid =3D &puuid->val.uuid;
+                               version =3D pVnum->val.uint16;
+                       }
+               }
+
+               if (uuid !=3D NULL) {
                        profDesc =3D (sdp_profile_desc_t
*)malloc(sizeof(sdp_profi le_desc_t));
-                       profDesc->uuid =3D uuid->val.uuid;
-                       profDesc->version =3D pVnum->val.uint16;
+                       profDesc->uuid =3D *uuid;
+                       profDesc->version =3D version;
 #ifdef SDP_DEBUG
                        sdp_uuid_print(&profDesc->uuid);
                        SDPDBG("Vnum : 0x%04x\n", profDesc->version);

--=20
Lo=EFc Lefort <loic.lefort@inelis.org>
inelis



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
