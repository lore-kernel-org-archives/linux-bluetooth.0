Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-hoy1sFjFqlpTIKr8ImUf"
Message-Id: <1075827176.13285.82.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Device specific configuration
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 03 Feb 2004 17:52:56 +0100


--=-hoy1sFjFqlpTIKr8ImUf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Folks,

this is the patch for the device specific configuration of hcid, that I
am going to apply. Comments?

Regards

Marcel


--=-hoy1sFjFqlpTIKr8ImUf
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: hcid/hcid.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/hcid.h,v
retrieving revision 1.6
diff -u -b -w -B -r1.6 hcid.h
--- hcid/hcid.h	7 Mar 2003 23:10:30 -0000	1.6
+++ hcid/hcid.h	3 Feb 2004 16:52:26 -0000
@@ -26,10 +27,10 @@
 
 #include <sys/types.h>
 
-#include "glib-ectomy.h"
-
 #include <bluetooth/bluetooth.h>
 
+#include "glib-ectomy.h"
+
 #define HCID_CONFIG_FILE "/etc/bluetooth/hcid.conf"
 #define HCID_PIN_FILE    "/etc/bluetooth/pin"
 #define HCID_KEY_FILE    "/etc/bluetooth/link_key"
@@ -45,7 +46,15 @@
 	uint16_t auth;
 	uint16_t encrypt;
 };   
-extern struct device_opts devi;
+
+extern struct device_opts default_device;
+extern struct device_opts *parser_device;
+
+struct device_list {
+	char *ref;			/* HCI device or Bluetooth address */
+	struct device_list *next;
+	struct device_opts opts;
+};
 
 struct link_key {
 	bdaddr_t sba;
@@ -83,6 +92,8 @@
 #define HCID_PAIRING_ONCE	2
 
 int read_config(char *file);
+
+struct device_opts *alloc_device_opts(char *addr);
 
 gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data);
 gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data);
Index: hcid/lexer.l
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/lexer.l,v
retrieving revision 1.2
diff -u -b -w -B -r1.2 lexer.l
--- hcid/lexer.l	24 Jun 2002 02:38:01 -0000	1.2
+++ hcid/lexer.l	3 Feb 2004 16:52:26 -0000
@@ -52,6 +52,9 @@
 fname		[A-Za-z0-9\_\.\-]+	
 path		(\/{fname})+
 string		\".*\"
+hci		hci[0-9]+
+hextuple	[0-9a-zA-Z][0-9a-zA-Z]
+bdaddr		{hextuple}:{hextuple}:{hextuple}:{hextuple}:{hextuple}:{hextuple}
 
 %x OPTION PARAM  
 
@@ -68,6 +71,16 @@
 
 \n {
 	lineno++;
+}
+
+{hci} {
+	yylval.str = yytext;
+	return HCI;
+}
+
+{bdaddr} {
+	yylval.str = yytext;
+	return BDADDR;
 }
 
 {hex} {
Index: hcid/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/main.c,v
retrieving revision 1.9
diff -u -b -w -B -r1.9 main.c
--- hcid/main.c	7 Mar 2003 23:10:30 -0000	1.9
+++ hcid/main.c	3 Feb 2004 16:52:26 -0000
@@ -50,7 +51,9 @@
 #include "lib.h"
 
 struct hcid_opts hcid;
-struct device_opts devi;
+struct device_opts default_device;
+struct device_opts *parser_device;
+static struct device_list *device_list = NULL;
 
 static GMainLoop *event_loop;
 
@@ -64,8 +67,93 @@
 	printf("\thcid [-n not_daemon] [-f config file]\n");
 }
 
+static inline void init_device_defaults(struct device_opts *device_opts)
+{
+	memset(device_opts, 0, sizeof(*device_opts));
+	device_opts->scan = SCAN_PAGE | SCAN_INQUIRY;
+}
+
+struct device_opts *alloc_device_opts(char *ref)
+{
+	struct device_list *device;
+
+	device = malloc(sizeof(struct device_list));
+	if (!device) {
+		syslog(LOG_INFO, "Can't allocate devlist opts buffer. %s(%d)", 
+			strerror(errno), errno);
+		exit(1);
+	}
+
+	device->ref = ref;
+	device->next = device_list;
+	device_list = device;
+
+	init_device_defaults(&device->opts);
+
+	return &device->opts;
+}
+
+static void free_device_opts(void)
+{
+	struct device_list *device, *next;
+
+	if (default_device.name) {
+		free(default_device.name);
+		default_device.name = NULL;
+	}
+
+	for (device = device_list; device; device = next) {
+		free(device->ref);
+		if (device->opts.name)
+			free(device->opts.name);
+		next = device->next;
+		free(device);
+	}
+
+	device_list = NULL;
+}
+
+static inline struct device_opts *find_device_opts(char *ref)
+{
+	struct device_list *device;
+
+	for (device = device_list; device; device = device->next)
+		if (!strcmp(ref, device->ref))
+			return &device->opts;
+
+	return NULL;
+}
+
+static struct device_opts *get_device_opts(int sock, int hdev)
+{
+	struct device_opts *device_opts = NULL;
+	struct hci_dev_info di;
+
+	/* First try to get BD_ADDR based settings ... */
+	di.dev_id = hdev;
+	if (!ioctl(sock, HCIGETDEVINFO, (void *) &di)) {
+		char addr[18];
+		ba2str(&di.bdaddr, addr);
+		device_opts = find_device_opts(addr);
+	}
+
+	/* ... then try HCI based settings ... */
+	if (!device_opts) {
+		char ref[8];
+		snprintf(ref, sizeof(ref) - 1, "hci%d", hdev);
+		device_opts = find_device_opts(ref);
+	}
+
+	/* ... and last use the default settings. */
+	if (!device_opts)
+		device_opts = &default_device;
+
+	return device_opts;
+}
+
 static void configure_device(int hdev)
 {
+	struct device_opts *device_opts;
 	struct hci_dev_req dr;
 	int s;
 
@@ -88,16 +176,17 @@
 	}
 
 	dr.dev_id  = hdev;
+	device_opts = get_device_opts(s, hdev);
 
 	/* Set scan mode */
-	dr.dev_opt = devi.scan;
+	dr.dev_opt = device_opts->scan;
 	if (ioctl(s, HCISETSCAN, (unsigned long)&dr) < 0) {
 		syslog(LOG_ERR, "Can't set scan mode on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
 	}
 
 	/* Set authentication */
-	if (devi.auth)
+	if (device_opts->auth)
 		dr.dev_opt = AUTH_ENABLED;
 	else
 		dr.dev_opt = AUTH_DISABLED;
@@ -108,7 +197,7 @@
 	}
 
 	/* Set encryption */
-	if (devi.encrypt)
+	if (device_opts->encrypt)
 		dr.dev_opt = ENCRYPT_P2P;
 	else
 		dr.dev_opt = ENCRYPT_DISABLED;
@@ -119,8 +208,8 @@
 	}
 
         /* Set device class */
-	if (devi.class) {
-		uint32_t class = htobl(devi.class);
+	if (device_opts->class) {
+		uint32_t class = htobl(device_opts->class);
 		write_class_of_dev_cp cp;
                 
 		memcpy(cp.dev_class, &class, 3);
@@ -129,9 +218,9 @@
 	}
 
 	/* Set device name */
-	if (devi.name) {
+	if (device_opts->name) {
 		change_local_name_cp cp;
-		expand_name(cp.name, devi.name, hdev);
+		expand_name(cp.name, device_opts->name, hdev);
 
 		hci_send_cmd(s, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
 			CHANGE_LOCAL_NAME_CP_SIZE, (void *) &cp);
@@ -142,6 +231,7 @@
 
 static void init_device(int hdev)
 {
+	struct device_opts *device_opts;
 	struct hci_dev_req dr;
 	int s;
 
@@ -171,10 +261,11 @@
 	}
 
 	dr.dev_id  = hdev;
+	device_opts = get_device_opts(s, hdev);
 
 	/* Set packet type */
-	if (devi.pkt_type) {
-		dr.dev_opt = devi.pkt_type;
+	if (device_opts->pkt_type) {
+		dr.dev_opt = device_opts->pkt_type;
 		if (ioctl(s, HCISETPTYPE, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set packet type on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -182,8 +273,8 @@
 	}
 
 	/* Set link mode */
-	if (devi.link_mode) {
-		dr.dev_opt = devi.link_mode;
+	if (device_opts->link_mode) {
+		dr.dev_opt = device_opts->link_mode;
 		if (ioctl(s, HCISETLINKMODE, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set link mode on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -191,8 +282,8 @@
 	}
 
 	/* Set link policy */
-	if (devi.link_policy) {
-		dr.dev_opt = devi.link_policy;
+	if (device_opts->link_policy) {
+		dr.dev_opt = device_opts->link_policy;
 		if (ioctl(s, HCISETLINKPOL, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set link policy on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -216,7 +307,7 @@
 	dl->dev_num = HCI_MAX_DEV;
 	dr = dl->dev_req;
 
-	if (ioctl(ctl, HCIGETDEVLIST, (void*)dl)) {
+	if (ioctl(ctl, HCIGETDEVLIST, (void *) dl) < 0) {
 		syslog(LOG_INFO, "Can't get device list. %s(%d)",
 			strerror(errno), errno);
 		exit(1);
@@ -241,10 +332,7 @@
 	hcid.auto_init = 0;
 	hcid.security  = 0;
 
-	devi.pkt_type = 0;
-	devi.scan = SCAN_PAGE | SCAN_INQUIRY;
-	devi.auth = 0;
-	devi.encrypt = 0;
+	init_device_defaults(&default_device);
 }
 
 static void sig_usr1(int sig)
@@ -466,6 +556,8 @@
 
 	/* Start event processor */
 	g_main_run(event_loop);
+
+	free_device_opts();
 
 	syslog(LOG_INFO, "Exit.");
 	return 0;
Index: hcid/parser.y
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/parser.y,v
retrieving revision 1.5
diff -u -b -w -B -r1.5 parser.y
--- hcid/parser.y	20 Aug 2002 18:42:12 -0000	1.5
+++ hcid/parser.y	3 Feb 2004 16:52:26 -0000
@@ -61,18 +61,18 @@
 %token K_PINHELP
 %token K_YES K_NO
 
-%token <str> WORD PATH STRING LIST
+%token <str> WORD PATH STRING LIST HCI BDADDR
 %token <num> NUM
 
 %type  <num> bool pkt_type link_mode link_policy sec_mode pair_mode
-%type  <str> dev_name
+%type  <str> dev_name hci bdaddr
 
 %%
 config: statement | config statement;
 statement: 
   K_OPTIONS hcid_options
  
-  | K_DEVICE device_options
+  | device device_options
 
   | WORD	{
 			cfg_error("Invalid statement '%s'", $1);
@@ -82,6 +83,20 @@
 		}
   ;
 
+device:
+  K_DEVICE		{
+				parser_device = &default_device;
+			}
+
+  | K_DEVICE hci	{
+				parser_device = alloc_device_opts($2);
+			}
+
+  | K_DEVICE bdaddr	{
+				parser_device = alloc_device_opts($2);
+			}
+  ;
+
 hcid_options: '{' hcid_opts '}';
 hcid_opts: | hcid_opt ';' | error ';' | hcid_opts hcid_opt ';';
 hcid_opt: 
@@ -118,7 +133,9 @@
 				$$ = opt;
 		}
 
-  | K_NO	{ 	$$ = HCID_SEC_NONE; 	}
+  | K_NO	{
+			$$ = HCID_SEC_NONE;
+		}
   ;
 
 pair_mode:
@@ -137,47 +154,47 @@
 device_opts: | device_opt ';' | error ';' | device_opts device_opt ';';
 device_opt:
   K_PTYPE pkt_type	{
-				devi.pkt_type = $2;
+				parser_device->pkt_type = $2;
 			}
 
   | K_LM link_mode	{
-				devi.link_mode = $2;
+				parser_device->link_mode = $2;
 			}
 
   | K_LP link_policy	{
-				devi.link_policy = $2;
+				parser_device->link_policy = $2;
 			}
 
   | K_NAME dev_name	{  
-				if (devi.name)
-					free(devi.name);
-				devi.name = $2;
+				if (parser_device->name)
+					free(parser_device->name);
+				parser_device->name = $2;
 			}
 
   | K_CLASS NUM		{
-				devi.class = $2;
+				parser_device->class = $2;
 			}
 
   | K_AUTH bool		{
-				devi.auth = $2;
+				parser_device->auth = $2;
 			}
 
   | K_ENCRYPT bool	{
-				devi.encrypt = $2;
+				 parser_device->encrypt = $2;
 			}
 
   | K_ISCAN bool	{
 				if ($2)
-					devi.scan |=  SCAN_INQUIRY;
+					parser_device->scan |=  SCAN_INQUIRY;
 				else
-					devi.scan &= ~SCAN_INQUIRY;
+					parser_device->scan &= ~SCAN_INQUIRY;
 			}
 
   | K_PSCAN bool	{
 				if ($2)
-					devi.scan |=  SCAN_PAGE;
+					parser_device->scan |=  SCAN_PAGE;
 				else
-					devi.scan &= ~SCAN_PAGE;
+					parser_device->scan &= ~SCAN_PAGE;
 			}
 
   | WORD		{
@@ -196,6 +213,18 @@
 		}
   ;
 
+hci:
+  HCI		{
+			$$ = strdup($1);
+		}
+  ;
+
+bdaddr:
+  BDADDR	{
+			$$ = strdup($1);
+		}
+  ;
+
 pkt_type:
   WORD 	 	{
 			int opt;

--=-hoy1sFjFqlpTIKr8ImUf--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
