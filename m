Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510270739y46a19f5blc44887fdf6f27e74@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_15343_2792571.1130423985833"
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
	 <1130159970.19317.28.camel@blade>
	 <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
	 <1130373447.32634.8.camel@blade>
	 <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
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
Date: Thu, 27 Oct 2005 12:39:45 -0200

------=_Part_15343_2792571.1130423985833
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

sorry... The attachment was missing :)

On 10/27/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi Marcel,
>
> Here are the patches based on the lastest BlueZ CVS. I am sending both
> approaches.
> Using signals is more clear in hcid side, however the clients will
> have to add flags to indicate that there is a authentication pending.
> Another problem is the error, using signals will not be possible send
> D-Bus error messages, therefore client will have to translate the
> status to a success or errors result.
>
> I understand that store atributes to create a reply later is not a
> clean solution but I don't see another solution. Using a peer message
> it's possible reply errors properly and it easier develop the python/c
> clients
>
> I think it's better ask py-dbus developers about this. I prefer the
> peer message reply approach.
>
> Regards,
> Claudio
>
> PS: This is the message content for both approachs:
> * Signal approach
>   >>> D-Bus AuthenticationComplete signal
>   - String: peer bt address
>   - Byte: status
>   - Uint16: handle
>
> * For method return approach
>    >>> D-Bus method return msg
>    - String: peer bt address
>    - Byte: handle
>   >>> D-Bus error msg
>    - String: error description
>    - uint32: error code
>
> On 10/26/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Claudio,
> >
> > > Here are the patches to send the authentication result, please DON'T
> > > commit it. Probably
> > > it will conflict with the latest Eduardo's patch.
> > >
> > > Which approach do you preffer?
> > > 1. Send a  signal
> > > 2. Send a method return (peer message)
> >
> > I think that a signal to inform the applications that a connection is
> > now authenticated (and also encrypted) is a good idea.
> >
> > Eduardos patches are now in the CVS. So you can re-create yours.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by the JBoss Inc.
> > Get Certified Today * Register for a JBoss Training Course
> > Free Certification Exam for All Training Attendees Through End of 2005
> > Visit http://www.jboss.com/services/certification for more information
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_15343_2792571.1130423985833
Content-Type: application/octet-stream;
	name=auth_complete_method_ret_03.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="auth_complete_method_ret_03.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-23 19:27:41.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-27 09:42:46.000000000 -0200
@@ -30,8 +30,9 @@
  
 #define __END_SIG__ DBUS_TYPE_INVALID_AS_STRING
 
+#define BLUEZ_BUS_NAME		"org.bluez"
 #define BASE_PATH		"/org/bluez"
-#define BASE_INTERFACE		"org.bluez"
+#define BASE_INTERFACE		BLUEZ_BUS_NAME	
 
 #define DEVICE_PATH		BASE_PATH "/Device"
 #define DEVICE_INTERFACE	BASE_INTERFACE ".Device"
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-26 22:33:33.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-27 10:27:14.000000000 -0200
@@ -60,6 +60,7 @@
 #define MAX_PATH_LENGTH   (64)
 #define READ_REMOTE_NAME_TIMEOUT	(25000)
 #define MAX_CONN_NUMBER			(10)
+#define MAX_SENDER_LEN			(16)
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
 #define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
@@ -80,7 +81,12 @@
 };
 
 struct hci_dbus_data {
-	uint16_t id;
+	/* adapter identification */
+	uint16_t 	id;
+	/* authentication data used to create the method return */
+	uint16_t	handle;
+	char 		sender[MAX_SENDER_LEN];
+	dbus_uint32_t	serial;
 };
 
 typedef int register_function_t(DBusConnection *conn, int dft_reg, uint16_t id);
@@ -668,6 +674,84 @@
 {
 }
 
+void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status, const uint16_t handle)
+{
+	char *local_addr, *peer_addr;
+	DBusMessage *message = NULL;
+	struct hci_dbus_data *dbus_data = NULL;
+	bdaddr_t tmp;
+	char path[MAX_PATH_LENGTH];
+	int id;
+
+	baswap(&tmp, local); local_addr = batostr(&tmp);
+	baswap(&tmp, peer); peer_addr = batostr(&tmp);
+
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+
+	if (!dbus_connection_get_object_path_data(connection, path, (void*)&dbus_data)) 
+		goto failed;
+
+	/* check if the auth request was triggered by a D-Bus client */
+	if (!dbus_data || dbus_data->serial == 0 || dbus_data->handle != handle)
+		goto failed;
+
+	if (!status) {
+		message = dbus_message_new(DBUS_MESSAGE_TYPE_METHOD_RETURN); 
+		if (message == NULL) 
+			goto failed;
+
+		dbus_message_append_args(message,
+				DBUS_TYPE_STRING, &peer_addr,
+				DBUS_TYPE_UINT16, &handle,
+				DBUS_TYPE_INVALID);
+
+	} else {
+		const uint32_t ecode = status;
+		const char *error_msg = bluez_dbus_error_to_str(ecode);
+			
+		message = dbus_message_new(DBUS_MESSAGE_TYPE_ERROR);
+		if (message == NULL)
+			goto failed;
+
+		dbus_message_set_error_name(message, ERROR_INTERFACE);
+		dbus_message_append_args(message, 
+				DBUS_TYPE_STRING, &error_msg,
+				DBUS_TYPE_UINT32, &ecode,
+				DBUS_TYPE_INVALID);
+	}
+
+	if (!dbus_message_set_destination(message, dbus_data->sender))
+		goto failed;
+
+	dbus_message_set_no_reply (message, TRUE);
+	if (!dbus_message_set_reply_serial (message, dbus_data->serial))
+		goto failed;
+	
+	/* Clean the auth dbus_data */
+	memset(dbus_data->sender, 0, MAX_SENDER_LEN);
+	dbus_data->serial = 0;
+	dbus_data->handle = 0;
+
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE)
+		goto failed;
+
+	dbus_connection_flush(connection);
+
+failed:
+	if (message)
+		dbus_message_unref(message);
+
+	bt_free(local_addr);
+	bt_free(peer_addr);
+}
+
 gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	DBusWatch *watch = (DBusWatch *) data;
@@ -1697,12 +1781,25 @@
 	rq.rlen = EVT_CMD_STATUS_SIZE;
 	rq.event = EVT_CMD_STATUS;
 
-	if (hci_send_req(dd, &rq, 25000) < 0) {
+	if (hci_send_req(dd, &rq, 100) < 0) {
 		syslog(LOG_ERR, "Unable to send authentication request: %s", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
-	}
+	} else {
+		const char *sender = dbus_message_get_sender(msg);
 
+		/* get the serial and the sender info to reply later */
+		if (sender) {
+			snprintf(dbus_data->sender, MAX_SENDER_LEN, "%s", sender);
+			dbus_data->serial =  dbus_message_get_serial(msg);
+			dbus_data->handle = cr->conn_info->handle;
+		} else {
+			memset(dbus_data->sender, 0, MAX_SENDER_LEN);
+			dbus_data->serial = 0;
+			dbus_data->handle = 0;
+		} 
+	}
+ 
 failed:
 	if (dd >= 0)
 		close(dd);
--- bluez-utils-cvs.orig/hcid/security.c	2005-10-24 09:03:37.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/security.c	2005-10-27 09:42:46.000000000 -0200
@@ -644,6 +644,18 @@
 	hcid_dbus_disconn_complete(sba, &dba, evt->reason);
 }
 
+static inline void auth_complete(int dev, bdaddr_t *sba, void *ptr)
+{
+	evt_auth_complete *evt = ptr;
+	bdaddr_t dba;
+
+	if (get_bdaddr(dev, sba, evt->handle, &dba) < 0) 
+		return;
+
+	hcid_dbus_auth_complete(sba, &dba, evt->status, evt->handle);
+}
+
+
 static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
@@ -726,6 +738,9 @@
 	case EVT_DISCONN_COMPLETE:
 		disconn_complete(dev, &di->bdaddr, ptr);
 		break;
+	case EVT_AUTH_COMPLETE:
+		auth_complete(dev, &di->bdaddr, ptr);
+		break;
 	}
 
 	if (hci_test_bit(HCI_SECMGR, &di->flags))
@@ -789,6 +804,7 @@
 	hci_filter_set_event(EVT_EXTENDED_INQUIRY_RESULT, &flt);
 	hci_filter_set_event(EVT_CONN_COMPLETE, &flt);
 	hci_filter_set_event(EVT_DISCONN_COMPLETE, &flt);
+	hci_filter_set_event(EVT_AUTH_COMPLETE, &flt);
 	if (setsockopt(dev, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
 		syslog(LOG_ERR, "Can't set filter on hci%d: %s (%d)",
 						hdev, strerror(errno), errno);

------=_Part_15343_2792571.1130423985833
Content-Type: application/octet-stream; name=auth_complete_signal_02.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="auth_complete_signal_02.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-23 19:27:41.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-27 10:39:59.000000000 -0200
@@ -96,6 +96,7 @@
 #define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
 #define BLUEZ_HCI_REMOTE_NAME		"RemoteName"
 #define BLUEZ_HCI_REMOTE_NAME_FAILED	"RemoteNameFailed"
+#define BLUEZ_HCI_AUTH_COMPLETE		"AuthenticationComplete"
 
 //HCI signals sent in the BLUEZ_HCI_PATH
 #define BLUEZ_HCI_DEV_ADDED		"DeviceAdded"
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-26 22:33:33.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-27 10:42:14.000000000 -0200
@@ -668,6 +668,52 @@
 {
 }
 
+void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status, const uint16_t handle)
+{
+	DBusMessage *message = NULL;
+	char *local_addr, *peer_addr;
+	bdaddr_t tmp;
+	char path[MAX_PATH_LENGTH];
+	int id;
+
+	baswap(&tmp, local); local_addr = batostr(&tmp);
+	baswap(&tmp, peer); peer_addr = batostr(&tmp);
+
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+
+	message = dbus_message_new_signal(path, BLUEZ_HCI_INTERFACE, BLUEZ_HCI_AUTH_COMPLETE);
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		goto failed;
+	}
+
+	dbus_message_append_args(message,
+				 DBUS_TYPE_STRING, &peer_addr,
+				 DBUS_TYPE_BYTE, &status,
+				 DBUS_TYPE_UINT16, &handle,
+				 DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS remote name message");
+		goto failed;
+	}
+
+	dbus_connection_flush(connection);
+
+failed:
+	if (message)
+		dbus_message_unref(message);
+
+	bt_free(local_addr);
+	bt_free(peer_addr);
+}
+
 gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	DBusWatch *watch = (DBusWatch *) data;
--- bluez-utils-cvs.orig/hcid/security.c	2005-10-24 09:03:37.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/security.c	2005-10-27 10:32:40.000000000 -0200
@@ -644,6 +644,18 @@
 	hcid_dbus_disconn_complete(sba, &dba, evt->reason);
 }
 
+static inline void auth_complete(int dev, bdaddr_t *sba, void *ptr)
+{
+	evt_auth_complete *evt = ptr;
+	bdaddr_t dba;
+
+	if (get_bdaddr(dev, sba, evt->handle, &dba) < 0) 
+		return;
+
+	hcid_dbus_auth_complete(sba, &dba, evt->status, evt->handle);
+}
+
+
 static gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
@@ -726,6 +738,9 @@
 	case EVT_DISCONN_COMPLETE:
 		disconn_complete(dev, &di->bdaddr, ptr);
 		break;
+	case EVT_AUTH_COMPLETE:
+		auth_complete(dev, &di->bdaddr, ptr);
+		break;
 	}
 
 	if (hci_test_bit(HCI_SECMGR, &di->flags))
@@ -789,6 +804,7 @@
 	hci_filter_set_event(EVT_EXTENDED_INQUIRY_RESULT, &flt);
 	hci_filter_set_event(EVT_CONN_COMPLETE, &flt);
 	hci_filter_set_event(EVT_DISCONN_COMPLETE, &flt);
+	hci_filter_set_event(EVT_AUTH_COMPLETE, &flt);
 	if (setsockopt(dev, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
 		syslog(LOG_ERR, "Can't set filter on hci%d: %s (%d)",
 						hdev, strerror(errno), errno);

------=_Part_15343_2792571.1130423985833--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
