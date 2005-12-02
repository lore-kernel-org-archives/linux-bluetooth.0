Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-TOE9On/keFPmodVSqyZq"
Message-Id: <1133509258.15695.8.camel@panic>
Mime-Version: 1.0
Subject: [Bluez-devel] more sdp patches
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
Date: Thu, 01 Dec 2005 23:40:58 -0800


--=-TOE9On/keFPmodVSqyZq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,

here is another patch for bluez-libs for sdp. I added:

int sdp_set_access_protos_attr(sdp_record_t *rec, const sdp_list_t
*proto, const uint16_t attr);

this is to add stuff like SDP_ATTR_ADD_PROTO_DESC_LIST, actually I
modified sdp_set_access_protos to take another parameter and made
sdp_set_access_protos do a call to sdp_set_access_protos_attr to keep
backward compatibility


... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
USS Enterprise Bumperstricker: Our other starship separates into 3
pieces!

--=-TOE9On/keFPmodVSqyZq
Content-Disposition: attachment; filename=bluez_libs_add_access_inc
Content-Type: text/plain; name=bluez_libs_add_access_inc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- bluez-libs-2.22/include/sdp_lib.h	2005-10-29 16:04:28.000000000 -0700
+++ bluez-libs-2.22_new/include/sdp_lib.h	2005-12-01 22:54:36.000000000 -0800
@@ -172,6 +174,7 @@
  * Set the access protocols of the record to those specified in proto
  */
 int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
+int sdp_set_access_protos_attr(sdp_record_t *rec, const sdp_list_t *proto, const uint16_t attr);
 
 /*
  * Get protocol port (i.e. PSM for L2CAP, Channel for RFCOMM) 

--=-TOE9On/keFPmodVSqyZq
Content-Disposition: attachment; filename=bluez_libs_add_access_src
Content-Type: text/plain; name=bluez_libs_add_access_src; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- bluez-libs-2.22/src/sdp.c	2005-10-29 16:04:28.000000000 -0700
+++ bluez-libs-2.22_new/src/sdp.c	2005-12-01 22:55:27.000000000 -0800
@@ -1742,6 +1772,11 @@
  */
 int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 {
+	return(sdp_set_access_protos_attr(rec, ap, SDP_ATTR_PROTO_DESC_LIST));
+}
+
+int sdp_set_access_protos_attr(sdp_record_t *rec, const sdp_list_t *ap, const uint16_t attr)
+{
 	const sdp_list_t *p;
 	sdp_data_t *protos = 0;
 
@@ -1749,7 +1784,7 @@
 		sdp_data_t *seq = access_proto_to_dataseq(rec, (sdp_list_t *)p->data);
 		protos = sdp_seq_append(protos, seq);
 	}
-	sdp_attr_add(rec, SDP_ATTR_PROTO_DESC_LIST, protos);
+	sdp_attr_add(rec, attr, protos);
 	return 0;
 }
 

--=-TOE9On/keFPmodVSqyZq--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
