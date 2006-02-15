Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14234_6847985.1140012673528"
Subject: [Bluez-devel] [DBUS PATCH] scan mode timeout
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
Date: Wed, 15 Feb 2006 12:11:13 -0200

------=_Part_14234_6847985.1140012673528
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi guys,

Here is the first proposal to support the discoverable timeout.

Current behaviour:
* it's using SIGALARM. We can try integrate in the main loop in the future.=
.
* the scan mode is changed automatically to connectable mode after 3 min
* multiple local adapters are handled: there are separated timers.
* scan mode changes requested by other applications(hciconfig and
other dbus clients) are monitored too.


Some points to things about:
* bluez_timeout_add consider the function handler and the user data to
compare if it's necessary update or add new timer. Is this approach
acceptable?
* Is it necessary handle race condition when updating the timeout array?
* 8 positions to timeout handler are enough?

Any comments?

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_14234_6847985.1140012673528
Content-Type: text/x-patch; name=timeout01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejpjgrpp
Content-Disposition: attachment; filename="timeout01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2006-02-14 05:37:57.000000000 -0200
+++ bluez-utils-cvs-scan-timeout/hcid/dbus.h	2006-02-15 08:45:35.000000000 -0200
@@ -65,7 +65,8 @@
 struct hci_dbus_data {
 	uint16_t dev_id;
 	uint16_t path_id;
-	uint32_t path_data;
+	uint32_t discoverable_timeout;
+	uint8_t  mode;
 };
 
 typedef int register_function_t(DBusConnection *conn, uint16_t id);
@@ -106,7 +107,7 @@
 #define DEV_GET_ADDRESS			"GetAddress"
 #define DEV_GET_ALIAS			"GetAlias"
 #define DEV_GET_COMPANY			"GetCompany"
-#define DEV_GET_DISCOVERABLE_TO		"GetDiscoverableTimeOut"
+#define DEV_GET_DISCOVERABLE_TO		"GetDiscoverableTimeout"
 #define DEV_GET_FEATURES		"GetFeatures"
 #define DEV_GET_MANUFACTURER		"GetManufacturer"
 #define DEV_GET_MODE			"GetMode"
@@ -117,7 +118,7 @@
 #define DEV_IS_DISCOVERABLE		"IsDiscoverable"
 #define DEV_SET_ALIAS			"SetAlias"
 #define DEV_SET_CLASS			"SetClass"
-#define DEV_SET_DISCOVERABLE_TO		"SetDiscoverableTimeOut"
+#define DEV_SET_DISCOVERABLE_TO		"SetDiscoverableTimeout"
 #define DEV_SET_MODE			"SetMode"
 #define DEV_SET_NAME			"SetName"
 #define DEV_DISCOVER			"Discover"
@@ -219,6 +220,9 @@
 #define MODE_DISCOVERABLE	"discoverable"
 #define MODE_UNKNOWN		"unknown"
 
+#define DFT_DISCOVERABLE_TIMEOUT	180 /* 3 seconds */
+#define DISCOVERABLE_TIMEOUT_OFF	0
+
 /* BLUEZ_DBUS_ERROR 
  * EFailed error messages signature is : su
  * Where the first argument is a string(error message description),
@@ -247,4 +251,12 @@
 /* BLUEZ_DBUS_ERR_NO_MEMORY */
 #define BLUEZ_DBUS_ERR_NO_MEMORY_STR	"No memory"
 
+/*======================================================================== 
+   timeout handler functions prototypes
+ *========================================================================*/
+typedef int8_t (timeout_handler_func_t) (void *data);
+int8_t bluez_timeout_add(timeout_handler_func_t *handler, uint32_t interval, void *data);
+void bluez_timeout_remove(timeout_handler_func_t *handler, void *data);
+int8_t scan_mode_timeout_handler(void *data);
+
 #endif /* __H_BLUEZ_DBUS_H__ */
--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-14 05:37:57.000000000 -0200
+++ bluez-utils-cvs-scan-timeout/hcid/dbus-device.c	2006-02-14 16:08:25.000000000 -0200
@@ -248,15 +248,23 @@
 
 static DBusMessage* handle_dev_get_discoverable_to_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply,
+				 	DBUS_TYPE_UINT32, &dbus_data->discoverable_timeout,
+				 	DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_get_mode_req(DBusMessage *msg, void *data)
 {
 	const struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
-	const uint8_t hci_mode = dbus_data->path_data;
+	const uint8_t hci_mode = dbus_data->mode;
 	const char *scan_mode;
 
 	switch (hci_mode) {
@@ -288,7 +296,7 @@
 {
 	const struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
-	const uint8_t hci_mode = dbus_data->path_data;
+	const uint8_t hci_mode = dbus_data->mode;
 	dbus_bool_t connectable = FALSE;
 
 	if (hci_mode & SCAN_PAGE)
@@ -306,7 +314,7 @@
 {
 	const struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
-	const uint8_t hci_mode = dbus_data->path_data;
+	const uint8_t hci_mode = dbus_data->mode;
 	dbus_bool_t discoverable = FALSE;
 
 	if (hci_mode & SCAN_INQUIRY)
@@ -328,8 +336,26 @@
 
 static DBusMessage* handle_dev_set_discoverable_to_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	DBusMessageIter iter;
+	uint32_t timeout;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &timeout);
+
+	if ((timeout < DFT_DISCOVERABLE_TIMEOUT) && (timeout != 0))
+		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+
+	dbus_data->discoverable_timeout = timeout;
+
+	/* update the timeout value if timeout is running */
+	if (dbus_data->mode & SCAN_INQUIRY)
+		bluez_timeout_add(&scan_mode_timeout_handler, timeout, data);
+
+	reply = dbus_message_new_method_return(msg);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_set_mode_req(DBusMessage *msg, void *data)
@@ -341,7 +367,7 @@
 	const char* scan_mode;
 	uint8_t hci_mode;
 	uint8_t status = 0;
-	const uint8_t current_mode = dbus_data->path_data;
+	const uint8_t current_mode = dbus_data->mode;
 
 	dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_STRING, &scan_mode,
--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-14 05:37:57.000000000 -0200
+++ bluez-utils-cvs-scan-timeout/hcid/dbus.c	2006-02-15 09:04:27.000000000 -0200
@@ -54,7 +54,7 @@
 static int default_dev = -1;
 
 #define TIMEOUT				(30 * 1000)		/* 30 seconds */
-#define DBUS_RECONNECT_TIMER		(5 * 1000 * 1000)	/* 5 sec */
+#define DBUS_RECONNECT_TIMER		5	/* 5 sec */
 #define MAX_CONN_NUMBER			10
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
@@ -67,6 +67,23 @@
 	bdaddr_t bda;
 };
 
+/*
+ * Structures/constants related to timer functions
+ */
+
+/*FIXME: Check the maximum value */
+#define MAX_TIMER_ARRAY_SIZE 8	
+
+struct timeout_settings {
+	timeout_handler_func_t *handler;
+	void *data;
+	uint32_t interval;
+	uint32_t hits;	
+};
+
+static struct timeout_settings timeout_array[MAX_TIMER_ARRAY_SIZE];
+static uint8_t index_mask = 0;
+
 DBusConnection *get_dbus_connection(void)
 {
 	return connection;
@@ -224,6 +241,8 @@
 
 	data->path_id = path_id;
 	data->dev_id = dev_id;
+	data->mode = 0;
+	data->discoverable_timeout = DFT_DISCOVERABLE_TIMEOUT;
 
 	if (fallback) {
 		if (!dbus_connection_register_fallback(connection, path, pvtable, data)) {
@@ -252,8 +271,10 @@
 
 	syslog(LOG_INFO, "[%s,%d] path:%s", __PRETTY_FUNCTION__, __LINE__, path);
 
-	if (dbus_connection_get_object_path_data(connection, path, &data) && data)
+	if (dbus_connection_get_object_path_data(connection, path, &data) && data){
+		bluez_timeout_remove(&scan_mode_timeout_handler, data);
 		free(data);
+	}
 
 	if (!dbus_connection_unregister_object_path (connection, path)) {
 		syslog(LOG_ERR, "DBUS failed to unregister %s object", path);
@@ -309,7 +330,7 @@
 	if (!dbus_connection_get_object_path_data(connection, path, (void*) &pdata))
 		syslog(LOG_ERR, "Getting path data failed!");
 	else
-		pdata->path_data = rp.enable; /* Keep the current scan status */
+		pdata->mode = rp.enable; /* Keep the current scan status */
 
 	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
 							BLUEZ_MGR_DEV_ADDED);
@@ -859,19 +880,185 @@
  *  Section reserved to re-connection timer
  *
  *****************************************************************/
-static void reconnect_timer_handler(int signum)
+static void timeout_handler (int signum)
+{
+	int8_t retval;
+	int8_t i;
+	uint8_t pos;
+
+	for (i = 0; i < MAX_TIMER_ARRAY_SIZE; i++ ) {
+		pos = (0x01 << i);
+		if ( pos & index_mask) {
+			/* Check if someome changed the interval to zero - it means discoverable forever*/
+			if (timeout_array[i].interval == 0) {
+				timeout_array[i].handler = NULL;
+				timeout_array[i].interval = 0;
+				timeout_array[i].data = NULL;
+
+				/* reset the bitmask */
+				index_mask &= ~pos;
+				break;
+			}
+			
+			/* Check if is time to call the function handler */
+			if ((++timeout_array[i].hits  % timeout_array[i].interval ) == 0) {
+				retval = (timeout_array[i].handler)(timeout_array[i].data);
+				if (!retval) {
+					timeout_array[i].handler = NULL;
+					timeout_array[i].interval = 0;
+					timeout_array[i].data = NULL;
+					/* reset the bitmask */
+					index_mask &= ~pos;
+				}
+			}
+		}
+	}
+
+	if (!index_mask) {
+		/* stop the timer */
+		sigaction(SIGALRM, NULL, NULL);
+		setitimer(ITIMER_REAL, NULL, NULL);
+	}
+}
+
+int8_t bluez_timeout_add(timeout_handler_func_t *handler, uint32_t interval, void *data)
+{
+	struct sigaction sa;
+	struct itimerval timer;
+	int8_t i;
+	int8_t next_pos = -1;
+	uint8_t pos;
+
+	if (!index_mask) {
+
+		memset (&sa, 0, sizeof (sa));
+		sa.sa_handler = &timeout_handler;
+		sigaction(SIGALRM, &sa, NULL);
+
+		/* expire after 1 sec... */
+		timer.it_value.tv_sec = 1;
+		timer.it_value.tv_usec = 0; 
+
+		/* ... and every 1 sec after that. */
+		timer.it_interval.tv_sec = 1;
+		timer.it_interval.tv_usec = 0;
+
+		setitimer(ITIMER_REAL, &timer, NULL);
+	}
+
+	/* Overwrite one position or make room for a new one */
+	for (i = 0; i< MAX_TIMER_ARRAY_SIZE; i++) {
+		pos = 1 << i;
+		/* check if the handler already belongs to the array. Check data
+		 * attribure is required to support multiple local adapter.
+		 */
+		if ((timeout_array[i].handler == handler) && (timeout_array[i].data == data)) {
+			/* it's necessary overwrite the timeout value */
+			next_pos = i;
+			break;
+		}
+		if (!(pos & index_mask)) {
+			/* set the next available position */
+			next_pos = i;
+		}
+	}
+
+	if ( next_pos < 0 ) {
+		/* There isn't space for more timeouts */
+		return -1;
+	}
+
+	timeout_array[next_pos].handler = handler;
+	timeout_array[next_pos].interval = interval;
+	timeout_array[next_pos].data = data;
+	timeout_array[next_pos].hits = 0;
+	index_mask |= (1 << next_pos);
+
+	return i;
+}
+
+void bluez_timeout_remove(timeout_handler_func_t *handler, void *data)
+{
+	int8_t i;
+	uint8_t pos;
+
+	if (!index_mask) {
+		return;
+	}
+
+	for (i = 0; i < MAX_TIMER_ARRAY_SIZE; i++) {
+		pos = 1 << i;
+		if ((timeout_array[i].handler == handler) && (timeout_array[i].data == data)) {
+			timeout_array[i].handler = NULL; 
+			timeout_array[i].interval = 0;
+			timeout_array[i].data = NULL;
+			index_mask &= ~pos;
+			break;
+		}
+	}
+
+	if ( !index_mask ) {
+		/* cancel the timer */
+		sigaction(SIGALRM, NULL, NULL);
+		setitimer(ITIMER_REAL, NULL, NULL);
+	}
+}
+
+int8_t scan_mode_timeout_handler(void *data)
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
+
+}
+
+static int8_t system_bus_reconnect_handler(void *data)
 {
 	struct hci_dev_list_req *dl = NULL;
 	struct hci_dev_req *dr;
 	int sk;
 	int i;
+	int8_t retval = 0;
 
 	if (hcid_dbus_init() == FALSE)
-		return;
-
-	/* stop the timer */
-	sigaction(SIGALRM, NULL, NULL);
-	setitimer(ITIMER_REAL, NULL, NULL);
+		return -1;
 
 	/* register the device based paths */
 
@@ -880,12 +1067,13 @@
 	if (sk < 0) {
 		syslog(LOG_ERR, "Can't open HCI socket: %s (%d)",
 							strerror(errno), errno);
-		return;
+		return -1;
 	}
 
 	dl = malloc(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
 	if (!dl) {
 		syslog(LOG_ERR, "Can't allocate memory");
+		retval = -1;
 		goto failed;
 	}
 
@@ -895,6 +1083,7 @@
 	if (ioctl(sk, HCIGETDEVLIST, (void *) dl) < 0) {
 		syslog(LOG_INFO, "Can't get device list: %s (%d)",
 							strerror(errno), errno);
+		retval = -1;
 		goto failed;
 	}
 
@@ -910,26 +1099,8 @@
 
 	if (dl)
 		free(dl);
-}
-
-static void reconnect_timer_start(void)
-{
-	struct sigaction sa;
-	struct itimerval timer;
 
-	memset (&sa, 0, sizeof (sa));
-	sa.sa_handler = &reconnect_timer_handler;
-	sigaction(SIGALRM, &sa, NULL);
-
-	/* expire after X  msec... */
-	timer.it_value.tv_sec = 0;
-	timer.it_value.tv_usec = DBUS_RECONNECT_TIMER;
-
-	/* ... and every x msec after that. */
-	timer.it_interval.tv_sec = 0;
-	timer.it_interval.tv_usec = DBUS_RECONNECT_TIMER;
-
-	setitimer(ITIMER_REAL, &timer, NULL);
+	return retval;
 }
 
 /*****************************************************************
@@ -958,7 +1129,7 @@
 		dbus_connection_dispatch(conn);
 		dbus_connection_close(conn);
 		dbus_connection_unref(conn);
-		reconnect_timer_start();
+		bluez_timeout_add(&system_bus_reconnect_handler, DBUS_RECONNECT_TIMER, NULL);
 		ret = DBUS_HANDLER_RESULT_HANDLED;
 	} else if (strcmp(iface, DBUS_INTERFACE_DBUS) == 0) {
 		if (strcmp(method, "NameOwnerChanged") == 0)
@@ -1078,8 +1249,8 @@
 	rq.rlen   = READ_SCAN_ENABLE_RP_SIZE;
 
 	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Sending read scan enable command failed: %s (%d)",
-							strerror(errno), errno);
+		syslog(LOG_ERR, "Sending read scan enable command to hci%d failed: %s (%d)",
+							id, strerror(errno), errno);
 		goto failed;
 	}
 
@@ -1096,16 +1267,21 @@
 	}
 
 	/* update the current scan mode value */
-	pdata->path_data = rp.enable;
+	pdata->mode = rp.enable;
 
 	switch (rp.enable) {
 	case SCAN_DISABLED:
 		scan_mode = MODE_OFF;
+		bluez_timeout_remove(&scan_mode_timeout_handler, pdata);
 		break;
 	case SCAN_PAGE:
 		scan_mode = MODE_CONNECTABLE;
+		bluez_timeout_remove(&scan_mode_timeout_handler, pdata);
 		break;
 	case (SCAN_PAGE | SCAN_INQUIRY):
+		if (pdata->discoverable_timeout != DISCOVERABLE_TIMEOUT_OFF)
+			bluez_timeout_add(&scan_mode_timeout_handler, pdata->discoverable_timeout, pdata);
+
 		scan_mode = MODE_DISCOVERABLE;
 		break;
 	case SCAN_INQUIRY:


------=_Part_14234_6847985.1140012673528--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
