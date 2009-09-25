Return-Path: <cyrus@holtmann.org>
From: Steve Grubb <sgrubb@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] fix memory leaks
Date: Fri, 25 Sep 2009 16:23:02 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909251623.02240.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I was doing some code reviews of the 4.54 release and found a few memory
leaks. These are mostly in error paths.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>


diff -urp bluez-4.54.orig/audio/a2dp.c bluez-4.54/audio/a2dp.c
--- bluez-4.54.orig/audio/a2dp.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/audio/a2dp.c	2009-09-25 15:31:04.000000000 -0400
@@ -1162,8 +1162,10 @@ proceed:
 			return -ENOMEM;
 
 		av_err = avdtp_init(src, config);
-		if (av_err < 0)
+		if (av_err < 0) {
+			g_free(server);
 			return av_err;
+		}
 
 		bacpy(&server->src, src);
 		servers = g_slist_append(servers, server);
diff -urp bluez-4.54.orig/audio/control.c bluez-4.54/audio/control.c
--- bluez-4.54.orig/audio/control.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/audio/control.c	2009-09-25 15:30:09.000000000 -0400
@@ -834,11 +834,13 @@ int avrcp_register(DBusConnection *conn,
 	record = avrcp_tg_record();
 	if (!record) {
 		error("Unable to allocate new service record");
+		g_free(server);
 		return -1;
 	}
 
 	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register AVRCP target service record");
+		g_free(server);
 		sdp_record_free(record);
 		return -1;
 	}
@@ -847,12 +849,15 @@ int avrcp_register(DBusConnection *conn,
 	record = avrcp_ct_record();
 	if (!record) {
 		error("Unable to allocate new service record");
+		g_free(server);
+		sdp_record_free(record);
 		return -1;
 	}
 
 	if (add_record_to_server(src, record) < 0) {
 		error("Unable to register AVRCP controller service record");
 		sdp_record_free(record);
+		g_free(server);
 		return -1;
 	}
 	server->ct_record_id = record->handle;
diff -urp bluez-4.54.orig/compat/dun.c bluez-4.54/compat/dun.c
--- bluez-4.54.orig/compat/dun.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/compat/dun.c	2009-09-25 15:08:59.000000000 -0400
@@ -86,6 +86,7 @@ static int for_each_port(int (*func)(str
 	}
 
 	close(sk);
+	free(dl);
 	return r;
 }
 
diff -urp bluez-4.54.orig/compat/dund.c bluez-4.54/compat/dund.c
--- bluez-4.54.orig/compat/dund.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/compat/dund.c	2009-09-25 15:08:11.000000000 -0400
@@ -568,21 +568,26 @@ int main(int argc, char *argv[])
 
 	io_init();
 
-	if (dun_init())
+	if (dun_init()) {
+		free(dst);
 		return -1;
+	}
 
 	/* Check non daemon modes first */
 	switch (mode) {
 	case SHOW:
 		do_show();
+		free(dst);
 		return 0;
 
 	case KILL:
 		do_kill(dst);
+		free(dst);
 		return 0;
 
 	case NONE:
 		printf(main_help, VERSION);
+		free(dst);
 		return 0;
 	}
 
@@ -612,6 +617,7 @@ int main(int argc, char *argv[])
 		src_dev = hci_devid(src);
 		if (src_dev < 0 || hci_devba(src_dev, &src_addr) < 0) {
 			syslog(LOG_ERR, "Invalid source. %s(%d)", strerror(errno), errno);
+			free(dst);
 			return -1;
 		}
 	}
@@ -634,5 +640,6 @@ int main(int argc, char *argv[])
 		break;
 	}
 
+	free(dst);
 	return 0;
 }
diff -urp bluez-4.54.orig/compat/pand.c bluez-4.54/compat/pand.c
--- bluez-4.54.orig/compat/pand.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/compat/pand.c	2009-09-25 15:06:16.000000000 -0400
@@ -721,21 +721,26 @@ int main(int argc, char *argv[])
 	argv += optind;
 	optind = 0;
 
-	if (bnep_init())
+	if (bnep_init()) {
+		free(dst);
 		return -1;
+	}
 
 	/* Check non daemon modes first */
 	switch (mode) {
 	case SHOW:
 		do_show();
+		free(dst);
 		return 0;
 
 	case KILL:
 		do_kill(dst);
+		free(dst);
 		return 0;
 
 	case NONE:
 		printf(main_help, VERSION);
+		free(dst);
 		return 0;
 	}
 
@@ -766,12 +771,15 @@ int main(int argc, char *argv[])
 		if (src_dev < 0 || hci_devba(src_dev, &src_addr) < 0) {
 			syslog(LOG_ERR, "Invalid source. %s(%d)",
 						strerror(errno), errno);
+			free(dst);
 			return -1;
 		}
 	}
 
-	if (pidfile && write_pidfile())
+	if (pidfile && write_pidfile()) {
+		free(dst);
 		return -1;
+	}
 
 	if (dst) {
 		/* Disable cache invalidation */
diff -urp bluez-4.54.orig/cups/main.c bluez-4.54/cups/main.c
--- bluez-4.54.orig/cups/main.c	2009-09-25 14:53:26.000000000 -0400
+++ bluez-4.54/cups/main.c	2009-09-25 15:26:13.000000000 -0400
@@ -599,6 +599,7 @@ static gboolean list_printers(void)
 	loop = g_main_loop_new(NULL, TRUE);
 	g_main_loop_run(loop);
 
+	g_free(adapter);
 	dbus_connection_unref(conn);
 
 	return TRUE;
diff -urp bluez-4.54.orig/serial/proxy.c bluez-4.54/serial/proxy.c
--- bluez-4.54.orig/serial/proxy.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/serial/proxy.c	2009-09-25 15:56:24.000000000 -0400
@@ -1228,6 +1228,7 @@ static void serial_proxy_init(struct ser
 			debug("%s: %s", file, gerr->message);
 			g_error_free(gerr);
 			g_key_file_free(config);
+			g_strfreev(group_list);
 			return;
 		}
 
@@ -1238,6 +1239,7 @@ static void serial_proxy_init(struct ser
 			g_error_free(gerr);
 			g_key_file_free(config);
 			g_free(uuid_str);
+			g_strfreev(group_list);
 			return;
 		}
 
diff -urp bluez-4.54.orig/src/glib-helper.c bluez-4.54/src/glib-helper.c
--- bluez-4.54.orig/src/glib-helper.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/src/glib-helper.c	2009-09-25 16:07:22.000000000 -0400
@@ -704,7 +704,7 @@ int bt_acl_encrypt(const bdaddr_t *src, 
 			bt_hci_result_t cb, gpointer user_data)
 {
 	GIOChannel *io;
-	struct hci_cmd_data *cmd;
+	struct hci_cmd_data *cmd = NULL;
 	struct hci_conn_info_req *cr;
 	auth_requested_cp cp;
 	struct hci_filter nf;
@@ -778,6 +778,7 @@ int bt_acl_encrypt(const bdaddr_t *src, 
 	return 0;
 
 failed:
+	g_free(cmd);
 	close(dd);
 
 	return -err;
diff -urp bluez-4.54.orig/src/plugin.c bluez-4.54/src/plugin.c
--- bluez-4.54.orig/src/plugin.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/src/plugin.c	2009-09-25 16:09:32.000000000 -0400
@@ -139,8 +139,10 @@ gboolean plugin_init(GKeyFile *config)
 		add_plugin(NULL,  __bluetooth_builtin[i]);
 	}
 
-	if (strlen(PLUGINDIR) == 0)
+	if (strlen(PLUGINDIR) == 0) {
+		g_strfreev(disabled);
 		goto start;
+	}
 
 	debug("Loading plugins %s", PLUGINDIR);
 
diff -urp bluez-4.54.orig/tools/hcitool.c bluez-4.54/tools/hcitool.c
--- bluez-4.54.orig/tools/hcitool.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/tools/hcitool.c	2009-09-25 15:03:10.000000000 -0400
@@ -111,6 +111,7 @@ static int conn_list(int s, int dev_id, 
 		bt_free(str);
 	}
 
+	free(cl);
 	return 0;
 }
 
@@ -134,9 +135,12 @@ static int find_conn(int s, int dev_id, 
 	}
 
 	for (i = 0; i < cl->conn_num; i++, ci++)
-		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr))
+		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr)) {
+			free(cl);
 			return 1;
+		}
 
+	free(cl);
 	return 0;
 }
 
diff -urp bluez-4.54.orig/tools/l2ping.c bluez-4.54/tools/l2ping.c
--- bluez-4.54.orig/tools/l2ping.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/tools/l2ping.c	2009-09-25 15:00:58.000000000 -0400
@@ -240,6 +240,8 @@ static void ping(char *svr)
 			id = ident;
 	}
 	stat(0);
+	free(send_buf);
+	free(recv_buf);
 	return;
 
 error:
diff -urp bluez-4.54.orig/tools/main.c bluez-4.54/tools/main.c
--- bluez-4.54.orig/tools/main.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/tools/main.c	2009-09-25 14:58:11.000000000 -0400
@@ -139,11 +139,13 @@ static void print_dev_list(int ctl, int 
 
 	if (ioctl(ctl, RFCOMMGETDEVLIST, (void *) dl) < 0) {
 		perror("Can't get device list");
+		free(dl);
 		exit(1);
 	}
 
 	for (i = 0; i < dl->dev_num; i++)
 		print_dev_info(di + i);
+	free(dl);
 }
 
 static int create_dev(int ctl, int dev, uint32_t flags, bdaddr_t *bdaddr, int argc, char **argv)
@@ -249,12 +251,14 @@ static int release_all(int ctl)
 
 	if (ioctl(ctl, RFCOMMGETDEVLIST, (void *) dl) < 0) {
 		perror("Can't get device list");
+		free(dl);
 		exit(1);
 	}
 
 	for (i = 0; i < dl->dev_num; i++)
 		release_dev(ctl, (di + i)->id, 0);
 
+	free(dl);
 	return 0;
 }
 
