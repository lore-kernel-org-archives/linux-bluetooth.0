Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Message-ID: <001701c376f2$bc163100$0500a8c0@baked>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0018_01C376B8.0FB75900"
Subject: [Bluez-devel] FW: Patches: Qualification - SDP
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 9 Sep 2003 09:52:18 -0700

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C376B8.0FB75900
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This didn't make it through the first time... Trying again.

-Daryl.

-----Original Message-----
From: Daryl Van Vorst [mailto:daryl@wideray.com]=20
Sent: September 8, 2003 11:29 AM
To: 'Stephen Crane'
Cc: 'BlueZ Mailing List'
Subject: Patches: Qualification - SDP


Steve, All,

Attached are two versions of a patch to SDP which make it pass the =
mandatory
qualification tests. One patch is against version 1.4 which is available =
for
download. The other patch is against what _I THINK_ is in CVS (if
sourceforge's CVS was better I'd be able to give a more definitive
statement).

The changes that I've made perform some simple checks on the PDU =
structure
for the three different SDP queries (SS, SA, SSA), and return the
appropriate error code (Invalid Request Syntax) to the initiator. =
Previously
the code would return "Invalid Continuation Sate" as the error code for
certain malformed queries.

The only difference between the two patches is a change that Steve made
which fixed a bug in handling the MaximumServiceRecordCount parameter in =
an
SS request. One patch includes it (the patch against version 1.4) and =
the
other patch does not.

-Daryl.

------=_NextPart_000_0018_01C376B8.0FB75900
Content-Type: text/plain;
	name="patch-sdp-1.4.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-sdp-1.4.txt"

--- bluez-sdp-1.4/sdpd/request.c	Wed Feb 12 05:18:07 2003=0A=
+++ bluez-sdp-1.4-mods/sdpd/request.c	Thu Sep  4 14:28:12 2003=0A=
@@ -228,7 +228,7 @@=0A=
  */=0A=
 static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)=0A=
 {=0A=
-	int status =3D 0, i;=0A=
+	int status =3D 0, i, plen;=0A=
 	sdp_list_t *pattern =3D NULL;=0A=
 	int expected, actual;=0A=
 	uint8_t dtd;=0A=
@@ -249,6 +249,14 @@=0A=
 		goto done;=0A=
 	}=0A=
 	pdata +=3D scanned;=0A=
+=0A=
+	plen =3D ntohs(((sdp_pdu_hdr_t *)(req->buf))->plen);=0A=
+	if((plen < (scanned + sizeof(uint16_t) + 1)) || // To ensure we don't =
read past buffer=0A=
+	   (plen !=3D (scanned + sizeof(uint16_t) + 1 + *((uint8_t =
*)(pdata+sizeof(uint16_t)))))) {=0A=
+	  status =3D SDP_INVALID_SYNTAX;=0A=
+	  goto done;=0A=
+	}=0A=
+=0A=
 	expected =3D ntohs(sdp_get_unaligned((uint16_t *)pdata));=0A=
 	=0A=
 	SDPDBG("Expected count: %d\n", expected);=0A=
@@ -285,7 +293,7 @@=0A=
 		sdp_list_t *list =3D sdp_get_record_list();=0A=
 =0A=
 		handleSize =3D 0;=0A=
-		for (; list; list =3D list->next) {=0A=
+		for (; list && rsp_count < expected; list =3D list->next) {=0A=
 			sdp_record_t *rec =3D (sdp_record_t *)list->data;=0A=
 =0A=
 			SDPDBG("Checking svcRec : 0x%x\n", rec->handle);=0A=
@@ -480,7 +488,7 @@=0A=
 	uint8_t dtd =3D 0;=0A=
 	int scanned =3D 0;=0A=
 	int max_rsp_size;=0A=
-	int status =3D 0;=0A=
+	int status =3D 0, plen;=0A=
 	char *pdata =3D req->buf + sizeof(sdp_pdu_hdr_t);=0A=
 	uint32_t handle =3D ntohl(sdp_get_unaligned((uint32_t *)pdata));=0A=
 =0A=
@@ -498,6 +506,13 @@=0A=
 	}=0A=
 	pdata +=3D scanned;=0A=
 =0A=
+	plen =3D ntohs(((sdp_pdu_hdr_t *)(req->buf))->plen);=0A=
+	if((plen < (scanned + sizeof(uint32_t) + sizeof(uint16_t) + 1)) || // =
To ensure we don't read past buffer=0A=
+	   (plen !=3D (scanned + sizeof(uint32_t) + sizeof(uint16_t) + 1 + =
*((uint8_t *)pdata)))) {=0A=
+	  status =3D SDP_INVALID_SYNTAX;=0A=
+	  goto done;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * if continuation state exists, attempt=0A=
 	 * to get rsp remainder from cache, else send error=0A=
@@ -584,7 +599,7 @@=0A=
  */=0A=
 static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)=0A=
 {=0A=
-	int status =3D 0;=0A=
+	int status =3D 0, plen, totscanned;=0A=
 	char *pdata, *pResponse =3D NULL;=0A=
 	int scanned, max, rsp_count =3D 0;=0A=
 	sdp_list_t *pattern =3D NULL, *seq =3D NULL, *svcList;=0A=
@@ -600,6 +615,7 @@=0A=
         	status =3D SDP_INVALID_SYNTAX;=0A=
 		goto done;=0A=
 	}=0A=
+	totscanned =3D scanned;=0A=
 =0A=
 	SDPDBG("Bytes scanned: %d", scanned);=0A=
 =0A=
@@ -616,6 +632,14 @@=0A=
 		goto done;=0A=
 	}=0A=
 	pdata +=3D scanned;=0A=
+	totscanned +=3D scanned;=0A=
+=0A=
+	plen =3D ntohs(((sdp_pdu_hdr_t *)(req->buf))->plen);=0A=
+	if((plen < (totscanned + sizeof(uint16_t) + 1)) || // To ensure we =
don't read past buffer=0A=
+	   (plen !=3D (totscanned + sizeof(uint16_t) + 1 + *((uint8_t =
*)pdata)))) {=0A=
+	  status =3D SDP_INVALID_SYNTAX;=0A=
+	  goto done;=0A=
+	}=0A=
 =0A=
 	/*=0A=
 	 * if continuation state exists attempt=0A=

------=_NextPart_000_0018_01C376B8.0FB75900
Content-Type: text/plain;
	name="patch-sdp-cvs.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-sdp-cvs.txt"

--- bluez-sdp-cvs/sdpd/request.c	Thu Sep  4 15:07:28 2003=0A=
+++ bluez-sdp-1.4-mods/sdpd/request.c	Thu Sep  4 14:28:12 2003=0A=
@@ -228,7 +228,7 @@=0A=
  */=0A=
 static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)=0A=
 {=0A=
-	int status =3D 0, i;=0A=
+	int status =3D 0, i, plen;=0A=
 	sdp_list_t *pattern =3D NULL;=0A=
 	int expected, actual;=0A=
 	uint8_t dtd;=0A=
@@ -249,6 +249,14 @@=0A=
 		goto done;=0A=
 	}=0A=
 	pdata +=3D scanned;=0A=
+=0A=
+	plen =3D ntohs(((sdp_pdu_hdr_t *)(req->buf))->plen);=0A=
+	if((plen < (scanned + sizeof(uint16_t) + 1)) || // To ensure we don't =
read past buffer=0A=
+	   (plen !=3D (scanned + sizeof(uint16_t) + 1 + *((uint8_t =
*)(pdata+sizeof(uint16_t)))))) {=0A=
+	  status =3D SDP_INVALID_SYNTAX;=0A=
+	  goto done;=0A=
+	}=0A=
+=0A=
 	expected =3D ntohs(sdp_get_unaligned((uint16_t *)pdata));=0A=
 	=0A=
 	SDPDBG("Expected count: %d\n", expected);=0A=
@@ -480,7 +488,7 @@=0A=
 	uint8_t dtd =3D 0;=0A=
 	int scanned =3D 0;=0A=
 	int max_rsp_size;=0A=
-	int status =3D 0;=0A=
+	int status =3D 0, plen;=0A=
 	char *pdata =3D req->buf + sizeof(sdp_pdu_hdr_t);=0A=
 	uint32_t handle =3D ntohl(sdp_get_unaligned((uint32_t *)pdata));=0A=
 =0A=
@@ -498,6 +506,13 @@=0A=
 	}=0A=
 	pdata +=3D scanned;=0A=
 =0A=
+	plen =3D ntohs(((sdp_pdu_hdr_t *)(req->buf))->plen);=0A=
+	if((plen < (scanned + sizeof(uint32_t) + sizeof(uint16_t) + 1)) || // =
To ensure we don't read past buffer=0A=
+	   (plen !=3D (scanned + sizeof(uint32_t) + sizeof(uint16_t) + 1 + =
*((uint8_t *)pdata)))) {=0A=
+	  status =3D SDP_INVALID_SYNTAX;=0A=
+	  goto done;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * if continuation state exists, attempt=0A=
 	 * to get rsp remainder from cache, else send error=0A=
@@ -584,7 +599,7 @@=0A=
  */=0A=
 static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)=0A=
 {=0A=
-	int status =3D 0;=0A=
+	int status =3D 0, plen, totscanned;=0A=
 	char *pdata, *pResponse =3D NULL;=0A=
 	int scanned, max, rsp_count =3D 0;=0A=
 	sdp_list_t *pattern =3D NULL, *seq =3D NULL, *svcList;=0A=
@@ -600,6 +615,7 @@=0A=
         	status =3D SDP_INVALID_SYNTAX;=0A=
 		goto done;=0A=
 	}=0A=
+	totscanned =3D scanned;=0A=
 =0A=
 	SDPDBG("Bytes scanned: %d", scanned);=0A=
 =0A=
@@ -616,6 +632,14 @@=0A=
 		goto done;=0A=
 	}=0A=
 	pdata +=3D scanned;=0A=
+	totscanned +=3D scanned;=0A=
+=0A=
+	plen =3D ntohs(((sdp_pdu_hdr_t *)(req->buf))->plen);=0A=
+	if((plen < (totscanned + sizeof(uint16_t) + 1)) || // To ensure we =
don't read past buffer=0A=
+	   (plen !=3D (totscanned + sizeof(uint16_t) + 1 + *((uint8_t =
*)pdata)))) {=0A=
+	  status =3D SDP_INVALID_SYNTAX;=0A=
+	  goto done;=0A=
+	}=0A=
 =0A=
 	/*=0A=
 	 * if continuation state exists attempt=0A=

------=_NextPart_000_0018_01C376B8.0FB75900--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
