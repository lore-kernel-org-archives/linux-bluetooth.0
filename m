Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051023211355.GB14179@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cmJC7u66zC7hs+87"
Subject: [Bluez-devel] [PATCH] Add CancelInquiry D-BUS method
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
Date: Mon, 24 Oct 2005 00:13:55 +0300


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a patch which implements inquiry cancel functionality. The
HCI_Inquiry_Cancel command will not cause a inquiry complete HCI event
to be generated, so I also changed security.c to send the inquiry
complete D-BUS signal when it encounters a command complete event for
HCI_Inquiry_Cancel.

I've also updated the pygtk testing program to work with this new API:
http://www.iki.fi/~jhedberg/bluez-python/bluez-python-0.6.tar.gz

Johan

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cancel-inquiry.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.31
diff -u -r1.31 dbus.c
--- dbus.c	22 Oct 2005 13:03:41 -0000	1.31
+++ dbus.c	23 Oct 2005 20:23:11 -0000
@@ -285,6 +285,7 @@
 static DBusMessage* handle_periodic_inq_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_inq_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_cancel_inq_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_display_conn_req(DBusMessage *msg, void *data);
@@ -295,6 +296,7 @@
 	{ HCI_CANCEL_PERIODIC_INQ,	handle_cancel_periodic_inq_req,	HCI_CANCEL_PERIODIC_INQ_SIGNATURE	},
 	{ HCI_ROLE_SWITCH,		handle_role_switch_req,		HCI_ROLE_SWITCH_SIGNATURE		},
 	{ HCI_INQ,			handle_inq_req,			HCI_INQ_SIGNATURE			},
+	{ HCI_CANCEL_INQ,		handle_cancel_inq_req,		HCI_CANCEL_INQ_SIGNATURE		},
 	{ HCI_REMOTE_NAME,		handle_remote_name_req,		HCI_REMOTE_NAME_SIGNATURE		},
 	{ HCI_CONNECTIONS,		handle_display_conn_req,	HCI_CONNECTIONS_SIGNATURE		},
 	{ HCI_AUTHENTICATE,		handle_auth_req,		HCI_AUTHENTICATE_SIGNATURE		},
@@ -1389,6 +1391,48 @@
 	return reply;
 }
 
+static DBusMessage* handle_cancel_inq_req(DBusMessage *msg, void *data)
+{
+	DBusMessage *reply = NULL;
+	struct hci_request rq;
+	struct hci_dbus_data *dbus_data = data;
+	int dev_id = -1, dd = -1;
+
+	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
+		if ((dev_id = hci_get_route(NULL)) < 0) {
+			syslog(LOG_ERR, "Bluetooth device is not available");
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+			goto failed;
+		}
+	} else
+		dev_id = dbus_data->id;
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		syslog(LOG_ERR, "Unable to open device %d: %s", dev_id, strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LINK_CTL;
+	rq.ocf = OCF_INQUIRY_CANCEL;
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Unable to cancel inquiry: %s", strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		hci_close_dev(dd);
+
+	return reply;
+}
+
 static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data)
 {
 	DBusMessageIter iter;
Index: dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.7
diff -u -r1.7 dbus.h
--- dbus.h	22 Oct 2005 13:03:41 -0000	1.7
+++ dbus.h	23 Oct 2005 20:23:11 -0000
@@ -105,10 +105,11 @@
 #define HCI_PERIODIC_INQ		"PeriodicInquiry"
 #define HCI_CANCEL_PERIODIC_INQ		"CancelPeriodic"
 #define HCI_INQ				"Inquiry"
+#define HCI_CANCEL_INQ			"CancelInquiry"
 #define HCI_ROLE_SWITCH			"RoleSwitch"
 #define HCI_REMOTE_NAME			"RemoteName"
 #define HCI_CONNECTIONS			"Connections"
-#define HCI_AUTHENTICATE			"Authenticate"
+#define HCI_AUTHENTICATE		"Authenticate"
 
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING\
@@ -122,6 +123,8 @@
 							DBUS_TYPE_BYTE_AS_STRING\
 							__END_SIG__
 
+#define HCI_CANCEL_INQ_SIGNATURE			__END_SIG__
+
 #define HCI_ROLE_SWITCH_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
 							DBUS_TYPE_BYTE_AS_STRING\
 							__END_SIG__
Index: security.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/security.c,v
retrieving revision 1.41
diff -u -r1.41 security.c
--- security.c	22 Oct 2005 12:56:13 -0000	1.41
+++ security.c	23 Oct 2005 20:23:12 -0000
@@ -493,6 +493,14 @@
 		hcid_dbus_inquiry_start(sba);
 }
 
+static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
+{
+	evt_cmd_complete *evt = ptr;
+
+	if (evt->opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL))
+		hcid_dbus_inquiry_complete(sba);
+}
+
 static inline void remote_name_information(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_remote_name_req_complete *evt = ptr;
@@ -679,6 +687,10 @@
 		cmd_status(dev, &di->bdaddr, ptr);
 		break;
 
+	case EVT_CMD_COMPLETE:
+		cmd_complete(dev, &di->bdaddr, ptr);
+		break;
+
 	case EVT_REMOTE_NAME_REQ_COMPLETE:
 		remote_name_information(dev, &di->bdaddr, ptr);
 		break;

--cmJC7u66zC7hs+87--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
