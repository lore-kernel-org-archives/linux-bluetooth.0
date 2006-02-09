Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602090555u507a1567tb0b3dcb8b1369f1a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS] remote name patch
In-Reply-To: <1138298602.5901.78.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12384_31495989.1139493326466"
References: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
	 <1137808123.20856.122.camel@localhost>
	 <e1effdeb0601230833t25905a64he7ca62c7d1ab48cf@mail.gmail.com>
	 <1138036115.7327.14.camel@localhost>
	 <e1effdeb0601231054q2a3e1ec1q6f0e2c90a48c05e3@mail.gmail.com>
	 <1138047251.3750.6.camel@localhost.localdomain>
	 <e1effdeb0601260609n644c313u91d193b8f5df89bb@mail.gmail.com>
	 <1138298602.5901.78.camel@localhost>
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
Date: Thu, 9 Feb 2006 11:55:26 -0200

------=_Part_12384_31495989.1139493326466
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

According with your request, I am sending the patch again.
The function get_device_name should be moved to a common library.

Basically, this patch try retrieve the remote name from the
cache(names file) instead of send the HCI command everytime.

Regards,
Claudio.

On 1/26/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > > > > Regarding the name, we might simply say the hcid/bluetoothd alway=
s sends
> > > > > a remote name signal if something changes. So it might get the sh=
ort
> > > > > name from the extended inquiry first and after that it receives t=
he full
> > > > > remote name. We can also always send the cached name and we updat=
e that
> > > > > name on every service discovery, because then it is at zero cost.
> > > >
> > > > The remote name is triggered by D-Bus clients. hcid/bluetoothd does=
n't
> > > > request the remote when the inquiry finishes. For EIR, are you
> > > > suggesting send the "InquiryResult" signal followed by a "RemoteNam=
e"?
> > >
> > > this sounds like a sane and backward compatible way of doing this.
> >
> > I did some tests and discovered that if we add extra fields at the
> > ending we can keep the
> > backward compatibility if applications check the signature partially.
> > The functions dbus_message_get_args and dbus_message_get_basic can be
> > used to extract the first three signal fields(bdaddr, class, rssi)
> > without broke. For python applications add an extra signal handler
> > function with the new signature is enough.
> >
> > Therefore, we have another option: Add the name at the ending of the
> > "InquiryResult" signal arguments.
>
> even if I wrote a backward compatibility, I actually don't care, because
> I mentioned sometimes that I don't consider the D-Bus stable unless we
> at least have D-Bus 1.0 finally released.
>
> > > > If we send the "RemoteName" with the short name, probably D-Bus
> > > > clients will not request the RemoteName to retrieve the complete na=
me.
> > > > D-Bus clients should not distinguish short/complete name.
> > >
> > > It is up to hcid/bluetoothd to update the remote when the client
> > > requests a service discovery.
> > >
> > > > Regarding the RemoteName request service signature. Do you agree wi=
th
> > > > my initial proprosal? (see the first e-mail sent: have an alternati=
ve
> > > > to force send the HCI remote name and another using the cache)
> > >
> > > No. We don't need any extra stuff. The client asks for a name and we
> > > give them a name. That's it and all the rest is implementation specif=
ic
> > > to hcid/bluetoothd.
> >
> > Sorry I didn't understand your proposal. Which logic do you want?
> > When the hcid/bluetoothd receives the RemoteName(bdaddr) request,
> > which steps should be done?
> >
> > This is the patch approach:
> > name =3D get_device_name(local, bdaddr); /* retrieving from names file =
*/
> > if (name =3D=3D NULL) {
> >    /* send HCI remote name request */
> > }
> > ...
> > Which modifications must be done on this patch?
>
> If the client ask for a name and we have a cached one, it gets the
> cached name. If we don't have a cached name hcid/bluetoothd will take
> care of filling the cache.
>
> The same applies to the device discovery. If we don't get any EIR
> information it is the job of hcid/bluetoothd to fill the name cache.
>
> > > > > So we have one device name. This maybe a cached, a remote or a sh=
ortened
> > > > > name. The application doesn't really have to care and it gets upd=
ates as
> > > > > soon as hcid/bluetoothd knows them.
> > > > >
> > > > > Besides the device name, we should implement an alias name. This =
name is
> > > > > associated with the BD_ADDR and can be changed by the user if he/=
she
> > > > > doesn't like the device name. Implementing this alias through the=
 D-Bus
> > > > > interface makes it available for all applications and we can stor=
e the
> > > > > aliases in /var/lib/bluetooth/<bdaddr>/aliases.
> > > >
> > > > When a client requests a RemoteName, which value should be returned=
?
> > > > The value stored in the aliases file or the value stored in the nam=
es
> > > > file? Or are you suggesting create a property
> > > > "GetProperty("alias")/SetProperty("alias", "value")?
> > >
> > > When they request the remote name or device name, then they get the
> > > device name that is valid at the moment. This will maybe a cached nam=
e,
> > > but that doesn't matter. If hcid/bluetoothd knows better they will se=
nd
> > > out a remote name signal to tell them.
> > >
> > > The alias name is totally different and independent. It is applicatio=
n
> > > choice to use the alias name or not. If the alias name is empty they =
can
> > > use the remote/device name.
> >
> > Is there someone working on this stuff?
>
> Not that I know of.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_12384_31495989.1139493326466
Content-Type: text/x-patch; name=remote_name_cache02.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejgyb9kg
Content-Disposition: attachment; filename="remote_name_cache02.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-07 23:22:31.000000000 -0200
+++ bluez-utils-cvs-remotename/hcid/dbus.c	2006-02-09 08:43:46.000000000 -0200
@@ -45,6 +45,7 @@
 
 #include "hcid.h"
 #include "dbus.h"
+#include "textfile.h"
 
 #ifndef DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT
 #define DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT	0x00
@@ -98,6 +99,19 @@
 	unregister_function_t	*unreg_func;
 	get_svc_table_func_t	*get_svc_table;	/* return the service table */
 };
+/*
+ * Utility functions
+ */
+static char *get_device_name(const bdaddr_t *local, const bdaddr_t *peer)
+{
+	char filename[PATH_MAX + 1], addr[18];
+
+	ba2str(local, addr);
+	snprintf(filename, PATH_MAX, "%s/%s/names", STORAGEDIR, addr);
+
+	ba2str(peer, addr);
+	return textfile_get(filename, addr);
+}
 
 /*
  * D-Bus error messages functions and declarations.
@@ -1707,50 +1721,92 @@
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
 {
 	DBusMessage *reply = NULL;
+	DBusMessage *signal = NULL;
 	struct hci_dbus_data *dbus_data = data;
-	int dd = -1;
 	const char *str_bdaddr;
+	char *name;
+	char path[MAX_PATH_LENGTH];
 	bdaddr_t bdaddr;
+	struct hci_dev_info di;
 	struct hci_request rq;
 	remote_name_req_cp cp;
 	evt_cmd_status rp;
+	int dd = -1;
 
 	dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_STRING, &str_bdaddr,
 					DBUS_TYPE_INVALID);
 
 	str2ba(str_bdaddr, &bdaddr);
-
-	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s (%d)",
-					dbus_data->dev_id, strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+	if (hci_devinfo(dbus_data->dev_id, &di) < 0) {
+		syslog(LOG_ERR, "Can't get device info");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 		goto failed;
 	}
 
-	memset(&cp, 0, sizeof(cp));
-	cp.bdaddr = bdaddr;
-	cp.pscan_rep_mode = 0x01;
+	/* Try retrieve from local cache */
+	name = get_device_name(&di.bdaddr, &bdaddr);
+	if (name) {
 
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_REMOTE_NAME_REQ;
-	rq.cparam = &cp;
-	rq.clen   = REMOTE_NAME_REQ_CP_SIZE;
-	rq.rparam = &rp;
-	rq.rlen   = EVT_CMD_STATUS_SIZE;
-	rq.event  = EVT_CMD_STATUS;
+		reply = dbus_message_new_method_return(msg);
 
-	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Unable to send remote name request: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
+		snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, dbus_data->dev_id, BLUEZ_HCI);
+
+		signal = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
+						 BLUEZ_HCI_REMOTE_NAME);
+
+		dbus_message_append_args(signal,
+					 DBUS_TYPE_STRING, &str_bdaddr,
+					 DBUS_TYPE_STRING, &name,
+					 DBUS_TYPE_INVALID);
+
+		if (dbus_connection_send(connection, signal, NULL) == FALSE) {
+			syslog(LOG_ERR, "Can't send D-BUS remote name signal message");
+			goto failed;
+		}
+
+		dbus_message_unref(signal);
+		free(name);
+
+	} else {
+
+		/* Send HCI command */
+		dd = hci_open_dev(dbus_data->dev_id);
+		if (dd < 0) {
+			syslog(LOG_ERR, "Unable to open device %d: %s (%d)",
+						dbus_data->dev_id, strerror(errno), errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+			goto failed;
+		}
+
+		memset(&cp, 0, sizeof(cp));
+		cp.bdaddr = bdaddr;
+		cp.pscan_rep_mode = 0x01;
+
+		memset(&rq, 0, sizeof(rq));
+		rq.ogf    = OGF_LINK_CTL;
+		rq.ocf    = OCF_REMOTE_NAME_REQ;
+		rq.cparam = &cp;
+		rq.clen   = REMOTE_NAME_REQ_CP_SIZE;
+		rq.rparam = &rp;
+		rq.rlen   = EVT_CMD_STATUS_SIZE;
+		rq.event  = EVT_CMD_STATUS;
+
+		if (hci_send_req(dd, &rq, 100) < 0) {
+			syslog(LOG_ERR, "Unable to send remote name request: %s (%d)",
+						strerror(errno), errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+			goto failed;
+		}
+
+		if (rp.status) {
+			syslog(LOG_ERR, "Remote name request failed");
+			reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | rp.status);
+			goto failed;
+		}
 	}
 
 	reply = dbus_message_new_method_return(msg);
-
 failed:
 	if (dd >= 0)
 		hci_close_dev(dd);

------=_Part_12384_31495989.1139493326466--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
