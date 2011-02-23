Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Move pcsuite drivers to its own plugin
Date: Wed, 23 Feb 2011 11:54:40 +0200
Message-Id: <1298454881-7941-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
References: <1298454881-7941-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This make it easier to enable/disable this funcionality as a whole.
---
 Makefile.am            |    6 +-
 configure.ac           |    9 +-
 plugins/ftp.c          |  165 ++------------------------
 plugins/nokia-backup.c |  309 ------------------------------------------------
 4 files changed, 16 insertions(+), 473 deletions(-)
 delete mode 100644 plugins/nokia-backup.c

diff --git a/Makefile.am b/Makefile.am
index fc996ec..d32d613 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -43,9 +43,9 @@ endif
 builtin_modules += filesystem
 builtin_sources += plugins/filesystem.c plugins/filesystem.h
 
-if NOKIA_BACKUP
-builtin_modules += backup
-builtin_sources += plugins/nokia-backup.c
+if NOKIA_PCSUITE
+builtin_modules += pcsuite
+builtin_sources += plugins/pcsuite.c
 endif
 
 builtin_modules += opp
diff --git a/configure.ac b/configure.ac
index da8fb64..a17d0ca 100644
--- a/configure.ac
+++ b/configure.ac
@@ -158,12 +158,11 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--enable-usb],
 AM_CONDITIONAL(USB, test "${enable_usb}" = "yes" &&
 				test "${enable_server}" != "no")
 
-AC_ARG_ENABLE(nokia_backup, AC_HELP_STRING([--enable-nokia-backup],
-				[enable nokia-backup plugin]), [
-	enable_nokia_backup=${enableval}
+AC_ARG_ENABLE(pcsuite, AC_HELP_STRING([--enable-pcsuite],
+				[enable Nokia PcSuite plugin]), [
+	enable_pcsuite=${enableval}
 ])
-AM_CONDITIONAL(NOKIA_BACKUP, test "${enable_nokia_backup}" = "yes" &&
-				test "${enable_server}" != "no")
+AM_CONDITIONAL(NOKIA_PCSUITE, test "${enable_pcsuite}" = "yes")
 
 AC_ARG_ENABLE(client, AC_HELP_STRING([--disable-client],
 				[disable compilation of OBEX client]), [
diff --git a/plugins/ftp.c b/plugins/ftp.c
index 633abf3..79223bf 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -50,6 +50,7 @@
 #include "dbus.h"
 #include "mimetype.h"
 #include "service.h"
+#include "ftp.h"
 
 #define LST_TYPE "x-obex/folder-listing"
 #define CAP_TYPE "x-obex/capability"
@@ -189,7 +190,7 @@ static int get_by_type(struct ftp_session *ftp, const char *type)
 	return err;
 }
 
-static void *ftp_connect(struct obex_session *os, int *err)
+void *ftp_connect(struct obex_session *os, int *err)
 {
 	struct ftp_session *ftp;
 	const char *root_folder;
@@ -212,8 +213,8 @@ static void *ftp_connect(struct obex_session *os, int *err)
 	return ftp;
 }
 
-static int ftp_get(struct obex_session *os, obex_object_t *obj,
-					gboolean *stream, void *user_data)
+int ftp_get(struct obex_session *os, obex_object_t *obj, gboolean *stream,
+							void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *type = obex_get_type(os);
@@ -254,7 +255,7 @@ static int ftp_delete(struct ftp_session *ftp, const char *name)
 	return ret;
 }
 
-static int ftp_chkput(struct obex_session *os, void *user_data)
+int ftp_chkput(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *name = obex_get_name(os);
@@ -278,8 +279,7 @@ static int ftp_chkput(struct obex_session *os, void *user_data)
 	return ret;
 }
 
-static int ftp_put(struct obex_session *os, obex_object_t *obj,
-						void *user_data)
+int ftp_put(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *name = obex_get_name(os);
@@ -299,8 +299,7 @@ static int ftp_put(struct obex_session *os, obex_object_t *obj,
 	return 0;
 }
 
-static int ftp_setpath(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
+int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *root_folder, *name;
@@ -404,7 +403,7 @@ done:
 	return err;
 }
 
-static void ftp_disconnect(struct obex_session *os, void *user_data)
+void ftp_disconnect(struct obex_session *os, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 
@@ -416,145 +415,6 @@ static void ftp_disconnect(struct obex_session *os, void *user_data)
 	g_free(ftp);
 }
 
-static void *pcsuite_connect(struct obex_session *os, int *err)
-{
-	struct pcsuite_session *pcsuite;
-	struct ftp_session *ftp;
-	int fd;
-	char *filename;
-
-	DBG("");
-
-	ftp = ftp_connect(os, err);
-	if (ftp == NULL)
-		return NULL;
-
-	filename = g_build_filename(g_get_home_dir(), ".pcsuite", NULL);
-
-	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0644);
-	if (fd < 0 && errno != EEXIST) {
-		error("open(%s): %s(%d)", filename, strerror(errno), errno);
-		goto fail;
-	}
-
-	/* Try to remove the file before retrying since it could be
-	   that some process left/crash without removing it */
-	if (fd < 0) {
-		if (remove(filename) < 0) {
-			error("remove(%s): %s(%d)", filename, strerror(errno),
-									errno);
-			goto fail;
-		}
-
-		fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0644);
-		if (fd < 0) {
-			error("open(%s): %s(%d)", filename, strerror(errno),
-									errno);
-			goto fail;
-		}
-	}
-
-	DBG("%s created", filename);
-
-	pcsuite = g_new0(struct pcsuite_session, 1);
-	pcsuite->ftp = ftp;
-	pcsuite->lock_file = filename;
-	pcsuite->fd = fd;
-
-	DBG("session %p created", pcsuite);
-
-	if (err)
-		*err = 0;
-
-	return pcsuite;
-
-fail:
-	if (ftp)
-		ftp_disconnect(os, ftp);
-	if (err)
-		*err = -errno;
-
-	g_free(filename);
-
-	return NULL;
-}
-
-static int pcsuite_get(struct obex_session *os, obex_object_t *obj,
-					gboolean *stream, void *user_data)
-{
-	struct pcsuite_session *pcsuite = user_data;
-
-	DBG("%p", pcsuite);
-
-	return ftp_get(os, obj, stream, pcsuite->ftp);
-}
-
-static int pcsuite_chkput(struct obex_session *os, void *user_data)
-{
-	struct pcsuite_session *pcsuite = user_data;
-
-	DBG("%p", pcsuite);
-
-	return ftp_chkput(os, pcsuite->ftp);
-}
-
-static int pcsuite_put(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
-{
-	struct pcsuite_session *pcsuite = user_data;
-
-	DBG("%p", pcsuite);
-
-	return ftp_put(os, obj, pcsuite->ftp);
-}
-
-static int pcsuite_setpath(struct obex_session *os, obex_object_t *obj,
-							void *user_data)
-{
-	struct pcsuite_session *pcsuite = user_data;
-
-	DBG("%p", pcsuite);
-
-	return ftp_setpath(os, obj, pcsuite->ftp);
-}
-
-static void pcsuite_disconnect(struct obex_session *os, void *user_data)
-{
-	struct pcsuite_session *pcsuite = user_data;
-
-	DBG("%p", pcsuite);
-
-	if (pcsuite->fd >= 0)
-		close(pcsuite->fd);
-
-	if (pcsuite->lock_file) {
-		remove(pcsuite->lock_file);
-		g_free(pcsuite->lock_file);
-	}
-
-	if (pcsuite->ftp)
-		ftp_disconnect(os, pcsuite->ftp);
-
-	g_free(pcsuite);
-}
-
-static struct obex_service_driver pcsuite = {
-	.name = "Nokia OBEX PC Suite Services",
-	.service = OBEX_PCSUITE,
-	.channel = PCSUITE_CHANNEL,
-	.record = PCSUITE_RECORD,
-	.target = FTP_TARGET,
-	.target_size = TARGET_SIZE,
-	.who = PCSUITE_WHO,
-	.who_size = PCSUITE_WHO_SIZE,
-	.connect = pcsuite_connect,
-	.get = pcsuite_get,
-	.put = pcsuite_put,
-	.chkput = pcsuite_chkput,
-	.setpath = pcsuite_setpath,
-	.disconnect = pcsuite_disconnect
-};
-
 static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
@@ -572,19 +432,12 @@ static struct obex_service_driver ftp = {
 
 static int ftp_init(void)
 {
-	int err;
-
-	err = obex_service_driver_register(&ftp);
-	if (err < 0)
-		return err;
-
-	return obex_service_driver_register(&pcsuite);
+	return obex_service_driver_register(&ftp);
 }
 
 static void ftp_exit(void)
 {
 	obex_service_driver_unregister(&ftp);
-	obex_service_driver_unregister(&pcsuite);
 }
 
 OBEX_PLUGIN_DEFINE(ftp, ftp_init, ftp_exit)
diff --git a/plugins/nokia-backup.c b/plugins/nokia-backup.c
deleted file mode 100644
index cf17e16..0000000
--- a/plugins/nokia-backup.c
+++ /dev/null
@@ -1,309 +0,0 @@
-/*
- *
- *  OBEX Server
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <dirent.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/statvfs.h>
-#include <fcntl.h>
-#include <wait.h>
-
-#include <glib.h>
-#include "gdbus.h"
-
-
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
-
-#include "plugin.h"
-#include "log.h"
-#include "obex.h"
-#include "mimetype.h"
-#include "service.h"
-
-#define BACKUP_BUS_NAME		"com.nokia.backup.plugin"
-#define BACKUP_PATH		"/com/nokia/backup"
-#define BACKUP_PLUGIN_INTERFACE	"com.nokia.backup.plugin"
-#define BACKUP_DBUS_TIMEOUT	(1000 * 60 * 15)
-
-static const uint8_t FTP_TARGET[TARGET_SIZE] = {
-	0xF9, 0xEC, 0x7B, 0xC4,  0x95, 0x3C, 0x11, 0xD2,
-	0x98, 0x4E, 0x52, 0x54,  0x00, 0xDC, 0x9E, 0x09  };
-
-struct backup_object{
-	gchar *cmd;
-	int fd;
-	int oflag;
-	int error_code;
-	mode_t mode;
-	DBusPendingCall *pending_call;
-	DBusConnection *conn;
-};
-
-static void on_backup_dbus_notify(DBusPendingCall *pending_call,
-					void *user_data)
-{
-	struct backup_object *obj = user_data;
-	DBusMessage *reply;
-	const char *filename;
-	int error_code;
-
-	DBG("Notification received for pending call - %s", obj->cmd);
-
-	reply = dbus_pending_call_steal_reply(pending_call);
-
-	if (reply && dbus_message_get_args(reply, NULL, DBUS_TYPE_INT32,
-					&error_code, DBUS_TYPE_STRING,
-					&filename, DBUS_TYPE_INVALID)) {
-
-		obj->error_code = error_code;
-
-		if (filename) {
-			DBG("Notification - file path = %s, error_code = %d",
-					filename, error_code);
-			if (error_code == 0)
-				obj->fd = open(filename,obj->oflag,obj->mode);
-		}
-
-	} else
-		DBG("Notification timed out or connection got closed");
-
-	if (reply)
-		dbus_message_unref(reply);
-
-	dbus_pending_call_unref(pending_call);
-	obj->pending_call = NULL;
-	dbus_connection_unref(obj->conn);
-	obj->conn = NULL;
-
-	if (obj->fd >= 0) {
-		DBG("File opened, setting io flags, cmd = %s",
-				obj->cmd);
-		if (obj->oflag == O_RDONLY)
-			obex_object_set_io_flags(user_data, G_IO_IN, 0);
-		else
-			obex_object_set_io_flags(user_data, G_IO_OUT, 0);
-	} else {
-		DBG("File open error, setting io error, cmd = %s",
-				obj->cmd);
-		obex_object_set_io_flags(user_data, G_IO_ERR, -EPERM);
-	}
-}
-
-static gboolean send_backup_dbus_message(const char *oper,
-					struct backup_object *obj,
-					size_t *size)
-{
-	DBusConnection *conn;
-	DBusMessage *msg;
-	DBusPendingCall *pending_call;
-	gboolean ret = FALSE;
-	dbus_uint32_t file_size;
-
-	file_size = size ? *size : 0;
-
-	conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
-
-	if (conn == NULL)
-		return FALSE;
-
-	msg = dbus_message_new_method_call(BACKUP_BUS_NAME, BACKUP_PATH,
-						BACKUP_PLUGIN_INTERFACE,
-						"request");
-	if (msg == NULL) {
-		dbus_connection_unref(conn);
-		return FALSE;
-	}
-
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &oper,
-					DBUS_TYPE_STRING, &obj->cmd,
-					DBUS_TYPE_INT32, &file_size,
-					DBUS_TYPE_INVALID);
-
-	if (strcmp(oper, "open") == 0) {
-		ret = dbus_connection_send_with_reply(conn, msg, &pending_call,
-							BACKUP_DBUS_TIMEOUT);
-		dbus_message_unref(msg);
-		if (ret) {
-			obj->conn = conn;
-			obj->pending_call = pending_call;
-			ret = dbus_pending_call_set_notify(pending_call,
-							on_backup_dbus_notify,
-							obj, NULL);
-		} else
-			dbus_connection_unref(conn);
-	} else {
-		ret = dbus_connection_send(conn, msg, NULL);
-		dbus_message_unref(msg);
-		dbus_connection_unref(conn);
-	}
-
-	return ret;
-}
-
-static void *backup_open(const char *name, int oflag, mode_t mode,
-				void *context, size_t *size, int *err)
-{
-	struct backup_object *obj = g_new0(struct backup_object, 1);
-
-	DBG("cmd = %s", name);
-
-	obj->cmd = g_path_get_basename(name);
-	obj->oflag = oflag;
-	obj->mode = mode;
-	obj->fd = -1;
-	obj->pending_call = NULL;
-	obj->conn = NULL;
-	obj->error_code = 0;
-
-	if (send_backup_dbus_message("open", obj, size) == FALSE) {
-		g_free(obj);
-		obj = NULL;
-	}
-
-	if (err)
-		*err = 0;
-
-	return obj;
-}
-
-static int backup_close(void *object)
-{
-	struct backup_object *obj = object;
-	size_t size = 0;
-
-	DBG("cmd = %s", obj->cmd);
-
-	if (obj->fd != -1)
-		close(obj->fd);
-
-	if (obj->pending_call) {
-		dbus_pending_call_cancel(obj->pending_call);
-		dbus_pending_call_unref(obj->pending_call);
-		dbus_connection_unref(obj->conn);
-	}
-
-	send_backup_dbus_message("close", obj, &size);
-
-	g_free(obj->cmd);
-	g_free(obj);
-
-	return 0;
-}
-
-static ssize_t backup_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
-{
-	struct backup_object *obj = object;
-	ssize_t ret = 0;
-
-	*hi = OBEX_HDR_BODY;
-
-	if (flags)
-		*flags = 0;
-
-	if (obj->pending_call) {
-		DBG("cmd = %s, IN WAITING STAGE", obj->cmd);
-		return -EAGAIN;
-	}
-
-	if (obj->fd != -1) {
-		DBG("cmd = %s, READING DATA", obj->cmd);
-		ret = read(obj->fd, buf, count);
-		if (ret < 0)
-			ret = -errno;
-	} else {
-		DBG("cmd = %s, PERMANENT FAILURE", obj->cmd);
-		ret = obj->error_code ? -obj->error_code : -ENOENT;
-	}
-
-	return ret;
-}
-
-static ssize_t backup_write(void *object, const void *buf, size_t count)
-{
-	struct backup_object *obj = object;
-	ssize_t ret = 0;
-
-	if (obj->pending_call) {
-		DBG("cmd = %s, IN WAITING STAGE", obj->cmd);
-		return -EAGAIN;
-	}
-
-	if (obj->fd != -1) {
-		ret = write(obj->fd, buf, count);
-
-		DBG("cmd = %s, WRITTING", obj->cmd);
-
-		if (ret < 0) {
-			error("backup: cmd = %s", obj->cmd);
-			ret = -errno;
-		}
-	} else {
-		error("backup: cmd = %s", obj->cmd);
-		ret = obj->error_code ? -obj->error_code : -ENOENT;
-	}
-
-	return ret;
-}
-
-static int backup_flush(void *object)
-{
-	DBG("%p", object);
-
-	return 0;
-}
-
-static struct obex_mime_type_driver backup = {
-	.target = FTP_TARGET,
-	.target_size = TARGET_SIZE,
-	.mimetype = "application/vnd.nokia-backup",
-	.open = backup_open,
-	.close = backup_close,
-	.read = backup_read,
-	.write = backup_write,
-	.flush = backup_flush,
-};
-
-static int backup_init(void)
-{
-	return obex_mime_type_driver_register(&backup);
-}
-
-static void backup_exit(void)
-{
-	obex_mime_type_driver_unregister(&backup);
-}
-
-OBEX_PLUGIN_DEFINE(backup, backup_init, backup_exit)
-- 
1.7.1

