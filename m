Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp seq of raw data
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1133436800.1190.62.camel@blade>
References: <1133429978.1037.22.camel@panic>
	 <1133430940.1190.28.camel@blade>  <1133431401.1037.33.camel@panic>
	 <1133433996.1190.48.camel@blade>  <1133436216.1037.35.camel@panic>
	 <1133436800.1190.62.camel@blade>
Content-Type: multipart/mixed; boundary="=-80ciQk2pDPio12j3bJUW"
Message-Id: <1133437800.1037.40.camel@panic>
Mime-Version: 1.0
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
Date: Thu, 01 Dec 2005 03:50:00 -0800


--=-80ciQk2pDPio12j3bJUW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,

here are the patches, one for include/sdp_lib.h and one src/for sdp.c.
It adds two new functions but stais backward compatible.

... Collin

PS: it's 4am and I need to go to sleep :-(

On Thu, 2005-12-01 at 12:33 +0100, Marcel Holtmann wrote:
> Hi Collin,
> 
> > Do you accept a patch for this?
> 
> yes :)
> 
> Regards
> 
> Marcel

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Blessed are the Geeks, for they internet the earth!

--=-80ciQk2pDPio12j3bJUW
Content-Disposition: attachment; filename=bluez_libs_raw_data_src
Content-Type: text/plain; name=bluez_libs_raw_data_src; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- bluez-libs-2.22/src/sdp.c	2005-10-29 16:04:28.000000000 -0700
+++ bluez-libs-2.22_new/src/sdp.c	2005-12-01 03:30:05.000000000 -0800
@@ -346,6 +346,11 @@
 
 sdp_data_t *sdp_data_alloc(uint8_t dtd, const void *value)
 {
+	return(sdp_data_alloc_leng(dtd, value, 0));
+}
+
+sdp_data_t *sdp_data_alloc_leng(uint8_t dtd, const void *value, uint32_t leng)
+{
 	sdp_data_t *seq;
 	int len = 0;
 	sdp_data_t *d = (sdp_data_t *) malloc(sizeof(sdp_data_t));
@@ -420,14 +425,15 @@
 		if (!value)
 			goto out_error;
 
-		len = strlen(value);
-		d->unitSize += len;
+		len = leng ? leng : strlen(value);
+		d->unitSize = len - 1;
 		if (len <= USHRT_MAX) {
 			d->val.str = (char *) malloc(len + 1);
 			if (!d->val.str)
 				goto out_error;
 
-			strcpy(d->val.str, value);
+			if (leng) memcpy(d->val.str, value, leng);
+			else strcpy(d->val.str, value);
 			if (len <= UCHAR_MAX) {
 				d->unitSize += sizeof(uint8_t);
 				if (dtd != SDP_URL_STR8 && dtd != SDP_TEXT_STR8) {
@@ -491,6 +497,29 @@
 	return seq;
 }
 
+sdp_data_t *sdp_seq_alloc_leng(void **dtds, void **values, int *leng, int len)
+{
+	sdp_data_t *curr = NULL, *seq = NULL;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		sdp_data_t *data;
+		uint8_t dtd = *(uint8_t *)dtds[i];
+		if (dtd >= SDP_SEQ8 && dtd <= SDP_ALT32)
+			data = (sdp_data_t *)values[i];
+		else
+			data = sdp_data_alloc_leng(dtd, values[i], leng[i]);
+		if (!data)
+			return NULL;
+		if (curr)
+			curr->next = data;
+		else
+			seq = data;
+		curr = data;
+	}
+	return sdp_data_alloc_leng(SDP_SEQ8, seq, leng[i]);
+}
+
 sdp_data_t *sdp_seq_alloc(void **dtds, void **values, int len)
 {
 	sdp_data_t *curr = NULL, *seq = NULL;
@@ -681,7 +710,8 @@
 	case SDP_URL_STR16:
 	case SDP_URL_STR32:
 		src = (unsigned char *)d->val.str;
-		data_size = strlen(d->val.str);
+		//data_size = strlen(d->val.str);
+		data_size = d->unitSize;
 		sdp_set_seq_len(seqp, data_size);
 		break;
 	case SDP_SEQ8:

--=-80ciQk2pDPio12j3bJUW
Content-Disposition: attachment; filename=bluez_libs_raw_data_inc
Content-Type: text/plain; name=bluez_libs_raw_data_inc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- bluez-libs-2.22/include/sdp_lib.h	2005-10-29 16:04:28.000000000 -0700
+++ bluez-libs-2.22_new/include/sdp_lib.h	2005-12-01 02:21:16.000000000 -0800
@@ -102,10 +102,12 @@
  * Basic sdp data functions
  */
 sdp_data_t *sdp_data_alloc(uint8_t dtd, const void *value);
+sdp_data_t *sdp_data_alloc_leng(uint8_t dtd, const void *value, uint32_t leng);
 void sdp_data_free(sdp_data_t *data);
 sdp_data_t *sdp_data_get(const sdp_record_t *rec, uint16_t attr_id);
 
 sdp_data_t *sdp_seq_alloc(void **dtds, void **values, int len);
+sdp_data_t *sdp_seq_alloc_leng(void **dtds, void **values, int *leng, int len);
 sdp_data_t *sdp_seq_append(sdp_data_t *seq, sdp_data_t *data);
 
 int sdp_attr_add(sdp_record_t *rec, uint16_t attr, sdp_data_t *data);

--=-80ciQk2pDPio12j3bJUW--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
