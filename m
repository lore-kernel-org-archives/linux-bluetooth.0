Return-Path: <noring@nocrew.org>
Subject: [PATCH] hcid configuration management through DBus
From: Fredrik Noring <noring@nocrew.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/mixed; boundary="=-5iA53N33NYIUHeUnusaX"
Message-Id: <1077657435.9567.12.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 22:17:15 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-5iA53N33NYIUHeUnusaX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

Attached patch implements configuration management through DBus
and also includes an updated hcid.1 man page.

Device configurations are maintained in hcid.conf. Device section
inheritance is implemented, so that parameters in the default
devices section are inherited in sections with specifiers such as
Bluetooth interface or address.

Example:

	device {
		name "BlueZ (%d)"
		class 0x100;
	}

	device 00:03:C9:2A:C4:A8 {
		name "Lingon"
		# "class" parameter is inherited
	}

Apart from a couple of FIXME:s such as better signal handling, I
think hcid is quite feature complete for an initial release with
DBus server support. Phil's pin thing should be possible to merge 
as well, it was DBus client right?

The rest of the patches as well as a Gnome Bluetooth Configuration
utility is available at: http://noring.nocrew.org/bluetooth/

Fredrik

 conf.c     |  556 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 conf.h     |   76 ++++----
 device.c   |  471 +++++++++++++++++++++++++++++++++++++++++++++++++--
 device.h   |    7
 hcid.1     |  214 +++++++++++++++++++++++
 hcid.h     |    8
 keytab.c   |    2
 lib.c      |   11 -
 lib.h      |    2
 main.c     |  419 ++-------------------------------------------
 nametab.c  |   11 -
 parser.y   |  129 +++++++-------
 pin.c      |   56 +++---
 pin.h      |    2
 security.c |    8
 str.c      |    7
 str.h      |    2


--=-5iA53N33NYIUHeUnusaX
Content-Disposition: attachment; filename=bluez-utils-2.4-fn9.patch
Content-Type: text/x-patch; name=bluez-utils-2.4-fn9.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/hcid/conf.c bluez-utils-2.4/hcid/conf.c
--- bluez-utils-2.4.orig/hcid/conf.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/conf.c	2004-02-24 21:47:20.000000000 +0100
@@ -11,40 +11,538 @@
  *  published by the Free Software Foundation.
  */
 
-#include <unistd.h>
-#include <stdlib.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <syslog.h>
+#include <errno.h>
+#include <time.h>
+#include <fcntl.h>
 #include <getopt.h>
 
-#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/time.h>
 #include <sys/stat.h>
-#include <fcntl.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
 
 #include "hcid.h"
+#include "str.h"
+#include "lib.h"
+#include "pin.h"
+
+#define DEFAULT_HCID_CONF_FILE      "/etc/bluetooth/hcid.conf"
+#define DEFAULT_PIN_FILE            "/etc/bluetooth/pin"
+#define DEFAULT_PIN_HELPER_FILE     "/bin/bluepin"
+#define DEFAULT_DEPRECATED_KEY_FILE "/etc/bluetooth/link_key"
+
+struct conf_param_int {
+	int is_configured;
+	int32_t i;
+};
+
+struct conf_param_string {
+	char *s;
+};
+
+struct conf_options {
+	struct conf_param_string config_file;
+
+	uint8_t pin_code[16];
+	int     pin_len;
+
+	struct conf_param_string pin_helper_file;
+	struct conf_param_string pin_file;
+	struct conf_param_string deprecated_key_file;
+};
+
+struct conf_device {
+	struct conf_param_string name;
+	
+	struct conf_param_int autoinit;
+	struct conf_param_int save_pair_names;
+	struct conf_param_int security;
+	struct conf_param_int pair_mode;
+
+	struct conf_param_int class;
+	struct conf_param_int pkt_type;
+	struct conf_param_int scan;
+	struct conf_param_int link_mode;
+	struct conf_param_int link_policy;
+	struct conf_param_int auth;
+	struct conf_param_int encrypt;
+};   
+
+struct conf_device_list {
+	char *ref;                   /* hci interface or Bluetooth address */
+	struct conf_device_list *next;
+	struct conf_device conf_device;
+};
+
+static char *hcid_conf_file;
+
+static struct conf_options conf_options;
+static struct conf_device conf_default_device;
+static struct conf_device_list *conf_device_list;
+
+/*
+ * Save configuration.
+ */
+
+static void conf_print_string(char **s, const char *name,
+			      const struct conf_param_string *param)
+{
+	if(!param->s)
+		return;
+	string_append(s, "\t");
+	string_append(s, name);
+	string_append(s, " \"");
+	string_append(s, param->s);
+	string_append(s, "\";\n");
+}
+
+static void conf_print_symbol(char **s, const char *name, const char *sym)
+{
+	string_append(s, "\t");
+	string_append(s, name);
+	string_append(s, " ");
+	string_append(s, sym);
+	string_append(s, ";\n");
+}
+
+static void conf_print_boolean(char **s, const char *name,
+			       const struct conf_param_int *param)
+{
+	if(!param->is_configured)
+		return;
+	string_append(s, "\t");
+	string_append(s, name);
+	string_append(s, param->i ? " yes;\n" : " no;\n");
+}
+
+static void conf_print_hex(char **s, const char *name,
+			   const struct conf_param_int *param)
+{
+	char buf[32];
+	
+	if(!param->is_configured)
+		return;
+	string_append(s, "\t");
+	string_append(s, name);
+	sprintf(buf, " 0x%x;\n", param->i);
+	string_append(s, buf);
+}
+
+static void conf_print_options(char **s, struct conf_options *opt)
+{
+	conf_print_boolean(s, "save_pair_names",
+			   &conf_default_device.save_pair_names);
+
+	if(conf_default_device.pair_mode.is_configured) {
+		char *mode;
+		
+		switch(conf_default_device.pair_mode.i) {
+			default:
+			case HCID_PAIRING_NONE:
+				mode = "none";
+				break;
+			case HCID_PAIRING_MULTI:
+				mode = "multi";
+				break;
+			case HCID_PAIRING_ONCE:
+				mode = "once";
+				break;
+		}
+		conf_print_symbol(s, "pairing", mode);
+	}
+
+	if(conf_default_device.security.is_configured) {
+		char *mode;
+		
+		switch(conf_default_device.security.i) {
+			default:
+			case HCID_SEC_NONE:
+				mode = "none";
+				break;
+			case HCID_SEC_AUTO:
+				mode = "auto";
+				break;
+			case HCID_SEC_USER:
+				mode = "user";
+				break;
+		}
+		conf_print_symbol(s, "security", mode);
+	}
+	
+	conf_print_string(s, "pin_helper", &conf_options.pin_helper_file);
+	conf_print_string(s, "pin_file", &conf_options.pin_file);
+	conf_print_string(s, "link_key", &conf_options.deprecated_key_file);
+}
+
+static void conf_format_list(char *s)
+{
+	while(*s) {
+		if(*s == ' ') {
+			if(!s[1])
+				*s = 0;
+			else
+				*s = ',';
+		}
+		
+		s++;
+	}
+}
+
+static void conf_print_device(char **s, struct conf_device *dev)
+{
+	conf_print_string(s, "name", &dev->name);
+	
+	conf_print_boolean(s, "autoinit", &dev->autoinit);
+	
+	conf_print_hex(s, "class", &dev->class);
+	
+	if(dev->scan.is_configured) {
+		conf_print_symbol(s, "iscan",
+				  dev->scan.i & SCAN_INQUIRY ? "yes" : "no");
+		conf_print_symbol(s, "pscan",
+				  dev->scan.i & SCAN_PAGE ? "yes" : "no");
+	}
+	
+	if(dev->pkt_type.is_configured) {
+		char *type;
+
+		type = hci_ptypetostr(dev->pkt_type.i);
+		conf_format_list(type);
+		conf_print_symbol(s, "pkt_type", type);
+		free(type);
+	}
+	
+	if(dev->link_policy.is_configured) {
+		char *policy;
+
+		policy = hci_lptostr(dev->link_policy.i);
+		conf_format_list(policy);
+		conf_print_symbol(s, "lp", policy);
+		free(policy);
+	}
+	
+	if(dev->link_mode.is_configured) {
+		char *mode;
+
+		mode = hci_lmtostr(dev->link_mode.i);
+		conf_format_list(mode);
+		conf_print_symbol(s, "lm", mode);
+		free(mode);
+	}
+
+	conf_print_boolean(s, "auth", &dev->auth);
+	conf_print_boolean(s, "encrypt", &dev->encrypt);
+}
+
+static char *conf_print(void)
+{
+	struct conf_device_list *dev;
+	char *s = 0;
+
+	string_append(&s,
+		      "# hcid.conf - Bluetooth HCI daemon configuration file\n"
+		      "#\n"
+		      "# This file was written by hcid.\n"
+		      "\n"
+		      "options {\n");
+	conf_print_options(&s, &conf_options);
+	string_append(&s,
+		      "}\n"
+		      "\n"
+		      "device {\n");
+	conf_print_device(&s, &conf_default_device);
+	string_append(&s, "}\n");
+
+	/* FIXME: Print in reverse order. */
+	for (dev = conf_device_list; dev; dev = dev->next)
+	{
+		string_append(&s, "\ndevice ");
+		string_append(&s, dev->ref);
+		string_append(&s, " {\n");
+		conf_print_device(&s, &dev->conf_device);
+		string_append(&s, "}\n");
+	}
+
+	return s;
+}
+
+int conf_write(void)
+{
+	char *s, *filename, *tmpfilename, *backupfilename;
+	int fd, r = 0;
+
+	filename = strdup(conf_get_hcid_conf_file());
+	tmpfilename = strdup(filename);
+	string_append(&tmpfilename, "~");
+	backupfilename = strdup(filename);
+	string_append(&backupfilename, "-");
+	
+	fd = open(tmpfilename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0) {
+		syslog(LOG_ERR, "%s open failed. %s(%d)",
+		       tmpfilename, strerror(errno), errno);
+		goto open_failed;
+	}
+	
+	s = conf_print();
+	if (write_sigsafe(fd, s, strlen(s)) == -1)
+	{
+		syslog(LOG_ERR, "%s write failed. %s(%d)",
+		       tmpfilename, strerror(errno), errno);
+		goto write_failed;
+	}
+	
+	/* Remove backups and link new backups. */
+	unlink(backupfilename);
+	link(filename, backupfilename);
+
+	/* Commit config file. */
+	if(rename(tmpfilename, filename) == -1)
+		syslog(LOG_ERR, "nametab rename failed. %s(%d)",
+		       strerror(errno), errno);
+	else
+		/* Success. */
+		r = 1;
+
+write_failed:
+	free(s);
+	close(fd);
+
+open_failed:
+	free(backupfilename);
+	free(tmpfilename);
+	free(filename);
+
+	return r;
+}
+
+static struct conf_device *allocate_conf_device(const char *ref)
+{
+	struct conf_device_list *device;
+	
+	device = malloc(sizeof(struct conf_device_list));
+	if (!device) {
+		syslog(LOG_INFO, "Can't allocate devlist opts buffer. %s(%d)", 
+			strerror(errno), errno);
+		exit(1);
+	}
+	
+	device->ref = strdup(ref);
+	device->next = conf_device_list;
+	conf_device_list = device;
+
+	memset(&device->conf_device, 0, sizeof(device->conf_device));
+	return &device->conf_device;
+}
+
+void conf_reset(void)
+{
+	struct conf_device_list *device, *next;
+
+	if(conf_options.pin_file.s)
+		free(conf_options.pin_file.s);
+	if(conf_options.pin_helper_file.s)
+		free(conf_options.pin_helper_file.s);
+	if(conf_options.deprecated_key_file.s)
+		free(conf_options.deprecated_key_file.s);
+	memset(&conf_options, 0, sizeof(conf_options));
+	
+	if(conf_default_device.name.s)
+		free(conf_default_device.name.s);
+	memset(&conf_default_device, 0, sizeof(conf_default_device));
+	
+	conf_default_device.security.i  = HCID_SEC_AUTO;
+	conf_default_device.pair_mode.i = HCID_PAIRING_MULTI;	
+	conf_default_device.scan.i      = SCAN_PAGE | SCAN_INQUIRY;
+	
+	for (device = conf_device_list; device; device = next) {
+		free(device->ref);
+		if(device->conf_device.name.s)
+			free(device->conf_device.name.s);
+		next = device->next;
+		free(device);
+	}
+	conf_device_list = 0;
+}
 
-struct hcid_opts hcid;
-struct device_opts default_device;
-struct device_opts *parser_device;
+/* ref == 0 means it's the default device. */
+static struct conf_device *get_conf_device(const char *ref)
+{
+	struct conf_device_list *dev;
+
+	if (!ref)
+		return &conf_default_device;
+	for (dev = conf_device_list; dev; dev = dev->next)
+		if(!strcmp(ref, dev->ref))
+			return &dev->conf_device;
+	return 0;
+}
+
+/*
+ * Find ref0 if possible, then try ref1 and fallback to default
+ * device. When ref0 and ref1 are 0, this means the default device.
+ */
+static struct conf_device *find_conf_device(const char *ref0, const char *ref1)
+{
+	struct conf_device *dev = 0;
+
+	if(ref0)
+		dev = get_conf_device(ref0);
+	if(!dev)
+		dev = get_conf_device(ref1);
+	return dev ? dev : &conf_default_device;
+}
+
+/* ref == 0 means it's the default device. */
+static struct conf_device *find_or_allocate_conf_device(const char *ref)
+{
+	struct conf_device *dev;
+
+	dev = find_conf_device(ref, 0);
+	if(ref && dev == &conf_default_device)
+		dev = allocate_conf_device(ref);
+	return dev;
+}
+
+/*
+ * These functions set/get configuration parameters.
+ *
+ */
+
+const char *conf_get_hcid_conf_file(void)
+{
+	if(hcid_conf_file)
+		return hcid_conf_file;
+	return DEFAULT_HCID_CONF_FILE;
+}
+
+const char *conf_get_pin_file(void)
+{
+	if(conf_options.pin_file.s)
+		return conf_options.pin_file.s;
+	return DEFAULT_PIN_FILE;
+}
+
+const char *conf_get_pin_code(void)
+{
+	return conf_options.pin_code;
+}
+
+const char *conf_get_pin_helper_file(void)
+{
+	if(conf_options.pin_helper_file.s)
+		return conf_options.pin_helper_file.s;
+	return DEFAULT_PIN_HELPER_FILE;
+}
+
+const char *conf_get_deprecated_key_file(void)
+{
+	if(conf_options.deprecated_key_file.s)
+		return conf_options.deprecated_key_file.s;
+	return DEFAULT_DEPRECATED_KEY_FILE;
+}
+
+void conf_set_pin_code(const char *default_pin_code)
+{
+	if (read_pin_code(conf_options.pin_code,
+			  sizeof(conf_options.pin_code),
+			  &conf_options.pin_len) < 0) {
+		strcpy(conf_options.pin_code, default_pin_code);
+		conf_options.pin_len = strlen(default_pin_code);
+	}
+}
+
+void conf_set_pin_helper_file(const char *file)
+{
+	if(conf_options.pin_helper_file.s)
+		free(conf_options.pin_helper_file.s);
+	conf_options.pin_helper_file.s = strdup(file);
+}
+
+const char *conf_device_get_name(const char *ref0, const char *ref1)
+{
+	return find_conf_device(ref0, ref1)->name.s;
+}
+
+void conf_device_set_name(const char *ref, const char *name)
+{
+	struct conf_device *dev = find_or_allocate_conf_device(ref);
+	if(dev->name.s)
+		free(dev->name.s);
+	dev->name.s = strdup(name);
+}
+
+/*
+ * Use macros to create these similar get/set parameter functions to
+ * avoid typos.
+ *
+ */
+
+#define CONF_DEVICE_GET_INT(decl, param)				\
+	int32_t decl(const char *ref0, const char *ref1)		\
+	{								\
+		struct conf_param_int *i = 				\
+			&find_conf_device(ref0, ref1)->param;		\
+		return i->is_configured ? i->i : conf_default_device.param.i; \
+	}
+
+#define CONF_DEVICE_SET_INT(decl, param, op)				\
+	void decl(const char *ref, int32_t val)				\
+	{								\
+		struct conf_device *conf_device =			\
+			find_or_allocate_conf_device(ref);		\
+		if(!conf_device->param.is_configured)			\
+			conf_device->param.i = 0;			\
+		conf_device->param.i op val;				\
+		conf_device->param.is_configured = 1;			\
+	}
+
+#define CONF_DEVICE_GET_SET_INT(param)					\
+	CONF_DEVICE_GET_INT(conf_device_ ## get_ ## param, param)	\
+	CONF_DEVICE_SET_INT(conf_device_ ## set_ ## param, param, =)
+
+CONF_DEVICE_GET_SET_INT(autoinit);
+CONF_DEVICE_GET_SET_INT(class);
+CONF_DEVICE_GET_SET_INT(pkt_type);
+CONF_DEVICE_GET_SET_INT(link_mode);
+CONF_DEVICE_GET_SET_INT(link_policy);
+CONF_DEVICE_GET_SET_INT(auth);
+CONF_DEVICE_GET_SET_INT(encrypt);
+CONF_DEVICE_GET_SET_INT(save_pair_names);
+CONF_DEVICE_GET_SET_INT(pair_mode);
+CONF_DEVICE_GET_SET_INT(security);
+
+CONF_DEVICE_GET_INT(conf_device_get_scan,      scan);
+CONF_DEVICE_SET_INT(conf_device_set_scan_or,   scan, |=);
+CONF_DEVICE_SET_INT(conf_device_set_scan_nand, scan, &= ~);
+
+/*
+ * Program argument parsing.
+ *
+ */
 
 static void usage(void)
 {
 	printf("Usage: hcid [options]\n"
 	       "Options:\n"
 	       "  -f, --config-file=file  Use the given configuration file.\n"
-	       "  -h, --help              Print a description of the command line options.\n"
+	       "  -h, --help              Print a description of the command "
+	       				 "line options.\n"
 	       "  -n, --no-daemon         Do not fork as a daemon.\n"
 	       "  -v, --version           Print the version of the daemon.\n");
 }
 
-static char *get_hostname(void)
-{
-	char name[100];
-
-	if (gethostname(name, sizeof(name)-1) == 0)
-		return strdup(name);
-	return strdup("noname");
-}
-
 static void parse_cmds(int argc, char *argv[])
 {
 	int daemon = 1, dofork = 1;
@@ -78,7 +576,7 @@
 				break;
 				
 			case 'f':
-				hcid.config_file = strdup(optarg);
+				hcid_conf_file = strdup(optarg);
 				break;
 				
 			case 'v':
@@ -115,28 +613,16 @@
 
 static void exit_conf(void *context)
 {
-	free(hcid.host_name);
-	
-	free(hcid.pin_file);
-	free(hcid.pin_helper);
-	
-	free(hcid.deprecated_key_file);
+	conf_reset();
+	if(hcid_conf_file)
+		free(hcid_conf_file);
 }
 
 void init_conf(int argc, char *argv[])
 {
-	hcid.config_file         = "/etc/bluetooth/hcid.conf";
-	
-	hcid.host_name           = get_hostname();
-	hcid.security            = HCID_SEC_AUTO;
-	hcid.pairing             = HCID_PAIRING_MULTI;
-	hcid.pair_name           = 1;
+	if (conf_read() < 0)
+		syslog(LOG_ERR, "Config load failed");
 	
-	hcid.pin_file            = strdup("/etc/bluetooth/pin");
-	hcid.pin_helper          = strdup("/bin/bluepin");
-	
-	hcid.deprecated_key_file = strdup("/etc/bluetooth/link_key");
-
 	parse_cmds(argc, argv);
 	register_exit(exit_conf, 0);
 }
diff -Naur bluez-utils-2.4.orig/hcid/conf.h bluez-utils-2.4/hcid/conf.h
--- bluez-utils-2.4.orig/hcid/conf.h	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/conf.h	2004-02-24 21:47:20.000000000 +0100
@@ -29,38 +29,48 @@
 #define HCID_KEYTAB_FILE "/etc/bluetooth/keytab"
 #define HCID_NAMETAB_FILE "/etc/bluetooth/nametab"
 
-struct hcid_opts {
-	char   *host_name;
-	int     auto_init;
-	int     security;
-	int     pairing;
-	int     pair_name;
-
-	char   *config_file;
-
-	uint8_t pin_code[16];
-	int     pin_len;
-	char   *pin_helper;
-	char   *pin_file;
-
-	char   *deprecated_key_file;
-
-	int     sock;
-};
-
-struct device_opts {
-	char  *name;
-	uint32_t class;
-	uint16_t pkt_type;
-	uint16_t scan;
-	uint16_t link_mode;
-	uint16_t link_policy;
-	uint16_t auth;
-	uint16_t encrypt;
-};   
-
-extern struct hcid_opts hcid;
-extern struct device_opts default_device;
-extern struct device_opts *parser_device;
+const char *conf_get_hcid_conf_file(void);
+const char *conf_get_pin_file(void);
+
+const char *conf_get_pin_helper_file(void);
+void conf_set_pin_helper_file(const char *file);
+
+const char *conf_get_deprecated_key_file(void);
+
+const char *conf_get_pin_code(void);
+void conf_set_pin_code(const char *default_pin_code);
+
+int conf_get_pair_name(void);
+void conf_set_pair_name(int val);
+
+const char *conf_device_get_name       (const char *ref0, const char *ref1);
+int32_t conf_device_get_autoinit       (const char *ref0, const char *ref1);
+int32_t conf_device_get_class          (const char *ref0, const char *ref1);
+int32_t conf_device_get_pkt_type       (const char *ref0, const char *ref1);
+int32_t conf_device_get_scan           (const char *ref0, const char *ref1);
+int32_t conf_device_get_link_mode      (const char *ref0, const char *ref1);
+int32_t conf_device_get_link_policy    (const char *ref0, const char *ref1);
+int32_t conf_device_get_auth           (const char *ref0, const char *ref1);
+int32_t conf_device_get_encrypt        (const char *ref0, const char *ref1);
+int32_t conf_device_get_pair_mode      (const char *ref0, const char *ref1);
+int32_t conf_device_get_security       (const char *ref0, const char *ref1);
+int32_t conf_device_get_save_pair_names(const char *ref0, const char *ref1);
+
+void conf_device_set_name           (const char *ref, const char *name);
+void conf_device_set_autoinit       (const char *ref, int32_t val);
+void conf_device_set_class          (const char *ref, int32_t val);
+void conf_device_set_pkt_type       (const char *ref, int32_t val);
+void conf_device_set_scan_or        (const char *ref, int32_t val);
+void conf_device_set_scan_nand      (const char *ref, int32_t val);
+void conf_device_set_link_mode      (const char *ref, int32_t val);
+void conf_device_set_link_policy    (const char *ref, int32_t val);
+void conf_device_set_auth           (const char *ref, int32_t val);
+void conf_device_set_encrypt        (const char *ref, int32_t val);
+void conf_device_set_pair_mode      (const char *ref, int32_t val);
+void conf_device_set_security       (const char *ref, int32_t val);
+void conf_device_set_save_pair_names(const char *ref, int32_t val);
+
+int conf_read(void);   /* Defined in parser.y. */
+int conf_write(void);
 
 void init_conf(int argc, char *argv[]);
diff -Naur bluez-utils-2.4.orig/hcid/device.c bluez-utils-2.4/hcid/device.c
--- bluez-utils-2.4.orig/hcid/device.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/device.c	2004-02-24 21:47:20.000000000 +0100
@@ -33,6 +33,359 @@
 #include "lib.h"
 #include "file.h"
 
+static	struct watch *ctl_io;
+int hci_sock;
+
+int device_set_scan(int sock, int hdev, uint16_t scan)
+{
+	struct hci_dev_req dr;
+	
+	dr.dev_id = hdev;
+	dr.dev_opt = scan;
+	if (ioctl(sock, HCISETSCAN, (unsigned long)&dr) < 0) {
+		syslog(LOG_ERR, "Can't set scan mode on hci%d. %s(%d)\n", 
+				hdev, strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+int device_set_auth(int sock, int hdev, uint16_t auth)
+{
+	struct hci_dev_req dr;
+	
+	dr.dev_id = hdev;
+	if (auth)
+		dr.dev_opt = AUTH_ENABLED;
+	else
+		dr.dev_opt = AUTH_DISABLED;
+	if (ioctl(sock, HCISETAUTH, (unsigned long)&dr) < 0) {
+		syslog(LOG_ERR, "Can't set auth on hci%d. %s(%d)\n", 
+				hdev, strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+int device_set_encrypt(int sock, int hdev, uint16_t encrypt)
+{
+	struct hci_dev_req dr;
+	
+	dr.dev_id = hdev;
+	if (encrypt)
+		dr.dev_opt = ENCRYPT_P2P;
+	else
+		dr.dev_opt = ENCRYPT_DISABLED;
+
+	if (ioctl(sock, HCISETENCRYPT, (unsigned long)&dr) < 0) {
+		syslog(LOG_ERR, "Can't set encrypt on hci%d. %s(%d)\n", 
+				hdev, strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+int device_set_class(int sock, int hdev, uint32_t class)
+{
+	if (class) {
+		uint32_t c = htobl(class);
+		write_class_of_dev_cp cp;
+                
+		memcpy(cp.dev_class, &c, 3);
+		hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_CLASS_OF_DEV,
+			WRITE_CLASS_OF_DEV_CP_SIZE, (void *) &cp);
+	}
+	return 1;
+}
+
+int device_set_name(int sock, int hdev, const char *name)
+{
+	if (name) {
+		change_local_name_cp cp;
+		expand_name(cp.name, name, hdev);
+		if(hci_send_cmd(sock, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
+				CHANGE_LOCAL_NAME_CP_SIZE, (void *) &cp) == -1)
+			return 0;
+	}
+	return 1;
+}
+
+int device_up(int hdev)
+{
+	if (ioctl(hci_sock, HCIDEVUP, hdev) < 0 && errno != EALREADY) {
+		syslog(LOG_ERR, "Can't up device hci%d. %s(%d)\n", hdev, 
+				strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+int device_down(int hdev)
+{
+	if (ioctl(hci_sock, HCIDEVDOWN, hdev) < 0 && errno != EALREADY) {
+		syslog(LOG_ERR, "Can't down device hci%d. %s(%d)\n", hdev, 
+				strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+int device_set_pkt_type(int sock, int hdev, uint16_t pkt_type)
+{
+	struct hci_dev_req dr;
+		
+	if (!pkt_type)
+		return 1;
+	dr.dev_id = hdev;
+	dr.dev_opt = pkt_type;
+	if (ioctl(sock, HCISETPTYPE, (unsigned long)&dr) < 0) {
+		syslog(LOG_ERR, "Can't set packet type on hci%d. %s(%d)\n", 
+		       hdev, strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+int device_set_link_mode(int sock, int hdev, uint16_t link_mode)
+{
+	struct hci_dev_req dr;
+		
+	if (!link_mode)
+		return 1;
+	dr.dev_id = hdev;
+	dr.dev_opt = link_mode;
+	if (ioctl(sock, HCISETLINKMODE, (unsigned long)&dr) < 0) {
+		syslog(LOG_ERR, "Can't set link_mode on hci%d. %s(%d)\n", 
+		       hdev, strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+int device_set_link_policy(int sock, int hdev, uint16_t link_policy)
+{
+	struct hci_dev_req dr;
+		
+	if (!link_policy)
+		return 1;
+	dr.dev_id = hdev;
+	dr.dev_opt = link_policy;
+	if (ioctl(sock, HCISETLINKPOL, (unsigned long)&dr) < 0) {
+		syslog(LOG_ERR, "Can't set link policy on hci%d. %s(%d)\n", 
+		       hdev, strerror(errno), errno);
+		return 0;
+	}
+	return 1;
+}
+
+static void device_conf_or_init(int hdev, int do_init)
+{
+	char *addrstr = 0, *hdevstr = 0;
+	char addrbuf[18], hdevbuf[16];
+	struct hci_dev_info di;
+	int s;
+
+	/* Do init/config in a separate process. */
+	switch (fork()) {
+		case 0:
+			break;
+		case -1:
+			syslog(LOG_ERR, "Fork failed. "
+			       "Can't init device hci%d. %s(%d)\n", 
+			       hdev, strerror(errno), errno);
+		default:
+			return;
+	}
+
+	set_title("hci%d %s", hdev, do_init ? "init" : "config");
+
+	s = hci_open_dev(hdev);
+	if (s < 0) {
+		syslog(LOG_ERR, "Can't open device hci%d. %s(%d)\n",
+		       hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	di.dev_id = hdev;
+	if(ioctl(s, HCIGETDEVINFO, (void*)&di) == 0) {
+		ba2str(&di.bdaddr, addrbuf);
+		addrstr = addrbuf;
+	} else
+		syslog(LOG_ERR, "HCI dev %d dev info failed", hdev);
+	sprintf(hdevbuf, "hci%d", hdev);
+	hdevstr = hdevbuf;
+	
+	if(do_init)
+		goto do_init;
+
+	/* Do configure. */
+	device_set_scan   (s, hdev, conf_device_get_scan   (addrstr, hdevstr));
+	device_set_auth   (s, hdev, conf_device_get_auth   (addrstr, hdevstr));
+	device_set_encrypt(s, hdev, conf_device_get_encrypt(addrstr, hdevstr));
+	device_set_class  (s, hdev, conf_device_get_class  (addrstr, hdevstr));
+	device_set_name   (s, hdev, conf_device_get_name   (addrstr, hdevstr));
+	exit(0);
+	
+do_init:
+	/* Do init. */
+	if (!device_up(hdev))
+		exit(1);
+	device_set_pkt_type
+		(s, hdev, conf_device_get_pkt_type   (addrstr, hdevstr));
+	device_set_link_mode
+		(s, hdev, conf_device_get_link_mode  (addrstr, hdevstr));
+	device_set_link_policy
+		(s, hdev, conf_device_get_link_policy(addrstr, hdevstr));
+	exit(0);
+}
+
+void device_conf(int hdev)
+{
+	device_conf_or_init(hdev, 0);
+}
+
+void device_init(int hdev)
+{
+	device_conf_or_init(hdev, 1);
+}
+
+void device_init_all(void)
+{
+	struct hci_dev_list_req *dl;
+	struct hci_dev_req *dr;
+	int i;
+
+	dl = malloc(HCI_MAX_DEV*sizeof(struct hci_dev_req) + sizeof(uint16_t));
+	if (!dl) {
+		syslog(LOG_INFO, "Can't allocate devlist buffer. %s(%d)", 
+			strerror(errno), errno);
+		exit(1);
+	}
+	dl->dev_num = HCI_MAX_DEV;
+	dr = dl->dev_req;
+
+	if (ioctl(hci_sock, HCIGETDEVLIST, (void*)dl)) {
+		syslog(LOG_INFO, "Can't get device list. %s(%d)",
+			strerror(errno), errno);
+		exit(1);
+	}
+
+	for (i=0; i < dl->dev_num; i++, dr++) {
+		char *addrstr = 0, *hdevstr = 0;
+		char addrbuf[18], hdevbuf[16];
+		struct hci_dev_info di;
+		
+		di.dev_id = dr->dev_id;
+		if(ioctl(hci_sock, HCIGETDEVINFO, (void*)&di) == 0) {
+			ba2str(&di.bdaddr, addrbuf);
+			addrstr = addrbuf;
+		}
+		sprintf(hdevbuf, "hci%d", dr->dev_id);
+		hdevstr = hdevbuf;
+		
+		if (conf_device_get_autoinit(addrstr, hdevstr)) {
+			device_init(dr->dev_id);
+
+			if (hci_test_bit(HCI_UP, &dr->dev_opt))
+				device_conf(dr->dev_id);
+		}
+
+		if (conf_device_get_security(addrstr, hdevstr))
+			if (hci_test_bit(HCI_UP, &dr->dev_opt))
+				start_security_manager(dr->dev_id);
+	}
+	
+	free(dl);
+}
+
+static inline void device_event(struct watch *chan, evt_stack_internal *si)
+{
+	char *addrstr = 0, *hdevstr = 0;
+	char addrbuf[18], hdevbuf[16];
+	struct hci_dev_info di;
+	
+	evt_si_device *sd = (void *) &si->data;
+
+	di.dev_id = sd->dev_id;
+	if(ioctl(hci_sock, HCIGETDEVINFO, (void*)&di) == 0) {
+		ba2str(&di.bdaddr, addrbuf);
+		addrstr = addrbuf;
+	} else
+		syslog(LOG_ERR, "HCI dev %d dev info failed", sd->dev_id);
+	sprintf(hdevbuf, "hci%d", sd->dev_id);
+	hdevstr = hdevbuf;
+		
+	switch (sd->event) {
+	case HCI_DEV_REG:
+		syslog(LOG_INFO, "HCI dev %d registered", sd->dev_id);
+		if (conf_device_get_autoinit(addrstr, hdevstr))
+			device_init(sd->dev_id);
+		break;
+
+	case HCI_DEV_UNREG:
+		syslog(LOG_INFO, "HCI dev %d unregistered", sd->dev_id);
+		break;
+
+	case HCI_DEV_UP:
+		syslog(LOG_INFO, "HCI dev %d up", sd->dev_id);
+		if (conf_device_get_autoinit(addrstr, hdevstr))
+			device_conf(sd->dev_id);
+		if (conf_device_get_security(addrstr, hdevstr))
+			start_security_manager(sd->dev_id);
+		break;
+
+	case HCI_DEV_DOWN:
+		syslog(LOG_INFO, "HCI dev %d down", sd->dev_id);
+		if (conf_device_get_security(addrstr, hdevstr))
+			stop_security_manager(sd->dev_id);
+		break;
+	}
+
+	signal_dbus("device");
+}
+
+void io_stack_event(struct watch *watch, short events, void *data)
+{
+	char buf[HCI_MAX_FRAME_SIZE], *ptr;
+	evt_stack_internal *si;
+	hci_event_hdr *eh;
+	int  len, type;
+	int err;
+
+	ptr = buf;
+
+	if ((err = watch_read(watch, buf, sizeof(buf), &len))) {
+		if (err == WATCH_ERROR_AGAIN)
+			return;
+
+		syslog(LOG_ERR, "Read from control socket failed. %s(%d)", 
+				strerror(errno), errno);
+		watch_exit_loop();
+		watch_free(watch);
+		return;
+	}
+
+	type = *ptr++;
+
+	if (type != HCI_EVENT_PKT)
+		return;
+
+	eh = (hci_event_hdr *) ptr;
+	if (eh->evt != EVT_STACK_INTERNAL)
+		return;
+
+	ptr += HCI_EVENT_HDR_SIZE;
+
+	si = (evt_stack_internal *) ptr;
+	switch (si->type) {
+		case EVT_SI_DEVICE:
+			device_event(watch, si);
+			break;
+	}
+
+	return;
+}
+
 /*
  * DBus interface to device
  */
@@ -44,8 +397,12 @@
 	char addr[18];
 
 	di.dev_id = hdev;
-	if (ioctl(hcid.sock, HCIGETDEVINFO, &di))
+	if (ioctl(hci_sock, HCIGETDEVINFO, &di)) {
+		syslog(LOG_ERR,
+		       "Can't read device info name on hci%d. %s(%d)\n", 
+		       hdev, strerror(errno), errno);
 		return 0;
+	}
 
 	dbus_message_iter_append_dict(iter, &dict_iter);
 		
@@ -76,7 +433,7 @@
 			
 		r = hci_read_local_name(sock, sizeof(name), name, 1000);
 		if (r < 0) {
-			syslog(LOG_INFO,
+			syslog(LOG_ERR,
 			       "Can't read local name on hci%d. "
 			       "%s(%d)\n", 
 			       hdev, strerror(errno), errno);
@@ -84,7 +441,7 @@
 		}
 
 		if (hci_read_local_version(sock, &ver, 1000) < 0) {
-			syslog(LOG_INFO,
+			syslog(LOG_ERR,
 			       "Can't read version info hci%d. %s(%d)\n", 
 			       hdev, strerror(errno), errno);
 		} else
@@ -119,10 +476,38 @@
 	return get_dbus_conf(hdev, &iter);
 }
 
+static int get_hdev_bdaddr(const char *ref, int *hdev, char *addrstr)
+{
+	bdaddr_t bdaddr;
+	
+	if(ref[0] == 'h' && ref[1] == 'c' && ref[2] == 'i') {
+		*hdev = hci_devid(ref);
+		if(*hdev == -1)
+			return 0;
+		if(hci_devba(*hdev, &bdaddr) == -1)
+			return 0;
+		ba2str(&bdaddr, addrstr);
+		return 1;
+	}
+
+	str2ba(ref, &bdaddr);
+	ba2str(&bdaddr, addrstr);
+	*hdev = hci_get_route(&bdaddr);
+	if(*hdev == -1)
+		return 0;
+	return 1;
+}
+
+/* up(string ref):
+ *
+ * - ref must be an interface (hci0 etc.) and not an address since
+ *   addresses cannot be derived on downed interfaces.
+ */
 static int method_dbus_up(DBusMessage *message, DBusMessage *reply)
 {
 	DBusMessageIter iter;
-	char *ref;
+	char *ref, addrstr[18];
+	bdaddr_t bdaddr;
 	int hdev;
 
 	dbus_message_iter_init(message, &iter);
@@ -132,36 +517,38 @@
 
 	if(sscanf(ref, "hci%d", &hdev) != 1)
 		return 0;
-
-	if (ioctl(hcid.sock, HCIDEVUP, hdev) < 0) {
-		syslog(LOG_INFO, "Can't down device hci%d. %s(%d)\n",
-		       hdev, strerror(errno), errno);
+	device_up(hdev);
+	if(hci_devba(hdev, &bdaddr) == -1)
 		return 0;
-	}
+	ba2str(&bdaddr, addrstr);
+	
+	conf_device_set_autoinit(addrstr, 1);
+	conf_write();
 	
 	dbus_message_append_iter_init(reply, &iter);
 	return 1;
 }
 
+/* down(string ref):
+ *
+ * - ref can be an interface (hci0 etc.) or an address.
+ */
 static int method_dbus_down(DBusMessage *message, DBusMessage *reply)
 {
 	DBusMessageIter iter;
-	char *ref;
+	char *ref, addrstr[18];
 	int hdev;
 
 	dbus_message_iter_init(message, &iter);
 	if(dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
 		return 0;
 	ref = dbus_message_iter_get_string(&iter);
-
-	if(sscanf(ref, "hci%d", &hdev) != 1)
+	if(!get_hdev_bdaddr(ref, &hdev, addrstr))
 		return 0;
 
-	if (ioctl(hcid.sock, HCIDEVDOWN, hdev) < 0) {
-		syslog(LOG_INFO, "Can't down device hci%d. %s(%d)\n",
-		       hdev, strerror(errno), errno);
-		return 0;
-	}
+	device_down(hdev);
+	conf_device_set_autoinit(addrstr, 0);
+	conf_write();
 	
 	dbus_message_append_iter_init(reply, &iter);
 	return 1;
@@ -170,15 +557,15 @@
 static int method_dbus_set_name(DBusMessage *message, DBusMessage *reply)
 {
 	DBusMessageIter iter;
-	int hdev, sock, r;
-	char *ref, *name;
+	char *ref, *name, addrstr[18];
+	int hdev, sock;
 
 	dbus_message_iter_init(message, &iter);
 	
 	if(dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
 		return 0;
 	ref = dbus_message_iter_get_string(&iter);
-	if(sscanf(ref, "hci%d", &hdev) != 1)
+	if(!get_hdev_bdaddr(ref, &hdev, addrstr))
 		return 0;
 
 	dbus_message_iter_next(&iter);
@@ -193,13 +580,15 @@
 		       hdev, strerror(errno), errno);
 		return 0;
 	}
-	r = hci_write_local_name(sock, name, 1000);
-	close(sock);
-	if (r < 0) {
+	if(!device_set_name(sock, hdev, name)) {
 		syslog(LOG_INFO, "Can't set name on device hci%d. %s(%d)\n",
 		       hdev, strerror(errno), errno);
+		close(sock);
 		return 0;
 	}
+	close(sock);
+	conf_device_set_name(addrstr, name);
+	conf_write();
 
 	signal_dbus("device");
 	
@@ -225,7 +614,7 @@
 	dl->dev_num = HCI_MAX_DEV;
 	dr = dl->dev_req;
 
-	if (ioctl(hcid.sock, HCIGETDEVLIST, (void*)dl)) {
+	if (ioctl(hci_sock, HCIGETDEVLIST, (void*)dl)) {
 		syslog(LOG_INFO, "Can't get device list. %s(%d)",
 			strerror(errno), errno);
 		goto error;
@@ -268,12 +657,46 @@
 
 static void exit_device(void *context)
 {
+	watch_free(ctl_io);
+	close(hci_sock);
 	unregister_dbus_interface(&interface);
 }
 
 void init_device(void)
 {
+	struct sockaddr_hci addr;
+	struct hci_filter flt;
+	
 	interface.methods = methods;
 	register_dbus_interface(&interface, 0);
+
+	/* Create and bind HCI socket */
+	hci_sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (hci_sock < 0) {
+		syslog(LOG_ERR, "Can't open HCI socket. %s(%d)",
+		       strerror(errno), errno);
+		exit(1);
+	}
+
+	/* Set filter */
+	hci_filter_clear(&flt);
+	hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
+	hci_filter_set_event(EVT_STACK_INTERNAL, &flt);
+	if (setsockopt(hci_sock, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
+		syslog(LOG_ERR, "Can't set filter. %s(%d)",
+		       strerror(errno), errno);
+		exit(1);
+	}
+
+	addr.hci_family = AF_BLUETOOTH;
+	addr.hci_dev = HCI_DEV_NONE;
+	if (bind(hci_sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		syslog(LOG_ERR, "Can't bind HCI socket. %s(%d)\n",
+		       strerror(errno), errno);
+		exit(1);
+	}
+
+	ctl_io = watch_allocate_fd(hci_sock, WATCH_IN, io_stack_event, 0);
+	
 	register_exit(exit_device, 0);
 }
diff -Naur bluez-utils-2.4.orig/hcid/device.h bluez-utils-2.4/hcid/device.h
--- bluez-utils-2.4.orig/hcid/device.h	2004-02-08 18:01:04.000000000 +0100
+++ bluez-utils-2.4/hcid/device.h	2004-02-24 21:47:20.000000000 +0100
@@ -9,4 +9,11 @@
  *  published by the Free Software Foundation.
  */
 
+extern int hci_sock;
+
+void device_init_all(void);
+
+void device_conf(int hdev);
+void device_init(int hdev);
+
 void init_device(void);
diff -Naur bluez-utils-2.4.orig/hcid/hcid.1 bluez-utils-2.4/hcid/hcid.1
--- bluez-utils-2.4.orig/hcid/hcid.1	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.1	2004-02-24 21:47:20.000000000 +0100
@@ -0,0 +1,214 @@
+.\" 
+.\" hcid manual page.
+.\" Copyright (C) 2004 Fredrik Noring
+.\"
+.TH hcid 1
+.SH NAME
+hcid \- Bluetooth HCI daemon
+.SH SYNOPSIS
+.PP
+\fBhcid\fP [\fIoption\fP]...
+
+.SH DESCRIPTION
+
+\fIhcid\fP is the Bluetooth interface daemon. See
+http://www.bluez.org/ for more information about Bluetooth for Linux.
+The main purpose of \fIhcid\fP is to automatically configure Bluetooth
+interfaces (hci0, hci1 ...).
+
+\fIhcid\fP also provides Bluetooth device pairing services.
+
+.SH OPTIONS
+The following options are supported:
+.TP
+\fB-f\fP=\fIfile\fP, \fB--config-file\fP=\fIfile\fP
+Use the given configuration file.
+.TP
+\fB-h\fP, \fB--help\fP
+Print on the standard output a description of the command line options.
+.TP
+\fB-n\fP, \fB--no-daemon\fP
+Do not fork as a daemon.
+.TP
+\fB--version\fP
+Print the version of the daemon.
+
+.SH CONFIGURATION FILE
+
+The \fIhcid\fP configuration file is located in
+/etc/bluetooth/hcid.conf. It consists of sections and parameters. A
+section begins with the name of the section followed by optional
+specifiers and the parameters inside curly brackets. Sections contain
+parameters of the form:
+
+.TP
+\fIname\fP \fIvalue1\fP, \fIvalue2\fP ... ;
+
+.PP
+Any character after a hash ('#') character is ignored until newline.
+Whitespace is also ignored.
+
+.SH SECTION DESCRIPTION
+
+Sections can be one \fBoption\fP section and any number of
+\fBdevice\fP sections.
+
+.SH OPTION SECTION DESCRIPTION
+
+The following parameters may be present in an option section:
+
+.TP
+\fBpair_name\fP = yes|no
+
+Request and store the names of remote devices in the nametab file when
+pairing. The default is \fIyes\fP.
+
+.TP
+\fBpairing\fP = none|multi|once
+
+\fInone\fP means that pairing is disabled. \fImulti\fP allows pairing
+with already paired devices. \fIonce\fP allows pairing once and denies
+successive attempts. The default is \fI???\fP.
+
+.TP
+\fBpin_file\fP = "\fIfile\fP"
+
+The path to the PIN file. It is a plain text file where the first row
+contains the PIN. The default is "/etc/bluetooth/pin".
+
+.TP
+\fBpin_helper\fP = "\fIfile\fP"
+
+The path to the PIN helper application. The default is "/bin/bluepin".
+The following output is expected from the PIN helper:
+
+PIN:12345678
+
+Or, when no PIN is available:
+
+ERR
+
+.TP
+\fBsecurity\fP = none|auto|user
+
+\fInone\fP means the security manager is disabled. \fIauto\fP uses
+local PIN for incoming connections. \fIuser\fP always asks the user
+for a PIN. The default is \fI???\fP.
+
+.SH DEVICE SECTION DESCRIPTION
+
+Parameters within a device section with no specifier, the default
+device section, will be applied to all devices and device sections
+where these are unspecified. The following optional device specifiers
+are supported:
+
+.TP
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
+
+Parameters specified within this section will be applied to the device
+with this \fIdevice address\fP. All other parameters are applied from
+the default section.
+
+.TP
+\fBhci\fIn\fP
+
+Parameters specified within this section will be applied to the device
+with this \fIdevice interface\fP, unless that device is matched by a
+\fIdevice address\fP section. All other parameters are applied from
+the default section.
+
+.PP
+
+The following parameters may be present in a device section:
+
+.TP
+\fBauth\fP = yes|no
+
+.TP
+\fBautoinit\fP = yes|no
+
+Automatically initialize the device. The default is \fIno\fP.
+
+.TP
+\fBclass\fP = 0x\fIhhh\FP
+
+.TP
+\fBencrypt\fP = yes|no
+
+.TP
+\fBiscan\fP = yes|no
+.TP
+\fBlm\fP = none|accept,master
+
+\fInone\fP means no specific policy. \fIaccept\fP means always accept
+incoming connections. \fImaster\fP means become master on incoming
+connections and deny role switch on outgoing connections. Default is
+\fI???\fP.
+
+.TP
+\fBlp\fP = none|rswitch,hold,sniff,park
+
+\fInone\fP means no specific policy. \fIrswitch\fP means allow role
+switch. \fIhold\fP means allow hold mode. \fIsniff\fP means allow
+sniff mode. \fIpark\fP means allow park mode. Several options can be
+combined. The default is \fI???\fP.
+
+.TP
+\fBname\fP = "\fIname\fP"
+
+The device name. \fI%d\fP inserts device id. \fI%h\fP inserts host
+name.
+
+.TP
+\fBpkt_type\fP = DH1,DM1,HV1
+
+.TP
+\fBpscan\fP = yes|no
+
+.SH SIGNALS
+
+.SH EXAMPLE
+Example of \fBhcid.conf\fP file:
+
+.nf
+options {
+	security auto;
+	pairing multi;
+}
+
+# These parameters are applied to all devices and device sections
+# unless specified in those sections.
+device {
+	autoinit yes;
+
+	name "%h (%d)";
+
+	class 0x100;
+
+	iscan yes;
+	pscan yes;
+
+	lm accept;
+
+	lp hold, sniff, park;
+}
+
+# Parameters for a device with address 00:11:22:33:44:55.
+device 00:11:22:33:44:55 {
+	name "My device";
+}
+
+.SH FILES
+.nf
+/etc/bluetooth/hcid.conf
+/etc/bluetooth/pin
+/etc/bluetooth/keytab
+/etc/bluetooth/keytab.shadow
+/etc/bluetooth/nametab
+/bin/bluepin
+
+.SH AUTHORS
+Written by Fredrik Noring and Maxim Krasnyansky.
+
+.SH BUGS
+Please send bug reports to <bluez-devel@lists.sf.net>.
diff -Naur bluez-utils-2.4.orig/hcid/hcid.h bluez-utils-2.4/hcid/hcid.h
--- bluez-utils-2.4.orig/hcid/hcid.h	2004-02-08 18:01:01.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.h	2004-02-24 21:47:20.000000000 +0100
@@ -19,12 +19,6 @@
 
 #include <bluetooth/bluetooth.h>
 
-struct device_list {
-	char *ref;                  /* hci interface or Bluetooth address */
-	struct device_list *next;
-	struct device_opts opts;
-};
-
 #define LINK_KEY_SIZE 16
 
 struct link_key {
@@ -43,8 +37,6 @@
 
 void register_exit(void (*callback)(void *context), void *context);
 
-int read_config(char *file);
-
 void free_device_opts(void);
 struct device_opts *allocate_device_opts(char *bdaddr);
 
diff -Naur bluez-utils-2.4.orig/hcid/keytab.c bluez-utils-2.4/hcid/keytab.c
--- bluez-utils-2.4.orig/hcid/keytab.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.c	2004-02-24 21:47:20.000000000 +0100
@@ -79,7 +79,7 @@
 	struct file *key_file;
 	size_t offset;
 
-	key_file = read_file(hcid.deprecated_key_file);
+	key_file = read_file(conf_get_deprecated_key_file());
 	if(!key_file)
 		return 0;
 
diff -Naur bluez-utils-2.4.orig/hcid/lib.c bluez-utils-2.4/hcid/lib.c
--- bluez-utils-2.4.orig/hcid/lib.c	2004-02-08 18:01:01.000000000 +0100
+++ bluez-utils-2.4/hcid/lib.c	2004-02-24 21:47:20.000000000 +0100
@@ -41,10 +41,10 @@
  * Device name expansion 
  * 	%d - device id
  */
-char * expand_name(char *dst, char *str, int dev_id)
+char *expand_name(char *dst, const char *str, int dev_id)
 {
-	register int sp, np, olen;
-	char *opt, buf[10];
+	char *opt, buf[10], hname[256];
+	int sp, np, olen;
 
 	if (!str && !dst)
 		return NULL;
@@ -62,7 +62,10 @@
 				break;
 
 			case 'h':
-				opt = hcid.host_name;
+				if(gethostname(hname, sizeof(hname)-1) == 0)
+					opt = hname;
+				else
+					opt = "noname";
 				break;
 			
 			case '%':
diff -Naur bluez-utils-2.4.orig/hcid/lib.h bluez-utils-2.4/hcid/lib.h
--- bluez-utils-2.4.orig/hcid/lib.h	2004-02-08 18:00:54.000000000 +0100
+++ bluez-utils-2.4/hcid/lib.h	2004-02-24 21:47:20.000000000 +0100
@@ -26,7 +26,7 @@
 
 #include <errno.h>
 
-char *expand_name(char *dst, char *str, int dev_id);
+char *expand_name(char *dst, const char *str, int dev_id);
 
 char *get_host_name(void);
 
diff -Naur bluez-utils-2.4.orig/hcid/main.c bluez-utils-2.4/hcid/main.c
--- bluez-utils-2.4.orig/hcid/main.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/main.c	2004-02-24 21:47:20.000000000 +0100
@@ -42,8 +42,6 @@
 #include "nametab.h"
 #include "security.h"
 
-static struct device_list *device_list = 0;
-
 struct exit_callback_list {
 	void (*callback)(void *context);
 	void *context;
@@ -84,284 +82,6 @@
 	}
 }
 
-static struct device_opts *get_device_ref_opts(char *ref)
-{
-	struct device_list *device;
-
-	for (device = device_list; device; device = device->next)
-		if(strcmp(ref, device->ref) == 0)
-			return &device->opts;
-	return 0;
-}
-
-static struct device_opts *get_bdaddr_device_opts(bdaddr_t *bdaddr)
-{
-	char addr[18];
-
-	ba2str(bdaddr, addr);
-	return get_device_ref_opts(addr);
-}
-
-static struct device_opts *get_hci_device_opts(int hdev)
-{
-	char ref[16];
-
-	sprintf(ref, "hci%d", hdev);
-	return get_device_ref_opts(ref);
-}
-
-static struct device_opts *get_device_opts(int sock, int hdev)
-{
-	struct device_opts *device_opts = 0;
-	struct hci_dev_info di;
-
-	di.dev_id = hdev;
-	if(ioctl(sock, HCIGETDEVINFO, (void*)&di) == 0)
-		/* First try to get BDADDR based settings... */
-		device_opts = get_bdaddr_device_opts(&di.bdaddr);
-	if(!device_opts)
-		/* ...then try hci interface based settings... */
-		device_opts = get_hci_device_opts(hdev);
-	if(!device_opts)
-		/* ...and last the default. */
-		device_opts = &default_device;
-	
-	return device_opts;
-}
-
-static void configure_device(int hdev)
-{
-	struct device_opts *device_opts = 0;
-	struct hci_dev_req dr;
-	int s;
-
-	/* Do configuration in the separate process */
-	switch (fork()) {
-		case 0:
-			break;
-		case -1:
-			syslog(LOG_ERR, "Fork failed. Can't init device hci%d. %s(%d)\n",
-					hdev, strerror(errno), errno);
-		default:
-			return;
-	}
-
-	set_title("hci%d config", hdev);
-
-	if ((s = hci_open_dev(hdev)) < 0) {
-		syslog(LOG_ERR, "Can't open device hci%d. %s(%d)\n", hdev, strerror(errno), errno);
-		exit(1);
-	}
-
-	dr.dev_id  = hdev;
-	device_opts = get_device_opts(s, hdev);
-
-	/* Set scan mode */
-	dr.dev_opt = device_opts->scan;
-	if (ioctl(s, HCISETSCAN, (unsigned long)&dr) < 0) {
-		syslog(LOG_ERR, "Can't set scan mode on hci%d. %s(%d)\n", 
-				hdev, strerror(errno), errno);
-	}
-
-	/* Set authentication */
-	if (device_opts->auth)
-		dr.dev_opt = AUTH_ENABLED;
-	else
-		dr.dev_opt = AUTH_DISABLED;
-
-	if (ioctl(s, HCISETAUTH, (unsigned long)&dr) < 0) {
-		syslog(LOG_ERR, "Can't set auth on hci%d. %s(%d)\n", 
-				hdev, strerror(errno), errno);
-	}
-
-	/* Set encryption */
-	if (device_opts->encrypt)
-		dr.dev_opt = ENCRYPT_P2P;
-	else
-		dr.dev_opt = ENCRYPT_DISABLED;
-
-	if (ioctl(s, HCISETENCRYPT, (unsigned long)&dr) < 0) {
-		syslog(LOG_ERR, "Can't set encrypt on hci%d. %s(%d)\n", 
-				hdev, strerror(errno), errno);
-	}
-
-        /* Set device class */
-	if (device_opts->class) {
-		uint32_t class = htobl(device_opts->class);
-		write_class_of_dev_cp cp;
-                
-		memcpy(cp.dev_class, &class, 3);
-		hci_send_cmd(s, OGF_HOST_CTL, OCF_WRITE_CLASS_OF_DEV,
-			WRITE_CLASS_OF_DEV_CP_SIZE, (void *) &cp);
-	}
-
-	/* Set device name */
-	if (device_opts->name) {
-		change_local_name_cp cp;
-		expand_name(cp.name, device_opts->name, hdev);
-
-		hci_send_cmd(s, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
-			CHANGE_LOCAL_NAME_CP_SIZE, (void *) &cp);
-	}
-
-	exit(0);
-}
-
-static void init_device_x(int hdev)
-{
-	struct device_opts *device_opts = 0;
-	struct hci_dev_req dr;
-	int s;
-
-	/* Do initialization in the separate process */
-	switch (fork()) {
-		case 0:
-			break;
-		case -1:
-			syslog(LOG_ERR, "Fork failed. Can't init device hci%d. %s(%d)\n", 
-					hdev, strerror(errno), errno);
-		default:
-			return;
-	}
-
-	set_title("hci%d init", hdev);
-
-	if ((s = hci_open_dev(hdev)) < 0) {
-		syslog(LOG_ERR, "Can't open device hci%d. %s(%d)\n", hdev, strerror(errno), errno);
-		exit(1);
-	}
-
-	/* Start HCI device */
-	if (ioctl(s, HCIDEVUP, hdev) < 0 && errno != EALREADY) {
-		syslog(LOG_ERR, "Can't init device hci%d. %s(%d)\n", hdev, 
-				strerror(errno), errno);
-		exit(1);
-	}
-
-	dr.dev_id  = hdev;
-	device_opts = get_device_opts(s, hdev);
-
-	/* Set packet type */
-	if (device_opts->pkt_type) {
-		dr.dev_opt = device_opts->pkt_type;
-		if (ioctl(s, HCISETPTYPE, (unsigned long)&dr) < 0) {
-			syslog(LOG_ERR, "Can't set packet type on hci%d. %s(%d)\n", 
-				hdev, strerror(errno), errno);
-		}
-	}
-
-	/* Set link mode */
-	if (device_opts->link_mode) {
-		dr.dev_opt = device_opts->link_mode;
-		if (ioctl(s, HCISETLINKMODE, (unsigned long)&dr) < 0) {
-			syslog(LOG_ERR, "Can't set link mode on hci%d. %s(%d)\n", 
-				hdev, strerror(errno), errno);
-		}
-	}
-
-	/* Set link policy */
-	if (device_opts->link_policy) {
-		dr.dev_opt = device_opts->link_policy;
-		if (ioctl(s, HCISETLINKPOL, (unsigned long)&dr) < 0) {
-			syslog(LOG_ERR, "Can't set link policy on hci%d. %s(%d)\n", 
-				hdev, strerror(errno), errno);
-		}
-	}
-
-	exit(0);
-}
-
-static void init_all_devices(int ctl)
-{
-	struct hci_dev_list_req *dl;
-	struct hci_dev_req *dr;
-	int i;
-
-	if (!(dl = malloc(HCI_MAX_DEV * sizeof(struct hci_dev_req) + sizeof(uint16_t)))) {
-		syslog(LOG_INFO, "Can't allocate devlist buffer. %s(%d)", 
-			strerror(errno), errno);
-		exit(1);
-	}
-	dl->dev_num = HCI_MAX_DEV;
-	dr = dl->dev_req;
-
-	if (ioctl(ctl, HCIGETDEVLIST, (void*)dl)) {
-		syslog(LOG_INFO, "Can't get device list. %s(%d)",
-			strerror(errno), errno);
-		exit(1);
-	}
-
-	for (i=0; i < dl->dev_num; i++, dr++) {
-		if (hcid.auto_init)
-			init_device_x(dr->dev_id);
-
-		if (hcid.auto_init && hci_test_bit(HCI_UP, &dr->dev_opt))
-			configure_device(dr->dev_id);
-
-		if (hcid.security && hci_test_bit(HCI_UP, &dr->dev_opt))
-			start_security_manager(dr->dev_id);
-	}
-	
-	free(dl);
-}
-
-static void init_device_defaults(struct device_opts *device_opts)
-{
-	device_opts->name        = 0;
-	device_opts->class       = 0;
-	device_opts->pkt_type    = 0;
-	device_opts->scan        = SCAN_PAGE | SCAN_INQUIRY;
-	device_opts->link_mode   = 0;
-	device_opts->link_policy = 0;
-	device_opts->auth        = 0;
-	device_opts->encrypt     = 0;
-}
-
-static void init_defaults(void)
-{
-	hcid.auto_init = 0;
-	hcid.security  = 0;
-
-	init_device_defaults(&default_device);
-}
-
-struct device_opts *allocate_device_opts(char *ref)
-{
-	struct device_list *device;
-	
-	device = malloc(sizeof(struct device_list));
-	if (!device) {
-		syslog(LOG_INFO, "Can't allocate devlist opts buffer. %s(%d)", 
-			strerror(errno), errno);
-		exit(1);
-	}
-	
-	device->ref = ref;
-	device->next = device_list;
-	device_list = device;
-
-	init_device_defaults(&device->opts);
-	return &device->opts;
-}
-
-void free_device_opts(void)
-{
-	struct device_list *device, *next;
-
-	if(default_device.name)
-		free(default_device.name);
-	init_defaults();
-	
-	for (device = device_list; device; device = next) {
-		free(device->ref);
-		if(device->opts.name)
-			free(device->opts.name);
-		next = device->next;
-		free(device);
-	}
-	device_list = 0;
-}
-
 static void sig_usr1(int sig)
 {
 	toggle_pairing(0);
@@ -377,105 +97,34 @@
 	watch_exit_loop();
 }
 
-static void sig_hup(int sig)
+/* Since devices are configured in a forked process, we need to signal
+ * the DBus when the configuration is complete. */
+static void sig_chld(int sig)
 {
-	syslog(LOG_INFO, "Reloading config file");
-	if (read_config(hcid.config_file) < 0)
-		syslog(LOG_ERR, "Config reload failed");
-
-	reset_security();
-
-	init_all_devices(hcid.sock);
-}
-
-static inline void device_event(struct watch *chan, evt_stack_internal *si)
-{
-	evt_si_device *sd = (void *) &si->data;
-
-	switch (sd->event) {
-	case HCI_DEV_REG:
-		syslog(LOG_INFO, "HCI dev %d registered", sd->dev_id);
-		if (hcid.auto_init)
-			init_device_x(sd->dev_id);
-		break;
-
-	case HCI_DEV_UNREG:
-		syslog(LOG_INFO, "HCI dev %d unregistered", sd->dev_id);
-		break;
-
-	case HCI_DEV_UP:
-		syslog(LOG_INFO, "HCI dev %d up", sd->dev_id);
-		if (hcid.auto_init)
-			configure_device(sd->dev_id);
-		if (hcid.security)
-			start_security_manager(sd->dev_id);
-		break;
-
-	case HCI_DEV_DOWN:
-		syslog(LOG_INFO, "HCI dev %d down", sd->dev_id);
-		if (hcid.security)
-			stop_security_manager(sd->dev_id);
-		break;
-	}
-
+	/* FIXME: Delay signal for poll loop. */
 	signal_dbus("device");
 }
 
-void io_stack_event(struct watch *watch, short events, void *data)
+static void sig_hup(int sig)
 {
-	char buf[HCI_MAX_FRAME_SIZE], *ptr;
-	evt_stack_internal *si;
-	hci_event_hdr *eh;
-	int  len, type;
-	int err;
-
-	ptr = buf;
-
-	if ((err = watch_read(watch, buf, sizeof(buf), &len))) {
-		if (err == WATCH_ERROR_AGAIN)
-			return;
-
-		syslog(LOG_ERR, "Read from control socket failed. %s(%d)", 
-				strerror(errno), errno);
-		watch_exit_loop();
-		watch_free(watch);
-		return;
-	}
-
-	type = *ptr++;
-
-	if (type != HCI_EVENT_PKT)
-		return;
-
-	eh = (hci_event_hdr *) ptr;
-	if (eh->evt != EVT_STACK_INTERNAL)
-		return;
-
-	ptr += HCI_EVENT_HDR_SIZE;
-
-	si = (evt_stack_internal *) ptr;
-	switch (si->type) {
-	case EVT_SI_DEVICE:
-		device_event(watch, si);
-		break;
-	}
+	/* FIXME: Delay signal for poll loop. */
+	syslog(LOG_INFO, "Reloading config file");
+	if (conf_read() < 0)
+		syslog(LOG_ERR, "Config reload failed");
 
-	return;
+	reset_security();
+	device_init_all();
 }
 
 int main(int argc, char *argv[], char *env[])
 {
-	struct sockaddr_hci addr;
-	struct hci_filter flt;
 	struct sigaction sa;
-	struct watch *ctl_io;
 
 	init_conf(argc, argv);
-	init_defaults();
-
+	init_watch();
         init_title(argc, argv, env, "hcid: ");
+	
 	set_title("initializing");
-
 	/* Start logging to syslog and stderr */
 	openlog("hcid", LOG_PID | LOG_NDELAY | LOG_PERROR, LOG_DAEMON);
 	syslog(LOG_INFO, "HCI daemon ver %s started", VERSION);
@@ -492,56 +141,26 @@
 	sa.sa_handler = sig_usr2;
 	sigaction(SIGUSR2, &sa, NULL);
 
-	sa.sa_handler = SIG_IGN;
+	sa.sa_handler = sig_chld;
 	sigaction(SIGCHLD, &sa, NULL);
+	sa.sa_handler = SIG_IGN;
 	sigaction(SIGPIPE, &sa, NULL);
 
-	/* Create and bind HCI socket */
-	if ((hcid.sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0) {
-		syslog(LOG_ERR, "Can't open HCI socket. %s(%d)", strerror(errno), errno);
-		exit(1);
-	}
-
-	/* Set filter */
-	hci_filter_clear(&flt);
-	hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
-	hci_filter_set_event(EVT_STACK_INTERNAL, &flt);
-	if (setsockopt(hcid.sock, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
-		syslog(LOG_ERR, "Can't set filter. %s(%d)", strerror(errno), errno);
-		exit(1);
-	}
-
-	addr.hci_family = AF_BLUETOOTH;
-	addr.hci_dev = HCI_DEV_NONE;
-	if (bind(hcid.sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		syslog(LOG_ERR, "Can't bind HCI socket. %s(%d)\n", strerror(errno), errno);
-		exit(1);
-	}
-
-	if (read_config(hcid.config_file) < 0)
-		syslog(LOG_ERR, "Config load failed");
-
-	init_watch();
-	init_security();
 	init_dbus();
 	init_device();
+	init_security();
 	init_keytab();
 	init_nametab();
-	init_all_devices(hcid.sock);
+	
+	device_init_all();
 	
 	set_title("processing events");
 
-	ctl_io = watch_allocate_fd(hcid.sock, WATCH_IN, io_stack_event, 0);
-	
 	/* Start event processor */
 	watch_run();
 
-	watch_free(ctl_io);
-	free_device_opts();
 	exit_register();
-	
-	close(hcid.sock);
-	
+		
 	syslog(LOG_INFO, "Exit.");
 	return 0;
 }
diff -Naur bluez-utils-2.4.orig/hcid/nametab.c bluez-utils-2.4/hcid/nametab.c
--- bluez-utils-2.4.orig/hcid/nametab.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/nametab.c	2004-02-24 21:47:20.000000000 +0100
@@ -130,13 +130,14 @@
 	
 	/* Bluetooth address */
 	ba2str(&item->bdaddr, bdaddr);
-	str = string_append(strdup(bdaddr), "\t");
+	str = strdup(bdaddr);
+	string_append(&str, "\t");
 	
 	quoted_name = string_quote(item->name);
-	str = string_append(str, quoted_name);
+	string_append(&str, quoted_name);
 	free(quoted_name);
 	
-	str = string_append(str, "\n");
+	string_append(&str, "\n");
 	
 	if (write_sigsafe(fd, str, strlen(str)) < 0) {
 		free(str);
@@ -161,7 +162,7 @@
 		return;
 	}
 	
-	/* Keys are saved properly in reversed order. */
+	/* Names are saved properly in reversed order. */
 	for(item = nametab; item->next; item = item->next)
 		;
 	for( ; item; item = item->prev) {
@@ -175,7 +176,7 @@
 	unlink(HCID_NAMETAB_FILE"-");
 	link(HCID_NAMETAB_FILE, HCID_NAMETAB_FILE"-");
 
-	/* Commit keytab and keytab.shadow. */
+	/* Commit nametab. */
 	if(rename(HCID_NAMETAB_FILE"~", HCID_NAMETAB_FILE) == -1)
 		syslog(LOG_ERR, "nametab rename failed. %s(%d)",
 		       strerror(errno), errno);
diff -Naur bluez-utils-2.4.orig/hcid/parser.y bluez-utils-2.4/hcid/parser.y
--- bluez-utils-2.4.orig/hcid/parser.y	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/parser.y	2004-02-24 21:47:20.000000000 +0100
@@ -1,29 +1,15 @@
 %{
 /* 
-   BlueZ - Bluetooth protocol stack for Linux
-   Copyright (C) 2000-2001 Qualcomm Incorporated
-   
-   Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-   
-   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
-   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY CLAIM,
-   OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER
-   RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
-   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
-   USE OR PERFORMANCE OF THIS SOFTWARE.
-   
-   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, COPYRIGHTS,
-   TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS SOFTWARE IS DISCLAIMED.
-*/
-
-/*
- * $Id: parser.y,v 1.5 2002/08/20 18:42:12 maxk Exp $
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2000-2001 Qualcomm Incorporated
+ *  
+ *  Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *  
+ *  $Id: parser.y,v 1.5 2002/08/20 18:42:12 maxk Exp $
  */ 
 
 #include <stdio.h>
@@ -42,6 +28,10 @@
 #include "hcid.h"
 #include "kword.h"
 
+void conf_reset(void);   /* Defined in conf.c. */
+
+static char *current_device = 0;
+	
 int cfg_error(const char *fmt, ...);
 
 int yyparse(void);
@@ -70,7 +60,7 @@
 %%
 config: statement | config statement;
 statement: 
-  K_OPTIONS hcid_options
+  options hcid_options
  
   | device device_options
 
@@ -82,17 +72,31 @@
 		}
   ;
 
+options:
+    K_OPTIONS		{
+	  			if(current_device)
+					free(current_device);
+				current_device = 0;
+			}
+    ;
+
 device:
     K_DEVICE		{
-				parser_device = &default_device;
+	  			if(current_device)
+					free(current_device);
+				current_device = 0;
 			}
     
     | K_DEVICE hci	{
-				parser_device = allocate_device_opts($2);
+	  			if(current_device)
+					free(current_device);
+				current_device = $2;
 			}
     
     | K_DEVICE bdaddr	{
-				parser_device = allocate_device_opts($2);
+	  			if(current_device)
+					free(current_device);
+				current_device = $2;
 			}
     ;
 
@@ -100,25 +104,19 @@
 hcid_opts: | hcid_opt ';' | error ';' | hcid_opts hcid_opt ';';
 hcid_opt: 
   K_AUTOINIT bool	{
-				hcid.auto_init = $2;
+				conf_device_set_autoinit(current_device, $2);
 			}
 
   | K_SECURITY sec_mode	{
-				hcid.security = $2;
+				conf_device_set_security(0, $2);
 			}
 
   | K_PAIRING pair_mode	{
-				hcid.pairing = $2;
-			}
-
-  | K_PAIR_NAME bool	{
-				hcid.pair_name = $2;
+				conf_device_set_pair_mode(0, $2);
 			}
 
   | K_PINHELP  PATH	{
-				if (hcid.pin_helper)
-					free(hcid.pin_helper);
-				hcid.pin_helper = strdup($2);
+				conf_set_pin_helper_file($2);
 			}
 
   | WORD		{
@@ -154,48 +152,60 @@
 device_options: '{' device_opts '}';
 device_opts: | device_opt ';' | error ';' | device_opts device_opt ';';
 device_opt:
-  K_PTYPE pkt_type	{
-				parser_device->pkt_type = $2;
+  K_AUTOINIT bool	{
+				conf_device_set_autoinit(current_device, $2);
+			}
+
+  | K_PTYPE pkt_type	{
+				conf_device_set_pkt_type(current_device, $2);
 			}
 
   | K_LM link_mode	{
-				parser_device->link_mode = $2;
+				conf_device_set_link_mode(current_device, $2);
 			}
 
   | K_LP link_policy	{
-				parser_device->link_policy = $2;
+				conf_device_set_link_policy(current_device, $2);
 			}
 
-  | K_NAME dev_name	{  
-				if (parser_device->name)
-					free(parser_device->name);
-				parser_device->name = $2;
+  | K_NAME dev_name	{
+				conf_device_set_name(current_device, $2);
+				free($2);
 			}
 
   | K_CLASS NUM		{
-				parser_device->class = $2;
+				conf_device_set_class(current_device, $2);
 			}
 
   | K_AUTH bool		{
-				parser_device->auth = $2;
+				conf_device_set_auth(current_device, $2);
 			}
 
   | K_ENCRYPT bool	{
-				parser_device->encrypt = $2;
+				conf_device_set_encrypt(current_device, $2);
 			}
 
   | K_ISCAN bool	{
 				if ($2)
-					parser_device->scan |=  SCAN_INQUIRY;
+					conf_device_set_scan_or
+						(current_device, SCAN_INQUIRY);
 				else
-					parser_device->scan &= ~SCAN_INQUIRY;
+					conf_device_set_scan_nand
+						(current_device, SCAN_INQUIRY);
 			}
 
   | K_PSCAN bool	{
 				if ($2)
-					parser_device->scan |=  SCAN_PAGE;
+					conf_device_set_scan_or
+						(current_device, SCAN_PAGE);
 				else
-					parser_device->scan &= ~SCAN_PAGE;
+					conf_device_set_scan_nand
+						(current_device, SCAN_PAGE);
+			}
+
+  | K_PAIR_NAME bool	{
+				conf_device_set_save_pair_names
+					(current_device, $2);
 			}
 
   | WORD		{
@@ -300,14 +310,17 @@
 /* 
  * Read config file. 
  */ 
-int read_config(char *file) 
+int conf_read(void) 
 {
+	const char *hcid_conf_file;
 	extern FILE *yyin;
 
-	free_device_opts();
-	
-	if( !(yyin = fopen(file,"r")) ){
-		syslog(LOG_ERR,"Can not open %s", file);
+	conf_reset();
+
+	hcid_conf_file = conf_get_hcid_conf_file();
+	yyin = fopen(hcid_conf_file, "r");
+	if(!yyin) {
+		syslog(LOG_ERR, "Can not open %s", hcid_conf_file);
 		return -1;      
 	}
 
diff -Naur bluez-utils-2.4.orig/hcid/pin.c bluez-utils-2.4/hcid/pin.c
--- bluez-utils-2.4.orig/hcid/pin.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/pin.c	2004-02-24 21:47:20.000000000 +0100
@@ -35,6 +35,7 @@
 #include "lib.h"
 #include "file.h"
 #include "keytab.h"
+#include "nametab.h"
 #include "security.h"
 #include "pin.h"
 
@@ -43,37 +44,40 @@
 void toggle_pairing(int enable)
 {
 	if (enable)
-		pairing = hcid.pairing;
+		pairing = conf_device_get_pair_mode(0 /* FIXME!*/,
+						    0 /* FIXME!*/);
 	else
 		pairing = 0;
 
 	syslog(LOG_INFO, "Pairing %s", pairing ? "enabled" : "disabled");
 }
 
-int read_pin_code(void)
+int read_pin_code(char *buf, int buf_len, int *len)
 {
-	char buf[17];
-	FILE *f; 
-	int len;
+	const char *pin_file;
+	FILE *f;
 
-	if (!(f = fopen(hcid.pin_file, "r"))) {
+	pin_file = conf_get_pin_file();
+	f = fopen(pin_file, "r");
+	if (!f) {
 		syslog(LOG_ERR, "Can't open PIN file %s. %s(%d)",
-				hcid.pin_file, strerror(errno), errno);
-		return -1;
+				pin_file, strerror(errno), errno);
+		return 0;
 	}
 
-	if (fgets(buf, sizeof(buf), f)) {
+	if (fgets(buf, buf_len, f)) {
 		strtok(buf, "\n\r");
-		len = strlen(buf); 
-		memcpy(hcid.pin_code, buf, len);
-		hcid.pin_len = len;
+		*len = strlen(buf); 
 	} else {
+		fclose(f);
 		syslog(LOG_ERR, "Can't read PIN file %s. %s(%d)",
-				hcid.pin_file, strerror(errno), errno);
-		len = -1;
+				pin_file, strerror(errno), errno);
+		buf[0] = 0;
+		*len = 0;
+		return 0;
 	}
 	fclose(f);
-	return len;
+	return 1;
 }
 
 /*
@@ -91,6 +95,7 @@
 {
 	pin_code_reply_cp pr;
 	char addr[12], str[255], *pin, name[20];
+	const char *pin_helper;
 	FILE *pipe;
 	int len;
 	
@@ -105,9 +110,10 @@
 			return;
 	}
 
-	if (access(hcid.pin_helper, R_OK | X_OK)) {
+	pin_helper = conf_get_pin_helper_file();
+	if (access(pin_helper, R_OK | X_OK)) {
 		syslog(LOG_ERR, "Can't exec PIN helper %s. %s(%d)",
-				hcid.pin_helper, strerror(errno), errno);
+				pin_helper, strerror(errno), errno);
 		goto reject;
 	}
 
@@ -115,9 +121,8 @@
 	//hci_remote_name(dev, &ci->bdaddr, sizeof(name), name, 0);
 
 	ba2str(&ci->bdaddr, addr);
-	sprintf(str, "%s %s %s \'%s\'", hcid.pin_helper, 
-			ci->out ? "out" : "in", 
-			addr, name);
+	sprintf(str, "%s %s %s \'%s\'", pin_helper, 
+		ci->out ? "out" : "in", addr, name);
 
 	setenv("PATH", "/bin:/usr/bin:/usr/local/bin", 1);
 
@@ -167,7 +172,7 @@
 	ba2str(dba, da);
 
 	memset(name, 0, sizeof(name));
-	if(hcid.pair_name) {
+	if(conf_device_get_save_pair_names(0 /* FIXME! */, 0 /* FIXME! */)) {
 		hci_read_remote_name(dev, dba, sizeof(name), name, 100000);
 		if(strlen(name))
 			nametab_set_name(dba, name);
@@ -201,14 +206,17 @@
 	} else if (pairing == HCID_PAIRING_NONE)
 		goto reject;
 
-	if (hcid.security == HCID_SEC_AUTO) {
+	if (conf_device_get_security(0 /* FIXME!*/,
+				     0 /* FIXME!*/) == HCID_SEC_AUTO) {
 		if (!ci->out) {
+			char *pin_code = conf_get_pin_code();
+			
 			/* Incomming connection */
 			pin_code_reply_cp pr;
 			memset(&pr, 0, sizeof(pr));
 			bacpy(&pr.bdaddr, dba);
-			memcpy(pr.pin_code, hcid.pin_code, hcid.pin_len);
-			pr.pin_len = hcid.pin_len;
+			memcpy(pr.pin_code, pin_code, strlen(pin_code));
+			pr.pin_len = strlen(pin_code);
 			hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_REPLY,
 				PIN_CODE_REPLY_CP_SIZE, &pr);
 		} else {
diff -Naur bluez-utils-2.4.orig/hcid/pin.h bluez-utils-2.4/hcid/pin.h
--- bluez-utils-2.4.orig/hcid/pin.h	2004-02-08 18:01:01.000000000 +0100
+++ bluez-utils-2.4/hcid/pin.h	2004-02-24 21:47:20.000000000 +0100
@@ -13,6 +13,6 @@
 extern int pairing;
 
 void toggle_pairing(int enable);
-int read_pin_code(void);
+int read_pin_code(char *buf, int buf_len, int *len);
 void call_pin_helper(int dev, struct hci_conn_info *ci);
 void pin_code_request(int dev, bdaddr_t *sba, bdaddr_t *dba);
diff -Naur bluez-utils-2.4.orig/hcid/security.c bluez-utils-2.4/hcid/security.c
--- bluez-utils-2.4.orig/hcid/security.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/security.c	2004-02-24 21:47:20.000000000 +0100
@@ -215,13 +215,9 @@
 
 void reset_security(void)
 {
-	/* Set local PIN code */
-	if (read_pin_code() < 0) {
-		strcpy(hcid.pin_code, "BlueZ");
-		hcid.pin_len = 5;
-	}
+	conf_set_pin_code("BlueZ");
 
-	pairing = hcid.pairing;
+	pairing = conf_device_get_pair_mode(0 /* FIXME!*/, 0 /* FIXME!*/);
 }
 
 static void exit_security(void *context)
diff -Naur bluez-utils-2.4.orig/hcid/str.c bluez-utils-2.4/hcid/str.c
--- bluez-utils-2.4.orig/hcid/str.c	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/str.c	2004-02-24 21:47:20.000000000 +0100
@@ -37,11 +37,12 @@
 	return -1;
 }
 
-char *string_append(char *a, const char *b)
+void string_append(char **s, const char *b)
 {
 	int size_a, size_b;
+	char *a = *s;
 
-	size_a = strlen(a);
+	size_a = a ? strlen(a) : 0;
 	size_b = strlen(b);
 	a = realloc(a, size_a + size_b + 1);
 	if(!a) {
@@ -52,7 +53,7 @@
 	memcpy(a + size_a, b, size_b);
 	a[size_a + size_b] = 0;
 	
-	return a;
+	*s = a;
 }
 
 /*
diff -Naur bluez-utils-2.4.orig/hcid/str.h bluez-utils-2.4/hcid/str.h
--- bluez-utils-2.4.orig/hcid/str.h	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/str.h	2004-02-24 21:47:20.000000000 +0100
@@ -12,6 +12,6 @@
 int parse_hex_digit(char c);
 const char *goto_next_line(const char *str);
 
-char *string_append(char *a, const char *b);
+void string_append(char **a, const char *b);
 char *string_quote(const char *str);
 void string_unquote(char *str);

--=-5iA53N33NYIUHeUnusaX--
