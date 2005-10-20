Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6120_15998583.1129830338633"
Subject: [Bluez-devel] [D-BUS PATCH] Authentication
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
Date: Thu, 20 Oct 2005 15:45:38 -0200

------=_Part_6120_15998583.1129830338633
Content-Type: multipart/alternative;
	boundary="----=_Part_6121_16522828.1129830338633"

------=_Part_6121_16522828.1129830338633
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

This is the initial patch to support authentication. There are improving
points
that I am planning send soon if everybody agree with my proposal.

The authentication function of this patch is not checking the authenticatio=
n

complete event status. Clients should not use a blocking send method becaus=
e

NO reply is being sent if the hci_send_req returns success.

There two possible solutions:
1. Change the security.c file to filter for authentication event and send a
SIGNAL with the bdaddr and the status
1. Change the security.c file to filter for authentication event and send a
METHOD REPLY with the bdaddr and the status. For this case will be required
keep the method_call message received in the service request.

>>>How test it:
- remove the linkkeys file :)
- use hcitool cc AA:BB:CC:DD:EE:FF to establish a connection
- send the D-BUS msg
$ dbus-send --system --dest=3D'org.bluez' --type=3Dmethod_call
/org/bluez/Manager/default/Controller
org.bluez.Manager.Authenticatestring:"AA:BB:CC:DD:EE:FF"

>>> Next action:
1. Change the reply
2. Change the pin helper to avoid blocking operation. Pipe should be
avoided. Maybe it's
possible add the file descriptor in the main loop instead of wait for data.
3. Support for re-authentication - It will be required add functions to
remove an entry from
the linkkey file.


Regards,
Claudio.

--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_6121_16522828.1129830338633
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,<br>
<br>
This is the initial patch to support authentication. There are improving po=
ints<br>
that I am planning send soon if everybody agree with my proposal.<br>
<br>
The authentication function of this patch is not checking the authenticatio=
n <br>
complete event status. Clients should not use a blocking send method becaus=
e <br>
NO reply is being sent if the hci_send_req returns success.<br>
<br>
There two possible solutions:<br>
1. Change the security.c file to filter for authentication event and send a=
 <br>
SIGNAL with the bdaddr and the status<br>
1. Change the security.c file to filter for authentication event and send a=
 <br>
METHOD REPLY with the bdaddr and the status. For this case will be required=
<br>
keep the method_call message received in the service request.<br>
<br>
&gt;&gt;&gt;How test it:<br>
- remove the linkkeys&nbsp; file :)<br>
- use hcitool cc AA:BB:CC:DD:EE:FF to establish a connection<br>
- send the D-BUS msg<br>
$ dbus-send --system --dest=3D'org.bluez' --type=3Dmethod_call
/org/bluez/Manager/default/Controller org.bluez.Manager.Authenticate
string:&quot;AA:BB:CC:DD:EE:FF&quot;<br>
<br>
&gt;&gt;&gt; Next action:<br>
1. Change the reply<br>
2. Change the pin helper to avoid blocking operation. Pipe should be avoide=
d. Maybe it's <br>
possible add the file descriptor in the main loop instead of wait for data.=
<br>
3. Support for re-authentication - It will be required add functions to rem=
ove an entry from <br>
the linkkey file.<br>
<br>
<br>
Regards,<br>
Claudio.<br clear=3D"all"><br>-- <br>--------------------------------------=
-------------------<br>Claudio Takahasi<br>Nokia's Institute of Technology =
- INdT<br><a href=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@=
indt.org.br
</a><br>

------=_Part_6121_16522828.1129830338633--

------=_Part_6120_15998583.1129830338633
Content-Type: application/octet-stream; name=auth_01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="auth_01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-19 16:48:36.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-20 14:20:21.000000000 -0200
@@ -128,6 +128,7 @@
 #define HCI_ROLE_SWITCH			"RoleSwitch"
 #define HCI_REMOTE_NAME			"RemoteName"
 #define HCI_CONNECTIONS			"Connections"
+#define HCI_AUTHENTICATE			"Authenticate"
 
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING\
@@ -172,6 +173,9 @@
 							DBUS_STRUCT_END_CHAR_AS_STRING\
 							__END_SIG__
 
+#define HCI_AUTHENTICATE_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+
 
 /* BLUEZ_DBUS_ERROR 
  * EFailed error messages signature is : su
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-19 16:48:15.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-20 14:18:57.000000000 -0200
@@ -225,6 +225,7 @@
 static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_display_conn_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_auth_req(DBusMessage *msg, void *data);
 
 static const struct service_data hci_services[] = {
 	{ HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_SIGNATURE		},
@@ -233,6 +234,7 @@
 	{ HCI_INQ,			handle_inq_req,			HCI_INQ_SIGNATURE			},
 	{ HCI_REMOTE_NAME,		handle_remote_name_req,		HCI_REMOTE_NAME_SIGNATURE		},
 	{ HCI_CONNECTIONS,		handle_display_conn_req,	HCI_CONNECTIONS_SIGNATURE		},
+	{ HCI_AUTHENTICATE,		handle_auth_req,		HCI_AUTHENTICATE_SIGNATURE		},
 	{ NULL,				NULL,				NULL					}
 };
 
@@ -1443,6 +1445,92 @@
 	return reply;
 }
 
+static DBusMessage* handle_auth_req(DBusMessage *msg, void *data)
+{
+	struct hci_request rq;
+	auth_requested_cp cp;
+	evt_cmd_status rp;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	char *str_bdaddr = NULL;
+	struct hci_dbus_data *dbus_data = data;
+	struct hci_conn_info_req *cr = NULL;
+	bdaddr_t bdaddr;
+	int dev_id = -1;
+	int sock = -1;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &str_bdaddr);
+	str2ba(str_bdaddr, &bdaddr);
+
+	dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
+
+	if (dev_id < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
+		goto failed;
+	}
+
+	if (dbus_data->id != DEFAULT_DEVICE_PATH_ID && dbus_data->id != dev_id) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
+		goto failed;
+	}
+
+	sock = hci_open_dev(dev_id);
+	if (sock < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+
+	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
+	if (!cr) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
+		goto failed;
+	}
+
+	bacpy(&cr->bdaddr, &bdaddr);
+	cr->type = ACL_LINK;
+
+	if (ioctl(sock, HCIGETCONNINFO, (unsigned long) cr) < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cr->conn_info->handle;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LINK_CTL;
+	rq.ocf = OCF_AUTH_REQUESTED;
+	rq.cparam = &cp;
+	rq.clen = AUTH_REQUESTED_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen = EVT_CMD_STATUS_SIZE;
+	rq.event = EVT_CMD_STATUS;
+
+	if (hci_send_req(sock, &rq, 25000) < 0) {
+		syslog(LOG_ERR, "Unable to send authentication request: %s", strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (rp.status) {
+		syslog(LOG_ERR, "Authentication command failed with status 0x%02X", rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + EIO);
+		goto failed;
+	}
+
+failed:
+
+	if (sock > 0)
+		close (sock);
+
+	if (cr)
+		free (cr);
+
+	return reply;
+
+}
+
 /*****************************************************************
  *  
  *  Section reserved to Manager D-Bus message handlers

------=_Part_6120_15998583.1129830338633--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
