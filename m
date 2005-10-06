Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1968_14280888.1128609081737"
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
Date: Thu, 6 Oct 2005 11:31:21 -0300

------=_Part_1968_14280888.1128609081737
Content-Type: multipart/alternative;
	boundary="----=_Part_1969_4043923.1128609081738"

------=_Part_1969_4043923.1128609081738
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel/folks,

There is a new patch available.

What was the final decision about the path name?
I read the e-mails exchanged in the D-Bus mailing list. Due the
instability/side-effects of the support '-' for path
names, I think is not a good idea support it. I will keep the "hci" device
name in the path until we find a good solution.

Do you have any suggestions or changes before integrate this code?

Regards,
Claudio.

>>>>Main Features
1. Fixed fallback, the Manager is now returning BLUEZ_EDBUS_UNKNOWN_PATH
when the device was detached.
2. Code style changed
3. Removed memory leak

>>>>Next Action
1. Move the functions to to suitable file names( eg: dbus-mgr.c and
dbus-dev.c)
2. Define the device based path name.
3. Implement /org/bluez/Devices services



On 10/4/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
> Hi folks/Johan,
>
> Sorry, I forgot remove it.
> I fixed it in this new patch.
>
> Regards,
> Claudio
>
> On 10/4/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> >
> > Hi Claudio,
> >
> > I see that you have removed "Req" from the end of method call names.
> > However, you still have "Sig" appended to the signal names. Is that
> > intentional or have you just forgotten to remove that?
> >
> > Johan
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
>


--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_1969_4043923.1128609081738
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>Hi Marcel/folks,<br>
<br>
There is a new patch available.<br>
<br>
What was the final decision about the path name? <br>
I read the e-mails exchanged in the D-Bus mailing list. Due the instability=
/side-effects of the&nbsp; support '-' for path<br>
names, I think is not a good idea support it. I will keep the &quot;hci&quo=
t; device name in the path until we find a good solution.<br>
<br>
Do you have any suggestions or changes before integrate this code?<br>
<br>
Regards,<br>
Claudio.<br>
<br>
&gt;&gt;&gt;&gt;Main Features<br>
1. Fixed fallback, the Manager is now returning BLUEZ_EDBUS_UNKNOWN_PATH wh=
en the device was detached.<br>
2. Code style changed<br>
3. Removed memory leak<br>
<br>
&gt;&gt;&gt;&gt;Next Action<br>
1. Move the functions to to suitable file names( eg: dbus-mgr.c and dbus-de=
v.c)<br>
2. Define the device based path name.<br>
3. Implement /org/bluez/Devices services<br>
<br>
<br>
<br><div><span class=3D"gmail_quote">On 10/4/05, <b class=3D"gmail_senderna=
me">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmail.com">cktaka=
hasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi folks/Johan,<br>
<br>
Sorry, I forgot remove it.<br>
I fixed it in this new patch. <br>
<br>
Regards,<br><span class=3D"sg">
Claudio</span><div><span class=3D"e" id=3D"q_106bbd4441a40618_2"><br><br><d=
iv><span class=3D"gmail_quote">On 10/4/05, <b class=3D"gmail_sendername">Jo=
han Hedberg</b> &lt;<a href=3D"mailto:johan.hedberg@nokia.com" target=3D"_b=
lank" onclick=3D"return top.js.OpenExtLink(window,event,this)">
johan.hedberg@nokia.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>I see that you have removed &quot;Req&quot; from the end=
 of method call names.<br>However, you still have &quot;Sig&quot; appended =
to the signal names. Is that<br>intentional or have you just forgotten to r=
emove that?
<br><br>Johan<br><br><br>--------------------------------------------------=
-----<br>This SF.Net email is sponsored by:<br>Power Architecture Resource =
Center: Free content, downloads, discussions,<br>and more. <a href=3D"http:=
//solutions.newsforge.com/ibmarch.tmpl" target=3D"_blank" onclick=3D"return=
 top.js.OpenExtLink(window,event,this)">

http://solutions.newsforge.com/ibmarch.tmpl</a><br>________________________=
_______________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bl=
uez-devel@lists.sourceforge.net" target=3D"_blank" onclick=3D"return top.js=
.OpenExtLink(window,event,this)">
Bluez-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></di=
v>
<br><br clear=3D"all"><br></span></div>-- <br>-----------------------------=
----------------------------
<div><span class=3D"e" id=3D"q_106bbd4441a40618_4"><br>Claudio Takahasi<br>=
Nokia's Institute of Technology - INdT<br><a href=3D"mailto:claudio.takahas=
i@indt.org.br" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(windo=
w,event,this)">
claudio.takahasi@indt.org.br</a><br>

</span></div><br clear=3D"all"></blockquote></div><br><br clear=3D"all"><br=
>-- <br>---------------------------------------------------------<br>Claudi=
o Takahasi<br>Nokia's Institute of Technology - INdT<br><a href=3D"mailto:c=
laudio.takahasi@indt.org.br">
claudio.takahasi@indt.org.br</a><br>

------=_Part_1969_4043923.1128609081738--

------=_Part_1968_14280888.1128609081737
Content-Type: application/octet-stream; name=hcid_dbus_0013.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hcid_dbus_0013.patch"

--- bluez-utils-cvs.orig/hcid/hcid.h	2005-08-25 15:32:41.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/hcid.h	2005-10-03 11:02:36.000000000 -0300
@@ -122,6 +122,9 @@
 
 #ifdef ENABLE_DBUS
 gboolean hcid_dbus_init(void);
+void hcid_dbus_exit(void);
+gboolean mgr_dbus_reg_device_paths(uint16_t id);
+gboolean mgr_dbus_unreg_device_paths(uint16_t id);
 void hcid_dbus_request_pin(int dev, struct hci_conn_info *ci);
 void hcid_dbus_inquiry_start(bdaddr_t *local);
 void hcid_dbus_inquiry_complete(bdaddr_t *local);
--- bluez-utils-cvs.orig/hcid/dbus.h	1969-12-31 21:00:00.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-06 11:12:26.000000000 -0300
@@ -0,0 +1,174 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2000-2001  Qualcomm Incorporated
+ *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2002-2005  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation;
+ *
+ *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+ *  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+ *  CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
+ *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
+ *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
+ *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ *  ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
+ *  COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
+ *  SOFTWARE IS DISCLAIMED.
+ *
+ *
+ *  $Id: dbus.h,v 0.1 2005/09/16 08:00:00 holtmann Exp $
+ */
+ 
+#ifndef __H_BLUEZ_DBUS_H__
+#define __H_BLUEZ_DBUS_H__
+
+#define __END_SIG__ DBUS_TYPE_INVALID_AS_STRING
+
+/* bluetoothd Bus name */
+#define BLUEZ_DBUS_NAME			"org.bluez"
+
+#define DEFAULT_DEVICE_PATH_ID 		(0xFFFF)
+#define MANAGER_PATH_ID			(0xFFFE)
+#define DEVICE_PATH_ID			(0xFFFD)
+
+#define HCI_DEFAULT_DEVICE_NAME		"default"
+#define HCI_DEVICE_NAME			"hci"
+
+#define DEVICE_PATH			"/org/bluez/Devices"
+#define DEVICE_INTERFACE		BLUEZ_DBUS_NAME".Devices"
+
+#define MANAGER_PATH			"/org/bluez/Manager"
+#define MANAGER_INTERFACE		BLUEZ_DBUS_NAME".Manager"
+
+/*======================================================================== 
+    BlueZ D-Bus Device service definitions "/org/bluez/Device"
+ *========================================================================*/
+#define DEV_UP				"Up"
+#define DEV_DOWN			"Down"
+#define DEV_RESET			"Reset"
+#define DEV_SET_PROPERTY		"SetProperty"
+#define DEV_GET_PROPERTY		"GetProperty"
+
+#define DEV_UP_SIGNATURE            	__END_SIG__
+#define DEV_DOWN_SIGNATURE            	__END_SIG__
+#define DEV_RESET_SIGNATURE            	__END_SIG__
+#define DEV_SET_PROPERTY_SIGNATURE     	__END_SIG__
+#define DEV_GET_PROPERTY_SIGNATURE      __END_SIG__
+
+
+//TODO add the other hciconfig features
+
+/*======================================================================== 
+    BlueZ D-Bus Manager service definitions "/org/bluez/Manager"
+ *========================================================================*/
+ 
+ /* ===== Manager definitions, services under DEVICE_PATH ===== */
+#define MGR_GET_DEV			"DeviceList"
+#define MGR_INIT			"Init"
+
+/* Enable/Disable services controller, pan, serial, ... */
+#define MGR_ENABLE			"Enable"
+#define MGR_DISABLE			"Disable"
+
+//signatures
+#define MGR_GET_DEV_SIGNATURE            	__END_SIG__
+
+/* yya(ss)*/
+#define MGR_GET_DEV_REPLY_SIGNATURE		DBUS_TYPE_BYTE_AS_STRING\
+						DBUS_TYPE_BYTE_AS_STRING\
+						DBUS_TYPE_ARRAY_AS_STRING\
+						HCI_DEVICE_STRUCT_SIGNATURE\
+						__END_SIG__
+ 
+/* ===== HCI definitions ===== */
+#define BLUEZ_HCI			"Controller"
+#define BLUEZ_HCI_PATH			MANAGER_PATH"/"BLUEZ_HCI
+#define BLUEZ_HCI_INTERFACE		MANAGER_INTERFACE"."BLUEZ_HCI
+
+//HCI signals
+#define BLUEZ_HCI_INQ_START		"InquiryStart"
+#define BLUEZ_HCI_INQ_COMPLETE		"InquiryComplete"
+#define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
+#define BLUEZ_HCI_REMOTE_NAME		"RemoteName"
+
+//HCI Provided services
+#define HCI_PERIODIC_INQ		"PeriodicInquiry"
+#define HCI_CANCEL_PERIODIC_INQ		"CancelPeriodic"
+#define HCI_INQ				"Inquiry"
+#define HCI_ROLE_SWITCH			"RoleSwitch"
+
+
+#define HCI_PERIODIC_INQ_SIGNATURE		        DBUS_TYPE_BYTE_AS_STRING\
+							DBUS_TYPE_BYTE_AS_STRING\
+							DBUS_TYPE_BYTE_AS_STRING\
+							__END_SIG__
+							
+#define HCI_CANCEL_PERIODIC_INQ_SIGNATURE		__END_SIG__
+
+#define HCI_INQ_SIGNATURE                	    	DBUS_TYPE_BYTE_AS_STRING\
+							DBUS_TYPE_BYTE_AS_STRING\
+							DBUS_TYPE_UINT16_AS_STRING\
+							__END_SIG__
+							
+#define HCI_ROLE_SWITCH_SIGNATURE                   	DBUS_TYPE_STRING_AS_STRING\
+							DBUS_TYPE_BYTE_AS_STRING\
+							__END_SIG__
+							
+#define HCI_DEVICE_STRUCT_SIGNATURE			DBUS_STRUCT_BEGIN_CHAR_AS_STRING\
+							DBUS_TYPE_STRING_AS_STRING\
+							DBUS_TYPE_STRING_AS_STRING\
+							DBUS_STRUCT_END_CHAR_AS_STRING
+
+#define HCI_INQ_REPLY_SIGNATURE				DBUS_STRUCT_BEGIN_CHAR_AS_STRING\
+							DBUS_TYPE_STRING_AS_STRING\
+							DBUS_TYPE_UINT32_AS_STRING\
+							DBUS_TYPE_UINT16_AS_STRING\
+							DBUS_STRUCT_END_CHAR_AS_STRING\
+							__END_SIG__
+
+
+/* ===== Common Error messages of org.bluez. =====*/
+#define BLUEZ_DBUS_ERROR              BLUEZ_DBUS_NAME".Error"
+
+
+/* BLUEZ_DBUS_ERROR 
+ * EFailed error messages signature is : su
+ * Where the first argument is a string(error message description),
+ * the last  is a uint32 that contains the error class(system, dbus or hci).
+ */
+ 
+/* Error code offsets */
+#define BLUEZ_EBT_OFFSET		(0x00000000) /* see Bluetooth error code */
+#define BLUEZ_EBT_EXT_OFFSET		(0x00000100)
+#define BLUEZ_EDBUS_OFFSET		(0x00010000)
+#define BLUEZ_ESYSTEM_OFFSET		(0x00020000)
+#define BLUEZ_EFUTURE_OFFSET		(0x00040000)
+
+
+/* D-Bus error code, class BLUEZ_EDBUS_OFFSET */
+#define BLUEZ_EDBUS_UNKNOWN_METHOD	(0x01 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_WRONG_SIGNATURE	(0x02 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_WRONG_PARAM		(0x03 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_RECORD_NOT_FOUND	(0x04 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_NO_MEM   		(0x05 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_CONN_NOT_FOUND	(0x06 + BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_UNKNOWN_PATH	(0x07 + BLUEZ_EDBUS_OFFSET)
+
+/* D-Bus error code, class BLUEZ_ESYSTEM_OFFSET */
+#define BLUEZ_ESYSTEM_ENODEV		(ENODEV + BLUEZ_ESYSTEM_OFFSET)
+
+
+/* BLUEZ_DBUS_ERR_NO_MEMORY */
+#define BLUEZ_DBUS_ERR_NO_MEMORY_STR	"No memory"
+
+
+#endif /*__H_BLUEZ_DBUS_H__*/
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-09-22 09:09:16.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-06 11:12:22.000000000 -0300
@@ -33,9 +33,14 @@
 #endif
 
 #include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/syslog.h>
 
+
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
@@ -45,22 +50,227 @@
 #include "glib-ectomy.h"
 
 #include "hcid.h"
+#include "dbus.h"
 
 static DBusConnection *connection;
+static int num_adapters = 0;
 
 #define TIMEOUT (30 * 1000)		/* 30 seconds */
+#define BLUETOOTH_DEVICE_NAME_LEN    (18)
+#define BLUETOOTH_DEVICE_ADDR_LEN    (18)
+#define MAX_PATH_LENGTH   (64)
+
+#define PINAGENT_SERVICE_NAME "org.bluez.PinAgent"
+#define PINAGENT_INTERFACE PINAGENT_SERVICE_NAME
+#define PIN_REQUEST "PinRequest"
+#define PINAGENT_PATH "/org/bluez/PinAgent"
 
-#define SERVICE_NAME "org.bluez.PinAgent"
-#define INTERFACE_NAME SERVICE_NAME
-#define REQUEST_NAME "PinRequest"
-#define PATH_NAME "/org/bluez/PinAgent"
-
-#define WRONG_ARGS_ERROR "org.bluez.Error.WrongArgs"
 
 struct pin_request {
 	int dev;
 	bdaddr_t bda;
 };
+/*
+ * next action: move to a common header
+ */
+
+
+typedef DBusMessage* (service_handler_func_t)(DBusMessage *, void *);
+
+struct service_data
+{
+	const char             *name;
+	service_handler_func_t *handler_func;
+	const char             *signature;
+};
+
+typedef int  register_function_t(DBusConnection *conn, int dft_reg, uint16_t id);
+typedef int  unregister_function_t(DBusConnection *conn, int unreg_dft, uint16_t id);
+
+const struct service_data *get_hci_table(void);
+
+static int  hci_dbus_reg_obj_path(DBusConnection *conn, int dft_reg, uint16_t id);
+static int  hci_dbus_unreg_obj_path(DBusConnection *conn, int unreg_dft, uint16_t id);
+
+
+typedef const struct service_data *get_svc_table_func_t(void);
+
+struct profile_obj_path_data {
+	const char		*name;
+	int			status; /* 1:active  0:disabled */
+	int			dft_reg; /* dft path registered */
+	register_function_t     *reg_func;
+	unregister_function_t   *unreg_func;
+	get_svc_table_func_t *get_svc_table; /* return the service table */
+};
+
+/*
+ * next action: Move to /common directory
+ */
+
+static int find_conn(int s, int dev_id, long arg)
+{
+	struct hci_conn_list_req *cl;
+	struct hci_conn_info *ci;
+	int i;
+
+	if (!(cl = malloc(10 * sizeof(*ci) + sizeof(*cl)))) {
+		syslog(LOG_ERR, "Can't allocate memory");
+		return 0;
+	}
+	cl->dev_id = dev_id;
+	cl->conn_num = 10;
+	ci = cl->conn_info;
+
+	if (ioctl(s, HCIGETCONNLIST, (void *) cl)) {
+		syslog(LOG_ERR, "Can't get connection list");
+		return 0;
+	}
+
+	for (i = 0; i < cl->conn_num; i++, ci++)
+		if (!bacmp((bdaddr_t *) arg, &ci->bdaddr))
+			return 1;
+
+	return 0;
+}
+
+
+/*
+ * D-Bus error messages functions and declarations.
+ * This section should be moved to a common file 
+ * in the future
+ *
+ */
+typedef struct  {
+	uint32_t code;
+	const char *str;
+}bluez_error_t;
+
+static const bluez_error_t error_array[] = {
+	{ BLUEZ_EDBUS_UNKNOWN_METHOD,   "Method not found"},
+	{ BLUEZ_EDBUS_WRONG_SIGNATURE,  "Wrong method signature"},
+	{ BLUEZ_EDBUS_WRONG_PARAM,      "Invalid parameters"},
+	{ BLUEZ_EDBUS_RECORD_NOT_FOUND, "No record found"},
+	{ BLUEZ_EDBUS_NO_MEM, 		"No memory"},
+	{ BLUEZ_EDBUS_CONN_NOT_FOUND, 	"Connection not found"},
+	{ BLUEZ_EDBUS_UNKNOWN_PATH, 	"Device path is not registered"},
+	{ 0, 				NULL }
+};
+
+static const char *bluez_dbus_error_to_str(const uint32_t ecode) 
+{
+	const bluez_error_t *ptr;
+	uint32_t raw_code = 0;
+	
+	
+	if (ecode & BLUEZ_ESYSTEM_OFFSET) {
+		/* System error */
+		raw_code = (!BLUEZ_ESYSTEM_OFFSET) & ecode;
+		syslog(LOG_INFO, "%s - msg:%s", __PRETTY_FUNCTION__, strerror(raw_code));
+		return strerror(raw_code);
+	} else if (ecode & BLUEZ_EDBUS_OFFSET) { 
+		/* D-Bus error */
+		for (ptr = error_array; ptr->code; ptr++) {
+			if (ptr->code == ecode) {
+				syslog(LOG_INFO, "%s - msg:%s", __PRETTY_FUNCTION__, ptr->str);
+				return ptr->str;
+			}
+		}
+	}
+	return NULL;
+}
+
+static DBusMessage *bluez_new_failure_msg(DBusMessage *msg, const uint32_t ecode)
+{
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	const char *error_msg = NULL;
+	
+	error_msg = bluez_dbus_error_to_str(ecode);
+	
+	if (error_msg) {
+	
+		reply = dbus_message_new_error(msg, BLUEZ_DBUS_ERROR, error_msg);
+	
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_UINT32 ,&ecode);
+	}
+	
+	return reply;
+}
+
+/*
+ * Object path register/unregister functions 
+ *
+ */
+static struct profile_obj_path_data obj_path_table[] = {
+	{BLUEZ_HCI,       1, 0, hci_dbus_reg_obj_path,    hci_dbus_unreg_obj_path,    get_hci_table  },
+	/* add other profiles here */
+	{NULL, 0, 0, NULL, NULL, NULL}
+};
+
+/*
+ * Device Message handler functions object table declaration
+ */
+static DBusHandlerResult msg_func(DBusConnection *conn, DBusMessage *msg, void *data);
+
+static DBusMessage* handle_get_devices_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data);
+
+static const DBusObjectPathVTable obj_vtable = {
+	NULL,
+	&msg_func,
+	NULL,
+	NULL,
+	NULL,
+	NULL
+};
+
+
+/*
+ * Service provided under the path DEVICE_PATH
+ * TODO add the handlers
+ */
+static const struct service_data dev_services[] = {
+	{DEV_UP, 		handle_not_implemented_req,	DEV_UP_SIGNATURE},
+	{DEV_DOWN, 		handle_not_implemented_req,	DEV_DOWN_SIGNATURE},
+	{DEV_RESET, 		handle_not_implemented_req,	DEV_RESET_SIGNATURE },
+	{DEV_SET_PROPERTY, 	handle_not_implemented_req,	DEV_SET_PROPERTY_SIGNATURE },
+	{DEV_GET_PROPERTY, 	handle_not_implemented_req,	DEV_GET_PROPERTY_SIGNATURE },
+	{NULL, NULL, NULL}
+};
+
+/*
+ * Manager Message handler functions object table declaration
+ *
+ */
+static const struct service_data mgr_services[] = {
+	{MGR_GET_DEV,		handle_get_devices_req,		MGR_GET_DEV_SIGNATURE},
+	{MGR_INIT, 		handle_not_implemented_req, 	NULL },
+	{MGR_ENABLE,		handle_not_implemented_req, 	NULL },
+	{MGR_DISABLE,		handle_not_implemented_req,	NULL },
+	{NULL,			handle_not_implemented_req,	NULL}
+};
+
+
+/*
+ * HCI Manager Message handler functions object table declaration
+ *
+ */
+static DBusHandlerResult hci_signal_filter (DBusConnection *conn, DBusMessage *msg, void *data);
+
+static DBusMessage* handle_periodic_inq_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_inq_req(DBusMessage *msg, void *data);
+static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data);
+
+static const struct service_data hci_services[] = {
+	{HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_SIGNATURE},
+	{HCI_CANCEL_PERIODIC_INQ,	handle_cancel_periodic_inq_req,	HCI_CANCEL_PERIODIC_INQ_SIGNATURE},
+	{HCI_ROLE_SWITCH,		handle_role_switch_req,		HCI_ROLE_SWITCH_SIGNATURE},
+	{HCI_INQ,			handle_inq_req,			HCI_INQ_SIGNATURE},
+	{NULL,				NULL,				NULL}
+};
 
 static void reply_handler_function(DBusPendingCall *call, void *user_data)
 {
@@ -126,8 +336,8 @@
 	uint8_t *addr = (uint8_t *) &ci->bdaddr;
 	dbus_bool_t out = ci->out;
 
-	message = dbus_message_new_method_call(SERVICE_NAME, PATH_NAME,
-						INTERFACE_NAME, REQUEST_NAME);
+	message = dbus_message_new_method_call(PINAGENT_SERVICE_NAME, PINAGENT_PATH,
+						PINAGENT_INTERFACE, PIN_REQUEST);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Couldn't allocate D-BUS message");
 		goto failed;
@@ -165,13 +375,14 @@
 void hcid_dbus_inquiry_start(bdaddr_t *local)
 {
 	DBusMessage *message;
-	char *local_addr;	
+	char *local_addr;								
 	bdaddr_t tmp;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal("/org/bluez/DevAgent",
-				"org.bluez.DevAgent", "InquiryStart");
+	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+					  BLUEZ_HCI_INTERFACE, 
+					  BLUEZ_HCI_INQ_START);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry start message");
 		goto failed;
@@ -204,8 +415,9 @@
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal("/org/bluez/DevAgent",
-				"org.bluez.DevAgent", "InquiryComplete");
+	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+				BLUEZ_HCI_INTERFACE, 
+				BLUEZ_HCI_INQ_COMPLETE);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
 		goto failed;
@@ -241,8 +453,9 @@
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 	baswap(&tmp, peer); peer_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal("/org/bluez/DevAgent",
-				"org.bluez.DevAgent", "InquiryResult");
+	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+				BLUEZ_HCI_INTERFACE, 
+				BLUEZ_HCI_INQ_RESULT);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry result message");
 		goto failed;
@@ -280,8 +493,9 @@
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 	baswap(&tmp, peer); peer_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal("/org/bluez/DevAgent",
-				"org.bluez.DevAgent", "RemoteName");
+	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+				BLUEZ_HCI_INTERFACE,
+				BLUEZ_HCI_REMOTE_NAME);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
@@ -387,7 +601,10 @@
 gboolean hcid_dbus_init(void)
 {
 	DBusError error;
-
+	uint16_t *dev_path_id  = (uint16_t*) malloc(1);
+	uint16_t *mgr_path_id  = (uint16_t*) malloc(1);
+	num_adapters = 0;
+	
 	dbus_error_init(&error);
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, &error);
@@ -398,8 +615,796 @@
 		return FALSE;
 	}
 
+	dbus_bus_request_name(connection, BLUEZ_DBUS_NAME, 
+			      DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT, 
+			      &error);
+	
+	if (dbus_error_is_set (&error)) {
+		syslog(LOG_ERR,"D-Bus Error: %s\n", error.message);
+		dbus_error_free (&error);
+		return FALSE;
+	}
+	if (dev_path_id) {
+		*dev_path_id = DEVICE_PATH_ID;
+		//Registering the device path
+		if (!dbus_connection_register_object_path(connection, DEVICE_PATH, &obj_vtable, dev_path_id)) {
+			syslog(LOG_ERR,"DBUS failed to register %s object", DEVICE_PATH);
+			return FALSE;
+		} else {
+			syslog(LOG_INFO,"registering  -  path:%s", DEVICE_PATH);	
+		}
+
+	} else {
+		return FALSE;
+	}
+
+	//Registering the manager path
+	if (mgr_path_id) {
+		*mgr_path_id = MANAGER_PATH_ID;
+		if (!dbus_connection_register_fallback(connection, MANAGER_PATH, &obj_vtable, mgr_path_id)) {
+			syslog(LOG_ERR,"DBUS failed to register %s object", MANAGER_PATH);
+			return FALSE;
+		} else {
+			syslog(LOG_INFO,"registering  -  path:%s", MANAGER_PATH);
+		}
+	}
+
+	if (!dbus_connection_add_filter (connection, hci_signal_filter, NULL, NULL)) {
+		syslog(LOG_ERR,"DBUS failed to add filter");
+		return FALSE;
+	}
+	
 	dbus_connection_set_watch_functions(connection,
 		add_watch, remove_watch, watch_toggled, NULL, NULL);
 
 	return TRUE;
 }
+
+/*
+ * @brief This function is responsible for register all service for 
+ * each new hci device
+ * Detailed description: When a HCI_DEV_UP event is received or the
+ * daemon is initialized the service paths must be registered. eg:
+ * pan, sdp, hci, rfcomm paths.
+ * @param id device id
+ * @return TRUE/FALSE
+ */ 
+gboolean mgr_dbus_reg_device_paths(uint16_t id)
+{
+	struct profile_obj_path_data *ptr = obj_path_table;
+	int ret = -1; 
+
+	if (connection) {
+		for (;ptr->name; ptr++) {
+			ret = (ptr->reg_func(connection, ptr->dft_reg, id));
+			/* the default path is now registered */
+			ptr->dft_reg = 1;
+		}
+		
+		if (!ret)
+			num_adapters++;
+
+		return TRUE;
+	} else 
+		return FALSE;
+}
+
+/*
+ * @brief This function is responsible for unregister all service for 
+ * a detached hci device
+ * Detailed description: When a HCI_DEV_DOWN event is received the 
+ * service paths must be unregistered. eg: pan, sdp, hci, rfcomm paths.
+ * @param id device id
+ * @return TRUE/FALSE
+ */
+gboolean mgr_dbus_unreg_device_paths(uint16_t id)
+{
+	struct profile_obj_path_data *ptr = obj_path_table;
+	int dft_unreg = 0;
+	
+	if (connection) {
+		for (;ptr->name; ptr++) {
+			dft_unreg = (num_adapters > 1)? 0:1;
+			num_adapters--;
+			ptr->unreg_func(connection, dft_unreg, id);
+			
+			if (dft_unreg ) 
+				ptr->dft_reg = 0;
+		}
+		return TRUE;
+	} else 
+		return FALSE;
+}
+
+/*
+ * @brief HCI object path register function
+ * Detailed description: function responsible for register a new hci 
+ * D-Bus path. If necessary the default path must be registered too.
+ * @param conn D-Bus connection
+ * @param dft_reg register the default path(0 or !0)
+ * @param id hci device identification
+ * @return (0-Success/-1 failure)
+ */
+static int hci_dbus_reg_obj_path(DBusConnection *conn, int dft_reg, uint16_t id)
+{
+	char path[MAX_PATH_LENGTH];
+	uint16_t *ptr_id =  (int16_t*)malloc(1);
+	uint16_t *ptr_id_dft;
+	
+	/* register the default path*/
+	if (!dft_reg) {
+	 	ptr_id_dft =  (int16_t*)malloc(1);
+		*ptr_id_dft = DEFAULT_DEVICE_PATH_ID;
+		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
+	
+		syslog(LOG_INFO, "registering dft path:%s - id:%d", path, DEFAULT_DEVICE_PATH_ID);
+	
+		if (!dbus_connection_register_object_path(conn, path, &obj_vtable, ptr_id_dft)) { 
+			syslog(LOG_ERR,"DBUS failed to register %s object", path);
+			/* ignore, the default path was already registered */
+		}
+	
+	}
+	
+	*ptr_id = id;
+	
+	/* register the default path*/
+	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id ,BLUEZ_HCI);
+	
+	syslog(LOG_INFO, "registering  -  path:%s - id:%d",path, id);
+	
+	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, ptr_id)) {
+		syslog(LOG_ERR,"DBUS failed to register %s object", path);
+		/* ignore, the path was already registered */
+	}
+	
+	return 0;
+}
+
+/*
+ * @brief HCI object path unregister function
+ * Detailed description: function responsible for unregister HCI D-Bus
+ * path for a detached hci device. If necessary the default path must 
+ * be registered too.
+ * @param conn D-Bus connection
+ * @param unreg_dft register the default path(0 or !0)
+ * @param id hci device identification
+ * @return (0-Success/-1 failure)
+ */
+static int hci_dbus_unreg_obj_path(DBusConnection *conn, int unreg_dft, uint16_t id) 
+{
+	int ret = 0;
+	char path[MAX_PATH_LENGTH];
+	char dft_path[MAX_PATH_LENGTH];
+	uint16_t *data;
+	
+	if (unreg_dft) {
+		sprintf(dft_path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
+		syslog(LOG_INFO, "%s - unregistering dft:%s", __PRETTY_FUNCTION__, dft_path);
+		if (!dbus_connection_unregister_object_path (connection, dft_path)) {
+			syslog(LOG_ERR,"DBUS failed to unregister %s object", dft_path);
+			ret = -1;
+		} else {
+			if (dbus_connection_get_object_path_data(conn, dft_path, (void*)&data)) {
+				if (data) {
+					free(data);
+					data = NULL;
+				}
+			}
+		}
+		
+	}
+	
+	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
+	syslog(LOG_INFO, "%s - unregistering spec:%s", __PRETTY_FUNCTION__, path);
+	if (!dbus_connection_unregister_object_path (connection, path)) {
+		syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
+		ret = -1;
+	} else {
+		if(dbus_connection_get_object_path_data(conn, path, (void*)&data)) {
+			if (data) {
+				free(data);
+				data = NULL;
+			}
+		}
+	}
+	
+	return ret;
+}
+
+
+//const service_table_t *get_hci_table(void) 
+const struct service_data *get_hci_table(void)
+{
+	return hci_services;
+}
+/*****************************************************************
+ *  
+ *  Section reserved to HCI Manaher D-Bus message handlers
+ *  
+ *****************************************************************/
+void hcid_dbus_exit(void)
+{
+	char path[MAX_PATH_LENGTH];
+	char fst_parent[] = MANAGER_PATH;
+	char snd_parent[MAX_PATH_LENGTH];
+	char **fst_level = NULL;
+	char **snd_level = NULL;
+	char *ptr1;
+	char *ptr2;
+	uint16_t *data = NULL;
+	
+	if (!connection)
+		return;
+	/* unregister all objects paths */
+	if (dbus_connection_get_object_path_data(connection, DEVICE_PATH, (void*)&data)) {
+		if (data) {
+			free(data);
+			data = NULL;
+		}
+	}
+	if (!dbus_connection_unregister_object_path (connection, DEVICE_PATH)) 
+		syslog(LOG_ERR,"DBUS failed to unregister %s object", DEVICE_PATH);
+	else
+		syslog(LOG_INFO,"unregistering  -  path:%s", DEVICE_PATH);
+
+	if (dbus_connection_get_object_path_data(connection, MANAGER_PATH, (void*)&data)) {
+		if (data) {
+			free(data);
+			data = NULL;
+		}
+	}
+	if (!dbus_connection_unregister_object_path (connection, MANAGER_PATH))
+		syslog(LOG_ERR,"DBUS failed to unregister %s object", MANAGER_PATH);
+	else 
+		syslog(LOG_INFO,"unregistering  -  path:%s", MANAGER_PATH);
+	
+	//getting the first level
+	dbus_connection_list_registered(connection, fst_parent, &fst_level);
+	
+	for ( ;*fst_level; fst_level++) {
+		ptr1 = *fst_level;
+		sprintf(snd_parent, "%s/%s", fst_parent, ptr1);
+		
+		//getting the second level
+		dbus_connection_list_registered(connection, snd_parent, &snd_level);
+		
+		if (!(*snd_level)) {
+			//no child
+			sprintf(path, "%s/%s", MANAGER_PATH, ptr1);
+			
+			syslog(LOG_INFO, "unregistering path: %s", path);
+
+			if (dbus_connection_get_object_path_data(connection, path, (void*)&data)) {
+				if (data) {
+					free(data);
+					data = NULL;
+				}
+			}		
+			if (!dbus_connection_unregister_object_path (connection, path))
+				syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
+			
+			continue;
+		}
+		
+		for ( ;*snd_level; snd_level++) {
+			//unregistering child level path
+			ptr2 = *snd_level;
+			sprintf(path, "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
+			
+			syslog(LOG_INFO, "unregistering path: %s", path);
+
+			if (dbus_connection_get_object_path_data(connection, path, (void*)&data)) {
+				if (data) {
+					free(data);
+					data = NULL;
+				}
+			}	
+			if (!dbus_connection_unregister_object_path (connection, path))
+				syslog(LOG_ERR,"DBUS failed to unregister %s object", path);
+			
+		}
+		if (*snd_level) 
+			dbus_free_string_array(snd_level);
+	}
+	
+	if (*fst_level) 
+		dbus_free_string_array(fst_level);
+}
+
+static DBusHandlerResult hci_signal_filter (DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	const char *iface;
+	const char *method;
+
+	if (!msg || !conn)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	
+	if (dbus_message_get_type (msg) != DBUS_MESSAGE_TYPE_SIGNAL)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
+	iface = dbus_message_get_interface(msg);
+	method = dbus_message_get_member(msg);
+	
+	if (strcmp(iface, DBUS_INTERFACE_LOCAL) == 0) {
+		if (strcmp(method, "Disconnected") == 0)
+			ret = DBUS_HANDLER_RESULT_HANDLED;
+
+	} else	if (strcmp(iface, DBUS_INTERFACE_DBUS) == 0) {
+			if (strcmp(method, "NameOwnerChanged") == 0)
+				ret = DBUS_HANDLER_RESULT_HANDLED;
+			
+			if (strcmp(method, "NameAcquired") == 0)
+				ret = DBUS_HANDLER_RESULT_HANDLED;
+	}
+
+	return ret;
+}
+/*
+ * There is only one message handler function for all object paths
+ *
+ */
+
+static DBusHandlerResult msg_func(DBusConnection *conn, 
+				      DBusMessage *msg, void *data)
+{
+	const struct service_data *ptr_handlers = NULL;
+	DBusMessage *reply = NULL;
+	int type;
+	const char *iface;
+	const char *method;
+	const char *signature;
+	const char *path;
+	const char *rel_path;
+	const char *tmp_iface = NULL;
+	const uint16_t *udata = (uint16_t*)data;
+	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
+	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	uint8_t found = 0;
+	
+	
+	path = dbus_message_get_path(msg);
+	type = dbus_message_get_type(msg);
+	iface = dbus_message_get_interface(msg);
+	method = dbus_message_get_member (msg);
+	signature = dbus_message_get_signature(msg);
+	
+	syslog (LOG_INFO, "%s - path:%s, udata:0x%X", __PRETTY_FUNCTION__, path, *udata);
+	
+	if (strcmp(path, DEVICE_PATH) == 0) {
+		ptr_handlers = dev_services;
+		tmp_iface = DEVICE_INTERFACE;
+		found = 1;
+	} else {
+
+		
+		if (strcmp(path, MANAGER_PATH) > 0) {
+			/* it is device specific path */
+			if ( *udata == MANAGER_PATH_ID ) {
+				/* fallback handling. The child path IS NOT registered */
+				reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_UNKNOWN_PATH);
+				ret = DBUS_HANDLER_RESULT_HANDLED;
+			} else {
+				const struct profile_obj_path_data *mgr_child = obj_path_table;
+				rel_path = strrchr(path,'/');
+				rel_path++;
+		
+				if (rel_path) {
+					for ( ;mgr_child->name; mgr_child++) {
+						if (strcmp(mgr_child->name, rel_path) == 0) {
+							ptr_handlers = mgr_child->get_svc_table();
+							found = 1;
+						}
+					}
+			
+					tmp_iface = MANAGER_INTERFACE;
+				}
+			}
+		} else {
+			/* it's the manager path */
+			ptr_handlers = mgr_services;
+			tmp_iface = MANAGER_INTERFACE;
+			found = 1;
+		}
+	}
+
+	if (found && (type == DBUS_MESSAGE_TYPE_METHOD_CALL) && 
+		(strcmp(iface, tmp_iface) == 0) && (method != NULL)) {
+		
+		for (; ptr_handlers->name; ptr_handlers++) {
+			if (strcmp(method, ptr_handlers->name) == 0) {
+				/* resetting unknown method. It's possible handle method overload */
+				result = BLUEZ_EDBUS_WRONG_SIGNATURE; 
+				if (strcmp(ptr_handlers->signature, signature) == 0) {
+					if (ptr_handlers->handler_func) {
+						reply = (ptr_handlers->handler_func)(msg, data);
+						result = 0; /* resetting wrong signature*/
+					} else 
+						syslog(LOG_INFO, "Service not implemented");
+
+					break;
+				} 
+				
+			}
+		}
+		
+		if (result) {
+			reply = bluez_new_failure_msg(msg, result);
+		}
+		
+		/* send an error or the success reply*/
+		if (reply) {
+			if (!dbus_connection_send (conn, reply, NULL)) { 
+				syslog(LOG_ERR, "%s line:%d Can't send reply message!", \
+					__PRETTY_FUNCTION__, __LINE__) ;
+			}
+			dbus_message_unref (reply);
+		}
+		
+		ret = DBUS_HANDLER_RESULT_HANDLED;
+	}
+	return ret;
+}
+
+static DBusMessage* handle_periodic_inq_req(DBusMessage *msg, void *data)
+{
+	write_inquiry_mode_cp inq_mode;
+	periodic_inquiry_cp inq_param;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	const uint16_t *udata = (uint16_t *)data;
+	uint8_t length;
+	uint8_t max_period;
+	uint8_t min_period;
+	int sock = -1;
+	int dev_id = -1;
+
+	if (*udata == DEFAULT_DEVICE_PATH_ID) {
+		if ((dev_id = hci_get_route(NULL)) < 0) {
+			syslog(LOG_ERR, "Bluetooth device is not available");
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+			goto failed;
+		
+		}
+	} else 
+		dev_id = *udata;
+	
+			
+	if ((sock = hci_open_dev(dev_id)) < 0) {
+		syslog(LOG_ERR, "HCI device open failed");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+	
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &length);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &min_period);
+	dbus_message_iter_next(&iter);	
+	dbus_message_iter_get_basic(&iter, &max_period);
+	
+	if ((length >= min_period) || (min_period >= max_period)) {
+		  reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+		  goto failed;
+	}
+
+	inq_param.num_rsp = 100;
+	inq_param.length  = length;
+
+	inq_param.max_period = max_period;
+	inq_param.min_period = min_period;
+
+	/* General/Unlimited Inquiry Access Code (GIAC) */
+	inq_param.lap[0] = 0x33;
+	inq_param.lap[1] = 0x8b;
+	inq_param.lap[2] = 0x9e;
+
+	inq_mode.mode = 1; //INQUIRY_WITH_RSSI;
+	
+	if (hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE, 
+		WRITE_INQUIRY_MODE_CP_SIZE, &inq_mode) < 0) {
+		syslog(LOG_ERR, "Can't set inquiry mode:%s.", strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+	
+	if (hci_send_cmd(sock, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY, 
+		PERIODIC_INQUIRY_CP_SIZE, &inq_param) < 0) {
+		syslog(LOG_ERR, "Can't send HCI commands:%s.", strerror(errno));
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	} else {
+	
+		uint8_t result = 0;
+		/* return TRUE to indicate that operation was completed */
+		reply = dbus_message_new_method_return(msg);
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE ,&result);
+	}
+	
+failed:
+
+	if (sock > 0)
+		close(sock);
+	
+	return reply;
+}
+
+static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	const uint16_t *udata = (uint16_t *)data;
+	int sock = -1;
+	int dev_id = -1;
+	
+	if (*udata == DEFAULT_DEVICE_PATH_ID) {
+		if ((dev_id = hci_get_route(NULL)) < 0) {
+			syslog(LOG_ERR, "Bluetooth device is not available");
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+			goto failed;
+		
+		}
+	} else 
+		dev_id = *udata;
+	
+	
+	if ((sock = hci_open_dev(dev_id)) < 0) {
+		syslog(LOG_ERR, "HCI device open failed");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+	
+	if (hci_send_cmd(sock, OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY, 0 , NULL) < 0) {
+		syslog(LOG_ERR, "Send hci command failed.");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+	} else  {
+		uint8_t result  = 0;
+		/* return TRUE to indicate that operation was completed */
+		reply = dbus_message_new_method_return(msg);
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE ,&result);
+	}
+	
+failed:
+	if (sock > 0)
+		close(sock);
+	
+	return reply;
+}
+
+static DBusMessage* handle_inq_req(DBusMessage *msg, void *data)
+{
+	char addr[18];
+	const char array_sig[] = HCI_INQ_REPLY_SIGNATURE;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessageIter  struct_iter;
+	DBusMessage *reply = NULL;
+	inquiry_info *info = NULL;
+	const uint16_t *udata = (uint16_t *)data;
+	const char *paddr = addr;
+	int dev_id = -1;
+	int i;
+	uint32_t class = 0;
+	uint16_t clock_offset;
+	uint16_t flags;
+	int8_t length;
+	int8_t num_rsp;
+
+
+	if (*udata == DEFAULT_DEVICE_PATH_ID) {
+		if ((dev_id = hci_get_route(NULL)) < 0) {
+			syslog(LOG_ERR, "Bluetooth device is not available");
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+			goto failed;
+		}
+	} else 
+		dev_id = *udata;
+	
+	
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &length);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &num_rsp);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &flags);
+	
+	if ((length <= 0) || (num_rsp <= 0)) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+		goto failed;
+	}
+	
+	num_rsp = hci_inquiry(dev_id, length, num_rsp, NULL, &info, flags);
+	
+	if (num_rsp < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+	} else {
+		reply = dbus_message_new_method_return(msg);
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
+		
+	        for (i = 0; i < num_rsp; i++) {
+			ba2str(&(info+i)->bdaddr, addr);
+
+			clock_offset = btohs((info+i)->clock_offset);
+                        /* only 3 bytes are used */
+			memcpy(&class, (info+i)->dev_class, 3);
+			
+			dbus_message_iter_open_container(&array_iter, DBUS_TYPE_STRUCT, NULL, &struct_iter);
+			dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING , &paddr);
+			dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT32 , &class);
+			dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_UINT16 , &clock_offset);
+			dbus_message_iter_close_container(&array_iter, &struct_iter);
+	}
+        	dbus_message_iter_close_container(&iter, &array_iter);
+        }
+
+failed:
+	if(info)
+		bt_free(info);
+	
+	return NULL;
+}
+
+static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	char *str_bdaddr = NULL;
+	const uint16_t *udata = (uint16_t *)data;
+	bdaddr_t bdaddr;
+	uint8_t role;
+	int dev_id = -1;
+	int sock = -1;
+	
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &str_bdaddr);
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &role);
+	
+	str2ba(str_bdaddr, &bdaddr);
+	
+	dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
+	
+	
+	if (dev_id < 0) {
+		syslog(LOG_ERR, "Bluetooth device failed\n");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+	
+	if (*udata != DEFAULT_DEVICE_PATH_ID && *udata != dev_id) {
+		syslog(LOG_ERR, "Connection not found\n");
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_CONN_NOT_FOUND);
+		goto failed;
+	}
+
+
+	sock = hci_open_dev(dev_id);
+	
+	if (sock < 0) {
+		syslog(LOG_ERR, "HCI device open failed\n");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+		goto failed;
+	}
+
+	if (hci_switch_role(sock, &bdaddr, role, 10000) < 0) {
+		syslog(LOG_ERR, "Switch role request failed\n");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+	} else {
+		uint8_t result = 0;
+		/* return TRUE to indicate that operation was completed */
+		reply = dbus_message_new_method_return(msg);
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &result);
+	}
+failed:
+	
+	return reply;
+}
+
+
+/*****************************************************************
+ *  
+ *  Section reserved to Device D-Bus message handlers
+ *  
+ *****************************************************************/
+static DBusMessage* handle_get_devices_req(DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	DBusMessageIter  struct_iter;
+	DBusMessage *reply = NULL;
+	
+	struct hci_dev_list_req *dl = NULL;
+	struct hci_dev_req *dr      = NULL;
+	struct hci_dev_info di;
+	int i;
+	int sock = -1;
+	
+	char aname[BLUETOOTH_DEVICE_NAME_LEN];
+	char aaddr[BLUETOOTH_DEVICE_ADDR_LEN];
+	char *paddr = aaddr;
+	char *pname = aname;
+	const char array_sig[] = HCI_DEVICE_STRUCT_SIGNATURE;
+	
+	
+        /* Create and bind HCI socket */
+        if ((sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0) {
+                syslog(LOG_ERR, "Can't open HCI socket: %s (%d)",
+                	strerror(errno), errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+        }
+
+
+	dl = malloc(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
+	
+	if (!dl) {
+		syslog(LOG_ERR, "Can't allocate memory");
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
+		goto failed;
+	}
+
+	dl->dev_num = HCI_MAX_DEV;
+	dr = dl->dev_req;
+
+	if (ioctl(sock, HCIGETDEVLIST, (void *) dl) < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		goto failed;
+	}
+
+	
+	/* active bluetooth adapter found */
+	reply = dbus_message_new_method_return(msg);
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, array_sig, &array_iter);
+	dr = dl->dev_req;
+	
+	for (i = 0; i < dl->dev_num; i++, dr++) {
+		if (hci_test_bit(HCI_UP, &dr->dev_opt)) {
+			memset(&di, 0 , sizeof(struct hci_dev_info));
+			di.dev_id = dr->dev_id;
+				
+			if (!ioctl(sock, HCIGETDEVINFO, (void *) &di)) {
+				strcpy(aname, di.name);
+				ba2str(&di.bdaddr, aaddr);
+				dbus_message_iter_open_container(&array_iter, DBUS_TYPE_STRUCT, NULL,
+						&struct_iter);
+				dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING ,&pname);
+				dbus_message_iter_append_basic(&struct_iter, DBUS_TYPE_STRING ,&paddr);
+				
+				dbus_message_iter_close_container(&array_iter, &struct_iter);
+			}
+		}
+	}
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+failed:
+	if (dl)
+		free(dl);
+	
+	if (sock > 0)
+		close (sock);
+	
+	return reply;
+}
+
+static DBusMessage* handle_not_implemented_req(DBusMessage *msg, void *data) 
+{
+	const char *path;
+	const char *iface;
+	const char *method;
+	
+	path = dbus_message_get_path(msg);
+	iface = dbus_message_get_interface(msg);
+	method = dbus_message_get_member(msg);
+	
+	syslog(LOG_INFO, "Not Implemented - path:%s, iface:%s method:%s", path, iface, method);
+	
+	return NULL;
+
+}
+
--- bluez-utils-cvs.orig/hcid/main.c	2005-07-05 18:15:44.000000000 -0300
+++ bluez-utils-cvs-hcid/hcid/main.c	2005-10-03 10:58:28.000000000 -0300
@@ -375,6 +375,9 @@
 
 		if (hcid.security && hci_test_bit(HCI_UP, &dr->dev_opt))
 			start_security_manager(dr->dev_id);
+#ifdef ENABLE_DBUS
+			mgr_dbus_reg_device_paths(dr->dev_id);
+#endif
 	}
 
 	free(dl);
@@ -438,12 +441,18 @@
 			configure_device(sd->dev_id);
 		if (hcid.security)
 			start_security_manager(sd->dev_id);
+#ifdef ENABLE_DBUS
+		mgr_dbus_reg_device_paths(sd->dev_id);
+#endif
 		break;
 
 	case HCI_DEV_DOWN:
 		syslog(LOG_INFO, "HCI dev %d down", sd->dev_id);
 		if (hcid.security)
 			stop_security_manager(sd->dev_id);
+#ifdef ENABLE_DBUS
+		mgr_dbus_unreg_device_paths(sd->dev_id);
+#endif
 		break;
 	}
 }
@@ -627,7 +636,9 @@
 	g_main_run(event_loop);
 
 	free_device_opts();
-
+#ifdef ENABLE_DBUS	
+	hcid_dbus_exit();
+#endif
 	syslog(LOG_INFO, "Exit.");
 	return 0;
 }

------=_Part_1968_14280888.1128609081737--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
