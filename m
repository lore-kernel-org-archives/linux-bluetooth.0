Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Arjan van de Ven <bluetooth@fenrus.demon.nl>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1137340560.3001.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Patch to add a --dailup option to dund, needed to make TomTomGo
 navigators connect to linux
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
Date: Sun, 15 Jan 2006 16:56:00 +0100

Hi,

Below is a patch to dund that adds a -dailup option. This option changes
the class that is advertized by dund to be "dailup", TomTom Go
navigators require this to connect to (they only want to connect to
phones normally ;)

http://www.fenrus.org/tomtom has a howto-in-progress on how to use the
linux bluez stack to connect a tomtom go to the internet, this patch is
one of the more hairy aspects of this, so it'd be nice if this got
merged...

In addition I suspect that tomtom isn't the only one wanting a dailup
device, so it ought to be a pretty generic feature.

Greetings,
   Arjan van de Ven

diff -purN bluez-utils-org/dund/dund.h bluez-utils-2.22/dund/dund.h
--- bluez-utils-org/dund/dund.h	2005-10-30 01:04:28.000000000 +0200
+++ bluez-utils-2.22/dund/dund.h	2006-01-15 16:45:02.000000000 +0100
@@ -33,6 +33,7 @@
 #define LANACCESS	0
 #define MROUTER		1
 #define ACTIVESYNC	2
+#define DAILUP		3
 
 /* DUN functions */
 int dun_init(void);
diff -purN bluez-utils-org/dund/main.c bluez-utils-2.22/dund/main.c
--- bluez-utils-org/dund/main.c	2005-10-30 01:04:28.000000000 +0200
+++ bluez-utils-2.22/dund/main.c	2006-01-15 16:44:51.000000000 +0100
@@ -398,10 +398,11 @@ static struct option main_lopts[] = {
 	{ "msdun",	2, 0, 'X' },
 	{ "activesync",	0, 0, 'a' },
 	{ "mrouter",	1, 0, 'm' },
+	{ "dailup",	1, 0, 'u' },
 	{ 0, 0, 0, 0 }
 };
 
-static char main_sopts[] = "hsc:k:Kr:i:lnp::DQ::AESMP:C::P:Xa";
+static char main_sopts[] = "hsc:k:Kr:i:lnp::DQ::AESMP:C::P:Xam:u";
 
 static char main_help[] = 
 	"Bluetooth LAP (LAN Access over PPP) daemon version " VERSION " \n"
@@ -412,6 +413,7 @@ static char main_help[] = 
 	"\t--listen -s               Listen for LAP connections\n"
 	"\t--connect -c <bdaddr>     Create LAP connection\n"
 	"\t--mrouter -m <bdaddr>     Create mRouter connection\n"
+	"\t--dailup -u               Pretend to be a dailup/telephone\n"
 	"\t--search -Q[duration]     Search and connect\n"
 	"\t--kill -k <bdaddr>        Kill LAP connection\n"
 	"\t--killall -K              Kill all LAP connections\n"
@@ -539,6 +541,11 @@ int main(int argc, char **argv)
 			type = MROUTER;
 			break;
 
+		case 'u':
+			mode = LISTEN;
+			type = DAILUP;
+			break;
+
 		case 'h':
 		default:
 			printf(main_help);
diff -purN bluez-utils-org/dund/sdp.c bluez-utils-2.22/dund/sdp.c
--- bluez-utils-org/dund/sdp.c	2005-10-30 01:04:28.000000000 +0200
+++ bluez-utils-2.22/dund/sdp.c	2006-01-15 16:46:21.000000000 +0100
@@ -98,6 +98,9 @@ int dun_sdp_register(bdaddr_t *device, u
 	case ACTIVESYNC:
 		sdp_uuid128_create(&dun, (void *) async_uuid);
 		break;
+	case DAILUP:
+		sdp_uuid16_create(&dun, DIALUP_NET_SVCLASS_ID);
+		break;
 	default:
 		sdp_uuid16_create(&dun, LAN_ACCESS_SVCLASS_ID);
 		break;
@@ -106,7 +109,7 @@ int dun_sdp_register(bdaddr_t *device, u
 	svclass = sdp_list_append(NULL, &dun);
 	sdp_set_service_classes(record, svclass);
 
-	if (type == LANACCESS) {
+	if (type == LANACCESS || type == DAILUP) {
 		sdp_uuid16_create(&profile[0].uuid, LAN_ACCESS_PROFILE_ID);
 		profile[0].version = 0x0100;
 		pfseq = sdp_list_append(NULL, &profile[0]);
@@ -120,6 +123,9 @@ int dun_sdp_register(bdaddr_t *device, u
 	case ACTIVESYNC:
 		sdp_set_info_attr(record, "ActiveSync", NULL, NULL);
 		break;
+	case DAILUP:
+		sdp_set_info_attr(record, "Dialup Networking", NULL, NULL);
+		break;
 	default:
 		sdp_set_info_attr(record, "LAN Access Point", NULL, NULL);
 		break;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
