Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511090836l28d7de4alc3f7f30ad7e209d9@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [DBUS PATCH] Disconnect
In-Reply-To: <1131551532.5544.110.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_21427_15838323.1131554206430"
References: <e1effdeb0511070401v66d86898n41277902d0fbfa9b@mail.gmail.com>
	 <e1effdeb0511080829n4795636ewfb85de47383da57c@mail.gmail.com>
	 <1131488528.5544.17.camel@blade>
	 <20051108231118.GA13205@localhost.localdomain>
	 <e1effdeb0511090514g2aab5a3dg5ed3810f244b6b31@mail.gmail.com>
	 <1131551532.5544.110.camel@blade>
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
Date: Wed, 9 Nov 2005 14:36:46 -0200

------=_Part_21427_15838323.1131554206430
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

your suggestions were done.

Regards,
Claudio.

On 11/9/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > If the first "disconnect" patch is not integrated yet, please ignore
> > it. It was missing close the HCI socket :)  and I changed some code
> > style.
>
> please redo this patch, because I am not fully happy with it. The
> DBUS_RECONNECT_TIME should be defined (5 * 1000 * 1000) to make it easy
> for people to change it. The compile will optimize this away anyhow.
>
> Please don't change any error messages to repeat the function name. This
> is not helpful if you are really looking for problems. Using grep inside
> the source to find a error message is really helpful.
>
> Can't reconnect_timer_handler() and reconnect_timer_start() be static?
>
> Check your whitespace. There is no need to have useless whitespaces at
> the end of a line. If an if-statement is over multiple lines we still
> use tabes and we are not trying to align it with anything of the line
> above. In fact we use two tabs to indent more then the actual code
> inside the statement. See the rest of the file for examples.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_21427_15838323.1131554206430
Content-Type: text/x-patch; name=disconnect_03.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="disconnect_03.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2005-11-09 09:38:04.000000000 -0200
+++ bluez-utils-cvs-hcid-disconn/hcid/dbus.c	2005-11-09 13:25:31.000000000 -0200
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
+#define DBUS_RECONNECT_TIMER		(5 * 1000 * 1000) /* 5 sec */
+
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
 #define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
@@ -898,6 +902,8 @@
 		return FALSE;
 	}
 
+	dbus_connection_set_exit_on_disconnect(connection, FALSE);
+
 	dbus_bus_request_name(connection, BASE_INTERFACE,
 				DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT, &error);
 
@@ -1156,6 +1162,88 @@
 }
 
 /*****************************************************************
+ *
+ *	Section reserved to re-connection timer
+ *
+ *****************************************************************/
+static void reconnect_timer_handler(int signum)
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
+	dl = malloc(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
+	if (!dl) {
+		syslog(LOG_ERR, "Can't allocate memory");
+		goto failed;
+	}
+
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
+	if (sk >= 0)
+		close(sk);
+
+	if (dl)
+		free(dl);
+
+}
+
+static void reconnect_timer_start(void)
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
  *  
  *  Section reserved to HCI D-Bus services 
  *  
@@ -1175,9 +1263,14 @@
 	iface = dbus_message_get_interface(msg);
 	method = dbus_message_get_member(msg);
 
-	if (strcmp(iface, DBUS_INTERFACE_LOCAL) == 0) {
-		if (strcmp(method, "Disconnected") == 0)
-			ret = DBUS_HANDLER_RESULT_HANDLED;
+	if ((strcmp(iface, DBUS_INTERFACE_LOCAL) == 0) &&
+			(strcmp(method, "Disconnected") == 0)) {
+		syslog(LOG_ERR, "Got disconnected from the system message bus");
+		dbus_connection_dispatch(conn);
+		dbus_connection_close(conn);
+		dbus_connection_unref(conn);
+		reconnect_timer_start();
+		ret = DBUS_HANDLER_RESULT_HANDLED;
 	} else if (strcmp(iface, DBUS_INTERFACE_DBUS) == 0) {
 		if (strcmp(method, "NameOwnerChanged") == 0)
 			ret = DBUS_HANDLER_RESULT_HANDLED;

------=_Part_21427_15838323.1131554206430--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
