Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510180413m6f88b23etdf98e16c530dbc4e@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net, Claudio Takahasi <cktakahasi@gmail.com>
Subject: Re: [Bluez-devel] [DBUS-PATCH] new signals(DeviceAdded and DeviceRemoved)
In-Reply-To: <20051018071545.GA7228@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7264_1998123.1129634013164"
References: <e1effdeb0510171437w1a668500kf963ae3acb55eb2f@mail.gmail.com>
	 <20051018071545.GA7228@localhost.localdomain>
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
Date: Tue, 18 Oct 2005 09:13:33 -0200

------=_Part_7264_1998123.1129634013164
Content-Type: multipart/alternative;
	boundary="----=_Part_7265_28025215.1129634013165"

------=_Part_7265_28025215.1129634013165
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

done!

I removed the handle_inq_reply reply message fix to avoid
conflict with the latest Johan's patch.

Regards,
Claudio.

On 10/18/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
>
> Hi Claudio,
>
> I think you forgot to attach the actual path to your previous email.
> However, before sending it I would suggest removing the
> handle_inquiry_req reply fix since my patch fixes that also (so the
> patches will most likely conflict).
>
> Johan
>

------=_Part_7265_28025215.1129634013165
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

done!<br>
<br>
I removed the handle_inq_reply reply message fix to avoid <br>
conflict with the latest Johan's patch.<br>
<br>
Regards,<br>
Claudio.<br><br><div><span class=3D"gmail_quote">On 10/18/05, <b class=3D"g=
mail_sendername">Johan Hedberg</b> &lt;<a href=3D"mailto:johan.hedberg@noki=
a.com">johan.hedberg@nokia.com</a>&gt; wrote:</span><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>I think you forgot to attach the actual path to your pre=
vious email.<br>However, before sending it I would suggest removing the<br>=
handle_inquiry_req reply fix since my patch fixes that also (so the<br>
patches will most likely conflict).<br><br>Johan<br></blockquote></div><br>=
<br>

------=_Part_7265_28025215.1129634013165--

------=_Part_7264_1998123.1129634013164
Content-Type: application/octet-stream; name=new_signals_02.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="new_signals_02.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-17 18:16:53.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-18 08:08:10.000000000 -0200
@@ -111,12 +111,16 @@
 #define BLUEZ_HCI_PATH			MANAGER_PATH "/" BLUEZ_HCI
 #define BLUEZ_HCI_INTERFACE		MANAGER_INTERFACE "." BLUEZ_HCI
 
-//HCI signals
+//Device based HCI signals
 #define BLUEZ_HCI_INQ_START		"InquiryStart"
 #define BLUEZ_HCI_INQ_COMPLETE		"InquiryComplete"
 #define BLUEZ_HCI_INQ_RESULT		"InquiryResult"
 #define BLUEZ_HCI_REMOTE_NAME		"RemoteName"
 
+//HCI signals sent in the BLUEZ_HCI_PATH
+#define BLUEZ_HCI_DEV_ADDED		"DeviceAdded"
+#define BLUEZ_HCI_DEV_REMOVED		"DeviceRemoved"
+
 //HCI Provided services
 #define HCI_PERIODIC_INQ		"PeriodicInquiry"
 #define HCI_CANCEL_PERIODIC_INQ		"CancelPeriodic"
@@ -169,6 +173,7 @@
 							DBUS_STRUCT_END_CHAR_AS_STRING\
 							__END_SIG__
 
+
 /* BLUEZ_DBUS_ERROR 
  * EFailed error messages signature is : su
  * Where the first argument is a string(error message description),
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-17 18:16:38.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-18 08:05:43.000000000 -0200
@@ -743,7 +743,11 @@
 
 gboolean hcid_dbus_register_device(uint16_t id)
 {
+	char dev[BLUETOOTH_DEVICE_NAME_LEN];
 	struct profile_obj_path_data *ptr = obj_path_table;
+	DBusMessage *message = NULL;
+	const char *pdev = dev;
+	DBusMessageIter iter;
 	int ret = -1; 
 
 	if (!connection)
@@ -757,12 +761,43 @@
 	if (!ret)
 		num_adapters++;
 
+
+	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+			BLUEZ_HCI_INTERFACE, BLUEZ_HCI_DEV_ADDED);
+
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
+		goto failed;
+	}
+
+	sprintf(dev, "hci%d", id);
+
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS added device message");
+		goto failed;
+	}
+
+	dbus_connection_flush(connection);
+
+failed:
+	/* if the signal can't be sent ignore the error */
+
+	if (message)
+		dbus_message_unref(message);
+
 	return TRUE;
 }
 
 gboolean hcid_dbus_unregister_device(uint16_t id)
 {
+	char dev[BLUETOOTH_DEVICE_NAME_LEN];
 	struct profile_obj_path_data *ptr = obj_path_table;
+	DBusMessage *message = NULL;
+	const char *pdev = dev;
+	DBusMessageIter iter;
 	int dft_unreg = 0;
 
 	if (!connection)
@@ -777,6 +812,33 @@
 			ptr->dft_reg = 0;
 	}
 
+
+	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+			BLUEZ_HCI_INTERFACE, BLUEZ_HCI_DEV_REMOVED);
+
+	if (message == NULL) {
+		syslog(LOG_ERR, "Can't allocate D-BUS device removed  message");
+		goto failed;
+	}
+
+	sprintf(dev, "hci%d", id);
+
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
+
+	if (dbus_connection_send(connection, message, NULL) == FALSE) {
+		syslog(LOG_ERR, "Can't send D-BUS removed device message");
+		goto failed;
+	}
+
+	dbus_connection_flush(connection);
+
+failed:
+	/* if the signal can't be sent ignore the error */
+
+	if (message)
+		dbus_message_unref(message);
+
 	return TRUE;
 }
 


------=_Part_7264_1998123.1129634013164--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
