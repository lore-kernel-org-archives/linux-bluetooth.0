Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Message-ID: <20030915221624.GA17085@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: [Bluez-devel] [PATCH] More SDP UUIDs...
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
Date: Mon, 15 Sep 2003 15:16:24 -0700

	Hi Stephen,

	I've just realised that you didn't keep the UUID and attribute
list of sdptool in sync. The patch below correct this.

	Also : I believe that having in the sdp library all the
functions xxx2str() (uuid2str, sdp_proto_uuid2strn...) and their
associated data (struct tupla ServiceClass...) is not
necessary.
	Realistically, only sdptool or a graphical equivalent would
use those functions, the vast majority of users of the library would
be like 'pand' and only create or search SDP records.
	Moving this functionality to sdptool would allow to reduce
further the size of the SDP library.

	Have fun...

	Jean

-------------------------------------------------------

--- listattr.s1.c	Mon Sep 15 11:59:20 2003
+++ listattr.c	Mon Sep 15 14:55:42 2003
@@ -9,7 +9,7 @@
 /************************** DOCUMENTATION **************************/
 /*
  * This code use a "brute force" approach to parsing SDP records.
- * Instead of a top down approach in sdptool, which pick only know
+ * Instead of a top down approach in sdptool, which pick only known
  * attributes/members, we use a bottom up approach, printing every
  * single bit of the record and trying to associate its defintion
  * to it.
@@ -79,20 +79,27 @@ static char *indent_spaces = "          
  * we need to find what is the service (which is messy) - Jean II */
 #define SERVICE_ATTR	0x1
 
-/* Defintion of the optional arguments in protocol list */
+/* Definition of the optional arguments in protocol list */
 static struct member_def protocol_members[] = {
   { "Protocol" },
   { "Channel/Port" },
   { "Version" },
 };
 
-/* Defintion of the optional arguments in profile list */
+/* Definition of the optional arguments in profile list */
 static struct member_def profile_members[] = {
   { "Profile" },
   { "Version" },
 };
 
-/* Name of the various attributes. See BT assigned numbers */
+/* Definition of the optional arguments in Language list */
+static struct member_def language_members[] = {
+  { "Code ISO639" },
+  { "Encoding" },
+  { "Base Offset" },
+};
+
+/* Name of the various common attributes. See BT assigned numbers */
 static struct attrib_def attrib_names[] = {
   { 0x0, "ServiceRecordHandle", NULL, 0 },
   { 0x1, "ServiceClassIDList", NULL, 0 },
@@ -101,7 +108,8 @@ static struct attrib_def attrib_names[] 
   { 0x4, "ProtocolDescriptorList",
     protocol_members, sizeof(protocol_members)/sizeof(struct member_def) },
   { 0x5, "BrowseGroupList", NULL, 0 },
-  { 0x6, "LanguageBaseAttributeIDList", NULL, 0 },
+  { 0x6, "LanguageBaseAttributeIDList",
+    language_members, sizeof(language_members)/sizeof(struct member_def) },
   { 0x7, "ServiceInfoTimeToLive", NULL, 0 },
   { 0x8, "ServiceAvailability", NULL, 0 },
   { 0x9, "BluetoothProfileDescriptorList",
@@ -126,6 +134,17 @@ static struct attrib_def browse_attrib_n
   { 0x200, "GroupID", NULL, 0 },
 };
 
+/* Name of the various PAN attributes. See BT assigned numbers */
+/* Note : those need to be double checked - Jean II */
+static struct attrib_def pan_attrib_names[] = {
+  { 0x200, "IpSubnet", NULL, 0 },		/* Obsolete ??? */
+  { 0x30A, "SecurityDescription", NULL, 0 },
+  { 0x30B, "NetAccessType", NULL, 0 },
+  { 0x30C, "MaxNetAccessrate", NULL, 0 },
+  { 0x30D, "IPv4Subnet", NULL, 0 },
+  { 0x30E, "IPv6Subnet", NULL, 0 },
+};
+
 /* Same for the UUIDs. See BT assigned numbers */
 static struct uuid_def uuid16_names[] = {
   /* -- Protocols -- */
@@ -165,12 +184,40 @@ static struct uuid_def uuid16_names[] = 
   { 0x1105, "OBEXObjectPush", NULL, 0 },
   { 0x1106, "OBEXFileTransfer", NULL, 0 },
   { 0x1107, "IrMCSyncCommand", NULL, 0 },
+  { 0x1108, "Headset", NULL, 0 },
+  { 0x1109, "CordlessTelephony", NULL, 0 },
   /* ... */
-  { 0x1115, "PANU (PAN/BNEP)", NULL, 0 },
-  { 0x1116, "NAP (PAN/BNEP)", NULL, 0 },
-  { 0x1117, "GN (PAN/BNEP)", NULL, 0 },
+  { 0x110F, "VideoConferencing", NULL, 0 },
+  { 0x1110, "Intercom", NULL, 0 },
+  { 0x1111, "Fax", NULL, 0 },
+  { 0x1112, "HeadsetAudioGateway", NULL, 0 },
+  { 0x1113, "WAP", NULL, 0 },
+  { 0x1114, "WAP_CLIENT", NULL, 0 },
+  { 0x1115, "PANU (PAN/BNEP)",
+    pan_attrib_names, sizeof(pan_attrib_names)/sizeof(struct attrib_def) },
+  { 0x1116, "NAP (PAN/BNEP)",
+    pan_attrib_names, sizeof(pan_attrib_names)/sizeof(struct attrib_def) },
+  { 0x1117, "GN (PAN/BNEP)",
+    pan_attrib_names, sizeof(pan_attrib_names)/sizeof(struct attrib_def) },
+  { 0x1118, "DirectPrinting (BPP)", NULL, 0 },
+  { 0x1119, "ReferencePrinting (BPP)", NULL, 0 },
   /* ... */
+  { 0x1120, "DirectPrintingReferenceObjectsService (BPP)", NULL, 0 },
+  { 0x1121, "ReflectedUI (BPP)", NULL, 0 },
+  { 0x1122, "BasicPrinting (BPP)", NULL, 0 },
+  { 0x1123, "PrintingStatus (BPP)", NULL, 0 },
+  { 0x1124, "HumanInterfaceDeviceService (HID)", NULL, 0 },
+  { 0x1125, "HardcopyCableReplacement (HCR)", NULL, 0 },
+  { 0x1126, "HCR_Print (HCR)", NULL, 0 },
+  { 0x1127, "HCR_Scan (HCR)", NULL, 0 },
   { 0x1128, "Common ISDN Access (CIP)", NULL, 0 },
+  { 0x1129, "VideoConferencingGW (VCP)", NULL, 0 },
+  /* ... */
+  { 0x1200, "PnPInformation", NULL, 0 },
+  { 0x1201, "GenericNetworking", NULL, 0 },
+  { 0x1202, "GenericFileTransfer", NULL, 0 },
+  { 0x1203, "GenericAudio", NULL, 0 },
+  { 0x1204, "GenericTelephony", NULL, 0 },
 };
 
 const int uuid16_max = sizeof(uuid16_names)/sizeof(struct uuid_def);
@@ -340,7 +387,6 @@ void sdp_data_printf(sdp_data_t *sdpdata
 	case SDP_ALT16:
 	case SDP_ALT32:
 		printf("%.*sData Sequence Alternates\n", indent, indent_spaces);
-		/* Not tested, and I believe it's bogus - Jean II */
 		printf_dataseq(sdpdata->val.dataseq, context, indent);
 		break;
 	}



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
