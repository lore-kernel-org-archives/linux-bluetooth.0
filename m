Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1075405154.22564.64.camel@akka.yeti.nocrew.org>
References: <1075316178.553.18.camel@akka.yeti.nocrew.org>
	 <1075355567.26729.65.camel@pegasus>
	 <1075405154.22564.64.camel@akka.yeti.nocrew.org>
Content-Type: multipart/mixed; boundary="=-UZMZkPGxaWpv7ml+zwKS"
Message-Id: <1075406315.22564.67.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 20:58:35 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-UZMZkPGxaWpv7ml+zwKS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

tor 2004-01-29 klockan 20.39 skrev Fredrik Noring:
> Attached patch implements both.

The new version of the patch fixes a small memory leak.

Fredrik


--=-UZMZkPGxaWpv7ml+zwKS
Content-Disposition: attachment; filename=hcid-device.patch
Content-Type: text/x-patch; name=hcid-device.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/hcid/hcid.h bluez-utils-2.4/hcid/hcid.h
--- bluez-utils-2.4.orig/hcid/hcid.h	2003-03-08 00:10:30.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.h	2004-01-29 20:30:36.000000000 +0100
@@ -45,7 +45,14 @@
 	uint16_t auth;
 	uint16_t encrypt;
 };   
-extern struct device_opts devi;
+extern struct device_opts default_device;
+extern struct device_opts *parser_device;
+
+struct device_list {
+	char *ref;                  /* hci interface or Bluetooth address */
+	struct device_list *next;
+	struct device_opts opts;
+};
 
 struct link_key {
 	bdaddr_t sba;
@@ -84,6 +91,9 @@
 
 int read_config(char *file);
 
+void free_device_opts(void);
+struct device_opts *allocate_device_opts(char *bdaddr);
+
 gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data);
 gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data);
 
diff -Naur bluez-utils-2.4.orig/hcid/lexer.l bluez-utils-2.4/hcid/lexer.l
--- bluez-utils-2.4.orig/hcid/lexer.l	2002-06-24 04:38:01.000000000 +0200
+++ bluez-utils-2.4/hcid/lexer.l	2004-01-29 20:10:51.000000000 +0100
@@ -52,6 +52,9 @@
 fname		[A-Za-z0-9\_\.\-]+	
 path		(\/{fname})+
 string		\".*\"
+hci		hci[0-9]+
+hextuple	[0-9a-zA-Z][0-9a-zA-Z]
+bdaddr		{hextuple}:{hextuple}:{hextuple}:{hextuple}:{hextuple}:{hextuple}
 
 %x OPTION PARAM  
 
@@ -70,6 +73,16 @@
 	lineno++;
 }
 
+{hci} {
+	yylval.str = yytext;
+	return HCI;
+}
+
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
+++ bluez-utils-2.4/hcid/main.c	2004-01-29 20:53:28.000000000 +0100
@@ -50,7 +50,9 @@
 #include "lib.h"
 
 struct hcid_opts hcid;
-struct device_opts devi;
+struct device_opts default_device;
+struct device_opts *parser_device;
+static struct device_list *device_list = 0;
 
 static GMainLoop *event_loop;
 
@@ -64,8 +66,54 @@
 	printf("\thcid [-n not_daemon] [-f config file]\n");
 }
 
+static struct device_opts *get_device_ref_opts(char *ref)
+{
+	struct device_list *device;
+
+	for (device = device_list; device; device = device->next)
+		if(strcmp(ref, device->ref) == 0)
+			return &device->opts;
+	return 0;
+}
+
+static struct device_opts *get_bdaddr_device_opts(bdaddr_t *bdaddr)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	return get_device_ref_opts(addr);
+}
+
+static struct device_opts *get_hci_device_opts(int hdev)
+{
+	char ref[16];
+
+	sprintf(ref, "hci%d", hdev);
+	return get_device_ref_opts(ref);
+}
+
+static struct device_opts *get_device_opts(int sock, int hdev)
+{
+        struct device_opts *device_opts = 0;
+	struct hci_dev_info di;
+
+	di.dev_id = hdev;
+	if(ioctl(sock, HCIGETDEVINFO, (void*)&di) == 0)
+		/* First try to get BDADDR based settings... */
+		device_opts = get_bdaddr_device_opts(&di.bdaddr);
+	if(!device_opts)
+		/* ...then try hci interface based settings... */
+		device_opts = get_hci_device_opts(hdev);
+	if(!device_opts)
+		/* ...and last the default. */
+		device_opts = &default_device;
+	
+	return device_opts;
+}
+
 static void configure_device(int hdev)
 {
+	struct device_opts *device_opts = 0;
 	struct hci_dev_req dr;
 	int s;
 
@@ -88,16 +136,17 @@
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
@@ -108,7 +157,7 @@
 	}
 
 	/* Set encryption */
-	if (devi.encrypt)
+	if (device_opts->encrypt)
 		dr.dev_opt = ENCRYPT_P2P;
 	else
 		dr.dev_opt = ENCRYPT_DISABLED;
@@ -119,8 +168,8 @@
 	}
 
         /* Set device class */
-	if (devi.class) {
-		uint32_t class = htobl(devi.class);
+	if (device_opts->class) {
+		uint32_t class = htobl(device_opts->class);
 		write_class_of_dev_cp cp;
                 
 		memcpy(cp.dev_class, &class, 3);
@@ -129,9 +178,9 @@
 	}
 
 	/* Set device name */
-	if (devi.name) {
+	if (device_opts->name) {
 		change_local_name_cp cp;
-		expand_name(cp.name, devi.name, hdev);
+		expand_name(cp.name, device_opts->name, hdev);
 
 		hci_send_cmd(s, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
 			CHANGE_LOCAL_NAME_CP_SIZE, (void *) &cp);
@@ -142,6 +191,7 @@
 
 static void init_device(int hdev)
 {
+	struct device_opts *device_opts = 0;
 	struct hci_dev_req dr;
 	int s;
 
@@ -171,10 +221,11 @@
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
@@ -182,8 +233,8 @@
 	}
 
 	/* Set link mode */
-	if (devi.link_mode) {
-		dr.dev_opt = devi.link_mode;
+	if (device_opts->link_mode) {
+		dr.dev_opt = device_opts->link_mode;
 		if (ioctl(s, HCISETLINKMODE, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set link mode on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -191,8 +242,8 @@
 	}
 
 	/* Set link policy */
-	if (devi.link_policy) {
-		dr.dev_opt = devi.link_policy;
+	if (device_opts->link_policy) {
+		dr.dev_opt = device_opts->link_policy;
 		if (ioctl(s, HCISETLINKPOL, (unsigned long)&dr) < 0) {
 			syslog(LOG_ERR, "Can't set link policy on hci%d. %s(%d)\n", 
 				hdev, strerror(errno), errno);
@@ -236,15 +287,64 @@
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
+struct device_opts *allocate_device_opts(char *ref)
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
+	device->ref = ref;
+	device->next = device_list;
+	device_list = device;
+
+	init_device_defaults(&device->opts);
+	return &device->opts;
+}
+
+void free_device_opts(void)
+{
+	struct device_list *device, *next;
+
+	if(default_device.name)
+	{
+		free(default_device.name);
+		default_device.name = 0;
+	}
+	
+	for (device = device_list; device; device = next) {
+		free(device->ref);
+		if(device->opts.name)
+			free(device->opts.name);
+		next = device->next;
+		free(device);
+	}
+	device_list = 0;
 }
 
 static void sig_usr1(int sig)
@@ -467,6 +567,8 @@
 	/* Start event processor */
 	g_main_run(event_loop);
 
+	free_device_opts();
+	
 	syslog(LOG_INFO, "Exit.");
 	return 0;
 }
diff -Naur bluez-utils-2.4.orig/hcid/parser.y bluez-utils-2.4/hcid/parser.y
--- bluez-utils-2.4.orig/hcid/parser.y	2002-08-20 20:42:12.000000000 +0200
+++ bluez-utils-2.4/hcid/parser.y	2004-01-29 20:31:18.000000000 +0100
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
@@ -82,6 +82,20 @@
 		}
   ;
 
+device:
+    K_DEVICE		{
+				parser_device = &default_device;
+			}
+    
+    | K_DEVICE hci	{
+				parser_device = allocate_device_opts($2);
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
@@ -137,47 +151,47 @@
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
@@ -196,6 +210,18 @@
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
@@ -274,6 +300,8 @@
 {
 	extern FILE *yyin;
 
+	free_device_opts();
+	
 	if( !(yyin = fopen(file,"r")) ){
 		syslog(LOG_ERR,"Can not open %s", file);
 		return -1;      

--=-UZMZkPGxaWpv7ml+zwKS--
