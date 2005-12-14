Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: adding Additional Protocol Descriptor List
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1134546080.14885.24.camel@localhost>
References: <20051214073020.77669.qmail@web32409.mail.mud.yahoo.com>
	 <1134546080.14885.24.camel@localhost>
Content-Type: multipart/mixed; boundary="=-u3YNE+r1QmmxAlW4Mds4"
Message-Id: <1134552546.14885.26.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 14 Dec 2005 10:29:06 +0100


--=-u3YNE+r1QmmxAlW4Mds4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Arch,

> > I have tried writing code to add the Additional Protocol Descriptor
> > List. But it seems that the data still cannot be added as a 3-level
> > sequence (sequence of a sequence of a sequence). The data I added for
> > the Additional Protocol Descriptor List still look similar to the
> > Protocol Descriptor List (2-level sequence of data).
> 
> you should coordinate with Collin, because he also needs this.

forget about that. I did the patch by myself. Feel free to try it out.

Regards

Marcel


--=-u3YNE+r1QmmxAlW4Mds4
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: include/sdp_lib.h
===================================================================
RCS file: /cvsroot/bluez/libs/include/sdp_lib.h,v
retrieving revision 1.12
diff -u -r1.12 sdp_lib.h
--- include/sdp_lib.h	9 Dec 2005 09:12:44 -0000	1.12
+++ include/sdp_lib.h	14 Dec 2005 09:27:40 -0000
@@ -176,6 +176,11 @@
 int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
 
 /*
+ * Set the additional access protocols of the record to those specified in proto
+ */
+int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
+
+/*
  * Get protocol port (i.e. PSM for L2CAP, Channel for RFCOMM) 
  */
 int sdp_get_proto_port(const sdp_list_t *list, int proto);
@@ -457,7 +462,7 @@
 /*
  * Get the additional access protocols from the service record
  */
-int sdp_get_add_access_protos(const sdp_record_t *rec, sdp_list_t **pap);
+int sdp_get_add_access_protos(const sdp_record_t *rec, sdp_list_t **protos);
 
 /*
  * Extract the list of browse groups to which the service belongs.
Index: src/sdp.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/sdp.c,v
retrieving revision 1.33
diff -u -r1.33 sdp.c
--- src/sdp.c	9 Dec 2005 09:39:16 -0000	1.33
+++ src/sdp.c	14 Dec 2005 09:27:41 -0000
@@ -1812,13 +1812,31 @@
 int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 {
 	const sdp_list_t *p;
-	sdp_data_t *protos = 0;
+	sdp_data_t *protos = NULL;
 
 	for (p = ap; p; p = p->next) {
-		sdp_data_t *seq = access_proto_to_dataseq(rec, (sdp_list_t *)p->data);
+		sdp_data_t *seq = access_proto_to_dataseq(rec, (sdp_list_t *) p->data);
 		protos = sdp_seq_append(protos, seq);
 	}
+
 	sdp_attr_add(rec, SDP_ATTR_PROTO_DESC_LIST, protos);
+
+	return 0;
+}
+
+int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
+{
+	const sdp_list_t *p;
+	sdp_data_t *protos = NULL;
+
+	for (p = ap; p; p = p->next) {
+		sdp_data_t *seq = access_proto_to_dataseq(rec, (sdp_list_t *) p->data);
+		protos = sdp_seq_append(protos, seq);
+	}
+
+	sdp_attr_add(rec, SDP_ATTR_ADD_PROTO_DESC_LIST,
+				sdp_data_alloc(SDP_SEQ8, protos));
+
 	return 0;
 }
 

--=-u3YNE+r1QmmxAlW4Mds4--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
