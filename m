Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075509170.3594.36.camel@pegasus>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-/DOsS8mVmRPwLUTncWPZ"
Message-Id: <1075546024.14644.153.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sat, 31 Jan 2004 11:47:04 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-/DOsS8mVmRPwLUTncWPZ
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel

lör 2004-01-31 klockan 01.32 skrev Marcel Holtmann:
> Follow the coding style.

Attached patch contains a bunch of cleanups.

 file.c     |   41 ++++++----------
 file.h     |   18 +++----
 hcid.h     |   12 ++--
 keytab.c   |  154 ++++++++++++++++++++++++++++++-------------------------------
 keytab.h   |   18 +++----
 lib.h      |    4 -
 security.c |   11 ++--
 7 files changed, 124 insertions(+), 134 deletions(-)

Fredrik


--=-/DOsS8mVmRPwLUTncWPZ
Content-Disposition: attachment; filename=hcid-cleanups.patch
Content-Type: text/x-patch; name=hcid-cleanups.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/hcid/file.c bluez-utils-2.4/hcid/file.c
--- bluez-utils-2.4.orig/hcid/file.c	2004-01-31 11:38:18.000000000 +0100
+++ bluez-utils-2.4/hcid/file.c	2004-01-31 11:29:16.000000000 +0100
@@ -1,13 +1,13 @@
 /* 
-   BlueZ - Bluetooth protocol stack for Linux
-   Copyright (C) 2004 Fredrik Noring
-   
-   Written 2004 by Fredrik Noring <noring@nocrew.org>
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-*/
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -17,15 +17,7 @@
 #include <fcntl.h>
 #include <syslog.h>
 #include <errno.h>
-#include <time.h>
 #include <fcntl.h>
-#include <time.h>
-
-#include <sys/ioctl.h>
-#include <sys/socket.h>
-#include <sys/time.h>
-#include <sys/stat.h>
-#include <asm/types.h>
 
 #include "file.h"
 #include "lib.h"
@@ -37,24 +29,24 @@
 	free(file);
 }
 
+/*
+ * Files are always terminated with 0.
+ */
 struct file *read_file(const char *filename)
-	/* Files are always terminated with 0. */
 {
 	struct file *file = 0;
 	size_t size = 0;
 	int fd;
 
 	fd = open(filename, O_RDONLY);
-	if (fd < 0)
-	{
+	if (fd < 0) {
 		if(errno != ENOENT)
 			syslog(LOG_ERR, "%s open failed. %s(%d)",
 					filename, strerror(errno), errno);
 		return 0;
 	}
 
-	for(;;)
-	{
+	for(;;) {
 		ssize_t r;
 
 		file = realloc(file, sizeof(struct file) +
@@ -65,7 +57,7 @@
 			exit(1);
 		}
 
-		r = read_n(fd, file->data + size, BUFFER_READ_SIZE);
+		r = read_sigsafe(fd, file->data + size, BUFFER_READ_SIZE);
 		
 		if (!r)
 			break;
@@ -80,8 +72,7 @@
 
 	close(fd);
 	
-	if(file)
-	{
+	if(file) {
 		file->size = size;
 
 		/* Always terminate files with 0. */
diff -Naur bluez-utils-2.4.orig/hcid/file.h bluez-utils-2.4/hcid/file.h
--- bluez-utils-2.4.orig/hcid/file.h	2004-01-31 11:38:19.000000000 +0100
+++ bluez-utils-2.4/hcid/file.h	2004-01-31 11:29:29.000000000 +0100
@@ -1,13 +1,13 @@
 /* 
-   BlueZ - Bluetooth protocol stack for Linux
-   Copyright (C) 2004 Fredrik Noring
-   
-   Written 2004 by Fredrik Noring <noring@nocrew.org>
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-*/
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
 
 struct file {
 	size_t size;
diff -Naur bluez-utils-2.4.orig/hcid/hcid.h bluez-utils-2.4/hcid/hcid.h
--- bluez-utils-2.4.orig/hcid/hcid.h	2004-01-31 11:38:19.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.h	2004-01-31 11:33:06.000000000 +0100
@@ -55,14 +55,14 @@
 	struct device_opts opts;
 };
 
-typedef uint8_t	link_key_t[16];
+#define LINK_KEY_SIZE 16
 
 struct link_key {
-	bdaddr_t   sba;
-	bdaddr_t   dba;
-	link_key_t key;
-	uint8_t    type;
-	time_t	   time;
+	bdaddr_t sba;
+	bdaddr_t dba;
+	uint8_t  key[LINK_KEY_SIZE];
+	uint8_t  type;
+	time_t	 time;
 };
 
 struct link_key_list {
diff -Naur bluez-utils-2.4.orig/hcid/keytab.c bluez-utils-2.4/hcid/keytab.c
--- bluez-utils-2.4.orig/hcid/keytab.c	2004-01-31 11:38:19.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.c	2004-01-31 11:34:37.000000000 +0100
@@ -1,13 +1,13 @@
 /* 
-   BlueZ - Bluetooth protocol stack for Linux
-   Copyright (C) 2004 Fredrik Noring
-   
-   Written 2004 by Fredrik Noring <noring@nocrew.org>
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-*/
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -17,15 +17,9 @@
 #include <fcntl.h>
 #include <syslog.h>
 #include <errno.h>
-#include <time.h>
 #include <fcntl.h>
-#include <time.h>
 
-#include <sys/ioctl.h>
 #include <sys/socket.h>
-#include <sys/time.h>
-#include <sys/stat.h>
-#include <asm/types.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -35,9 +29,11 @@
 #include "lib.h"
 #include "file.h"
 
+/*
+ * Returns binary 0-15 for hex '0'-'a' and '0'-'A'. Returns -1 for
+ * invalid hex digits.
+ */
 static int parse_hex_digit(char c)
-	/* Returns binary 0-15 for hex '0'-'a' and '0'-'A'.
-	 * Returns -1 for invalid hex digits. */
 {
 	if('0' <= c && c <= '9')
 		return c - '0';
@@ -48,9 +44,11 @@
 	return -1;
 }
 
+/*
+ * Returns a character pointer to the character after the next newline
+ * or after end-of-file.
+ */
 static const char *goto_next_line(const char *str)
-	/* Returns a character pointer to the character after the next
-	 * newline or after end-of-file. */
 {
 	while(*str)
 		if(*str++ == '\n')
@@ -58,18 +56,20 @@
 	return str;
 }
 
+/*
+ * Allocate a new link_key item and put it on the top of the link
+ * structure.
+ */
 static struct link_key *allocate_link_key(struct link_key_list **link_key_list)
-	/* Allocate a new link_key item and put it on the top of the
-	 * link structure. */
 {
 	struct link_key_list *item;
 	
 	item = malloc(sizeof(struct link_key_list));
-	if (!item)
-	{
+	if (!item) {
 		/* A good reason for exit: We don't want to lose any
 		 * data when saving because we happened to fail
-		 * allocating a link_key. */
+		 * allocating a link_key.
+		 */
 		syslog(LOG_INFO, "Can't allocate link_key_list. Exit. %s(%d)",
 		       strerror(errno), errno);
 		exit(1);
@@ -89,16 +89,16 @@
 {
 	struct link_key_list *next;
 
-	for( ; list; list = next)
-	{
+	for( ; list; list = next) {
 		next = list->next;
 		free(list);
 	}
 }
 
+/*
+ * Load deprecated keys, typically from /etc/bluetooth/link_key.
+ */
 static struct link_key_list *load_deprecated_link_keys(void)
-	/* Load deprecated keys, typically from
-	 * /etc/bluetooth/link_key. */
 {
 	struct link_key_list *deprecated_link_key_list = 0;
 	struct file *key_file;
@@ -110,8 +110,7 @@
 
 	for(offset = 0;
 	    offset + sizeof(struct link_key) <= key_file->size;
-	    offset += sizeof(struct link_key))
-	{
+	    offset += sizeof(struct link_key)) {
 		struct link_key *deprecated_link_key;
 
 		deprecated_link_key =
@@ -126,13 +125,14 @@
 	return deprecated_link_key_list;
 }
 
+/*
+ * Parse keytab file, typically in /etc/bluetooth/keytab.
+ */
 static void parse_keytab(const char *str, struct link_key_list **link_key_list)
-	/* Parse keytab file, typically in /etc/bluetooth/keytab. */
 {
 	int line = 1;
 	
-	while(*str)
-	{
+	while(*str) {
 		struct link_key *link_key;
 		char sba_str[18], dba_str[18];
 		int type;
@@ -143,9 +143,8 @@
 			goto skip_row;
 
 		if(sscanf(str, "%17s %17s %d %ld",
-			  sba_str, dba_str, &type, &time) != 4)
+			  sba_str, dba_str, &type, &time) != 4) {
 			/* Skip unparsable row. */
-		{
 			syslog(LOG_ERR, "keytab:%d: Parse error", line);
 			goto skip_row;
 		}
@@ -161,24 +160,23 @@
 	}
 }
 
+/*
+ * Parse hex encoding of 16 bytes binary key.
+ */
 static int parse_key(const char *key_str, unsigned char *key, int line)
-	/* Parse hex encoding of 16 bytes binary key. */
 {
 	int i, hi, lo;
 	
-	for(i = 0; i < sizeof(link_key_t); i++)
-	{
+	for(i = 0; i < LINK_KEY_SIZE; i++) {
 		hi = parse_hex_digit(*key_str++);
-		if(hi == -1)
-		{
+		if(hi == -1) {
 			syslog(LOG_ERR,
 			       "keytab.shadow:%d: Key malformed", line);
 			return 0;
 		}
 
 		lo = parse_hex_digit(*key_str++);
-		if(lo == -1)
-		{
+		if(lo == -1) {
 			syslog(LOG_ERR,
 			       "keytab.shadow:%d: Key malformed", line);
 			return 0;
@@ -190,31 +188,33 @@
 	return 1;
 }
 
+/*
+ * Find matching sba/dba key pairs and attach the key to it. If there
+ * are several identical key pairs, attach the key to all of them.
+ */
 static void attach_key(struct link_key_list *link_key_list,
 		       const bdaddr_t *sba, const bdaddr_t *dba,
-		       const link_key_t key)
-	/* Find matching sba/dba key pairs and attach the key to it.
-	 * If there are several identical key pairs, attach the key to
-	 * all of them. */
+		       const uint8_t key[LINK_KEY_SIZE])
 {
-	for( ; link_key_list; link_key_list = link_key_list->next)
-	{
+	for( ; link_key_list; link_key_list = link_key_list->next) {
 		if(bacmp(&link_key_list->link_key.sba, sba) ||
 		   bacmp(&link_key_list->link_key.dba, dba))
 			continue;
 
 		link_key_list->has_key = 1;
-		memcpy(link_key_list->link_key.key, key, sizeof(link_key_t));
+		memcpy(link_key_list->link_key.key, key, LINK_KEY_SIZE);
+		
 		/* Let's continue because there might be duplicate entries. */
 	}
 }
 
+/*
+ * Find first matching sba/dba key pair.
+ */
 static struct link_key *get_key(struct link_key_list *link_key_list,
 				const bdaddr_t *sba, const bdaddr_t *dba)
-	/* Find first matching sba/dba key pair. */
 {
-	for( ; link_key_list; link_key_list = link_key_list->next)
-	{
+	for( ; link_key_list; link_key_list = link_key_list->next) {
 		if(!link_key_list->has_key ||
 		   bacmp(&link_key_list->link_key.sba, sba) ||
 		   bacmp(&link_key_list->link_key.dba, dba))
@@ -226,16 +226,17 @@
 	return 0;
 }
 
+/*
+ * Parse shadow file, typically in /etc/bluetooth/keytab.shadow.
+ */
 static void parse_shadow(const char *str, struct link_key_list *link_key_list)
-	/* Parse shadow file, typically in /etc/bluetooth/keytab.shadow. */
 {
 	int line = 1;
 	
-	while(*str)
-	{
+	while(*str) {
 		char sba_str[18], dba_str[18];
-		char key_str[2 * sizeof(link_key_t) + 1];
-		link_key_t key;
+		char key_str[2 * LINK_KEY_SIZE + 1];
+		uint8_t key[LINK_KEY_SIZE];
 		bdaddr_t sba, dba;
 		
 		if(*str == '#')
@@ -243,9 +244,8 @@
 			goto skip_row;
 
 		if(sscanf(str, "%17s\t%17s\t%32s",
-			  sba_str, dba_str, key_str) != 3)
+			  sba_str, dba_str, key_str) != 3) {
 			/* Skip unparsable row. */
-		{
 			syslog(LOG_ERR, "keytab.shadow:%d: Parse error", line);
 			goto skip_row;
 		}
@@ -261,9 +261,11 @@
 	}
 }
 
+/*
+ * Load keytab and associated shadow file. Returns 0 if the file
+ * couldn't be loaded.
+ */
 static struct link_key_list *load_keys(void)
-	/* Load keytab and associated shadow file. Returns 0 if the
-	 * file couldn't be loaded. */
 {
 	struct link_key_list *link_key_list;
 	struct file *key_file;
@@ -306,25 +308,22 @@
 	
 	*s++ = '\t';
 	
-	if(is_shadow)
-	{
+	if(is_shadow) {
 		int i;
 		
 		/* The link key */
-		for(i = 0; i < sizeof(key->key); i++)
-		{
+		for(i = 0; i < sizeof(key->key); i++) {
 			sprintf(s, "%02x", key->key[i]);
 			s += 2;
 		}
 		
 		*s++ = '\n';
 		*s++ = 0;
-	}
-	else
+	} else
 		/* Key type and time. FIXME: Use key type symbol? */
 		sprintf(s, "%d\t%ld\n", key->type, key->time);
 	
-	if (write_n(fd, row, strlen(row)) < 0) {
+	if (write_sigsafe(fd, row, strlen(row)) < 0) {
 		syslog(LOG_ERR, "keytab write failed. %s(%d)",
 		       strerror(errno), errno);
 		return 0;
@@ -333,8 +332,10 @@
 	return 1;
 }
 
+/*
+ * Save keytab and associated shadow file.
+ */
 static void save_keys(struct link_key_list *link_key_list)
-	/* Save keytab and associated shadow file. */
 {
 	struct link_key_list *list_item;
 	int keytab_fd, shadow_fd;
@@ -360,8 +361,7 @@
 	    list_item->next;
 	    list_item = link_key_list->next)
 		;
-	for( ; list_item; list_item = list_item->prev)
-	{
+	for( ; list_item; list_item = list_item->prev) {
 		if(!list_item->has_key)
 			continue;
 		if(!write_keytab_row(keytab_fd, &list_item->link_key, 0))
@@ -371,7 +371,8 @@
 	}
 
 	/* The following scheme is designed to make keytab and
-	 * keytab.shadow readable at all times. */
+	 * keytab.shadow readable at all times.
+	 */
 	
 	/* Remove backups and link new backups. */
 	unlink(HCID_KEYTAB_FILE"-");
@@ -397,11 +398,9 @@
 
 	/* Convert deprecated key_list file if needed. */
 	link_key_list = load_keys();
-	if(!link_key_list)
-	{
+	if(!link_key_list) {
 		link_key_list = load_deprecated_link_keys();
-		if(link_key_list)
-		{
+		if(link_key_list) {
 			syslog(LOG_INFO, "Converting deprecated link_keys "
 			       "file to keytab format.");
 			save_keys(link_key_list);
@@ -437,8 +436,7 @@
 
 	link_key_list = load_keys();
 
-	if(link_key_list)
-	{
+	if(link_key_list) {
 		k = get_key(link_key_list, &key->sba, &key->dba);
 		if(k)
 			exists = 1;
diff -Naur bluez-utils-2.4.orig/hcid/keytab.h bluez-utils-2.4/hcid/keytab.h
--- bluez-utils-2.4.orig/hcid/keytab.h	2004-01-31 11:38:19.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.h	2004-01-31 11:29:40.000000000 +0100
@@ -1,13 +1,13 @@
 /* 
-   BlueZ - Bluetooth protocol stack for Linux
-   Copyright (C) 2004 Fredrik Noring
-   
-   Written 2004 by Fredrik Noring <noring@nocrew.org>
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License version 2 as
-   published by the Free Software Foundation;
-*/
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
 
 void init_link_key(void);
 void set_link_key(struct link_key *key);
diff -Naur bluez-utils-2.4.orig/hcid/lib.h bluez-utils-2.4/hcid/lib.h
--- bluez-utils-2.4.orig/hcid/lib.h	2004-01-31 11:38:19.000000000 +0100
+++ bluez-utils-2.4/hcid/lib.h	2004-01-31 11:21:37.000000000 +0100
@@ -47,7 +47,7 @@
 }
 
 /* Read exactly len bytes (Signal safe)*/
-static inline int read_n(int fd, void *buf, int len)
+static inline int read_sigsafe(int fd, void *buf, int len)
 {
 	register int t = 0, w;
 
@@ -68,7 +68,7 @@
 }
 
 /* Write exactly len bytes (Signal safe)*/
-static inline int write_n(int fd, void *buf, int len)
+static inline int write_sigsafe(int fd, void *buf, int len)
 {
 	register int t = 0, w;
 
diff -Naur bluez-utils-2.4.orig/hcid/security.c bluez-utils-2.4/hcid/security.c
--- bluez-utils-2.4.orig/hcid/security.c	2004-01-31 11:38:19.000000000 +0100
+++ bluez-utils-2.4/hcid/security.c	2004-01-31 11:33:19.000000000 +0100
@@ -86,10 +86,11 @@
 		hci_send_cmd(dev, OGF_LINK_CTL, OCF_LINK_KEY_REPLY,
 				LINK_KEY_REPLY_CP_SIZE, &lr);
 		/* Apparently the original author intended to save
-		   the request time for this key, but no call to the
-		   save function was made so this was lost.
-
-		   key.time = time(0); */
+		 * the request time for this key, but no call to the
+		 * save function was made so this was lost.
+		 * 
+		 * key.time = time(0);
+		 */
 	} else {
 		/* Link key not found */
 		hci_send_cmd(dev, OGF_LINK_CTL, OCF_LINK_KEY_NEG_REPLY, 6, dba);
@@ -106,7 +107,7 @@
 	ba2str(sba, sa);
 	syslog(LOG_INFO, "link_key_notify (sba=%s)\n", sa);
 
-	memcpy(key.key, evt->link_key, sizeof(link_key_t));
+	memcpy(key.key, evt->link_key, LINK_KEY_SIZE);
 	bacpy(&key.sba, sba);
 	bacpy(&key.dba, dba);
 	key.type = evt->key_type;

--=-/DOsS8mVmRPwLUTncWPZ--
