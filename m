Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45DD67FD.8050307@access-company.com>
Date: Thu, 22 Feb 2007 10:53:01 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45DB19E9.5080709@access-company.com>	<1172059615.7403.7.camel@violet>
	<45DC675F.8010508@access-company.com>	<1172073075.7403.37.camel@violet>
	<45DC766D.1000903@access-company.com>
	<1172077056.7403.40.camel@violet>
In-Reply-To: <1172077056.7403.40.camel@violet>
Content-Type: multipart/mixed; boundary="------------050807080101070500070402"
Subject: Re: [Bluez-devel] pan profile sdp record
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050807080101070500070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Marcel,
> for an initial patch, I think we only change sdp.c with appropriate
> default values to make it specification conform. 
>   
Here is new patch proposal.

Frédéric

--------------050807080101070500070402
Content-Type: text/x-patch;
 name="pand-sdp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pand-sdp.patch"

? Doxyfile
? Makefile.in
? aclocal.m4
? autom4te.cache
? bluezutils.kdevelop
? bluezutils.kdevelop.pcs
? bluezutils.kdevses
? config.guess
? config.h.in
? config.sub
? configure
? debug
? depcomp
? install-sh
? ltmain.sh
? missing
? stamp-h.in
? alsa/Makefile.in
? audio/Makefile.in
? common/Makefile.in
? cups/Makefile.in
? daemon/Makefile.in
? daemon/bt.echod
? daemon/service-agent-glue.h
? dund/Makefile.in
? eglib/Makefile.in
? fuse/Makefile.in
? hcid/Makefile.in
? hidd/Makefile.in
? input/Makefile.in
? network/Makefile.in
? pand/Makefile.in
? print/Makefile.in
? rfcomm/Makefile.in
? rfcomm/cvs
? sbc/Makefile.in
? scripts/Makefile.in
? sdpd/Makefile.in
? serial/Makefile.in
? sync/Makefile.in
? test/Makefile.in
? tools/Makefile.in
? transfer/Makefile.in
Index: pand/sdp.c
===================================================================
RCS file: /cvsroot/bluez/utils/pand/sdp.c,v
retrieving revision 1.8
diff -u -r1.8 sdp.c
--- pand/sdp.c	13 Jan 2007 17:48:25 -0000	1.8
+++ pand/sdp.c	22 Feb 2007 09:39:44 -0000
@@ -53,6 +53,20 @@
 	sdp_close(session);
 }
 
+static void add_lang_attr(sdp_record_t *r)
+{
+	sdp_lang_attr_t base_lang;
+	sdp_list_t *langs = 0;
+
+	/* UTF-8 MIBenum (http://www.iana.org/assignments/character-sets) */
+	base_lang.code_ISO639 = (0x65 << 8) | 0x6e;
+	base_lang.encoding = 106;
+	base_lang.base_offset = SDP_PRIMARY_LANG_BASE;
+	langs = sdp_list_append(0, &base_lang);
+	sdp_set_lang_attr(r, langs);
+	sdp_list_free(langs, 0);
+}
+
 int bnep_sdp_register(bdaddr_t *device, uint16_t role)
 {
 	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
@@ -61,6 +75,11 @@
 	sdp_list_t *proto[2];
 	sdp_data_t *v, *p;
 	uint16_t psm = 15, version = 0x0100;
+	uint16_t security_desc = 0;
+	uint16_t net_access_type = 0xFFFE;
+	uint32_t max_net_access_rate = 0;
+	char *name = "BlueZ PAN";
+	char *desc = "BlueZ PAN Service";
 	int status;
 
 	session = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, 0);
@@ -118,12 +137,16 @@
 	
 	aproto   = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
+
+	add_lang_attr(record);
+
 	sdp_list_free(proto[0], NULL);
 	sdp_list_free(proto[1], NULL);
 	sdp_list_free(apseq, NULL);
 	sdp_list_free(aproto, NULL);
 	sdp_data_free(p);
 	sdp_data_free(v);
+	sdp_attr_add_new(record, SDP_ATTR_SECURITY_DESC, SDP_UINT16, &security_desc);
 
 	switch (role) {
 	case BNEP_SVC_NAP:
@@ -136,7 +159,10 @@
 		pfseq = sdp_list_append(NULL, &profile[0]);
 		sdp_set_profile_descs(record, pfseq);
 
-		sdp_set_info_attr(record, "Network Access Point", NULL, NULL);
+		sdp_set_info_attr(record, "Network Access Point", name, desc);
+
+		sdp_attr_add_new(record, SDP_ATTR_NET_ACCESS_TYPE, SDP_UINT16, &net_access_type);
+		sdp_attr_add_new(record, SDP_ATTR_MAX_NET_ACCESSRATE, SDP_UINT32, &max_net_access_rate);
 		break;
 
 	case BNEP_SVC_GN:
@@ -149,7 +175,7 @@
 		pfseq = sdp_list_append(NULL, &profile[0]);
 		sdp_set_profile_descs(record, pfseq);
 		
-		sdp_set_info_attr(record, "Group Network Service", NULL, NULL);
+		sdp_set_info_attr(record, "Group Network Service", name, desc);
 		break;
 
 	case BNEP_SVC_PANU:
@@ -164,7 +190,7 @@
 		sdp_set_profile_descs(record, pfseq);
 		sdp_list_free(pfseq, 0);
 
-		sdp_set_info_attr(record, "PAN User", NULL, NULL);
+		sdp_set_info_attr(record, "PAN User", name, desc);
 		break;
 	}
 

--------------050807080101070500070402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050807080101070500070402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050807080101070500070402--
