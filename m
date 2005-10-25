Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80510250452j702622acw98ed9abef758bca1@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Device Configuration D-Bus services
In-Reply-To: <1130189692.7840.21.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1348_32678932.1130241140553"
References: <e1effdeb0510190606x50364b25y52a5092847000105@mail.gmail.com>
	 <3013cac80510241400k2b71125ao7b8b4dfe5077a300@mail.gmail.com>
	 <1130189692.7840.21.camel@blade>
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
Date: Tue, 25 Oct 2005 08:52:20 -0300

------=_Part_1348_32678932.1130241140553
Content-Type: multipart/alternative;
	boundary="----=_Part_1349_15883422.1130241140553"

------=_Part_1349_15883422.1130241140553
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I've changed the functions names. Here is the patch.

About the SetProperty:

Claudio said: " The device based paths can provide services like:
- SetProperty
- GetProperty
- Commands
- Features

Using SetProperty/GetProperty instead of define one method name for each
property is more clean. However it is important keep in mind that the
documentation of this service must be well-defined, because the method
call/method reply arguments will have different argument number and types.
In the method call, the first argument must be a byte(faster comparison)
indicating the command code instead of use a string to represent the
command"

The point is, as we have merged the main operations in two functions (set
and get), so we have to identify the operation by an integer or by a string
constant. It seems that a string is better for python binding (can anyone
confirm that?).

BR,
Eduardo.



On 10/24/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Eduardo,
>
> > here is the initial patch regarding /org/bluez/Devices. I keep it
> > really simple so we can improve it in small steps. I've merged the
> > Claudio's code for register and unregister a new path for a device in
> > two funcions as this code is used in 3 different parts of the code.
>
> call it *register_device() and *register_manager().
>
> > For now I've leaved the syslog call to register and unregister
> > operations so we can see if every thing is going ok.
>
> I think it is a good idea to introduce some DBG() defines.
>
> > My next step is to provide a list of registed devices (not only the
> > devices that are up) through /org/bluez/Devices path.
>
> Feel free to send another patch on top of this one.
>
> > One question: the SetProperty and GetProperty will use an interger or
> > a string constant to determing which operation will be used?
>
> You need to explain to me what you are talking about.
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
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_1349_15883422.1130241140553
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I've changed the functions names.&nbsp; Here is the&nbsp; patch. <br>
<br>
About the SetProperty:<br>
<br>
Claudio said: &quot;
The device based paths can provide services like:<br>

- SetProperty<br>

- GetProperty<br>

- Commands<br>

- Features<br>

<br>

Using SetProperty/GetProperty instead of define one method name for each<br=
>

property is more clean. However it is important keep in mind that the <br>

documentation of this service must be well-defined, because the method <br>

call/method reply arguments will have different argument number and types.<=
br>

In the method call, the first argument must be a byte(faster comparison)<br=
>

indicating the command code instead of use a string to represent the comman=
d&quot;<br>
<br>
The point is, as we have merged the main operations in two functions
(set and get), so we have to identify the operation by an integer or by
a string constant. It seems that a string is better for python binding
(can anyone confirm that?).<br>
<br>
BR,<br>
Eduardo.<br>
<br>
<br><br><div><span class=3D"gmail_quote">On 10/24/05, <b class=3D"gmail_sen=
dername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">mar=
cel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Hi Eduardo,<br><br>&gt; here is the initial patch regarding /org/bluez/Devi=
ces. I keep it<br>&gt; really simple so we can improve it in small steps. I=
've merged the<br>&gt; Claudio's code for register and unregister a new pat=
h for a device in
<br>&gt; two funcions as this code is used in 3 different parts of the code=
.<br><br>call it *register_device() and *register_manager().<br><br>&gt; Fo=
r now I've leaved the syslog call to register and unregister<br>&gt; operat=
ions so we can see if every thing is going ok.
<br><br>I think it is a good idea to introduce some DBG() defines.<br><br>&=
gt; My next step is to provide a list of registed devices (not only the<br>=
&gt; devices that are up) through /org/bluez/Devices path.<br><br>Feel free=
 to send another patch on top of this one.
<br><br>&gt; One question: the SetProperty and GetProperty will use an inte=
rger or<br>&gt; a string constant to determing which operation will be used=
?<br><br>You need to explain to me what you are talking about.<br><br>Regar=
ds
<br><br>Marcel<br><br><br><br><br>-----------------------------------------=
--------------<br>This SF.Net email is sponsored by the JBoss Inc.<br>Get C=
ertified Today * Register for a JBoss Training Course<br>Free Certification=
 Exam for All Training Attendees Through End of 2005
<br>Visit <a href=3D"http://www.jboss.com/services/certification">http://ww=
w.jboss.com/services/certification</a> for more information<br>____________=
___________________________________<br>Bluez-devel mailing list<br><a href=
=3D"mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br=
>
Eduardo Rocha<br>Instituto Nokia de Tecnologia - INdT<br><br>

------=_Part_1349_15883422.1130241140553--

------=_Part_1348_32678932.1130241140553
Content-Type: text/x-patch; name=dbus_device.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dbus_device.patch"

--- bluez-cvs-old/utils/hcid/hcid.h	2005-10-24 15:29:36.204404720 -0300
+++ bluez-cvs-new/utils/hcid/hcid.h	2005-10-25 08:23:37.995046640 -0300
@@ -126,7 +126,9 @@
 gboolean hcid_dbus_init(void);
 void hcid_dbus_exit(void);
 gboolean hcid_dbus_register_device(uint16_t id);
+gboolean hcid_dbus_register_manager(uint16_t id);
 gboolean hcid_dbus_unregister_device(uint16_t id);
+gboolean hcid_dbus_unregister_manager(uint16_t id);
 void hcid_dbus_request_pin(int dev, struct hci_conn_info *ci);
 void hcid_dbus_inquiry_start(bdaddr_t *local);
 void hcid_dbus_inquiry_complete(bdaddr_t *local);
--- bluez-cvs-old/utils/hcid/main.c	2005-10-24 15:29:36.204404720 -0300
+++ bluez-cvs-new/utils/hcid/main.c	2005-10-25 08:25:34.803289088 -0300
@@ -377,6 +377,8 @@
 			start_security_manager(dr->dev_id);
 
 #ifdef ENABLE_DBUS
+		if (hci_test_bit(HCI_UP, &dr->dev_opt ))
+			hcid_dbus_register_manager(dr->dev_id);
 		hcid_dbus_register_device(dr->dev_id);
 #endif
 	}
@@ -430,10 +432,16 @@
 		syslog(LOG_INFO, "HCI dev %d registered", sd->dev_id);
 		if (hcid.auto_init)
 			init_device(sd->dev_id);
+#ifdef ENABLE_DBUS
+		hcid_dbus_register_device(sd->dev_id);
+#endif
 		break;
 
 	case HCI_DEV_UNREG:
 		syslog(LOG_INFO, "HCI dev %d unregistered", sd->dev_id);
+#ifdef ENABLE_DBUS
+		hcid_dbus_unregister_device(sd->dev_id);
+#endif
 		break;
 
 	case HCI_DEV_UP:
@@ -443,7 +451,7 @@
 		if (hcid.security)
 			start_security_manager(sd->dev_id);
 #ifdef ENABLE_DBUS
-		hcid_dbus_register_device(sd->dev_id);
+		hcid_dbus_register_manager(sd->dev_id);
 #endif
 		break;
 
@@ -452,7 +460,7 @@
 		if (hcid.security)
 			stop_security_manager(sd->dev_id);
 #ifdef ENABLE_DBUS
-		hcid_dbus_unregister_device(sd->dev_id);
+		hcid_dbus_unregister_manager(sd->dev_id);
 #endif
 		break;
 	}
--- bluez-cvs-old/utils/hcid/dbus.c	2005-10-24 15:29:36.171409736 -0300
+++ bluez-cvs-new/utils/hcid/dbus.c	2005-10-25 08:23:03.191337608 -0300
@@ -52,7 +52,7 @@
 #include "dbus.h"
 
 static DBusConnection *connection;
-static int num_adapters = 0;
+static int up_adapters = 0;
 
 #define TIMEOUT (30 * 1000)		/* 30 seconds */
 #define BLUETOOTH_DEVICE_NAME_LEN    (18)
@@ -359,6 +359,39 @@
 	free(req);
 }
 
+static gboolean register_dbus_path(char *path, uint16_t id)
+{
+	struct hci_dbus_data *data;
+	syslog(LOG_INFO,"Registering DBUS Path: %s", path);
+	data = malloc(sizeof(struct hci_dbus_data));
+	if (data == NULL) {
+		syslog(LOG_ERR,"Failed to alloc memory to DBUS path register data (%s)", path);
+		return FALSE;
+	}
+	data->id = id;
+
+	if (!dbus_connection_register_object_path(connection, path, &obj_vtable, data)) {
+		syslog(LOG_ERR,"DBUS failed to register %s object", path);
+		free(data);
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static gboolean unregister_dbus_path(char *path)
+{
+	void *data;
+	syslog(LOG_INFO,"Unregistering DBUS Path: %s", path);
+	if (dbus_connection_get_object_path_data(connection, path, &data) && data) 
+		free(data);
+	
+	if (!dbus_connection_unregister_object_path (connection, path)) {
+		syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
+		return FALSE;
+	} 
+	return TRUE;
+}
+
 void hcid_dbus_request_pin(int dev, struct hci_conn_info *ci)
 {
 	DBusMessage *message;
@@ -739,7 +772,7 @@
 
 	data->id = DEVICE_PATH_ID;
 
-	if (!dbus_connection_register_object_path(connection, DEVICE_PATH,
+	if (!dbus_connection_register_fallback(connection, DEVICE_PATH,
 						&obj_vtable, data)) {
 		syslog(LOG_ERR, "Can't register %s object", DEVICE_PATH);
 		return FALSE;
@@ -855,7 +888,32 @@
 	}
 }
 
-gboolean hcid_dbus_register_device(uint16_t id)
+gboolean hcid_dbus_register_device(uint16_t id) 
+{
+	char path[MAX_PATH_LENGTH+1];
+	char dev[BLUETOOTH_DEVICE_NAME_LEN+1];
+	const char *pdev = dev;
+
+	snprintf(dev, BLUETOOTH_DEVICE_NAME_LEN, HCI_DEVICE_NAME "%d", id);
+	snprintf(path, MAX_PATH_LENGTH, "%s/%s", DEVICE_PATH, pdev);
+
+	/* register the default path*/
+	return register_dbus_path(path, id);
+}
+
+gboolean hcid_dbus_unregister_device(uint16_t id)
+{
+	char dev[BLUETOOTH_DEVICE_NAME_LEN+1];
+	char path[MAX_PATH_LENGTH+1];
+	const char *pdev = dev;
+
+	snprintf(dev, BLUETOOTH_DEVICE_NAME_LEN, HCI_DEVICE_NAME "%d", id);
+	snprintf(path, MAX_PATH_LENGTH, "%s/%s", DEVICE_PATH, pdev);
+
+	return unregister_dbus_path(path);
+}
+
+gboolean hcid_dbus_register_manager(uint16_t id)
 {
 	char dev[BLUETOOTH_DEVICE_NAME_LEN];
 	struct profile_obj_path_data *ptr = obj_path_table;
@@ -873,7 +931,7 @@
 	}
 
 	if (!ret)
-		num_adapters++;
+		up_adapters++;
 
 	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
 			BLUEZ_HCI_INTERFACE, BLUEZ_HCI_DEV_ADDED);
@@ -883,7 +941,7 @@
 		goto failed;
 	}
 
-	sprintf(dev, "hci%d", id);
+	sprintf(dev, HCI_DEVICE_NAME "%d", id);
 
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
@@ -904,7 +962,7 @@
 	return TRUE;
 }
 
-gboolean hcid_dbus_unregister_device(uint16_t id)
+gboolean hcid_dbus_unregister_manager(uint16_t id)
 {
 	char dev[BLUETOOTH_DEVICE_NAME_LEN];
 	struct profile_obj_path_data *ptr = obj_path_table;
@@ -917,8 +975,8 @@
 		return FALSE;
 
 	for (; ptr->name; ptr++) {
-		dft_unreg = (num_adapters > 1) ? 0 : 1;
-		num_adapters--;
+		dft_unreg = (up_adapters > 1) ? 0 : 1;
+		up_adapters--;
 		ptr->unreg_func(connection, dft_unreg, id);
 
 		if (dft_unreg )
@@ -933,7 +991,7 @@
 		goto failed;
 	}
 
-	sprintf(dev, "hci%d", id);
+	sprintf(dev, HCI_DEVICE_NAME "%d", id);
 
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
@@ -965,39 +1023,17 @@
  */
 static int hci_dbus_reg_obj_path(DBusConnection *conn, int dft_reg, uint16_t id)
 {
-	struct hci_dbus_data *data;
 	char path[MAX_PATH_LENGTH];
 
 	/* register the default path*/
 	if (!dft_reg) {
-
 		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
-
-		data = malloc(sizeof(struct hci_dbus_data));
-		if (data == NULL)
-			return -1;
-
-		data->id = DEFAULT_DEVICE_PATH_ID;
-
-		if (!dbus_connection_register_object_path(conn, path, &obj_vtable, data)) { 
-			syslog(LOG_ERR,"DBUS failed to register %s object", path);
-			/* ignore, the default path was already registered */
-		}
+		register_dbus_path(path, DEFAULT_DEVICE_PATH_ID);
 	}
 
-	data = malloc(sizeof(struct hci_dbus_data));
-	if (data == NULL)
-		return -1;
-
-	data->id = id;
-
 	/* register the default path*/
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
-
-	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, data)) {
-		syslog(LOG_ERR,"DBUS failed to register %s object", path);
-		/* ignore, the path was already registered */
-	}
+	register_dbus_path(path, id);
 
 	return 0;
 }
@@ -1016,39 +1052,14 @@
 {
 	int ret = 0;
 	char path[MAX_PATH_LENGTH];
-	char dft_path[MAX_PATH_LENGTH];
-	void *data = NULL;
 
 	if (unreg_dft) {
-
-		sprintf(dft_path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
-
-		if (!dbus_connection_unregister_object_path (connection, dft_path)) {
-			syslog(LOG_ERR,"DBUS failed to unregister %s object", dft_path);
-			ret = -1;
-		} else {
-			if (dbus_connection_get_object_path_data(conn, dft_path, &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
-				}
-			}
-		}
+		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
+		unregister_dbus_path(path);
 	}
 
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
-
-	if (!dbus_connection_unregister_object_path (connection, path)) {
-		syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
-		ret = -1;
-	} else {
-		if (dbus_connection_get_object_path_data(conn, path, &data)) {
-			if (data) {
-				free(data);
-				data = NULL;
-			}
-		}
-	}
+	unregister_dbus_path(path);
 
 	return ret;
 }






------=_Part_1348_32678932.1130241140553--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
