Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511070401v66d86898n41277902d0fbfa9b@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_27235_8468980.1131364861705"
Subject: [Bluez-devel] [DBUS PATCH] Disconnect
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 7 Nov 2005 10:01:01 -0200

------=_Part_27235_8468980.1131364861705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here is patch do handle the dbus system "Disconnect" signal.

When the signal is received, a timer is started to try reconnect to
the system bus each 5sec.


Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_27235_8468980.1131364861705
Content-Type: text/x-patch; name=disconnect.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="disconnect.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2005-11-07 08:04:29.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-11-07 08:54:30.000000000 -0200
@@ -28,10 +28,12 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
+#include <signal.h>
 #include <string.h>
 #include <syslog.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <sys/time.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -50,6 +52,8 @@
 #define TIMEOUT				(30 * 1000)	/* 30 seconds */
 #define MAX_PATH_LENGTH			64
 #define MAX_CONN_NUMBER			10
+#define DBUS_RECONNECT_TIMER		5000000 /* 5 sec */
+
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
 #define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
@@ -890,18 +894,18 @@
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, &error);
 
 	if (dbus_error_is_set(&error)) {
-		syslog(LOG_ERR, "Can't open system message bus connection: %s",
-								error.message);
+		syslog(LOG_ERR, "dbus_bus_get: %s", error.message);
 		dbus_error_free(&error);
 		return FALSE;
 	}
 
+	dbus_connection_set_exit_on_disconnect(connection, FALSE);
+
 	dbus_bus_request_name(connection, BASE_INTERFACE,
 				DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT, &error);
 
 	if (dbus_error_is_set(&error)) {
-		syslog(LOG_ERR, "Can't get system message bus name: %s",
-								error.message);
+		syslog(LOG_ERR, "dbus_bus_request_name: %s", error.message);
 		dbus_error_free(&error);
 		return FALSE;
 	}
@@ -1155,6 +1159,84 @@
 
 /*****************************************************************
  *  
+ *    Section reserved to re-connection timer
+ *     
+ ******************************************************************/
+void reconnect_timer_handler(int signum)
+{
+	struct hci_dev_list_req *dl = NULL;
+	struct hci_dev_req *dr;
+	int sk;
+	int i;
+
+	if (hcid_dbus_init() == FALSE) 
+		return;
+
+	/* stop the timer */
+	sigaction(SIGALRM, NULL, NULL);
+	setitimer(ITIMER_REAL, NULL, NULL);
+
+	/* register the device based paths */
+
+	/* Create and bind HCI socket */
+	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (sk < 0) {
+		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)", strerror(errno), errno);
+		return;
+	}
+
+	if (!(dl = malloc(HCI_MAX_DEV * sizeof(struct hci_dev_req) + sizeof(uint16_t)))) {
+		syslog(LOG_INFO, "Can't allocate devlist buffer: %s (%d)",
+		       strerror(errno), errno);
+		return;
+	}
+	dl->dev_num = HCI_MAX_DEV;
+	dr = dl->dev_req;
+
+	if (ioctl(sk, HCIGETDEVLIST, (void *) dl) < 0) {
+		syslog(LOG_INFO, "Can't get device list: %s (%d)",
+		       strerror(errno), errno);
+		goto failed;
+	}
+
+	/* reset the default device */
+	default_dev = -1;
+
+	for (i = 0; i < dl->dev_num; i++, dr++) {
+
+		hcid_dbus_register_device(dr->dev_id);
+
+		if (hci_test_bit(HCI_UP, &dr->dev_opt))
+			hcid_dbus_dev_up(dr->dev_id);
+	}
+failed:
+	if (dl)
+		free(dl);
+
+}
+
+void reconnect_timer_start(void)
+{
+	struct sigaction sa;
+	struct itimerval timer;
+
+	memset (&sa, 0, sizeof (sa));
+	sa.sa_handler = &reconnect_timer_handler;
+	sigaction(SIGALRM, &sa, NULL);
+
+	/* expire after X  msec... */
+	timer.it_value.tv_sec = 0;
+	timer.it_value.tv_usec = DBUS_RECONNECT_TIMER;
+
+	/* ... and every x msec after that. */
+	timer.it_interval.tv_sec = 0;
+	timer.it_interval.tv_usec = DBUS_RECONNECT_TIMER;
+
+	setitimer(ITIMER_REAL, &timer, NULL);
+}
+
+/*****************************************************************
+ *  
  *  Section reserved to HCI D-Bus services 
  *  
  *****************************************************************/
@@ -1173,9 +1255,14 @@
 	iface = dbus_message_get_interface(msg);
 	method = dbus_message_get_member(msg);
 
-	if (strcmp(iface, DBUS_INTERFACE_LOCAL) == 0) {
-		if (strcmp(method, "Disconnected") == 0)
-			ret = DBUS_HANDLER_RESULT_HANDLED;
+	if ((strcmp(iface, DBUS_INTERFACE_LOCAL) == 0) && 
+	    (strcmp(method, "Disconnected") == 0)) {
+		syslog(LOG_ERR, "Got disconnected from the system message bus");
+		dbus_connection_dispatch(conn);
+		dbus_connection_close(conn);
+		dbus_connection_unref(conn);
+		reconnect_timer_start();
+		ret = DBUS_HANDLER_RESULT_HANDLED;
 	} else if (strcmp(iface, DBUS_INTERFACE_DBUS) == 0) {
 		if (strcmp(method, "NameOwnerChanged") == 0)
 			ret = DBUS_HANDLER_RESULT_HANDLED;

------=_Part_27235_8468980.1131364861705--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
