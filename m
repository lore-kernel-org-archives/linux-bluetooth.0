Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510270933q4cc1e108of143a86d46c8b750@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
In-Reply-To: <1130424788.5163.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_17207_16639771.1130430822173"
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
	 <1130159970.19317.28.camel@blade>
	 <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
	 <1130373447.32634.8.camel@blade>
	 <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
	 <1130424788.5163.15.camel@localhost.localdomain>
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
Date: Thu, 27 Oct 2005 14:33:42 -0200

------=_Part_17207_16639771.1130430822173
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

done!

The signal has two arguments now:
- String: peer address
- Byte: authentication status

Regards,
Claudio.

On 10/27/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here are the patches based on the lastest BlueZ CVS. I am sending both
> > approaches.
> > Using signals is more clear in hcid side, however the clients will
> > have to add flags to indicate that there is a authentication pending.
> > Another problem is the error, using signals will not be possible send
> > D-Bus error messages, therefore client will have to translate the
> > status to a success or errors result.
>
> we need the signal anyway, because a second application might be request
> the authentication and if your first application displays different
> icons for authenticated or unauthenticated connection then it should be
> told that this connection is now authenticated. The same applies for the
> encryption.
>
> > PS: This is the message content for both approachs:
> > * Signal approach
> >   >>> D-Bus AuthenticationComplete signal
> >   - String: peer bt address
> >   - Byte: status
> >   - Uint16: handle
>
> We don't need the handle and the address. Use the address only, because
> connection handles should be only used in hcid and the kernel.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_17207_16639771.1130430822173
Content-Type: application/octet-stream; name=auth_complete_signal_03.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="auth_complete_signal_03.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-23 19:27:41.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-27 10:39:59.000000000 -0200
@@ -96,6 +96,7 @@
 #define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
 #define BLUEZ_HCI_REMOTE_NAME		"RemoteName"
 #define BLUEZ_HCI_REMOTE_NAME_FAILED	"RemoteNameFailed"
+#define BLUEZ_HCI_AUTH_COMPLETE		"AuthenticationComplete"
 
 //HCI signals sent in the BLUEZ_HCI_PATH
 #define BLUEZ_HCI_DEV_ADDED		"DeviceAdded"
--- bluez-utils-cvs.orig/hcid/hcid.h	2005-10-26 22:28:36.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/hcid.h	2005-10-27 13:25:12.000000000 -0200
@@ -137,6 +137,7 @@
 void hcid_dbus_remote_name_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer);
 void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason);
+void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status);
 #else
 static inline void hcid_dbus_inquiry_start(bdaddr_t *local) {}
 static inline void hcid_dbus_inquiry_complete(bdaddr_t *local) {}
@@ -145,6 +146,7 @@
 static inline void hcid_dbus_remote_name_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status) {}
 static inline void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer) {}
 static inline void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason) {}
+static inline void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status) {}
 #endif
 
 int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-26 22:33:33.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-27 13:12:05.000000000 -0200
@@ -668,6 +668,51 @@
 {
 }
 
+void hcid_dbus_auth_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status)
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
@@ -1697,7 +1742,7 @@
 	rq.rlen = EVT_CMD_STATUS_SIZE;
 	rq.event = EVT_CMD_STATUS;
 
-	if (hci_send_req(dd, &rq, 25000) < 0) {
+	if (hci_send_req(dd, &rq, 100) < 0) {
 		syslog(LOG_ERR, "Unable to send authentication request: %s", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
--- bluez-utils-cvs.orig/hcid/security.c	2005-10-24 09:03:37.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/security.c	2005-10-27 13:01:45.000000000 -0200
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
+	hcid_dbus_auth_complete(sba, &dba, evt->status);
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

------=_Part_17207_16639771.1130430822173--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
