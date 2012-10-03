Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] storage: Move adapter info to adapter.conf
Date: Wed,  3 Oct 2012 16:26:41 +0200
Message-Id: <1349274401-32012-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add functions to read and write to .conf files.
Convert adapter "config" file to "adapter.conf".
---
 .gitignore          |    1 +
 Makefile.am         |    3 +-
 Makefile.tools      |    6 +-
 src/keyfile.c       |  282 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/keyfile.h       |   51 ++++++++++
 src/storage.c       |  100 +++++++-----------
 test/test-keyfile.c |  252 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 627 insertions(+), 68 deletions(-)
 create mode 100644 src/keyfile.c
 create mode 100644 src/keyfile.h
 create mode 100644 test/test-keyfile.c

diff --git a/.gitignore b/.gitignore
index c9f293a..2f89353 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,6 +82,7 @@ unit/test-eir
 tools/btmgmt
 monitor/btmon
 emulator/btvirt
+test/test-keyfile
 
 doc/*.bak
 doc/*.stamp
diff --git a/Makefile.am b/Makefile.am
index c27eb01..ba7c8d8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -309,7 +309,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/dbus-common.c src/dbus-common.h \
 			src/event.h src/event.c \
 			src/oob.h src/oob.c src/eir.h src/eir.c \
-			src/mgmt.c src/mgmt.h
+			src/mgmt.c src/mgmt.h \
+			src/keyfile.h src/keyfile.c
 src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
 								-ldl -lrt
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
diff --git a/Makefile.tools b/Makefile.tools
index 9637a9f..e122b0a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -157,7 +157,8 @@ noinst_PROGRAMS += test/gaptest test/sdptest test/scotest \
 			test/attest test/hstest test/avtest \
 					test/lmptest test/bdaddr test/agent \
 					test/btiotest test/test-textfile \
-					test/uuidtest test/mpris-player
+					test/uuidtest test/mpris-player \
+					test/test-keyfile
 
 test_hciemu_LDADD = lib/libbluetooth-private.la
 
@@ -195,6 +196,9 @@ test_mpris_player_LDADD = @DBUS_LIBS@ @GLIB_LIBS@
 
 test_test_textfile_SOURCES = test/test-textfile.c src/textfile.h src/textfile.c
 
+test_test_keyfile_SOURCES = test/test-keyfile.c src/keyfile.h src/keyfile.c
+test_test_keyfile_LDADD = @GLIB_LIBS@
+
 dist_man_MANS += test/rctest.1 test/hciemu.1
 
 EXTRA_DIST += test/bdaddr.8
diff --git a/src/keyfile.c b/src/keyfile.c
new file mode 100644
index 0000000..ea5f0bf
--- /dev/null
+++ b/src/keyfile.c
@@ -0,0 +1,282 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "keyfile.h"
+
+int keyfile_put_string(const char *pathname, const char *group,
+				const char *key, const char *value)
+{
+	GKeyFile *key_file;
+	char *data;
+	FILE *file;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, pathname, 0, NULL);
+
+	g_key_file_set_string(key_file, group, key, value);
+
+	data = g_key_file_to_data(key_file, NULL, NULL);
+	file = fopen(pathname, "w");
+	fputs(data, file);
+	fclose(file);
+
+	g_free(data);
+	g_key_file_free(key_file);
+
+	return 0;
+}
+
+int keyfile_put_boolean(const char *pathname, const char *group,
+				const char *key, gboolean value)
+{
+	GKeyFile *key_file;
+	char *data;
+	FILE *file;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, pathname, 0, NULL);
+
+	g_key_file_set_boolean(key_file, group, key, value);
+
+	data = g_key_file_to_data(key_file, NULL, NULL);
+	file = fopen(pathname, "w");
+	fputs(data, file);
+	fclose(file);
+
+	g_free(data);
+	g_key_file_free(key_file);
+
+	return 0;
+}
+
+int keyfile_put_integer(const char *pathname, const char *group,
+				const char *key, int value)
+{
+	GKeyFile *key_file;
+	char *data;
+	FILE *file;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, pathname, 0, NULL);
+
+	g_key_file_set_integer(key_file, group, key, value);
+
+	data = g_key_file_to_data(key_file, NULL, NULL);
+	file = fopen(pathname, "w");
+	fputs(data, file);
+	fclose(file);
+
+	g_free(data);
+	g_key_file_free(key_file);
+
+	return 0;
+}
+
+char *keyfile_get_string(const char *pathname, const char *group,
+				const char *key)
+{
+	char *str = NULL;
+	GKeyFile *key_file;
+	int err = 0;
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, pathname, 0, NULL)) {
+		err = -ENOENT;
+		goto failed;
+	}
+
+	str = g_key_file_get_string(key_file, group, key, NULL);
+	if (!str)
+		err = -EINVAL;
+
+failed:
+	g_key_file_free(key_file);
+	errno = -err;
+
+	return str;
+}
+
+
+int keyfile_get_boolean(const char *pathname, const char *group,
+				const char *key, gboolean *value)
+{
+	GKeyFile *key_file;
+	GError *error = NULL;
+	int err = 0;
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, pathname, 0, NULL)) {
+		err = -ENOENT;
+		goto failed;
+	}
+
+	*value = g_key_file_get_boolean(key_file, group, key, &error);
+	if (error) {
+		g_error_free(error);
+		err = -EINVAL;
+	}
+
+failed:
+	g_key_file_free(key_file);
+	errno = -err;
+
+	return 0;
+}
+
+int keyfile_get_integer(const char *pathname, const char *group,
+				const char *key, int *value)
+{
+	GKeyFile *key_file;
+	GError *error = NULL;
+	int err = 0;
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, pathname, 0, NULL)) {
+		err = -ENOENT;
+		goto failed;
+	}
+
+	*value = g_key_file_get_integer(key_file, group, key, &error);
+	if (error) {
+		g_error_free(error);
+		err = -EINVAL;
+	}
+
+failed:
+	g_key_file_free(key_file);
+	errno = -err;
+
+	return 0;
+}
+
+int keyfile_del(const char *pathname, const char *group, const char *key)
+{
+	GKeyFile *key_file;
+	char *data;
+	FILE *file;
+	GError *error = NULL;
+	int err = 0;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, pathname, 0, NULL);
+
+	if (key)
+		g_key_file_remove_key(key_file, group, key, &error);
+	else
+		g_key_file_remove_group(key_file, group, &error);
+
+	if (error) {
+		if (error->code != G_KEY_FILE_ERROR_GROUP_NOT_FOUND &&
+				error->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
+			err = -EINVAL;
+
+		g_error_free(error);
+		goto failed;
+	}
+
+	data = g_key_file_to_data(key_file, NULL, NULL);
+	file = fopen(pathname, "w");
+	fputs(data, file);
+	fclose(file);
+
+	g_free(data);
+
+failed:
+	g_key_file_free(key_file);
+	errno = -err;
+
+	return err;
+}
+
+int keyfile_foreach_key(const char *pathname, const char *group,
+				keyfile_key_cb func, void *data)
+{
+	GKeyFile *key_file;
+	char **keys, **key, *value;
+	int err = 0;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, pathname, 0, NULL);
+	keys = g_key_file_get_keys(key_file, group, NULL, NULL);
+
+	if (!keys) {
+		err = -EINVAL;
+		goto failed;
+	}
+
+	for (key = keys; *key; key++) {
+		value = g_key_file_get_string(key_file, group, *key, NULL);
+		func(*key, value, data);
+	}
+
+failed:
+	g_key_file_free(key_file);
+	errno = -err;
+
+	return err;
+}
+
+int keyfile_foreach_group(const char *pathname,
+				keyfile_group_cb func, void *data)
+{
+	GKeyFile *key_file;
+	char **groups, **group;
+	int err = 0;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, pathname, 0, NULL);
+	groups = g_key_file_get_groups(key_file, NULL);
+
+	if (!groups) {
+		err = -EINVAL;
+		goto failed;
+	}
+
+	for (group = groups; *group; group++)
+		func(*group, data);
+
+failed:
+	g_key_file_free(key_file);
+	errno = -err;
+
+	return err;
+}
diff --git a/src/keyfile.h b/src/keyfile.h
new file mode 100644
index 0000000..b2e19c3
--- /dev/null
+++ b/src/keyfile.h
@@ -0,0 +1,51 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __KEYFILE_H
+#define __KEYFILE_H
+
+int keyfile_put_string(const char *pathname, const char *group,
+				const char *key, const char *value);
+int keyfile_put_boolean(const char *pathname, const char *group,
+				const char *key, gboolean value);
+int keyfile_put_integer(const char *pathname, const char *group,
+				const char *key, int value);
+
+char *keyfile_get_string(const char *pathname, const char *group,
+				const char *key);
+int keyfile_get_boolean(const char *pathname, const char *group,
+				const char *key, gboolean *value);
+int keyfile_get_integer(const char *pathname, const char *group,
+				const char *key, int *value);
+
+int keyfile_del(const char *pathname, const char *group, const char *key);
+
+typedef void (*keyfile_key_cb) (char *key, char *value, void *data);
+typedef void (*keyfile_group_cb) (char *group, void *data);
+
+int keyfile_foreach_key(const char *pathname, const char *group,
+				keyfile_key_cb func, void *data);
+int keyfile_foreach_group(const char *pathname,
+				keyfile_group_cb func, void *data);
+
+#endif /* __KEYFILE_H */
diff --git a/src/storage.c b/src/storage.c
index 96db6f5..eeae246 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -44,6 +44,7 @@
 #include <bluetooth/uuid.h>
 
 #include "textfile.h"
+#include "keyfile.h"
 #include "glib-helper.h"
 #include "storage.h"
 
@@ -112,91 +113,65 @@ int write_device_alias(const char *src, const char *dst, uint8_t dst_type,
 
 int write_discoverable_timeout(bdaddr_t *bdaddr, int timeout)
 {
-	char filename[PATH_MAX + 1], str[32];
-
-	snprintf(str, sizeof(str), "%d", timeout);
+	char filename[PATH_MAX + 1];
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	return textfile_put(filename, "discovto", str);
+	return keyfile_put_integer(filename, "General", "DiscovTO", timeout);
 }
 
 int read_discoverable_timeout(const char *src, int *timeout)
 {
-	char filename[PATH_MAX + 1], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
-
-	str = textfile_get(filename, "discovto");
-	if (!str)
-		return -ENOENT;
-
-	if (sscanf(str, "%d", timeout) != 1) {
-		free(str);
-		return -ENOENT;
-	}
+	char filename[PATH_MAX + 1];
 
-	free(str);
+	create_name(filename, PATH_MAX, STORAGEDIR, src, "adapter.conf");
 
-	return 0;
+	return keyfile_get_integer(filename, "General", "DiscovTO", timeout);
 }
 
 int write_pairable_timeout(bdaddr_t *bdaddr, int timeout)
 {
-	char filename[PATH_MAX + 1], str[32];
-
-	snprintf(str, sizeof(str), "%d", timeout);
+	char filename[PATH_MAX + 1];
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	return textfile_put(filename, "pairto", str);
+	return keyfile_put_integer(filename, "General", "PairTO", timeout);
 }
 
 int read_pairable_timeout(const char *src, int *timeout)
 {
-	char filename[PATH_MAX + 1], *str;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
-
-	str = textfile_get(filename, "pairto");
-	if (!str)
-		return -ENOENT;
-
-	if (sscanf(str, "%d", timeout) != 1) {
-		free(str);
-		return -ENOENT;
-	}
+	char filename[PATH_MAX + 1];
 
-	free(str);
+	create_name(filename, PATH_MAX, STORAGEDIR, src, "adapter.conf");
 
-	return 0;
+	return keyfile_get_integer(filename, "General", "PairTO", timeout);
 }
 
 int write_device_mode(bdaddr_t *bdaddr, const char *mode)
 {
 	char filename[PATH_MAX + 1];
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 	if (strcmp(mode, "off") != 0)
-		textfile_put(filename, "onmode", mode);
+		keyfile_put_string(filename, "General", "OnMode", mode);
 
-	return textfile_put(filename, "mode", mode);
+	return keyfile_put_string(filename, "General", "Mode", mode);
 }
 
 int read_device_mode(const char *src, char *mode, int length)
 {
 	char filename[PATH_MAX + 1], *str;
 
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
+	create_name(filename, PATH_MAX, STORAGEDIR, src, "adapter.conf");
 
-	str = textfile_get(filename, "mode");
+	str = keyfile_get_string(filename, "General", "Mode");
 	if (!str)
 		return -ENOENT;
 
@@ -212,9 +187,9 @@ int read_on_mode(const char *src, char *mode, int length)
 {
 	char filename[PATH_MAX + 1], *str;
 
-	create_name(filename, PATH_MAX, STORAGEDIR, src, "config");
+	create_name(filename, PATH_MAX, STORAGEDIR, src, "adapter.conf");
 
-	str = textfile_get(filename, "onmode");
+	str = keyfile_get_string(filename, "General", "OnMode");
 	if (!str)
 		return -ENOENT;
 
@@ -238,11 +213,11 @@ int write_local_name(bdaddr_t *bdaddr, const char *name)
 		else
 			str[i] = name[i];
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	return textfile_put(filename, "name", str);
+	return keyfile_put_string(filename, "General", "Name", str);
 }
 
 int read_local_name(bdaddr_t *bdaddr, char *name)
@@ -250,9 +225,10 @@ int read_local_name(bdaddr_t *bdaddr, char *name)
 	char filename[PATH_MAX + 1], *str;
 	int len;
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
+
+	str = keyfile_get_string(filename, "General", "Name");
 
-	str = textfile_get(filename, "name");
 	if (!str)
 		return -ENOENT;
 
@@ -272,11 +248,11 @@ int write_local_class(bdaddr_t *bdaddr, uint8_t *class)
 
 	sprintf(str, "0x%2.2x%2.2x%2.2x", class[2], class[1], class[0]);
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	return textfile_put(filename, "class", str);
+	return keyfile_put_string(filename, "General", "Class", str);
 }
 
 int read_local_class(bdaddr_t *bdaddr, uint8_t *class)
@@ -284,9 +260,9 @@ int read_local_class(bdaddr_t *bdaddr, uint8_t *class)
 	char filename[PATH_MAX + 1], tmp[3], *str;
 	int i;
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
-	str = textfile_get(filename, "class");
+	str = keyfile_get_string(filename, "General", "Class");
 	if (!str)
 		return -ENOENT;
 
@@ -1151,28 +1127,20 @@ int write_device_pairable(bdaddr_t *bdaddr, gboolean mode)
 {
 	char filename[PATH_MAX + 1];
 
-	create_filename(filename, PATH_MAX, bdaddr, "config");
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
 	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
-	return textfile_put(filename, "pairable", mode ? "yes" : "no");
+	return keyfile_put_boolean(filename, "General", "Pairable", mode);
 }
 
 int read_device_pairable(bdaddr_t *bdaddr, gboolean *mode)
 {
-	char filename[PATH_MAX + 1], *str;
-
-	create_filename(filename, PATH_MAX, bdaddr, "config");
-
-	str = textfile_get(filename, "pairable");
-	if (!str)
-		return -ENOENT;
-
-	*mode = strcmp(str, "yes") == 0 ? TRUE : FALSE;
+	char filename[PATH_MAX + 1];
 
-	free(str);
+	create_filename(filename, PATH_MAX, bdaddr, "adapter.conf");
 
-	return 0;
+	return keyfile_get_boolean(filename, "General", "Pairable", mode);
 }
 
 gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
diff --git a/test/test-keyfile.c b/test/test-keyfile.c
new file mode 100644
index 0000000..61d3929
--- /dev/null
+++ b/test/test-keyfile.c
@@ -0,0 +1,252 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include "keyfile.h"
+
+#define GROUP_1	 "Test strings"
+#define GROUP_2 "others"
+
+static void print_entry(char *key, char *value, void *data)
+{
+	printf("%s %s\n", key, value);
+}
+
+static void print_group(char *group, void *data)
+{
+	char *filename = data;
+
+	printf("[%s]\n", group);
+	keyfile_foreach_key(filename, group, print_entry, NULL);
+}
+
+int main(int argc, char *argv[])
+{
+	char filename[] = "/tmp/keyfile.conf";
+	char key[18], value[512], *str;
+	unsigned int i, j, size, max = 10;
+	gboolean bval;
+	int ival;
+	int fd;
+
+	size = getpagesize();
+	printf("System uses a page size of %d bytes\n\n", size);
+
+	fd = creat(filename, 0644);
+	if (ftruncate(fd, 0) < 0)
+		return -errno;
+
+	memset(value, 0, sizeof(value));
+	for (i = 0; i < (size / sizeof(value)); i++) {
+		if (write(fd, value, sizeof(value)) < 0)
+			return -errno;
+	}
+
+	close(fd);
+
+	/* Test retrieval for non existent group and string key */
+	sprintf(key, "11:11:11:11:11:11");
+	str = keyfile_get_string(filename, GROUP_1, key);
+
+	if (truncate(filename, 0) < 0)
+		return -errno;
+
+	/* Test deletion for non existent group and key */
+	sprintf(key, "00:00:00:00:00:00");
+	if (keyfile_del(filename, GROUP_1, key) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	/* Test retrieval for existent group and string key */
+	memset(value, 0, sizeof(value));
+	if (keyfile_put_string(filename, GROUP_1, key, value) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	str = keyfile_get_string(filename, GROUP_1, key);
+	if (!str)
+		fprintf(stderr, "No value for %s\n", key);
+	else
+		free(str);
+
+	/* Test multiple write of same key before deletion */
+	snprintf(value, sizeof(value), "Test");
+	if (keyfile_put_string(filename, GROUP_1, key, value) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	if (keyfile_put_string(filename, GROUP_1, key, value) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	if (keyfile_put_string(filename, GROUP_1, key, value) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	if (keyfile_del(filename, GROUP_1, key) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	str = keyfile_get_string(filename, GROUP_1, key);
+	if (str) {
+		fprintf(stderr, "Found value for %s\n", key);
+		free(str);
+	}
+
+	/* Test retrieval for existent group and boolean key */
+	if (keyfile_put_boolean(filename, GROUP_2, "bool_key", FALSE) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	if (keyfile_get_boolean(filename, GROUP_2, "bool_key", &bval) < 0)
+		fprintf(stderr, "No value for bool_key\n");
+
+	if (bval)
+		fprintf(stderr, "Error on bool_key\n");
+
+	if (keyfile_put_boolean(filename, GROUP_2, "bool_key", TRUE) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	if (keyfile_get_boolean(filename, GROUP_2, "bool_key", &bval) < 0)
+		fprintf(stderr, "No value for bool_key\n");
+
+	if (!bval)
+		fprintf(stderr, "Error on bool_key\n");
+
+	/* Test retrieval for existent group and integer key */
+	if (keyfile_put_integer(filename, GROUP_2, "int_key", 42) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	if (keyfile_get_integer(filename, GROUP_2, "int_key", &ival) < 0)
+		fprintf(stderr, "No value for int_key\n");
+
+	if (ival != 42)
+		fprintf(stderr, "Error on int_key\n");
+
+	if (keyfile_put_integer(filename, GROUP_2, "int_key", 1) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	if (keyfile_get_integer(filename, GROUP_2, "int_key", &ival) < 0)
+		fprintf(stderr, "No value for int_key\n");
+
+	if (ival != 1)
+		fprintf(stderr, "Error on int_key\n");
+
+	/* Write multiple string keys and check them */
+	for (i = 1; i < max + 1; i++) {
+		sprintf(key, "00:00:00:00:00:%02X", i);
+
+		memset(value, 0, sizeof(value));
+		for (j = 0; j < i; j++)
+			value[j] = 'x';
+
+		printf("%s %s\n", key, value);
+
+		if (keyfile_put_string(filename, GROUP_1, key, value) < 0) {
+			fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+			break;
+		}
+
+		str = keyfile_get_string(filename, GROUP_1, key);
+		if (!str)
+			fprintf(stderr, "No value for %s\n", key);
+		else
+			free(str);
+	}
+
+	/* Re-write first and last keys */
+	sprintf(key, "00:00:00:00:00:%02X", max);
+
+	memset(value, 0, sizeof(value));
+	for (j = 0; j < max; j++)
+		value[j] = 'y';
+
+	if (keyfile_put_string(filename, GROUP_1, key, value) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	sprintf(key, "00:00:00:00:00:%02X", 1);
+
+	memset(value, 0, sizeof(value));
+	for (j = 0; j < max; j++)
+		value[j] = 'z';
+
+	if (keyfile_put_string(filename, GROUP_1, key, value) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	printf("\n");
+
+	for (i = 1; i < max + 1; i++) {
+		sprintf(key, "00:00:00:00:00:%02X", i);
+
+		str = keyfile_get_string(filename, GROUP_1, key);
+		if (str) {
+			printf("%s %s\n", key, str);
+			free(str);
+		}
+	}
+
+
+	/* Remove 2nd and (max - 3) keys */
+	sprintf(key, "00:00:00:00:00:%02X", 2);
+
+	if (keyfile_del(filename, GROUP_1, key) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	sprintf(key, "00:00:00:00:00:%02X", max - 3);
+
+	if (keyfile_del(filename, GROUP_1, key) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	printf("\n");
+
+	keyfile_foreach_key(filename, GROUP_1, print_entry, NULL);
+
+
+	/* Remove first, last and non-existent keys */
+	sprintf(key, "00:00:00:00:00:%02X", 1);
+
+	if (keyfile_del(filename, GROUP_1, key) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	sprintf(key, "00:00:00:00:00:%02X", max);
+
+	if (keyfile_del(filename, GROUP_1, key) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	sprintf(key, "00:00:00:00:00:%02X", max + 1);
+
+	if (keyfile_del(filename, GROUP_1, key) < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
+
+	printf("\n");
+
+	keyfile_foreach_group(filename, print_group, filename);
+
+	return 0;
+}
-- 
1.7.9.5

