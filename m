Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fredrik Noring <noring@nocrew.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Edd Dumbill <edd@usefulinc.com>
Content-Type: multipart/mixed; boundary="=-Mo3Tvpyp0AW1qyNORTpQ"
Message-Id: <1075316178.553.18.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Bluetooth address specific device configuration
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
Date: Wed, 28 Jan 2004 19:56:18 +0100


--=-Mo3Tvpyp0AW1qyNORTpQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

Attached patch makes it possible to use a configuration in hcid.conf
for a device with a certain Bluetooth device address:

   options
   {
	# hcid options...
   }

   device
   {
	# Default device options...
   }

   device 00:11:22:33:44:55
   {
	# Device options for bdaddr 00:11:22:33:44:55...
   }

It's useful to do persistent device specific configurations, for example
setting unique and meaningful names. I've only done limited testing.

Any thoughts?

Fredrik


--=-Mo3Tvpyp0AW1qyNORTpQ
Content-Disposition: attachment; filename=hcid-addr.patch
Content-Type: text/x-patch; name=hcid-addr.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/hcid/hcid.h bluez-utils-2.4/hcid/hcid.h
--- bluez-utils-2.4.orig/hcid/hcid.h	2003-03-08 00:10:30.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.h	2004-01-28 17:59:44.000000000 +0100
@@ -45,7 +45,14 @@
 	uint16_t auth;
 	uint16_t encrypt;
 };   
-extern struct device_opts devi;
+extern struct device_opts default_device;
+extern struct device_opts *parser_device;
+
+struct device_list {
+	char *bdaddr;
+	struct device_list *next;
+	struct device_opts opts;
+};
 
 struct link_key {
 	bdaddr_t sba;
@@ -84,6 +91,9 @@
 
 int read_config(char *file);
 
+void unlink_device_opts(void);
+struct device_opts *allocate_device_opts(char *bdaddr);
+
 gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data);
 gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data);
 
diff -Naur bluez-utils-2.4.orig/hcid/lexer.l bluez-utils-2.4/hcid/lexer.l
--- bluez-utils-2.4.orig/hcid/lexer.l	2002-06-24 04:38:01.000000000 +0200
+++ bluez-utils-2.4/hcid/lexer.l	2004-01-28 16:21:36.000000000 +0100
@@ -52,6 +52,8 @@
 fname		[A-Za-z0-9\_\.\-]+	
 path		(\/{fname})+
 string		\".*\"
+hextuple        [0-9a-zA-Z][0-9a-zA-Z]
+bdaddr          {hextuple}:{hextuple}:{hextuple}:{hextuple}:{hextuple}:{hextuple}
 
 %x OPTION PARAM  
 
@@ -70,6 +72,11 @@
 	lineno++;
 }
 
+{bdaddr} {
+	yylval.str = yytext;
+	return BDADDR;
+}
+
 {hex} {
 	yylval.num = strtol(yytext, NULL, 16);
 	return NUM;
diff -Naur bluez-utils-2.4.orig/hcid/main.c bluez-utils-2.4/hcid/main.c
--- bluez-utils-2.4.orig/hcid/main.c	2003-03-08 00:10:30.000000000 +0100
+++ bluez-utils-2.4/hcid/main.c	2004-01-28 19:19:46.000000000 +0100
@@ -50,7 +50,9 @@
 #include "lib.h"
 
 struct hcid_opts hcid;
-struct device_opts devi;
+struct device_opts default_device;
+struct device_opts *parser_device;
+static struct device_list *device_list = 0;
 
 static GMainLoop *event_loop;
 
@@ -64,11 +66,31 @@
 	printf("\thcid [-n not_daemon] [-f config file]\n");
 }
 
+static struct device_opts *get_device_opts(bdaddr_t *bdaddr)
+  /* Returns device options for the given BD Address or 0. */
+{
+	struct device_list *device;
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	for (device = device_list; device; device = device->next)
+		if(strcmp(addr, device->bdaddr) == 0)
+			return &device->opts;
+	return 0;
+}
+
 static void configure_device(int hdev)
 {
+        struct device_opts *device_opts = 0;
+	struct hci_dev_info di;
 	struct hci_dev_req dr;
 	int s;
 
+	uint16_t auth;
+	uint16_t encrypt;
+	uint32_t class;
+	char *name;
+
 	/* Do configuration in the separate process */
 	switch (fork()) {
 		case 0:
@@ -88,16 +110,20 @@
 	}
 
 	dr.dev_id  = hdev;
-
+	di.dev_id = hdev;
+	if(ioctl(s, HCIGETDEVINFO, (void*)&di) == 0)
+		device_opts = get_device_opts(&di.bdaddr);
+	
 	/* Set scan mode */
-	dr.dev_opt = devi.scan;
+	dr.dev_opt = device_opts ? device_opts->scan : default_device.scan;
 	if (ioctl(s, HCISETSCAN, (unsigned long)&dr) < 0) {
 		syslog(LOG_ERR, "Can't set scan mode on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
 	}
 
 	/* Set authentication */
-	if (devi.auth)
+	auth = device_opts ? device_opts->auth : default_device.auth;
+	if (auth)
 		dr.dev_opt = AUTH_ENABLED;
 	else
 		dr.dev_opt = AUTH_DISABLED;
@@ -108,7 +134,8 @@
 	}
 
 	/* Set encryption */
-	if (devi.encrypt)
+	encrypt = device_opts ? device_opts->encrypt : default_device.encrypt;
+	if (encrypt)
 		dr.dev_opt = ENCRYPT_P2P;
 	else
 		dr.dev_opt = ENCRYPT_DISABLED;
@@ -119,19 +146,21 @@
 	}
 
         /* Set device class */
-	if (devi.class) {
-		uint32_t class = htobl(devi.class);
+	class = device_opts ? device_opts->class : default_device.class;
+	if (class) {
+		uint32_t dev_class = htobl(class);
 		write_class_of_dev_cp cp;
                 
-		memcpy(cp.dev_class, &class, 3);
+		memcpy(cp.dev_class, &dev_class, 3);
 		hci_send_cmd(s, OGF_HOST_CTL, OCF_WRITE_CLASS_OF_DEV,
 			WRITE_CLASS_OF_DEV_CP_SIZE, (void *) &cp);
 	}
 
 	/* Set device name */
-	if (devi.name) {
+	name = device_opts ? device_opts->name : default_device.name;
+	if (name) {
 		change_local_name_cp cp;
-		expand_name(cp.name, devi.name, hdev);
+		expand_name(cp.name, name, hdev);
 
 		hci_send_cmd(s, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
 			CHANGE_LOCAL_NAME_CP_SIZE, (void *) &cp);
@@ -142,9 +171,15 @@
 
 static void init_device(int hdev)
 {
+        struct device_opts *device_opts = 0;
+	struct hci_dev_info di;
 	struct hci_dev_req dr;
 	int s;
 
+	uint16_t pkt_type;
+	uint16_t link_mode;
+	uint16_t link_policy;
+
 	/* Do initialization in the separate process */
 	switch (fork()) {
 		case 0:
@@ -170,11 +205,15 @@
 		exit(1);
 	}
 
-	dr.dev_id  = hdev;
+	dr.dev_id = hdev;
+	di.dev_id = hdev;
+	if(ioctl(s, HCIGETDEVINFO, (void*)&di) == 0)
+		device_opts = get_device_opts(&di.bdaddr);
 
 	/* Set packet type */
-	if (devi.pkt_type) {
-		dr.dev_opt = devi.pkt_type;
+	pkt_type = device_opts ? device_opts->pkt_type : default_device.pkt_type;
+	if (pkt_type) {
+		dr.dev_opt = pkt_type;
 		if (ioctl(s, HCISETPTYPE, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set packet type on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -182,8 +221,9 @@
 	}
 
 	/* Set link mode */
-	if (devi.link_mode) {
-		dr.dev_opt = devi.link_mode;
+	link_mode = device_opts ? device_opts->link_mode : default_device.link_mode;
+	if (link_mode) {
+		dr.dev_opt = link_mode;
 		if (ioctl(s, HCISETLINKMODE, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set link mode on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -191,8 +231,9 @@
 	}
 
 	/* Set link policy */
-	if (devi.link_policy) {
-		dr.dev_opt = devi.link_policy;
+	link_policy = device_opts ? device_opts->link_policy : default_device.link_policy;
+	if (link_policy) {
+		dr.dev_opt = link_policy;
 		if (ioctl(s, HCISETLINKPOL, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set link policy on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -236,15 +277,59 @@
 	free(dl);
 }
 
+static void init_device_defaults(struct device_opts *device_opts)
+{
+	device_opts->name        = 0;
+	device_opts->class       = 0;
+	device_opts->pkt_type    = 0;
+	device_opts->scan        = SCAN_PAGE | SCAN_INQUIRY;
+	device_opts->link_mode   = 0;
+	device_opts->link_policy = 0;
+	device_opts->auth        = 0;
+	device_opts->encrypt     = 0;
+}
+
 static void init_defaults(void)
 {
 	hcid.auto_init = 0;
 	hcid.security  = 0;
 
-	devi.pkt_type = 0;
-	devi.scan = SCAN_PAGE | SCAN_INQUIRY;
-	devi.auth = 0;
-	devi.encrypt = 0;
+	init_device_defaults(&default_device);
+}
+
+struct device_opts *allocate_device_opts(char *bdaddr)
+{
+	struct device_list *device;
+	
+	device = malloc(sizeof(struct device_list));
+	if (!device)
+	{
+		syslog(LOG_INFO, "Can't allocate devlist opts buffer. %s(%d)", 
+			strerror(errno), errno);
+		exit(1);
+	}
+	
+	device->bdaddr = bdaddr;
+	device->next = device_list;
+	device_list = device;
+
+	init_device_defaults(&device->opts);
+
+	return &device->opts;
+}
+
+void unlink_device_opts(void)
+{
+	struct device_list *device, *next;
+
+	for (device = device_list; device; device = next) {
+		free(device->bdaddr);
+		if(device->opts.name)
+			free(device->opts.name);
+		next = device->next;
+		free(device);
+	}
+	device_list = 0;
 }
 
 static void sig_usr1(int sig)
@@ -467,6 +552,8 @@
 	/* Start event processor */
 	g_main_run(event_loop);
 
+	unlink_device_opts();
+	
 	syslog(LOG_INFO, "Exit.");
 	return 0;
 }
diff -Naur bluez-utils-2.4.orig/hcid/parser.y bluez-utils-2.4/hcid/parser.y
--- bluez-utils-2.4.orig/hcid/parser.y	2002-08-20 20:42:12.000000000 +0200
+++ bluez-utils-2.4/hcid/parser.y	2004-01-28 19:26:19.000000000 +0100
@@ -61,18 +61,18 @@
 %token K_PINHELP
 %token K_YES K_NO
 
-%token <str> WORD PATH STRING LIST
+%token <str> WORD PATH STRING LIST BDADDR
 %token <num> NUM
 
 %type  <num> bool pkt_type link_mode link_policy sec_mode pair_mode
-%type  <str> dev_name
+%type  <str> dev_name bdaddr
 
 %%
 config: statement | config statement;
 statement: 
   K_OPTIONS hcid_options
  
-  | K_DEVICE device_options
+  | device device_options
 
   | WORD	{
 			cfg_error("Invalid statement '%s'", $1);
@@ -82,6 +82,16 @@
 		}
   ;
 
+device:
+    K_DEVICE		{
+				parser_device = &default_device;
+			}
+    
+    | K_DEVICE bdaddr	{
+				parser_device = allocate_device_opts($2);
+			}
+    ;
+
 hcid_options: '{' hcid_opts '}';
 hcid_opts: | hcid_opt ';' | error ';' | hcid_opts hcid_opt ';';
 hcid_opt: 
@@ -137,47 +147,47 @@
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
+				parser_device->encrypt = $2;
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
@@ -196,6 +206,12 @@
 		}
   ;
 
+bdaddr:
+  BDADDR	{  
+			$$ = strdup($1);
+		}
+  ;
+
 pkt_type:
   WORD 	 	{
 			int opt;
@@ -274,6 +290,8 @@
 {
 	extern FILE *yyin;
 
+	unlink_device_opts();
+	
 	if( !(yyin = fopen(file,"r")) ){
 		syslog(LOG_ERR,"Can not open %s", file);
 		return -1;      

--=-Mo3Tvpyp0AW1qyNORTpQ--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
