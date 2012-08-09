Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 2/3] rfcomm: Remove support for configuration file
Date: Thu,  9 Aug 2012 17:29:02 -0300
Message-Id: <1344544143-12805-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1344544143-12805-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1344544143-12805-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore        |   5 --
 Makefile.am       |   2 +-
 Makefile.tools    |  15 +----
 configure.ac      |   2 -
 tools/kword.c     |  65 ---------------------
 tools/kword.h     |  46 ---------------
 tools/lexer.l     | 120 --------------------------------------
 tools/parser.y    | 171 ------------------------------------------------------
 tools/rfcomm.1    |  19 +-----
 tools/rfcomm.c    |  99 ++++++-------------------------
 tools/rfcomm.conf |  17 ------
 11 files changed, 24 insertions(+), 537 deletions(-)
 delete mode 100644 tools/kword.c
 delete mode 100644 tools/kword.h
 delete mode 100644 tools/lexer.l
 delete mode 100644 tools/parser.y
 delete mode 100644 tools/rfcomm.conf

diff --git a/.gitignore b/.gitignore
index 38318cd..c9f293a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,11 +26,6 @@ missing
 stamp-h1
 autom4te.cache
 
-ylwrap
-lexer.c
-parser.h
-parser.c
-
 bluez.pc
 lib/bluetooth
 src/builtin.h
diff --git a/Makefile.am b/Makefile.am
index 45a811c..a74709d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -423,7 +423,7 @@ DISTCLEANFILES = $(pkgconfig_DATA)
 
 MAINTAINERCLEANFILES = Makefile.in \
 	aclocal.m4 configure config.h.in config.sub config.guess \
-	ltmain.sh depcomp compile missing install-sh mkinstalldirs ylwrap
+	ltmain.sh depcomp compile missing install-sh mkinstalldirs
 
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
diff --git a/Makefile.tools b/Makefile.tools
index 5579b86..d3b6f57 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -1,9 +1,5 @@
 
 if TOOLS
-if DATAFILES
-conf_DATA += tools/rfcomm.conf
-endif
-
 bin_PROGRAMS += tools/rfcomm tools/l2ping \
 				tools/hcitool tools/sdptool tools/ciptool
 
@@ -12,12 +8,7 @@ sbin_PROGRAMS += tools/hciattach tools/hciconfig
 noinst_PROGRAMS += tools/avinfo tools/ppporc \
 				tools/hcieventmask tools/hcisecfilter
 
-tools/kword.c: tools/parser.h
-
-tools_rfcomm_SOURCES = tools/rfcomm.c tools/parser.y tools/lexer.l \
-					tools/kword.h tools/kword.c
-EXTRA_tools_rfcomm_SOURCES = tools/parser.h tools/parser.c \
-							tools/lexer.c
+tools_rfcomm_SOURCES = tools/rfcomm.c
 tools_rfcomm_LDADD = lib/libbluetooth-private.la
 
 tools_l2ping_LDADD = lib/libbluetooth-private.la
@@ -88,10 +79,6 @@ EXTRA_DIST += tools/rfcomm.1 tools/l2ping.8 \
 			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1
 endif
 
-CLEANFILES += tools/lexer.c tools/parser.c tools/parser.h
-
-EXTRA_DIST += tools/rfcomm.conf
-
 if BCCMD
 sbin_PROGRAMS += tools/bccmd
 
diff --git a/configure.ac b/configure.ac
index 7f331ae..7d9a34d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,8 +20,6 @@ AC_PROG_CC
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
 AC_PROG_INSTALL
-AC_PROG_YACC
-AM_PROG_LEX
 AM_PROG_MKDIR_P
 
 m4_define([_LT_AC_TAGCONFIG], [])
diff --git a/tools/kword.c b/tools/kword.c
deleted file mode 100644
index 62e24fe..0000000
--- a/tools/kword.c
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-
-#include "kword.h"
-#include "parser.h"
-
-int lineno;
-
-struct keyword_t rfcomm_keyword[] = {
-	{ "bind",	K_BIND		},
-	{ "device",	K_DEVICE	},
-	{ "channel",	K_CHANNEL	},
-	{ "comment",	K_COMMENT	},
-
-	{ "yes",	K_YES		},
-	{ "no",		K_NO		},
-	{ "enable",	K_YES		},
-	{ "disable",	K_NO		},
-
-	{ NULL , 0 }
-};
-
-int rfcomm_find_keyword(struct keyword_t *keyword, char *string)
-{
-	while (keyword->string) {
-		if (!strcmp(string, keyword->string))
-			return keyword->type;
-		keyword++;
-	}
-
-	return -1;
-}
-
-struct rfcomm_opts rfcomm_opts[RFCOMM_MAX_DEV];
diff --git a/tools/kword.h b/tools/kword.h
deleted file mode 100644
index 81a2a88..0000000
--- a/tools/kword.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-extern int lineno;
-
-struct keyword_t {
-	char *string;
-	int type;
-};
-
-extern struct keyword_t rfcomm_keyword[];
-
-int rfcomm_find_keyword(struct keyword_t *keyword, char *string);
-
-#define MAXCOMMENTLEN  100
-
-struct rfcomm_opts {
-	int bind;
-	bdaddr_t bdaddr;
-	int channel;
-	char comment[MAXCOMMENTLEN + 1];
-};
-
-extern struct rfcomm_opts rfcomm_opts[RFCOMM_MAX_DEV];
-
-int rfcomm_read_config(char *filename);
diff --git a/tools/lexer.l b/tools/lexer.l
deleted file mode 100644
index ff9ce81..0000000
--- a/tools/lexer.l
+++ /dev/null
@@ -1,120 +0,0 @@
-%{
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-/* Nasty workaround, but flex defines isatty() twice */
-#define _UNISTD_H
-
-#include <stdio.h>
-#include <errno.h>
-#include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-
-#include "kword.h"
-#include "parser.h"
-
-int yylex(void);
-
-#define YY_NO_INPUT
-
-#define ECHO {;}
-#define YY_DECL int yylex(void)
-
-int yyerror(char *str);
-
-%}
-
-%option nounput
-
-space		[ \t]
-linebreak	\n
-comment		\#.*\n
-keyword		[A-Za-z0-9\_\-]+
-
-number		[0-9]+
-string		\".*\"
-bdaddr		[A-Za-z0-9]{2}:[A-Za-z0-9]{2}:[A-Za-z0-9]{2}:[A-Za-z0-9]{2}:[A-Za-z0-9]{2}:[A-Za-z0-9]{2}
-
-%%
-
-{space}		{
-			/* Skip spaces and tabs */
-			;
-		}
-
-{comment}	{
-			/* Skip comments */
-			lineno++; 
-		}
-
-{number}	{
-			yylval.number = atoi(yytext);
-			return NUMBER;
-		}
-
-{string}	{
-			yylval.string = yytext;
-			return STRING;
-		}
-
-{bdaddr}	{
-			bdaddr_t *ba = malloc(sizeof(bdaddr_t));
-			str2ba(yytext, ba);
-			yylval.bdaddr = ba;
-			return BDADDR;
-		}
-
-{keyword}	{
-			int keyword = rfcomm_find_keyword(rfcomm_keyword, yytext);
-			if (keyword != -1)
-				return keyword;
-
-			if (strncmp(yytext, "rfcomm", 6) == 0) {
-				yylval.number = atoi(yytext + 6);
-				return RFCOMM;
-			}
-
-			yylval.string = yytext;
-			return WORD;
-		}
-
-{linebreak}	{
-			lineno++;
-		}
-
-.		{
-			return *yytext;
-		}
-
-%%
-
-int yywrap(void) 
-{
-	return 1;
-}
diff --git a/tools/parser.y b/tools/parser.y
deleted file mode 100644
index 96e6a56..0000000
--- a/tools/parser.y
+++ /dev/null
@@ -1,171 +0,0 @@
-%{
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/param.h>
-#include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-
-#include "kword.h"
-
-int yylex(void);
-int yyerror(char *s); 
-
-struct rfcomm_opts *opts;
-
-%}
-
-%union {
-	int number;
-	char *string;
-	bdaddr_t *bdaddr;
-}
-
-%token K_BIND K_DEVICE K_CHANNEL K_COMMENT
-%token K_YES K_NO
-
-%token <number> NUMBER RFCOMM
-%token <string> STRING WORD
-%token <bdaddr> BDADDR
-
-%type <number> bool
-
-%%
-
-config		:
-		| statement
-		| config statement
-		;
-
-statement	: section '{' rfcomm_options '}'
-		| rfcomm  '{' rfcomm_options '}'
-		| WORD
-			{
-			}
-		| error
-			{
-				yyclearin;
-				yyerrok;
-			}
-		;
-
-section		: WORD
-			{
-				opts = NULL;
-			}
-		;
-
-rfcomm		: RFCOMM
-			{
-				if (($1 >= 0) && ($1 < RFCOMM_MAX_DEV))
-					opts = &rfcomm_opts[$1];
-				else
-					opts = NULL;
-			}
-		;
-
-rfcomm_options	: rfcomm_option ';'
-		| error ';'
-		| rfcomm_options rfcomm_option ';'
-		;
-
-rfcomm_option	: K_BIND bool
-			{
-				if (opts)
-					opts->bind = $2;
-			}
-		| K_DEVICE BDADDR
-			{
-				if (opts)
-					bacpy(&opts->bdaddr, $2);
-			}
-		| K_CHANNEL NUMBER
-			{
-				if (opts)
-					opts->channel = $2;
-			}
-		| K_COMMENT STRING
-			{
-				if (opts)
-					snprintf(opts->comment, MAXCOMMENTLEN, "%s", $2);
-			}
-		| WORD
-			{
-				// Unknown option
-			}
-		;
-
-bool		: K_YES	{ $$ = 1; }
-		| K_NO	{ $$ = 0; }
-		;
-
-%%
-
-int yyerror(char *s) 
-{
-	fprintf(stderr, "%s line %d\n", s, lineno);
-	return 0;
-}
-
-int rfcomm_read_config(char *filename)
-{
-	extern FILE *yyin;
-	char file[MAXPATHLEN + 1];
-	int i;
-
-	for (i = 0; i < RFCOMM_MAX_DEV; i++) {
-		rfcomm_opts[i].bind = 0;
-		bacpy(&rfcomm_opts[i].bdaddr, BDADDR_ANY);
-		rfcomm_opts[i].channel = 1;
-	}
-
-	if (filename) {
-		snprintf(file, MAXPATHLEN,  "%s", filename);
-	} else {
-		snprintf(file, MAXPATHLEN, "%s/.bluetooth/rfcomm.conf", getenv("HOME"));
-
-		if ((getuid() == 0) || (access(file, R_OK) < 0))
-			snprintf(file, MAXPATHLEN, "%s/rfcomm.conf", CONFIGDIR);
-	}
-
-	if (!(yyin = fopen(file, "r")))
-		return -1;
-
-	lineno = 1;
-	yyparse();
-
-	fclose(yyin);
-
-	return 0;
-}
diff --git a/tools/rfcomm.1 b/tools/rfcomm.1
index 06303cd..f880f52 100644
--- a/tools/rfcomm.1
+++ b/tools/rfcomm.1
@@ -48,9 +48,6 @@ Prints information about all configured RFCOMM devices.
 .BI -r
 Switch TTY into raw mode (doesn't work with "bind").
 .TP
-.BI -f " <file>"
-Specify alternate config file.
-.TP
 .BI -i " <hciX> | <bdaddr>"
 The command is applied to device
 .BI -A
@@ -89,9 +86,8 @@ Display the information about the specified device.
 .BI connect " <dev> [bdaddr] [channel]"
 Connect the RFCOMM device to the remote Bluetooth device on the
 specified channel. If no channel is specified, it will use the
-channel number 1. If also the Bluetooth address is left out, it
-tries to read the data from the config file. This command can
-be terminated with the key sequence CTRL-C.
+channel number 1. This command can be terminated with the key
+sequence CTRL-C.
 .TP
 .BI listen " <dev> [channel] [cmd]"
 Listen on a specified RFCOMM channel for incoming connections.
@@ -115,15 +111,7 @@ This binds the RFCOMM device to a remote Bluetooth device. The
 command did not establish a connection to the remote device, it
 only creates the binding. The connection will be established right
 after an application tries to open the RFCOMM device. If no channel
-number is specified, it uses the channel number 1. If the Bluetooth
-address is also left out, it tries to read the data from the config
-file.
-
-If
-.B all
-is specified for the RFCOMM device, then all devices that have
-.B "bind yes"
-set in the config will be bound.
+number is specified, it uses the channel number 1.
 .TP
 .BI release " <dev>"
 This command releases a defined RFCOMM binding.
@@ -131,7 +119,6 @@ This command releases a defined RFCOMM binding.
 If
 .B all
 is specified for the RFCOMM device, then all bindings will be removed.
-This command didn't care about the settings in the config file.
 .SH AUTHOR
 Written by Marcel Holtmann <marcel@holtmann.org>.
 .br
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index 0a80670..add9f3b 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -46,13 +46,10 @@
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/rfcomm.h>
 
-#include "kword.h"
-
 #ifdef NEED_PPOLL
 #include "ppoll.h"
 #endif
 
-static char *rfcomm_config_file = NULL;
 static int rfcomm_raw_tty = 0;
 static int auth = 0;
 static int encryption = 0;
@@ -159,27 +156,16 @@ static int create_dev(int ctl, int dev, uint32_t flags, bdaddr_t *bdaddr, int ar
 	bacpy(&req.src, bdaddr);
 
 	if (argc < 2) {
-		err = rfcomm_read_config(rfcomm_config_file);
-		if (err < 0) {
-			perror("Can't open RFCOMM config file");
-			return err;
-		}
-
-		bacpy(&req.dst, &rfcomm_opts[dev].bdaddr);
-		req.channel = rfcomm_opts[dev].channel;
+		fprintf(stderr, "Missing dev parameter");
+		return -EINVAL;
+	}
 
-		if (bacmp(&req.dst, BDADDR_ANY) == 0) {
-			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
-			return -EFAULT;
-		}
-	} else {
-		str2ba(argv[1], &req.dst);
+	str2ba(argv[1], &req.dst);
 
-		if (argc > 2)
-			req.channel = atoi(argv[2]);
-		else
-			req.channel = 1;
-	}
+	if (argc > 2)
+		req.channel = atoi(argv[2]);
+	else
+		req.channel = 1;
 
 	err = ioctl(ctl, RFCOMMCREATEDEV, &req);
 	if (err == -1) {
@@ -194,35 +180,6 @@ static int create_dev(int ctl, int dev, uint32_t flags, bdaddr_t *bdaddr, int ar
 	return err;
 }
 
-static int create_all(int ctl)
-{
-	struct rfcomm_dev_req req;
-	int i, err;
-
-	err = rfcomm_read_config(rfcomm_config_file);
-	if (err < 0) {
-		perror("Can't open RFCOMM config file");
-		return err;
-	}
-
-	for (i = 0; i < RFCOMM_MAX_DEV; i++) {
-		if (!rfcomm_opts[i].bind)
-			continue;
-
-		memset(&req, 0, sizeof(req));
-		req.dev_id = i;
-		req.flags = 0;
-		bacpy(&req.src, BDADDR_ANY);
-		bacpy(&req.dst, &rfcomm_opts[i].bdaddr);
-		req.channel = rfcomm_opts[i].channel;
-
-		if (bacmp(&req.dst, BDADDR_ANY) != 0)
-			ioctl(ctl, RFCOMMCREATEDEV, &req);
-	}
-
-	return 0;
-}
-
 static int release_dev(int ctl, int dev, uint32_t flags)
 {
 	struct rfcomm_dev_req req;
@@ -335,28 +292,17 @@ static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **arg
 	laddr.rc_channel = 0;
 
 	if (argc < 2) {
-		if (rfcomm_read_config(rfcomm_config_file) < 0) {
-			perror("Can't open RFCOMM config file");
-			return;
-		}
+		fprintf(stderr, "Missing dev parameter");
+		return;
+	}
 
-		raddr.rc_family = AF_BLUETOOTH;
-		bacpy(&raddr.rc_bdaddr, &rfcomm_opts[dev].bdaddr);
-		raddr.rc_channel = rfcomm_opts[dev].channel;
+	raddr.rc_family = AF_BLUETOOTH;
+	str2ba(argv[1], &raddr.rc_bdaddr);
 
-		if (bacmp(&raddr.rc_bdaddr, BDADDR_ANY) == 0) {
-			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
-			return;
-		}
-	} else {
-		raddr.rc_family = AF_BLUETOOTH;
-		str2ba(argv[1], &raddr.rc_bdaddr);
-
-		if (argc > 2)
-			raddr.rc_channel = atoi(argv[2]);
-		else
-			raddr.rc_channel = 1;
-	}
+	if (argc > 2)
+		raddr.rc_channel = atoi(argv[2]);
+	else
+		raddr.rc_channel = 1;
 
 	sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
 	if (sk < 0) {
@@ -658,10 +604,7 @@ static void cmd_watch(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 
 static void cmd_create(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
-	if (strcmp(argv[0], "all") == 0)
-		create_all(ctl);
-	else
-		create_dev(ctl, dev, 0, bdaddr, argc, argv);
+	create_dev(ctl, dev, 0, bdaddr, argc, argv);
 }
 
 static void cmd_release(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
@@ -754,7 +697,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:f:rahAESML:", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+i:rahAESML:", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (strncmp(optarg, "hci", 3) == 0)
@@ -763,10 +706,6 @@ int main(int argc, char *argv[])
 				str2ba(optarg, &bdaddr);
 			break;
 
-		case 'f':
-			rfcomm_config_file = strdup(optarg);
-			break;
-
 		case 'r':
 			rfcomm_raw_tty = 1;
 			break;
diff --git a/tools/rfcomm.conf b/tools/rfcomm.conf
deleted file mode 100644
index 6179ef7..0000000
--- a/tools/rfcomm.conf
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# RFCOMM configuration file.
-#
-
-#rfcomm0 {
-#	# Automatically bind the device at startup
-#	bind no;
-#
-#	# Bluetooth address of the device
-#	device 11:22:33:44:55:66;
-#
-#	# RFCOMM channel for the connection
-#	channel	1;
-#
-#	# Description of the connection
-#	comment "Example Bluetooth device";
-#}
-- 
1.7.11.4

