Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45DC675F.8010508@access-company.com>
Date: Wed, 21 Feb 2007 16:38:07 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45DB19E9.5080709@access-company.com>
	<1172059615.7403.7.camel@violet>
In-Reply-To: <1172059615.7403.7.camel@violet>
Content-Type: multipart/mixed; boundary="------------060107060703040202010401"
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
--------------060107060703040202010401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Marcel,

>> There are several issues to the problem :
>> - patching pand is easy but some more options are needed to customize 
>> fields (unless good defaults exists)
>>     
>
> we need good default values and some extra parameters to change them. I
> am all for this way.
>   

What about this patch then?
I still have a modified rfcomm man page, so I put it together...

Also, Olivier from access once submitted a dev-down patch. As the patch 
has not been adopted I was wondering if something could be mde better or 
if it was just missed ?

Frédéric.


--------------060107060703040202010401
Content-Type: text/x-patch;
 name="pand-rfcomm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pand-rfcomm.patch"

? Doxyfile
? Makefile
? Makefile.in
? aclocal.m4
? autom4te.cache
? bluezutils.kdevelop
? bluezutils.kdevelop.pcs
? bluezutils.kdevses
? config.guess
? config.h
? config.h.in
? config.log
? config.status
? config.sub
? configure
? debug
? depcomp
? install-sh
? libtool
? ltmain.sh
? missing
? stamp-h.in
? stamp-h1
? alsa/Makefile.in
? audio/.deps
? audio/.libs
? audio/Makefile
? audio/Makefile.in
? audio/bluetoothd-service-audio
? audio/bluetoothd-service-headset
? common/.deps
? common/.libs
? common/Makefile
? common/Makefile.in
? common/test_textfile
? cups/.deps
? cups/.libs
? cups/Makefile
? cups/Makefile.in
? cups/bluetooth
? daemon/.deps
? daemon/.libs
? daemon/Makefile
? daemon/Makefile.in
? daemon/auth-agent
? daemon/bluetoothd
? daemon/bt.echod
? daemon/passkey-agent
? daemon/service-agent-glue.h
? dund/.deps
? dund/.libs
? dund/Makefile
? dund/Makefile.in
? dund/dund
? eglib/.deps
? eglib/.libs
? eglib/Makefile
? eglib/Makefile.in
? eglib/gmain.lo
? eglib/libeglib.la
? fuse/Makefile.in
? hcid/.deps
? hcid/.libs
? hcid/Makefile
? hcid/Makefile.in
? hcid/hcid
? hcid/lexer.c
? hcid/parser.c
? hcid/parser.h
? hidd/.deps
? hidd/.libs
? hidd/Makefile
? hidd/Makefile.in
? hidd/hidd
? input/.deps
? input/Makefile
? input/Makefile.in
? network/.deps
? network/.libs
? network/Makefile
? network/Makefile.in
? network/bluetoothd-service-network
? pand/.deps
? pand/.libs
? pand/Makefile
? pand/Makefile.in
? pand/pand
? print/Makefile
? print/Makefile.in
? rfcomm/.deps
? rfcomm/.libs
? rfcomm/Makefile
? rfcomm/Makefile.in
? rfcomm/cvs
? rfcomm/lexer.c
? rfcomm/main.c.modified
? rfcomm/main.patch
? rfcomm/parser.c
? rfcomm/parser.h
? rfcomm/rfcomm
? sbc/.deps
? sbc/.libs
? sbc/Makefile
? sbc/Makefile.in
? sbc/libsbc.la
? sbc/sbc.lo
? scripts/Makefile
? scripts/Makefile.in
? sdpd/.deps
? sdpd/.libs
? sdpd/Makefile
? sdpd/Makefile.in
? sdpd/sdpd
? serial/Makefile
? serial/Makefile.in
? sync/.deps
? sync/Makefile
? sync/Makefile.in
? test/.deps
? test/Makefile
? test/Makefile.in
? tools/.deps
? tools/.libs
? tools/Makefile
? tools/Makefile.in
? tools/ciptool
? tools/hciattach
? tools/hciconfig
? tools/hcisecfilter
? tools/hcitool
? tools/l2ping
? tools/ppporc
? tools/sdptool
? transfer/.deps
? transfer/Makefile
? transfer/Makefile.in
Index: pand/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/pand/main.c,v
retrieving revision 1.27
diff -u -r1.27 main.c
--- pand/main.c	13 Jan 2007 17:48:25 -0000	1.27
+++ pand/main.c	21 Feb 2007 15:25:07 -0000
@@ -56,6 +56,14 @@
 static uint16_t role    = BNEP_SVC_PANU;	/* Local role (ie service) */
 static uint16_t service = BNEP_SVC_NAP;		/* Remote service */
 
+static	struct bnep_sdp_infos infos = {
+	.security_desc = 0,
+	.net_access_type = 0xFFFE,
+	.max_net_access_rate = 0,
+	.name = "Bluez PAN",
+	.desc = "Bluez PAN Network Service"
+};
+
 static int detach = 1;
 static int persist;
 static int use_sdp = 1;
@@ -132,7 +140,7 @@
 	int sk, lm;
 
 	if (use_sdp)
-		bnep_sdp_register(&src_addr, role);
+		bnep_sdp_register(&src_addr, role, &infos);
 
 	/* Create L2CAP socket and bind it to PSM BNEP */
 	sk = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
@@ -514,6 +522,9 @@
 	{ "ethernet", 1, 0, 'e' },
 	{ "device",   1, 0, 'i' },
 	{ "nosdp",    0, 0, 'D' },
+	{ "security", 0, 0, 'y' },
+	{ "access",   0, 0, 'a' },
+	{ "maxrate",  0, 0, 'm' },
 	{ "list",     0, 0, 'l' },
 	{ "show",     0, 0, 'l' },
 	{ "nodetach", 0, 0, 'n' },
@@ -529,7 +540,7 @@
 	{ 0, 0, 0, 0 }
 };
 
-static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::DQ::AESMC::P:u:z";
+static char main_sopts[] = "hsc:k:Kr:d:e:i:lnp::Dy:a:m:Q::AESMC::P:u:z";
 
 static char main_help[] = 
 	"Bluetooth PAN daemon version " VERSION " \n"
@@ -548,6 +559,9 @@
 	"\t--ethernet -e <name>      Network interface name\n"
 	"\t--device -i <bdaddr>      Source bdaddr\n"
 	"\t--nosdp -D                Disable SDP\n"
+	"\t--security -y             SDP Security Description attribute\n"
+	"\t--access -a               SDP Net Access Type attribute\n"
+	"\t--maxrate -m              SDP Max Access Rate attribute\n"
 	"\t--auth -A                 Enable authentication\n"
 	"\t--encrypt -E              Enable encryption\n"
 	"\t--secure -S               Secure connection\n"
@@ -614,6 +628,18 @@
 			use_sdp = 0;
 			break;
 
+		case 'y':
+			infos.security_desc = atoi(optarg);
+			break;
+
+		case 'a':
+			infos.net_access_type = atoi(optarg);
+			break;
+
+		case 'm':
+			infos.max_net_access_rate = atoi(optarg);
+			break;
+
 		case 'A':
 			link_mode |= L2CAP_LM_AUTH;
 			break;
Index: pand/pand.1
===================================================================
RCS file: /cvsroot/bluez/utils/pand/pand.1,v
retrieving revision 1.6
diff -u -r1.6 pand.1
--- pand/pand.1	4 Jun 2006 13:05:36 -0000	1.6
+++ pand/pand.1	21 Feb 2007 15:25:07 -0000
@@ -42,6 +42,15 @@
 \fB\-\-nosdp\fR \fB\-D\fR
 Disable SDP
 .TP
+\fB\-\-security\fR \fB\-y\fR
+SDP Security Description attribute
+.TP
+\fB\-\-access\fR \fB\-a\fR
+SDP Net Access Type attribute
+.TP
+\fB\-\-maxrate\fR \fB\-m\fR
+SDP Max Access Rate attribute
+.TP
 \fB\-\-encrypt\fR \fB\-E\fR
 Enable encryption
 .TP
Index: pand/pand.h
===================================================================
RCS file: /cvsroot/bluez/utils/pand/pand.h,v
retrieving revision 1.7
diff -u -r1.7 pand.h
--- pand/pand.h	13 Jan 2007 17:48:25 -0000	1.7
+++ pand/pand.h	21 Feb 2007 15:25:07 -0000
@@ -36,7 +36,16 @@
 int bnep_accept_connection(int sk, uint16_t role, char *dev);
 int bnep_create_connection(int sk, uint16_t role, uint16_t svc, char *dev);
 
+/* SDP structs */
+struct bnep_sdp_infos {
+	uint16_t security_desc;
+	uint16_t net_access_type;
+	uint32_t max_net_access_rate;
+	char *name;
+	char *desc;
+};
+
 /* SDP functions */
-int  bnep_sdp_register(bdaddr_t *device, uint16_t role);
+int  bnep_sdp_register(bdaddr_t *device, uint16_t role, struct bnep_sdp_infos *infos);
 void bnep_sdp_unregister(void);
 int  bnep_sdp_search(bdaddr_t *src, bdaddr_t *dst, uint16_t service);
Index: pand/sdp.c
===================================================================
RCS file: /cvsroot/bluez/utils/pand/sdp.c,v
retrieving revision 1.8
diff -u -r1.8 sdp.c
--- pand/sdp.c	13 Jan 2007 17:48:25 -0000	1.8
+++ pand/sdp.c	21 Feb 2007 15:25:07 -0000
@@ -53,7 +53,21 @@
 	sdp_close(session);
 }
 
-int bnep_sdp_register(bdaddr_t *device, uint16_t role)
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
+int bnep_sdp_register(bdaddr_t *device, uint16_t role, struct bnep_sdp_infos *infos)
 {
 	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
 	uuid_t root_uuid, pan, l2cap, bnep;
@@ -118,12 +132,16 @@
 	
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
+	sdp_attr_add_new(record, SDP_ATTR_SECURITY_DESC, SDP_UINT16, &infos->security_desc);
 
 	switch (role) {
 	case BNEP_SVC_NAP:
@@ -136,7 +154,10 @@
 		pfseq = sdp_list_append(NULL, &profile[0]);
 		sdp_set_profile_descs(record, pfseq);
 
-		sdp_set_info_attr(record, "Network Access Point", NULL, NULL);
+		sdp_set_info_attr(record, "Network Access Point", infos->name, infos->desc);
+
+		sdp_attr_add_new(record, SDP_ATTR_NET_ACCESS_TYPE, SDP_UINT16, &infos->net_access_type);
+		sdp_attr_add_new(record, SDP_ATTR_MAX_NET_ACCESSRATE, SDP_UINT32, &infos->max_net_access_rate);
 		break;
 
 	case BNEP_SVC_GN:
@@ -149,9 +170,10 @@
 		pfseq = sdp_list_append(NULL, &profile[0]);
 		sdp_set_profile_descs(record, pfseq);
 		
-		sdp_set_info_attr(record, "Group Network Service", NULL, NULL);
+		sdp_set_info_attr(record, "Group Network Service", infos->name, infos->desc);
 		break;
 
+
 	case BNEP_SVC_PANU:
 		sdp_uuid16_create(&pan, PANU_SVCLASS_ID);
 		svclass = sdp_list_append(NULL, &pan);
@@ -164,7 +186,7 @@
 		sdp_set_profile_descs(record, pfseq);
 		sdp_list_free(pfseq, 0);
 
-		sdp_set_info_attr(record, "PAN User", NULL, NULL);
+		sdp_set_info_attr(record, "PAN User", infos->name, infos->desc);
 		break;
 	}
 
Index: rfcomm/rfcomm.1
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/rfcomm.1,v
retrieving revision 1.6
diff -u -r1.6 rfcomm.1
--- rfcomm/rfcomm.1	24 Dec 2006 13:49:04 -0000	1.6
+++ rfcomm/rfcomm.1	21 Feb 2007 15:25:07 -0000
@@ -53,6 +53,14 @@
 .TP
 .BI -i " <hciX> | <bdaddr>"
 The command is applied to device
+.BI -A
+Enable authentification
+.BI -E
+Enable encryption
+.BI -S
+Secure connection
+.BI -M
+Become the master of a piconet
 .I
 hciX
 , which must be the name or the address of an installed Bluetooth

--------------060107060703040202010401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------060107060703040202010401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060107060703040202010401--
