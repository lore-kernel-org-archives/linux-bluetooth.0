Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510140703t4080f782o8fcdef057fa00c06@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS-PATCH] cleanup
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12775_5447608.1129298638079"
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
Date: Fri, 14 Oct 2005 11:03:58 -0300

------=_Part_12775_5447608.1129298638079
Content-Type: multipart/alternative;
	boundary="----=_Part_12776_21465080.1129298638079"

------=_Part_12776_21465080.1129298638079
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Minor changes:
- removed some logs
- added verification for dbus_connection_list_registered function. It can
return FALSE if there is no memory to allocate the child entries


Regards,
Claudio.

On 10/14/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
>
>
> On 10/14/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Claudio,
> >
> > > The attached patch implements the service for list the registered
> > > paths under the path /org/bluez/Manager.
> > >
> > > The message request signature can be:
> > > 1. ListPaths() - list all paths under /org/bluez/Manager
> > > 2. ListPaths(String), The string is the relative path. eg: "hci0",
> > > "default" - list all paths provided by one adapter
> >
> > do we really need this?
>
>
> [Claudio Takahasi]
> How clients will discover the active paths if we change the format?
> eg: "hci0" to "AA_BB_CC_DD_EE_FF"
>
> The developers can use the dbus.h constants to compose the path, but if w=
e
> provide this service. It will be possible check if the path is active and=
/or
> check if it provide a specific profile(pan,rfcomm).
>
> When a client send a msg to a unregistered path, it will receive a reply
> with "Device path is not registered" message.
>
> I agree that at the moment this service is not much useful, the final
> decision is yours :)
>
>
> > Other minor changes:
> > > - removed some logs
> > > - added verification for dbus_connection_list_registered function. It
> > > can return FALSE if there is no memory
> > > to allocate the child entries
> >
> > Don't send combined patches. If you have cleanups then send them as a
> > separate patch.
>
>
> [Claudio Takahasi]
> Ok. I will send soon.
>
> Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by:
> > Power Architecture Resource Center: Free content, downloads,
> > discussions,
> > and more. http://solutions.newsforge.com/ibmarch.tmpl
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
>
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Nokia's Institute of Technology - INdT
> claudio.takahasi@indt.org.br
>



--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_12776_21465080.1129298638079
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
<span class=3D"q">Minor changes:<br>&nbsp;- removed some logs<br>&nbsp;-
added verification for dbus_connection_list_registered function. It can
return FALSE if there is no memory to allocate the child entries<br>
<br>
<br>
Regards,<br>
Claudio.<br>
<br>
</span><div><span class=3D"gmail_quote">On 10/14/05, <b class=3D"gmail_send=
ername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmail.com">ck=
takahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
<br><br><div><span class=3D"q"><span class=3D"gmail_quote">On 10/14/05, <b =
class=3D"gmail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel=
@holtmann.org" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(windo=
w,event,this)">
marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">

Hi Claudio,<br><br>&gt; The attached patch implements the service for list =
the registered<br>&gt; paths under the path /org/bluez/Manager.<br>&gt;<br>=
&gt; The message request signature can be:<br>&gt; 1. ListPaths() - list al=
l paths under /org/bluez/Manager
<br>&gt; 2. ListPaths(String), The string is the relative path. eg: &quot;h=
ci0&quot;,<br>&gt; &quot;default&quot; - list all paths provided by one ada=
pter<br><br>do we really need this?</blockquote></span><div><br>
[Claudio Takahasi]<br>
How clients will discover the active paths if we change the format? <br>eg:=
 &quot;hci0&quot; to &quot;AA_BB_CC_DD_EE_FF&quot;<br>
<br>
The developers can use the dbus.h constants to compose the path, but if
we provide this service. It will be possible check if the path is
active and/or&nbsp; check if it provide a specific profile(pan,rfcomm).<br>
<br>
When a client send a msg to a unregistered path, it will receive a reply wi=
th &quot;Device path is not registered&quot; message. <br>
<br>
I agree that at the moment this service is not much useful, the final decis=
ion is yours :)<br>
<br>
</div><span class=3D"q"><br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">&gt; Other minor changes:<br>&gt; - removed some logs<br>&gt; - =
added verification for dbus_connection_list_registered function. It
<br>&gt; can return FALSE if there is no memory<br>&gt;&nbsp;&nbsp; to allo=
cate the child entries<br><br>Don't send combined patches. If you have clea=
nups then send them as a<br>separate patch.</blockquote></span><span class=
=3D"sg">
<div><br>
[Claudio Takahasi]<br>
Ok. I will send soon. <br>
</div></span><span class=3D"q"><br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">Regards<br><br>Marcel<br><br><br>
<br><br>-------------------------------------------------------<br>This SF.=
Net email is sponsored by:<br>Power Architecture Resource Center: Free cont=
ent, downloads, discussions,<br>and more. <a href=3D"http://solutions.newsf=
orge.com/ibmarch.tmpl" target=3D"_blank" onclick=3D"return top.js.OpenExtLi=
nk(window,event,this)">


http://solutions.newsforge.com/ibmarch.tmpl</a><br>________________________=
_______________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bl=
uez-devel@lists.sourceforge.net" target=3D"_blank" onclick=3D"return top.js=
.OpenExtLink(window,event,this)">
Bluez-devel@lists.sourceforge.net</a><br>

<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></sp=
an>
</div><br><br clear=3D"all"><br>-- <br>------------------------------------=
---------------------
<div><span class=3D"e" id=3D"q_106ef6422b39adf7_7"><br>Claudio Takahasi<br>=
Nokia's Institute of Technology - INdT<br><a href=3D"mailto:claudio.takahas=
i@indt.org.br" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(windo=
w,event,this)">
claudio.takahasi@indt.org.br</a><br>


</span></div></blockquote></div><br><br clear=3D"all"><br>-- <br>----------=
-----------------------------------------------<br>Claudio Takahasi<br>Noki=
a's Institute of Technology - INdT<br><a href=3D"mailto:claudio.takahasi@in=
dt.org.br">
claudio.takahasi@indt.org.br</a><br>

------=_Part_12776_21465080.1129298638079--

------=_Part_12775_5447608.1129298638079
Content-Type: application/octet-stream; name=cleanup_01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cleanup_01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-14 08:13:43.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-14 10:57:54.000000000 -0300
@@ -631,8 +631,6 @@
 		return FALSE;
 	}
 
-	syslog(LOG_INFO,"Registered %s object", DEVICE_PATH);
-
 	data = malloc(sizeof(struct hci_dbus_data));
 	if (data == NULL)
 		return FALSE;
@@ -645,8 +643,6 @@
 		return FALSE;
 	}
 
-	syslog(LOG_INFO, "Registered %s object", MANAGER_PATH);
-
 	if (!dbus_connection_add_filter(connection, hci_signal_filter, NULL, NULL)) {
 		syslog(LOG_ERR, "Can't add new HCI filter");
 		return FALSE;
@@ -673,7 +669,7 @@
 		return;
 
 	if (dbus_connection_get_object_path_data(connection,
-						DEVICE_PATH, &data)) {
+				DEVICE_PATH, &data)) {
 		if (data) {
 			free(data);
 			data = NULL;
@@ -682,11 +678,9 @@
 
 	if (!dbus_connection_unregister_object_path(connection, DEVICE_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", DEVICE_PATH);
-	else
-		syslog(LOG_INFO, "Unregistered %s object", DEVICE_PATH);
 
 	if (dbus_connection_get_object_path_data(connection,
-						MANAGER_PATH, &data)) {
+				MANAGER_PATH, &data)) {
 		if (data) {
 			free(data);
 			data = NULL;
@@ -695,60 +689,56 @@
 
 	if (!dbus_connection_unregister_object_path(connection, MANAGER_PATH))
 		syslog(LOG_ERR, "Can't unregister %s object", MANAGER_PATH);
-	else
-		syslog(LOG_INFO, "Unregistered %s object", MANAGER_PATH);
 
-	dbus_connection_list_registered(connection, fst_parent, &fst_level);
+	if (dbus_connection_list_registered(connection, fst_parent, &fst_level)) {
 
-	for (; *fst_level; fst_level++) {
-		ptr1 = *fst_level;
-		sprintf(snd_parent, "%s/%s", fst_parent, ptr1);
+		for (; *fst_level; fst_level++) {
+			ptr1 = *fst_level;
+			sprintf(snd_parent, "%s/%s", fst_parent, ptr1);
 
-		dbus_connection_list_registered(connection, snd_parent, &snd_level);
+			if (dbus_connection_list_registered(connection, snd_parent, &snd_level)) {
 
-		if (!(*snd_level)) {
-			sprintf(path, "%s/%s", MANAGER_PATH, ptr1);
+				if (!(*snd_level)) {
+					sprintf(path, "%s/%s", MANAGER_PATH, ptr1);
 
-			syslog(LOG_INFO, "Unregistered %s object", path);
-
-			if (dbus_connection_get_object_path_data(connection,
+					if (dbus_connection_get_object_path_data(connection,
 								path, &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
-				}
-			}
+						if (data) {
+							free(data);
+							data = NULL;
+						}
+					}
 
-			if (!dbus_connection_unregister_object_path(connection, path))
-				syslog(LOG_ERR, "Can't unregister %s object", path);
+					if (!dbus_connection_unregister_object_path(connection, path))
+						syslog(LOG_ERR, "Can't unregister %s object", path);
 
-			continue;
-		}
-
-		for (; *snd_level; snd_level++) {
-			ptr2 = *snd_level;
-			sprintf(path, "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
+					continue;
+				}
 
-			syslog(LOG_INFO, "Unregistered %s object", path);
+				for (; *snd_level; snd_level++) {
+					ptr2 = *snd_level;
+					sprintf(path, "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
 
-			if (dbus_connection_get_object_path_data(connection,
+					if (dbus_connection_get_object_path_data(connection,
 								path, &data)) {
-				if (data) {
-					free(data);
-					data = NULL;
+						if (data) {
+							free(data);
+							data = NULL;
+						}
+					}
+
+					if (!dbus_connection_unregister_object_path(connection, path))
+						syslog(LOG_ERR, "Can't unregister %s object", path);
 				}
-			}
 
-			if (!dbus_connection_unregister_object_path(connection, path))
-				syslog(LOG_ERR, "Can't unregister %s object", path);
+				if (*snd_level)
+					dbus_free_string_array(snd_level);
+			}
 		}
 
-		if (*snd_level)
-			dbus_free_string_array(snd_level);
+		if (*fst_level)
+			dbus_free_string_array(fst_level);
 	}
-
-	if (*fst_level)
-		dbus_free_string_array(fst_level);
 }
 
 gboolean hcid_dbus_register_device(uint16_t id)
@@ -806,9 +796,8 @@
 
 	/* register the default path*/
 	if (!dft_reg) {
-		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
 
-		syslog(LOG_INFO, "registering dft path:%s - id:%d", path, DEFAULT_DEVICE_PATH_ID);
+		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
 
 		data = malloc(sizeof(struct hci_dbus_data));
 		if (data == NULL)
@@ -831,8 +820,6 @@
 	/* register the default path*/
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
 
-	syslog(LOG_INFO, "registering  -  path:%s - id:%d",path, id);
-
 	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, data)) {
 		syslog(LOG_ERR,"DBUS failed to register %s object", path);
 		/* ignore, the path was already registered */
@@ -859,8 +846,9 @@
 	void *data = NULL;
 
 	if (unreg_dft) {
+
 		sprintf(dft_path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
-		syslog(LOG_INFO, "%s - unregistering dft:%s", __PRETTY_FUNCTION__, dft_path);
+
 		if (!dbus_connection_unregister_object_path (connection, dft_path)) {
 			syslog(LOG_ERR,"DBUS failed to unregister %s object", dft_path);
 			ret = -1;
@@ -875,7 +863,7 @@
 	}
 
 	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
-	syslog(LOG_INFO, "%s - unregistering spec:%s", __PRETTY_FUNCTION__, path);
+
 	if (!dbus_connection_unregister_object_path (connection, path)) {
 		syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
 		ret = -1;
@@ -1315,7 +1303,6 @@
 			reply = dbus_message_new_method_return(msg);
 			dbus_message_iter_init_append(reply, &iter);
 			dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &pname);
-			syslog(LOG_INFO, "Remote Name: %s", pname);
 		} else {
 			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		}
@@ -1410,7 +1397,7 @@
 
 /*****************************************************************
  *  
- *  Section reserved to Device D-Bus message handlers
+ *  Section reserved to Manager D-Bus message handlers
  *  
  *****************************************************************/
 

------=_Part_12775_5447608.1129298638079--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
