Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510110749jf47c023ne87567fba3d65937@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1226_8011435.1129042151005"
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com>
Subject: [Bluez-devel] Re: hcid patch (remote name and connections)
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
Date: Tue, 11 Oct 2005 11:49:11 -0300

------=_Part_1226_8011435.1129042151005
Content-Type: multipart/alternative;
	boundary="----=_Part_1227_27822942.1129042151005"

------=_Part_1227_27822942.1129042151005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks, Marcel,

I added the support to remote name and display connections.
This patch is based on dbus.c revision 1.20

Marcel, please ignore the blocked e-mail. I sent a big attachement. :)

There is a command line client to test the added services:
http://www.cin.ufpe.br/~ckt/bluez/bluez-hcid-dbus-client.tar.gz

Regards,
Claudio.

On 10/11/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
> Hi folks/Marcel,
>
> I added the support to remote name and display connections.
> This patch is based on dbus.c revision 1.20
>
> There is a command line client attached to test the added services.
>
> Regards,
> Claudio
>
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Nokia's Institute of Technology - INdT
> claudio.takahasi@indt.org.br
>
>


--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_1227_27822942.1129042151005
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks, Marcel,<br>
<br>


I added the support to remote name and display connections.<br>


This patch is based on dbus.c revision 1.20<br>
<br>
Marcel, please ignore the blocked e-mail. I sent a big attachement. :)<br>
<br>
There is a command line client to test the added services:<br>
<a href=3D"http://www.cin.ufpe.br/~ckt/bluez/bluez-hcid-dbus-client.tar.gz"=
>http://www.cin.ufpe.br/~ckt/bluez/bluez-hcid-dbus-client.tar.gz</a><br>
<br>
Regards,<br>
Claudio.<br><br><div><span class=3D"gmail_quote">On 10/11/05, <b class=3D"g=
mail_sendername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmai=
l.com">cktakahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">
Hi folks/Marcel,<br>

<br>

I added the support to remote name and display connections.<br>

This patch is based on dbus.c revision 1.20<br>

<br>

There is a command line client attached to test the added services.<br>

<br>

Regards,<br>

Claudio<br clear=3D"all"><span class=3D"sg"><br>-- <br>--------------------=
-------------------------------------<br>Claudio Takahasi<br>Nokia's Instit=
ute of Technology - INdT<br><a href=3D"mailto:claudio.takahasi@indt.org.br"=
 target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)"=
>
claudio.takahasi@indt.org.br
</a><br>

</span><br clear=3D"all"></blockquote></div><br><br clear=3D"all"><br>-- <b=
r>---------------------------------------------------------<br>Claudio Taka=
hasi<br>Nokia's Institute of Technology - INdT<br><a href=3D"mailto:claudio=
.takahasi@indt.org.br">
claudio.takahasi@indt.org.br</a><br>

------=_Part_1227_27822942.1129042151005--

------=_Part_1226_8011435.1129042151005
Content-Type: application/octet-stream; name=rem_name_connections_01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rem_name_connections_01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-09 19:15:22.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-10 17:37:57.000000000 -0300
@@ -122,6 +122,8 @@
 #define HCI_CANCEL_PERIODIC_INQ		"CancelPeriodic"
 #define HCI_INQ				"Inquiry"
 #define HCI_ROLE_SWITCH			"RoleSwitch"
+#define HCI_REMOTE_NAME			"RemoteName"
+#define HCI_CONNECTIONS			"Connections"
 
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING\
@@ -139,6 +141,21 @@
 #define HCI_ROLE_SWITCH_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
 							DBUS_TYPE_BYTE_AS_STRING\
 							__END_SIG__
+							
+#define HCI_REMOTE_NAME_SIGNATURE			DBUS_TYPE_STRING_AS_STRING\
+							__END_SIG__
+							
+#define HCI_CONNECTIONS_SIGNATURE			__END_SIG__
+
+#define HCI_CONN_INFO_STRUCT_SIGNATURE			DBUS_STRUCT_BEGIN_CHAR_AS_STRING\
+							DBUS_TYPE_UINT16_AS_STRING\
+							DBUS_TYPE_STRING_AS_STRING\
+							DBUS_TYPE_BYTE_AS_STRING\
+							DBUS_TYPE_BYTE_AS_STRING\
+							DBUS_TYPE_UINT16_AS_STRING\
+							DBUS_TYPE_UINT32_AS_STRING\
+							DBUS_STRUCT_END_CHAR_AS_STRING\
+							__END_SIG__
 
 #define HCI_DEVICE_STRUCT_SIGNATURE			DBUS_STRUCT_BEGIN_CHAR_AS_STRING\
 							DBUS_TYPE_STRING_AS_STRING\
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-11 11:10:21.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-11 11:20:40.000000000 -0300
@@ -58,6 +58,7 @@
 #define BLUETOOTH_DEVICE_NAME_LEN    (18)
 #define BLUETOOTH_DEVICE_ADDR_LEN    (18)
 #define MAX_PATH_LENGTH   (64)
+#define READ_REMOTE_NAME_TIMEOUT	25000
 
 #define PINAGENT_SERVICE_NAME BASE_INTERFACE ".PinAgent"
 #define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
@@ -125,14 +126,12 @@
 
 	if (ecode & BLUEZ_ESYSTEM_OFFSET) {
 		/* System error */
-		raw_code = (!BLUEZ_ESYSTEM_OFFSET) & ecode;
-		syslog(LOG_INFO, "%s - msg:%s", __PRETTY_FUNCTION__, strerror(raw_code));
+		raw_code = (~BLUEZ_ESYSTEM_OFFSET) & ecode;
 		return strerror(raw_code);
 	} else if (ecode & BLUEZ_EDBUS_OFFSET) { 
 		/* D-Bus error */
 		for (ptr = error_array; ptr->code; ptr++) {
 			if (ptr->code == ecode) {
-				syslog(LOG_INFO, "%s - msg:%s", __PRETTY_FUNCTION__, ptr->str);
 				return ptr->str;
 			}
 		}
@@ -217,12 +216,16 @@
 static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_inq_req(DBusMessage *msg, void *data);
 static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_display_conn_req(DBusMessage *msg, void *data);
 
 static const struct service_data hci_services[] = {
 	{ HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_SIGNATURE		},
 	{ HCI_CANCEL_PERIODIC_INQ,	handle_cancel_periodic_inq_req,	HCI_CANCEL_PERIODIC_INQ_SIGNATURE	},
 	{ HCI_ROLE_SWITCH,		handle_role_switch_req,		HCI_ROLE_SWITCH_SIGNATURE		},
 	{ HCI_INQ,			handle_inq_req,			HCI_INQ_SIGNATURE			},
+	{ HCI_REMOTE_NAME,		handle_remote_name_req,		HCI_REMOTE_NAME_SIGNATURE		},
+	{ HCI_CONNECTIONS,		handle_display_conn_req,	HCI_CONNECTIONS_SIGNATURE		},
 	{ NULL,				NULL,				NULL					}
 };
 
@@ -838,7 +841,6 @@
 	signature = dbus_message_get_signature(msg);
 
 	syslog (LOG_INFO, "%s - path:%s, udata:0x%X", __PRETTY_FUNCTION__, path, (guint) udata);
-
 	if (strcmp(path, DEVICE_PATH) == 0) {
 		ptr_handlers = dev_services;
 		tmp_iface = DEVICE_INTERFACE;
@@ -898,17 +900,18 @@
 			reply = bluez_new_failure_msg(msg, result);
 		}
 
-		/* send an error or the success reply*/
-		if (reply) {
-			if (!dbus_connection_send (conn, reply, NULL)) { 
-				syslog(LOG_ERR, "%s line:%d Can't send reply message!",
-					__PRETTY_FUNCTION__, __LINE__) ;
-			}
-			dbus_message_unref (reply);
-		}
 
 		ret = DBUS_HANDLER_RESULT_HANDLED;
 	}
+
+	/* send an error or the success reply*/
+	if (reply) {
+		if (!dbus_connection_send (conn, reply, NULL)) { 
+			syslog(LOG_ERR, "Can't send reply message!");
+		}
+		dbus_message_unref (reply);
+	}
+	
 	return ret;
 }
 
@@ -1162,6 +1165,126 @@
 	return reply;
 }
 
+static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
+{
+	char name[64];
+	const char *pname = name;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	long udata = (long) data;
+	int dev_id = -1;
+	int dd = -1;
+	const char *str_bdaddr;
+	bdaddr_t bdaddr;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &str_bdaddr);
+	
+	str2ba(str_bdaddr, &bdaddr);
+
+	if (udata == DEFAULT_DEVICE_PATH_ID) {
+		if ((dev_id = hci_get_route(&bdaddr)) < 0) {
+			syslog(LOG_ERR, "Bluetooth device is not available");
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+			goto failed;
+		}
+	} else  {
+		dev_id = (int) udata;
+	}
+
+	if ((dd = hci_open_dev(dev_id)) > 0) {
+	
+		if (hci_read_remote_name(dd, &bdaddr, sizeof(name), name, READ_REMOTE_NAME_TIMEOUT) ==0) {
+			reply = dbus_message_new_method_return(msg);
+			dbus_message_iter_init_append(reply, &iter);
+			dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &pname);
+		} else {
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		}
+	} else {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+	}
+	
+	if (dd > 0)
+		close (dd);
+
+failed:
+	return reply;
+}
+
+static DBusMessage* handle_display_conn_req(DBusMessage *msg, void *data)
+{
+	struct hci_conn_list_req *cl = NULL;
+	struct hci_conn_info *ci = NULL;
+	DBusMessage *reply = NULL;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessageIter  struct_iter;
+	char addr[18];
+	const char array_sig[] = HCI_CONN_INFO_STRUCT_SIGNATURE;
+	const char *paddr = addr;
+	long udata = (long) data;
+	int i;
+	int dev_id = -1;
+	int sk;
+
+	if (udata == DEFAULT_DEVICE_PATH_ID) {
+		if ((dev_id = hci_get_route(NULL)) < 0) {
+			syslog(LOG_ERR, "Bluetooth device is not available");
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+			goto failed;
+		}
+	} else  {
+		dev_id = (int) udata;
+	}
+
+	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+
+	if (sk < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	if (!(cl = malloc(10 * sizeof(*ci) + sizeof(*cl)))) { 
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
+		goto failed;
+	}
+
+	cl->dev_id = dev_id;
+	cl->conn_num = 10;
+	ci = cl->conn_info;
+
+	if (ioctl(sk, HCIGETCONNLIST, (void *) cl)) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
+	
+	for (i = 0; i < cl->conn_num; i++, ci++) {
+		ba2str(&ci->bdaddr, addr);
+
+		dbus_message_iter_open_container(&array_iter, DBUS_TYPE_STRUCT, NULL, &struct_iter);
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT16 ,&(ci->handle));
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING ,&paddr);
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_BYTE ,&(ci->type));
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_BYTE ,&(ci->out));
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT16 ,&(ci->state));
+		dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT32 ,&(ci->link_mode));
+		dbus_message_iter_close_container(&array_iter, &struct_iter);
+	}
+	
+	dbus_message_iter_close_container(&iter, &array_iter);
+failed:
+
+	if (cl)
+		free (cl);
+	
+	return reply;
+}
+
 /*****************************************************************
  *  
  *  Section reserved to Device D-Bus message handlers

------=_Part_1226_8011435.1129042151005--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
