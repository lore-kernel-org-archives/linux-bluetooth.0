Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602150918y7b8ce5a8xe0cad1c72aa53a5e@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode timeout
In-Reply-To: <e1effdeb0602150831j55ae6d68p856bbc3761ecab00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3873_25127492.1140023891655"
References: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
	 <1140013222.26072.80.camel@localhost>
	 <e1effdeb0602150831j55ae6d68p856bbc3761ecab00@mail.gmail.com>
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
Date: Wed, 15 Feb 2006 15:18:11 -0200

------=_Part_3873_25127492.1140023891655
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is patch to get/set the discoverable timeout.
Currently, there isn't verification for a valid value range. Do you
think that it is required?
Should we define a minimum and a maximum value?


I will send the next part(timer) soon.

Regards,
Claudio.


On 2/15/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi Marcel,
>
> On 2/15/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Claudio,
> >
> > > Here is the first proposal to support the discoverable timeout.
> > >
> > > Current behaviour:
> > > * it's using SIGALARM. We can try integrate in the main loop in the f=
uture..
> > > * the scan mode is changed automatically to connectable mode after 3 =
min
> > > * multiple local adapters are handled: there are separated timers.
> > > * scan mode changes requested by other applications(hciconfig and
> > > other dbus clients) are monitored too.
> > >
> > >
> > > Some points to things about:
> > > * bluez_timeout_add consider the function handler and the user data t=
o
> > > compare if it's necessary update or add new timer. Is this approach
> > > acceptable?
> > > * Is it necessary handle race condition when updating the timeout arr=
ay?
> > > * 8 positions to timeout handler are enough?
> > >
> > > Any comments?
> >
> > maybe you wanna separate the {Set|Get}DiscoverableTimeout code, because
> > this is obviously correct and would apply right away.
> [Claudio Takahasi]
> Ok. I will split into two patches.
>
> >
> > Using an array of 8 handles is actually not enough. Even if no sane
> > person would ever attach more than 8 dongles, but I might do ;)
> >
> > However you need at least to support HCI_MAX_DEV from hci.h and this is
> > currently 16 adapters. Remember that the kernel will still accept more
> > than 16 device, but the userspace simply can't handle them (except you
> > recompile the Bluetooth library).
> [Claudio Takahasi]
> ok. I will fix it.
> >
> > Do we have a function to iterate over the registered device paths and
> > retrieve their hci_dbus_data structures? If yes, then I would prefer to
> > include everything from timeout_settings there and use it.
> [Claudio Takahasi]
> It's possible store in the dbus path data. Using the function
> "dbus_connection_get_object_path_data(DBusConnection, path, user
> data)" it's possible retrieve the data associated to one device. I
> will try propose someting soon.
>
> Regards,
> Claudio
>
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
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

------=_Part_3873_25127492.1140023891655
Content-Type: text/x-patch; name=timeout02.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejpq4eyu
Content-Disposition: attachment; filename="timeout02.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2006-02-14 05:37:57.000000000 -0200
+++ bluez-utils-cvs-disc-timeout/hcid/dbus.h	2006-02-15 11:59:12.000000000 -0200
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
--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-14 05:37:57.000000000 -0200
+++ bluez-utils-cvs-disc-timeout/hcid/dbus-device.c	2006-02-15 12:02:43.000000000 -0200
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
+					 DBUS_TYPE_UINT32, &dbus_data->discoverable_timeout,
+					 DBUS_TYPE_INVALID);
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
@@ -328,8 +336,19 @@
 
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
+	dbus_data->discoverable_timeout = timeout;
+
+	reply = dbus_message_new_method_return(msg);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_set_mode_req(DBusMessage *msg, void *data)
@@ -341,7 +360,7 @@
 	const char* scan_mode;
 	uint8_t hci_mode;
 	uint8_t status = 0;
-	const uint8_t current_mode = dbus_data->path_data;
+	const uint8_t current_mode = dbus_data->mode;
 
 	dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_STRING, &scan_mode,
--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-14 05:37:57.000000000 -0200
+++ bluez-utils-cvs-disc-timeout/hcid/dbus.c	2006-02-15 11:43:34.000000000 -0200
@@ -224,6 +224,8 @@
 
 	data->path_id = path_id;
 	data->dev_id = dev_id;
+	data->mode = MODE_OFF;
+	data->discoverable_timeout = DFT_DISCOVERABLE_TIMEOUT;
 
 	if (fallback) {
 		if (!dbus_connection_register_fallback(connection, path, pvtable, data)) {
@@ -309,7 +311,7 @@
 	if (!dbus_connection_get_object_path_data(connection, path, (void*) &pdata))
 		syslog(LOG_ERR, "Getting path data failed!");
 	else
-		pdata->path_data = rp.enable; /* Keep the current scan status */
+		pdata->mode = rp.enable; /* Keep the current scan status */
 
 	message = dbus_message_new_signal(MANAGER_PATH, MANAGER_INTERFACE,
 							BLUEZ_MGR_DEV_ADDED);
@@ -1096,7 +1098,7 @@
 	}
 
 	/* update the current scan mode value */
-	pdata->path_data = rp.enable;
+	pdata->mode = rp.enable;
 
 	switch (rp.enable) {
 	case SCAN_DISABLED:


------=_Part_3873_25127492.1140023891655--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
