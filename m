Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602161041i14382295l2eda08be4a515e3d@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode timeout
In-Reply-To: <1140025571.26072.94.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10764_9315680.1140115278294"
References: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
	 <1140013222.26072.80.camel@localhost>
	 <e1effdeb0602150831j55ae6d68p856bbc3761ecab00@mail.gmail.com>
	 <e1effdeb0602150918y7b8ce5a8xe0cad1c72aa53a5e@mail.gmail.com>
	 <1140025571.26072.94.camel@localhost>
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
Date: Thu, 16 Feb 2006 16:41:18 -0200

------=_Part_10764_9315680.1140115278294
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the patch based on the registered D-Bus paths.

This patch is working fine, except for the following case:
After restart the D-Bus daemon, the paths are being registered
properly. However, if you remove and after add the dongle the HCI
events is not being received by the hcid anymore. This problem happens
with older hcid versions too :-) I lost some hours trying to fix this
weird problem.

How reproduce the error:
pre-condition: at least one dongle connected.
1. start the hcid "hcid -n"
2. restart the dbus-daemon "$/etc/init.d/dbus-1 restart"
3. remove and add the dongle. Note that the HCI removed/added device
event are not received. If you run the hciconfig command you can see
that the device is DOWN.
Do you have any idea of what is happening? IMHO, it seems to a problem
related to main loop add/remove watches function. I will investigate
more and try give you a feedback later.

I investigated how other applications are handling the D-Bus
Disconnect event. All applications are exiting :-) Some linux
distributions are changed the /etc/init.d/dbus-1including command to
start the daemons(avahi, hald, ...). If we don't fix this bug, we can
try use this approach :-)

Do you have another comments about this patch?

Regards,
Claudio.

On 2/15/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here is patch to get/set the discoverable timeout.
>
> the patch is applied to the CVS, but you should watch out for compiler
> warnings. They help you to find some bugs ;)
>
> dbus.c: In function 'register_dbus_path':
> dbus.c:227: warning: assignment makes integer from pointer without a cast
>
> > Currently, there isn't verification for a valid value range. Do you
> > think that it is required?
> > Should we define a minimum and a maximum value?
>
> I don't know. We will see.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=103432&bid#0486&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_10764_9315680.1140115278294
Content-Type: text/x-patch; name=timeout03.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejr8lskq
Content-Disposition: attachment; filename="timeout03.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2006-02-16 09:17:41.000000000 -0200
+++ bluez-utils-cvs-timer/hcid/dbus.h	2006-02-16 13:19:09.000000000 -0200
@@ -62,10 +62,14 @@
 	const char		*signature;
 };
 
+typedef int (timeout_handler_func_t) (void *data);
+
 struct hci_dbus_data {
 	uint16_t dev_id;
 	uint16_t path_id;
 	uint32_t discoverable_timeout;
+	uint32_t timeout_hits;
+	timeout_handler_func_t *timeout_handler;
 	uint8_t  mode;
 };
 
--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-16 09:17:41.000000000 -0200
+++ bluez-utils-cvs-timer/hcid/dbus.c	2006-02-16 13:18:50.000000000 -0200
@@ -52,9 +52,9 @@
 
 static DBusConnection *connection;
 static int default_dev = -1;
+static volatile sig_atomic_t __timeout_active = 0;
 
 #define TIMEOUT				(30 * 1000)		/* 30 seconds */
-#define DBUS_RECONNECT_TIMER		(5 * 1000 * 1000)	/* 5 sec */
 #define MAX_CONN_NUMBER			10
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
@@ -224,8 +224,10 @@
 
 	data->path_id = path_id;
 	data->dev_id = dev_id;
-	data->mode = 0x00;
+	data->mode = SCAN_DISABLED;
 	data->discoverable_timeout = DFT_DISCOVERABLE_TIMEOUT;
+	data->timeout_hits = 0;
+	data->timeout_handler = NULL;
 
 	if (fallback) {
 		if (!dbus_connection_register_fallback(connection, path, pvtable, data)) {
@@ -393,7 +395,7 @@
 	uint8_t *addr = (uint8_t *) &ci->bdaddr;
 	dbus_bool_t out = ci->out;
 
-	if (!connection) {
+	if (!dbus_connection_get_is_connected(connection)) {
 		if (!hcid_dbus_init())
 			goto failed;
 	}
@@ -830,24 +832,24 @@
 void hcid_dbus_exit(void)
 {
 	char **children = NULL;
+	int i = 0;
 
-	if (!connection)
+	if (!dbus_connection_get_is_connected(connection))
 		return;
 
 	/* Unregister all paths in Device path hierarchy */
 	if (!dbus_connection_list_registered(connection, DEVICE_PATH, &children))
 		goto done;
 
-	for (; *children; children++) {
+	for (; children[i]; i++) {
 		char dev_path[MAX_PATH_LENGTH];
 
-		snprintf(dev_path, sizeof(dev_path), "%s/%s", DEVICE_PATH, *children);
+		snprintf(dev_path, sizeof(dev_path), "%s/%s", DEVICE_PATH, children[i]);
 
 		unregister_dbus_path(dev_path);
 	}
 
-	if (*children)
-		dbus_free_string_array(children);
+	dbus_free_string_array(children);
 
 done:
 	unregister_dbus_path(DEVICE_PATH);
@@ -861,7 +863,52 @@
  *  Section reserved to re-connection timer
  *
  *****************************************************************/
-static void reconnect_timer_handler(int signum)
+
+static int discoverable_timeout_handler(void *data)
+{
+	const struct hci_dbus_data *dbus_data = data;
+	struct hci_request rq;
+	int dd = -1;
+	uint8_t hci_mode = dbus_data->mode;
+	uint8_t status = 0;
+	int8_t retval = 0;
+
+	hci_mode &= ~SCAN_INQUIRY;
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
+		return -1;
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_WRITE_SCAN_ENABLE;
+	rq.cparam = &hci_mode;
+	rq.clen   = sizeof(hci_mode);
+	rq.rparam = &status;
+	rq.rlen   = sizeof(status);
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Sending write scan enable command to hci%d failed: %s (%d)",
+		       dbus_data->dev_id, strerror(errno), errno);
+		retval = -1;
+		goto failed;
+	}
+	if (status) {
+		syslog(LOG_ERR, "Setting scan enable failed with status 0x%02x", status);
+		retval = -1;
+		goto failed;
+	}
+
+failed:
+	if (dd >= 0)
+		close(dd);
+
+	return retval;
+}
+
+static void system_bus_reconnect(void)
 {
 	struct hci_dev_list_req *dl = NULL;
 	struct hci_dev_req *dr;
@@ -871,12 +918,6 @@
 	if (hcid_dbus_init() == FALSE)
 		return;
 
-	/* stop the timer */
-	sigaction(SIGALRM, NULL, NULL);
-	setitimer(ITIMER_REAL, NULL, NULL);
-
-	/* register the device based paths */
-
 	/* Create and bind HCI socket */
 	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (sk < 0) {
@@ -914,22 +955,85 @@
 		free(dl);
 }
 
-static void reconnect_timer_start(void)
+static void sigalarm_handler (int signum)
+{
+	struct hci_dbus_data *pdata = NULL;
+	char device_path[MAX_PATH_LENGTH];
+	char **device = NULL;
+	int active_handlers = 0;
+	int i = 0;
+
+	if (!dbus_connection_get_is_connected(connection)) {
+		/* it is not connected */
+		system_bus_reconnect();
+		return;
+	}
+
+	if (!dbus_connection_list_registered(connection, DEVICE_PATH, &device))
+		goto done;
+
+	/* check the timer for each registered path */
+	for (; device[i]; i++) {
+
+		snprintf(device_path, sizeof(device_path), "%s/%s", DEVICE_PATH, device[i]);
+
+		if (!dbus_connection_get_object_path_data(connection, device_path, (void*) &pdata)){
+			syslog(LOG_ERR, "Getting %s path data failed!", device_path);
+			continue;
+		}
+
+		if (pdata->timeout_handler == NULL)
+			continue;
+
+		if (!(pdata->mode & SCAN_INQUIRY)) {
+			pdata->timeout_hits = 0;
+			continue;
+		}
+
+		active_handlers++;
+
+		if ((++(pdata->timeout_hits) % pdata->discoverable_timeout) != 0)
+			continue;
+
+		if (!pdata->timeout_handler(pdata)) {
+			/* Remove from the timeout queue */
+			pdata->timeout_handler = NULL;
+			pdata->timeout_hits = 0;
+			active_handlers--;
+		}
+	}
+
+	dbus_free_string_array(device);
+
+done:
+	if (!active_handlers) {
+		sigaction(SIGALRM, NULL, NULL);
+		setitimer(ITIMER_REAL, NULL, NULL);
+		__timeout_active = 0;
+	}
+}
+
+static void bluez_timeout_start(void)
 {
 	struct sigaction sa;
 	struct itimerval timer;
 
+	if (__timeout_active)
+		return;
+
+	__timeout_active = 1;
+
 	memset (&sa, 0, sizeof (sa));
-	sa.sa_handler = &reconnect_timer_handler;
+	sa.sa_handler = &sigalarm_handler;
 	sigaction(SIGALRM, &sa, NULL);
 
-	/* expire after X  msec... */
-	timer.it_value.tv_sec = 0;
-	timer.it_value.tv_usec = DBUS_RECONNECT_TIMER;
-
-	/* ... and every x msec after that. */
-	timer.it_interval.tv_sec = 0;
-	timer.it_interval.tv_usec = DBUS_RECONNECT_TIMER;
+	/* expire after 1 sec... */
+	timer.it_value.tv_sec = 1;
+	timer.it_value.tv_usec = 0;
+
+	/* ... and every 1 sec after that. */
+	timer.it_interval.tv_sec = 1;
+	timer.it_interval.tv_usec = 0;
 
 	setitimer(ITIMER_REAL, &timer, NULL);
 }
@@ -957,10 +1061,8 @@
 	if ((strcmp(iface, DBUS_INTERFACE_LOCAL) == 0) &&
 			(strcmp(method, "Disconnected") == 0)) {
 		syslog(LOG_ERR, "Got disconnected from the system message bus");
-		dbus_connection_dispatch(conn);
-		dbus_connection_close(conn);
 		dbus_connection_unref(conn);
-		reconnect_timer_start();
+		bluez_timeout_start();
 		ret = DBUS_HANDLER_RESULT_HANDLED;
 	} else if (strcmp(iface, DBUS_INTERFACE_DBUS) == 0) {
 		if (strcmp(method, "NameOwnerChanged") == 0)
@@ -1109,8 +1211,13 @@
 		break;
 	case (SCAN_PAGE | SCAN_INQUIRY):
 		scan_mode = MODE_DISCOVERABLE;
+		pdata->timeout_handler = &discoverable_timeout_handler;
+		bluez_timeout_start();
 		break;
 	case SCAN_INQUIRY:
+		/* Address the scenario where another app changed the scan mode */
+		pdata->timeout_handler = &discoverable_timeout_handler;
+		bluez_timeout_start();
 		/* ignore, this event should not be sent*/
 	default:
 		/* ignore, reserved */

------=_Part_10764_9315680.1140115278294--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
