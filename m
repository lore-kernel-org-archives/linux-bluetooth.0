Return-Path: <noring@nocrew.org>
Subject: [PATCH] Improved command line support, cleanups
From: Fredrik Noring <noring@nocrew.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/mixed; boundary="=-ovUTaveItenmSqv/cDGw"
Message-Id: <1075838704.2640.21.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Tue, 03 Feb 2004 21:05:04 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-ovUTaveItenmSqv/cDGw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

Attached patch implements improved command line support and
various cleanups like moving the PIN code to a separate file.

Fredrik

 Makefile.am |    2
 conf.c      |  139 +++++++++++++++++++++++++++++++++++++
 conf.h      |   64 +++++++++++++++++
 hcid.h      |   81 +++-------------------
 keytab.c    |    2
 lib.c       |   12 ---
 main.c      |   59 ----------------
 pin.c       |  220 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 pin.h       |   18 ++++
 security.c  |  212 +++------------------------------------------------------
 security.h  |   19 +++++
 11 files changed, 488 insertions(+), 340 deletions(-)


--=-ovUTaveItenmSqv/cDGw
Content-Disposition: attachment; filename=bluez-utils-2.4-fn6.patch
Content-Type: text/x-patch; name=bluez-utils-2.4-fn6.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/hcid/conf.c bluez-utils-2.4/hcid/conf.c
--- bluez-utils-2.4.orig/hcid/conf.c	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/conf.c	2004-02-03 20:37:27.000000000 +0100
@@ -0,0 +1,139 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2000-2001 Qualcomm Incorporated
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2000, 2001 by Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <getopt.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "hcid.h"
+
+struct hcid_opts hcid;
+struct device_opts default_device;
+struct device_opts *parser_device;
+
+static void usage(void)
+{
+	printf("Usage: hcid [options]\n"
+	       "Options:\n"
+	       "  -f, --config-file=file  Use the given configuration file.\n"
+	       "  -h, --help              Print a description of the command line options.\n"
+	       "  -n, --no-daemon         Do not fork as a daemon.\n"
+	       "  -v, --version           Print the version of the daemon.\n");
+}
+
+static char *get_hostname(void)
+{
+	char name[100];
+
+	if (gethostname(name, sizeof(name)-1) == 0)
+		return strdup(name);
+	return strdup("noname");
+}
+
+static void parse_cmds(int argc, char *argv[])
+{
+	int daemon = 1, dofork = 1;
+
+	for(;;) {
+		int c, option_index = 0;
+		static struct option long_options[] = {
+			{ "config-file", 1, 0, 'f' },
+			{ "help",        0, 0, 'h' },
+			{ "no-daemon",   0, 0, 'n' },
+			{ "version",     0, 0, 'v' },
+			{ 0,             0, 0,  0  }
+		};
+		
+		c = getopt_long (argc, argv, "f:hnv",
+				 long_options, &option_index);
+		if (c == -1)
+			break;
+		
+		switch(c) {
+			case 0:
+				printf("option %s",
+					long_options[option_index].name);
+				if (optarg)
+					printf (" with arg %s", optarg);
+				printf ("\n");
+				break;
+ 
+			case 'n':
+				daemon = 0;
+				break;
+				
+			case 'f':
+				hcid.config_file = strdup(optarg);
+				break;
+				
+			case 'v':
+				printf("hcid "VERSION"\n");
+				exit(1);
+				
+			case 'h':
+				usage();
+				exit(1);
+				
+			default:
+				fprintf(stderr, "%s: unrecognized option "
+					"'%c'\n", argv[0], c);
+				exit(1);
+		}
+	}
+
+	if (daemon) {
+		int fd;
+		
+		if (dofork && fork())
+			exit(0);
+
+		/* Direct stdin, stdout and stderr to /dev/null */
+		fd = open("/dev/null", O_RDWR);
+		dup2(fd, 0); dup2(fd, 1); dup2(fd, 2);
+		close(fd);
+		setsid();
+		chdir("/");
+	}
+}
+
+static void exit_conf(void *context)
+{
+	free(hcid.host_name);
+	
+	free(hcid.pin_file);
+	free(hcid.pin_helper);
+	
+	free(hcid.deprecated_key_file);
+}
+
+void init_conf(int argc, char *argv[])
+{
+	hcid.config_file         = "/etc/bluetooth/hcid.conf";
+	
+	hcid.host_name           = get_hostname();
+	hcid.security            = HCID_SEC_AUTO;
+	hcid.pairing             = HCID_PAIRING_MULTI;
+	
+	hcid.pin_file            = strdup("/etc/bluetooth/pin");
+	hcid.pin_helper          = strdup("/bin/bluepin");
+	
+	hcid.deprecated_key_file = strdup("/etc/bluetooth/link_key");
+
+	parse_cmds(argc, argv);
+	register_exit(exit_conf, 0);
+}
diff -Naur bluez-utils-2.4.orig/hcid/conf.h bluez-utils-2.4/hcid/conf.h
--- bluez-utils-2.4.orig/hcid/conf.h	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/conf.h	2004-02-03 20:26:57.000000000 +0100
@@ -0,0 +1,64 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2000-2001 Qualcomm Incorporated
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2000, 2001 by Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <sys/types.h>
+#include <bluetooth/bluetooth.h>
+
+enum {
+	HCID_SEC_NONE,
+	HCID_SEC_AUTO,
+	HCID_SEC_USER
+};
+
+enum {
+	HCID_PAIRING_NONE,
+	HCID_PAIRING_MULTI,
+	HCID_PAIRING_ONCE
+};
+
+#define HCID_KEYTAB_FILE "/etc/bluetooth/keytab"
+
+struct hcid_opts {
+	char   *host_name;
+	int     auto_init;
+	int     security;
+	int     pairing;
+
+	char   *config_file;
+
+	uint8_t pin_code[16];
+	int     pin_len;
+	char   *pin_helper;
+	char   *pin_file;
+
+	char   *deprecated_key_file;
+
+	int     sock;
+};
+
+struct device_opts {
+	char  *name;
+	uint32_t class;
+	uint16_t pkt_type;
+	uint16_t scan;
+	uint16_t link_mode;
+	uint16_t link_policy;
+	uint16_t auth;
+	uint16_t encrypt;
+};   
+
+extern struct hcid_opts hcid;
+extern struct device_opts default_device;
+extern struct device_opts *parser_device;
+
+void init_conf(int argc, char *argv[]);
diff -Naur bluez-utils-2.4.orig/hcid/hcid.h bluez-utils-2.4/hcid/hcid.h
--- bluez-utils-2.4.orig/hcid/hcid.h	2004-02-03 20:40:48.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.h	2004-02-03 19:55:19.000000000 +0100
@@ -1,54 +1,24 @@
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
-/*
- * $Id: hcid.h,v 1.6 2003/03/07 23:10:30 holtmann Exp $
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2000-2001 Qualcomm Incorporated
+ *  
+ *  Written 2000, 2001 by Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation;
+ *
+ *  $Id: hcid.h,v 1.6 2003/03/07 23:10:30 holtmann Exp $
  */
 
 #include <sys/types.h>
 
 #include "watch.h"
+#include "conf.h"
 
 #include <bluetooth/bluetooth.h>
 
-#define HCID_CONFIG_FILE "/etc/bluetooth/hcid.conf"
-#define HCID_PIN_FILE    "/etc/bluetooth/pin"
-#define HCID_KEY_FILE    "/etc/bluetooth/link_key"   /* DEPRECATED */
-#define HCID_KEYTAB_FILE "/etc/bluetooth/keytab"
-#define HCID_PIN_HELPER  "/bin/bluepin"
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
-extern struct device_opts default_device;
-extern struct device_opts *parser_device;
-
 struct device_list {
 	char *ref;                  /* hci interface or Bluetooth address */
 	struct device_list *next;
@@ -71,33 +41,6 @@
 	struct link_key link_key;
 };
 
-struct hcid_opts {
-	char   *host_name;
-	int     auto_init;
-	int     security;
-	int     pairing;
-
-	char   *config_file;
-
-	uint8_t pin_code[16];
-	int     pin_len;
-	char   *pin_helper;
-	char   *pin_file;
-
-	char   *key_file;
-
-	int     sock;
-};
-extern struct hcid_opts hcid;
-
-#define HCID_SEC_NONE	0
-#define HCID_SEC_AUTO	1
-#define HCID_SEC_USER	2
-
-#define HCID_PAIRING_NONE	0
-#define HCID_PAIRING_MULTI	1
-#define HCID_PAIRING_ONCE	2
-
 void register_exit(void (*callback)(void *context), void *context);
 
 int read_config(char *file);
diff -Naur bluez-utils-2.4.orig/hcid/keytab.c bluez-utils-2.4/hcid/keytab.c
--- bluez-utils-2.4.orig/hcid/keytab.c	2004-02-03 20:40:48.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.c	2004-02-03 00:01:08.000000000 +0100
@@ -105,7 +105,7 @@
 	struct file *key_file;
 	size_t offset;
 
-	key_file = read_file(hcid.key_file);
+	key_file = read_file(hcid.deprecated_key_file);
 	if(!key_file)
 		return 0;
 
diff -Naur bluez-utils-2.4.orig/hcid/lib.c bluez-utils-2.4/hcid/lib.c
--- bluez-utils-2.4.orig/hcid/lib.c	2002-06-24 04:38:01.000000000 +0200
+++ bluez-utils-2.4/hcid/lib.c	2004-02-03 00:18:26.000000000 +0100
@@ -94,18 +94,6 @@
     return dst;
 }
 
-/* Returns current host name */
-char *get_host_name(void)
-{
-	char name[40];
-
-	if (!gethostname(name, sizeof(name)-1)) {
-		name[sizeof(name)-1] = 0;
-		return strdup(name);
-	} 
-	return strdup("noname");
-}
-
 /* Functions to manipulate program title */
 extern char **environ;
 char	*title_start;	/* start of the proc title space */
diff -Naur bluez-utils-2.4.orig/hcid/main.c bluez-utils-2.4/hcid/main.c
--- bluez-utils-2.4.orig/hcid/main.c	2004-02-03 20:40:48.000000000 +0100
+++ bluez-utils-2.4/hcid/main.c	2004-02-03 19:58:19.000000000 +0100
@@ -49,10 +49,8 @@
 #include "lib.h"
 
 #include "keytab.h"
+#include "security.h"
 
-struct hcid_opts hcid;
-struct device_opts default_device;
-struct device_opts *parser_device;
 static struct device_list *device_list = 0;
 
 struct exit_callback_list {
@@ -95,13 +93,6 @@
 	}
 }
 
-static void usage(void)
-{
-	printf("hcid - HCI daemon ver %s\n", VERSION);
-	printf("Usage: \n");
-	printf("\thcid [-n not_daemon] [-f config file]\n");
-}
-
 static struct device_opts *get_device_ref_opts(char *ref)
 {
 	struct device_list *device;
@@ -484,55 +475,13 @@
 
 int main(int argc, char *argv[], char *env[])
 {
-	int daemon, dofork, opt, fd;
 	struct sockaddr_hci addr;
 	struct hci_filter flt;
 	struct sigaction sa;
 	struct watch *ctl_io;
 
-	daemon = 1; dofork = 1;
-
-	/* Default HCId settings */
-	hcid.config_file = HCID_CONFIG_FILE;
-	hcid.host_name = get_host_name();
-	hcid.security  = HCID_SEC_AUTO;
-	hcid.pairing   = HCID_PAIRING_MULTI;
-
-	hcid.pin_file   = strdup(HCID_PIN_FILE);
-	hcid.pin_helper = strdup(HCID_PIN_HELPER);
-	hcid.key_file   = strdup(HCID_KEY_FILE);
-
+	init_conf(argc, argv);
 	init_defaults();
-	
-	while ((opt=getopt(argc,argv,"f:n")) != EOF) {
-		switch(opt) {
-		case 'n':
-			daemon = 0;
-			break;
-
-		case 'f':
-			hcid.config_file = strdup(optarg);
-			break;
-
-		default:
-			usage();
-			exit(1);
-		}
-	}
-
-	if (daemon) {
-		if (dofork && fork())
-			exit(0);
-
-		/* Direct stdin,stdout,stderr to '/dev/null' */
-		fd = open("/dev/null", O_RDWR);
-		dup2(fd, 0); dup2(fd, 1); dup2(fd, 2);
-		close(fd);
-
-		setsid();
-
-		chdir("/");
-	}
 
         init_title(argc, argv, env, "hcid: ");
 	set_title("initializing");
@@ -600,10 +549,6 @@
 	exit_register();
 	
 	close(hcid.sock);
-	free(hcid.host_name);
-	free(hcid.key_file);
-	free(hcid.pin_helper);
-	free(hcid.pin_file);
 	
 	syslog(LOG_INFO, "Exit.");
 	return 0;
diff -Naur bluez-utils-2.4.orig/hcid/Makefile.am bluez-utils-2.4/hcid/Makefile.am
--- bluez-utils-2.4.orig/hcid/Makefile.am	2004-02-03 20:40:46.000000000 +0100
+++ bluez-utils-2.4/hcid/Makefile.am	2004-02-03 00:10:49.000000000 +0100
@@ -6,7 +6,7 @@
 
 hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y \
                lexer.l kword.h kword.c glib-ectomy.h watch.c file.c   \
-               keytab.c dbus.c
+               keytab.c dbus.c conf.c pin.c
 hcid_CONFIG  = hcid.conf
 
 AM_YFLAGS = -d
diff -Naur bluez-utils-2.4.orig/hcid/pin.c bluez-utils-2.4/hcid/pin.c
--- bluez-utils-2.4.orig/hcid/pin.c	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/pin.c	2004-02-03 00:13:59.000000000 +0100
@@ -0,0 +1,220 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2000-2001 Qualcomm Incorporated
+ *  
+ *  Written 2000, 2001 by Maxim Krasnyansky <maxk@qualcomm.com>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <syslog.h>
+#include <errno.h>
+#include <time.h>
+#include <fcntl.h>
+#include <time.h>
+
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/stat.h>
+#include <asm/types.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#include "hcid.h"
+#include "lib.h"
+#include "file.h"
+#include "keytab.h"
+#include "security.h"
+#include "pin.h"
+
+int pairing;
+
+void toggle_pairing(int enable)
+{
+	if (enable)
+		pairing = hcid.pairing;
+	else
+		pairing = 0;
+
+	syslog(LOG_INFO, "Pairing %s", pairing ? "enabled" : "disabled");
+}
+
+int read_pin_code(void)
+{
+	char buf[17];
+	FILE *f; 
+	int len;
+
+	if (!(f = fopen(hcid.pin_file, "r"))) {
+		syslog(LOG_ERR, "Can't open PIN file %s. %s(%d)",
+				hcid.pin_file, strerror(errno), errno);
+		return -1;
+	}
+
+	if (fgets(buf, sizeof(buf), f)) {
+		strtok(buf, "\n\r");
+		len = strlen(buf); 
+		memcpy(hcid.pin_code, buf, len);
+		hcid.pin_len = len;
+	} else {
+		syslog(LOG_ERR, "Can't read PIN file %s. %s(%d)",
+				hcid.pin_file, strerror(errno), errno);
+		len = -1;
+	}
+	fclose(f);
+	return len;
+}
+
+/*
+ * PIN helper is an external app that asks user for a PIN. It can 
+ * implement its own PIN  code generation policy and methods like
+ * PIN look up in some database, etc.
+ *
+ * HCId expects following output from PIN helper:
+ *
+ *	PIN:12345678	-	PIN code
+ *	ERR		-	No PIN available
+ */
+
+void call_pin_helper(int dev, struct hci_conn_info *ci)
+{
+	pin_code_reply_cp pr;
+	char addr[12], str[255], *pin, name[20];
+	FILE *pipe;
+	int len;
+	
+	/* Run PIN helper in the separate process */
+	switch (fork()) {
+		case 0:
+			break;
+		case -1:
+			syslog(LOG_ERR, "Can't fork PIN helper. %s(%d)", 
+					strerror(errno), errno);
+		default:
+			return;
+	}
+
+	if (access(hcid.pin_helper, R_OK | X_OK)) {
+		syslog(LOG_ERR, "Can't exec PIN helper %s. %s(%d)",
+				hcid.pin_helper, strerror(errno), errno);
+		goto reject;
+	}
+
+	name[0] = 0;
+	//hci_remote_name(dev, &ci->bdaddr, sizeof(name), name, 0);
+
+	ba2str(&ci->bdaddr, addr);
+	sprintf(str, "%s %s %s \'%s\'", hcid.pin_helper, 
+			ci->out ? "out" : "in", 
+			addr, name);
+
+	setenv("PATH", "/bin:/usr/bin:/usr/local/bin", 1);
+
+	pipe = popen(str, "r");
+	if (!pipe) {
+		syslog(LOG_ERR, "Can't exec PIN helper. %s(%d)",
+		       strerror(errno), errno);
+		goto reject;
+	}	
+
+	pin = fgets(str, sizeof(str), pipe);
+	pclose(pipe);
+
+	if (!pin || strlen(pin) < 5)
+		goto reject;
+
+	strtok(pin, "\n\r");
+
+	if (strncmp("PIN:", pin, 4))
+		goto reject;
+
+	pin += 4;
+	len  = strlen(pin);
+	
+	memset(&pr, 0, sizeof(pr));
+	bacpy(&pr.bdaddr, &ci->bdaddr);
+	memcpy(pr.pin_code, pin, len);
+	pr.pin_len = len;
+	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_REPLY,
+			PIN_CODE_REPLY_CP_SIZE, &pr);
+	exit(0);
+
+reject:
+	hci_send_cmd(dev, OGF_LINK_CTL,
+		     OCF_PIN_CODE_NEG_REPLY, 6, &ci->bdaddr);
+	exit(0);
+}
+
+void pin_code_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
+{
+	struct hci_conn_info_req *cr;
+	struct hci_conn_info *ci;
+	char sa[18], da[18];
+
+	ba2str(sba, sa); ba2str(dba, da);
+	syslog(LOG_INFO, "pin_code_request (sba=%s, dba=%s)\n", sa, da);
+
+	cr = malloc(sizeof(*cr) + sizeof(*ci));
+	if (!cr)
+		return;
+
+	bacpy(&cr->bdaddr, dba);
+	cr->type = ACL_LINK;
+	if (ioctl(dev, HCIGETCONNINFO, (unsigned long) cr) < 0) {
+		syslog(LOG_ERR, "Can't get conn info %s(%d)",
+					strerror(errno), errno);
+		goto reject;
+	}
+	ci = cr->conn_info;
+
+	if (pairing == HCID_PAIRING_ONCE) {
+		struct link_key key;
+		if (get_link_key(&key, sba, dba)) {
+			ba2str(dba, da);
+			syslog(LOG_WARNING,
+			       "PIN code request for already paired device %s",
+			       da);
+			goto reject;
+		}
+	} else if (pairing == HCID_PAIRING_NONE)
+		goto reject;
+
+	if (hcid.security == HCID_SEC_AUTO) {
+		if (!ci->out) {
+			/* Incomming connection */
+			pin_code_reply_cp pr;
+			memset(&pr, 0, sizeof(pr));
+			bacpy(&pr.bdaddr, dba);
+			memcpy(pr.pin_code, hcid.pin_code, hcid.pin_len);
+			pr.pin_len = hcid.pin_len;
+			hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_REPLY,
+				PIN_CODE_REPLY_CP_SIZE, &pr);
+		} else {
+			/* Outgoing connection */
+		
+			/* Let PIN helper handle that */ 
+			call_pin_helper(dev, ci);
+		}
+	} else {
+		/* Let PIN helper handle that */ 
+		call_pin_helper(dev, ci);
+	}	
+	free(cr);
+	return;
+
+reject:
+	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, dba);
+	free(cr);
+	return;
+}
diff -Naur bluez-utils-2.4.orig/hcid/pin.h bluez-utils-2.4/hcid/pin.h
--- bluez-utils-2.4.orig/hcid/pin.h	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/pin.h	2004-02-03 00:13:23.000000000 +0100
@@ -0,0 +1,18 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+extern int pairing;
+
+void toggle_pairing(int enable);
+int read_pin_code(void);
+void call_pin_helper(int dev, struct hci_conn_info *ci);
+void pin_code_request(int dev, bdaddr_t *sba, bdaddr_t *dba);
diff -Naur bluez-utils-2.4.orig/hcid/security.c bluez-utils-2.4/hcid/security.c
--- bluez-utils-2.4.orig/hcid/security.c	2004-02-03 20:40:48.000000000 +0100
+++ bluez-utils-2.4/hcid/security.c	2004-02-03 00:14:56.000000000 +0100
@@ -1,27 +1,14 @@
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
-/*
- * $Id: security.c,v 1.8 2003/07/24 17:34:34 holtmann Exp $
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2000-2001 Qualcomm Incorporated
+ *  
+ *  Written 2000, 2001 by Maxim Krasnyansky <maxk@qualcomm.com>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  $Id: security.c,v 1.8 2003/07/24 17:34:34 holtmann Exp $
  */
 
 #include <stdio.h>
@@ -50,21 +37,11 @@
 #include "lib.h"
 #include "file.h"
 #include "keytab.h"
+#include "security.h"
+#include "pin.h"
 
 static struct watch *hci_watch_list[HCI_MAX_DEV];
 
-static int pairing;
-
-void toggle_pairing(int enable)
-{
-	if (enable)
-		pairing = hcid.pairing;
-	else
-		pairing = 0;
-
-	syslog(LOG_INFO, "Pairing %s", pairing ? "enabled" : "disabled");
-}
-
 static void link_key_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 {
 	struct link_key key;
@@ -114,171 +91,6 @@
 	set_link_key(&key);
 }
 
-/* PIN code handling */
-
-int read_pin_code(void)
-{
-	char buf[17];
-	FILE *f; 
-	int len;
-
-	if (!(f = fopen(hcid.pin_file, "r"))) {
-		syslog(LOG_ERR, "Can't open PIN file %s. %s(%d)",
-				hcid.pin_file, strerror(errno), errno);
-		return -1;
-	}
-
-	if (fgets(buf, sizeof(buf), f)) {
-		strtok(buf, "\n\r");
-		len = strlen(buf); 
-		memcpy(hcid.pin_code, buf, len);
-		hcid.pin_len = len;
-	} else {
-		syslog(LOG_ERR, "Can't read PIN file %s. %s(%d)",
-				hcid.pin_file, strerror(errno), errno);
-		len = -1;
-	}
-	fclose(f);
-	return len;
-}
-
-/*
-  PIN helper is an external app that asks user for a PIN. It can 
-  implement its own PIN  code generation policy and methods like
-  PIN look up in some database, etc. 
-  HCId expects following output from PIN helper:
-	PIN:12345678	-	PIN code
-	ERR		-	No PIN available
-*/
-
-static void call_pin_helper(int dev, struct hci_conn_info *ci)
-{
-	pin_code_reply_cp pr;
-	char addr[12], str[255], *pin, name[20];
-	FILE *pipe;
-	int len;
-	
-	/* Run PIN helper in the separate process */
-	switch (fork()) {
-		case 0:
-			break;
-		case -1:
-			syslog(LOG_ERR, "Can't fork PIN helper. %s(%d)", 
-					strerror(errno), errno);
-		default:
-			return;
-	}
-
-	if (access(hcid.pin_helper, R_OK | X_OK)) {
-		syslog(LOG_ERR, "Can't exec PIN helper %s. %s(%d)",
-				hcid.pin_helper, strerror(errno), errno);
-		goto reject;
-	}
-
-	name[0] = 0;
-	//hci_remote_name(dev, &ci->bdaddr, sizeof(name), name, 0);
-
-	ba2str(&ci->bdaddr, addr);
-	sprintf(str, "%s %s %s \'%s\'", hcid.pin_helper, 
-			ci->out ? "out" : "in", 
-			addr, name);
-
-	setenv("PATH", "/bin:/usr/bin:/usr/local/bin", 1);
-
-	pipe = popen(str, "r");
-	if (!pipe) {
-		syslog(LOG_ERR, "Can't exec PIN helper. %s(%d)", strerror(errno), errno);
-		goto reject;
-	}	
-
-	pin = fgets(str, sizeof(str), pipe);
-	pclose(pipe);
-
-	if (!pin || strlen(pin) < 5)
-		goto reject;
-
-	strtok(pin, "\n\r");
-
-	if (strncmp("PIN:", pin, 4))
-		goto reject;
-
-	pin += 4;
-	len  = strlen(pin);
-	
-	memset(&pr, 0, sizeof(pr));
-	bacpy(&pr.bdaddr, &ci->bdaddr);
-	memcpy(pr.pin_code, pin, len);
-	pr.pin_len = len;
-	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_REPLY,
-			PIN_CODE_REPLY_CP_SIZE, &pr);
-	exit(0);
-
-reject:
-	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, &ci->bdaddr);
-	exit(0);
-}
-
-static void pin_code_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
-{
-	struct hci_conn_info_req *cr;
-	struct hci_conn_info *ci;
-	char sa[18], da[18];
-
-	ba2str(sba, sa); ba2str(dba, da);
-	syslog(LOG_INFO, "pin_code_request (sba=%s, dba=%s)\n", sa, da);
-
-	cr = malloc(sizeof(*cr) + sizeof(*ci));
-	if (!cr)
-		return;
-
-	bacpy(&cr->bdaddr, dba);
-	cr->type = ACL_LINK;
-	if (ioctl(dev, HCIGETCONNINFO, (unsigned long) cr) < 0) {
-		syslog(LOG_ERR, "Can't get conn info %s(%d)",
-					strerror(errno), errno);
-		goto reject;
-	}
-	ci = cr->conn_info;
-
-	if (pairing == HCID_PAIRING_ONCE) {
-		struct link_key key;
-		if (get_link_key(&key, sba, dba)) {
-			ba2str(dba, da);
-			syslog(LOG_WARNING, "PIN code request for already paired device %s", da);
-			goto reject;
-		}
-	} else if (pairing == HCID_PAIRING_NONE)
-		goto reject;
-
-	if (hcid.security == HCID_SEC_AUTO) {
-		if (!ci->out) {
-			/* Incomming connection */
-			pin_code_reply_cp pr;
-			memset(&pr, 0, sizeof(pr));
-			bacpy(&pr.bdaddr, dba);
-			memcpy(pr.pin_code, hcid.pin_code, hcid.pin_len);
-			pr.pin_len = hcid.pin_len;
-			hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_REPLY,
-				PIN_CODE_REPLY_CP_SIZE, &pr);
-		} else {
-			/* Outgoing connection */
-		
-			/* Let PIN helper handle that */ 
-			call_pin_helper(dev, ci);
-		}
-	} else {
-		/* Let PIN helper handle that */ 
-		call_pin_helper(dev, ci);
-	}	
-	free(cr);
-	return;
-
-reject:
-	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, dba);
-	free(cr);
-	return;
-}
-
 void io_security_event(struct watch *watch, short events,
 		       struct hci_dev_info *di)
 {
diff -Naur bluez-utils-2.4.orig/hcid/security.h bluez-utils-2.4/hcid/security.h
--- bluez-utils-2.4.orig/hcid/security.h	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/security.h	2004-02-03 00:06:23.000000000 +0100
@@ -0,0 +1,19 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+void init_security_data(void);
+void start_security_manager(int hdev);
+void stop_security_manager(int hdev);
+void toggle_pairing(int enable);
+
+void reset_security(void);
+
+void init_security(void);

--=-ovUTaveItenmSqv/cDGw--
