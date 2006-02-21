Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602211009k215f066n3ca6ef20d321d362@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] RemoveBonding
In-Reply-To: <1140541511.22767.11.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_15517_20874580.1140545399094"
References: <e1effdeb0602210649n3f391d0bgb3b6192e60ac083a@mail.gmail.com>
	 <1140541511.22767.11.camel@localhost>
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
Date: Tue, 21 Feb 2006 15:09:59 -0300

------=_Part_15517_20874580.1140545399094
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Your suggestions are done!

Regarding the disconnect timeout, I tested with 100ms. It is working,
but is it enough?


On 2/21/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here is the patch to remove bondings.
> >
> > Please check the logic. I read the BlueZ D-Bus API and the Bluetooth
> > Spec, but I am not complete sure if I am covering all scenarios.
>
> the logic looks fine to me. However it is not that important at the
> moment, because we can sort out the details later.
>
> Some small notes. The textfile_get() is not needed. Simply delete the
> link key. If it fails, because it doesn't exists, this is fine. And use
> hci_disconnect() instead of implementing it by yourself.
[Claudio Takahasi]
I didn't use hci_disconnect and hci_delete_stored_link_keys to get the
error reason.


>
> > Regarding the HCI disconnect complete event, I think we need notify
> > the connected applications sending a D-Bus signal. What do you think?
>
> We need to inform applications about the disconnect, but this is not the
> job of this method. It will be done by other routines inside hcid.
[Claudio Takahasi]
Ok. I will write in my TODO list.


Regards,
Claudio
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

------=_Part_15517_20874580.1140545399094
Content-Type: text/x-patch; name=remove-bonding02.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejycpflb
Content-Disposition: attachment; filename="remove-bonding02.patch"

--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-20 14:52:10.000000000 -0300
+++ bluez-utils-cvs-remove-bonding/hcid/dbus-device.c	2006-02-21 11:58:16.000000000 -0300
@@ -791,8 +791,73 @@
 
 static DBusMessage* handle_dev_remove_bonding_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	char filename[PATH_MAX + 1];
+	char addr[18];
+	DBusMessageIter iter;
+	bdaddr_t bdaddr;
+	struct hci_dbus_data *dbus_data = data;
+	struct hci_conn_info_req *cr = NULL;
+	DBusMessage *reply = NULL;
+	const char *addr_ptr;
+	int dd;
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0)
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+
+	get_device_address(dbus_data->dev_id, addr, sizeof(addr));
+
+	snprintf(filename, PATH_MAX, "%s/%s/linkkeys", STORAGEDIR, addr);
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &addr_ptr);
+
+	/* delete the link key from linkkeys file */
+	textfile_del(filename, addr_ptr);
+
+	str2ba(addr_ptr, &bdaddr);
+
+	/* delete the key stored in the Bluetooth Controller */
+	if (hci_delete_stored_link_key(dd, &bdaddr, 0, 100) < 0) {
+		syslog(LOG_ERR, "Can't delete stored link keys");
+		/* ignore failures and try disconnect */
+	}
+
+	/* close active connections for the remote device */
+	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
+	if (!cr) {
+		syslog(LOG_ERR, "Can't allocate memory");
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
+		goto failed;
+	}
+
+	bacpy(&cr->bdaddr, &bdaddr);
+	cr->type = ACL_LINK;
+	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
+		/* Ignore when there isn't active connections, return success */
+		syslog(LOG_INFO, "skipping: there isn't active connections or get connection info failed");
+		reply = dbus_message_new_method_return(msg);
+		goto failed;
+	}
+
+	/* send the disconnect HCI command */
+	if (hci_disconnect(dd, htobs(cr->conn_info->handle), HCI_OE_USER_ENDED_CONNECTION, 100) < 0) {
+		syslog(LOG_ERR, "Disconnect failed");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+
+	if (cr)
+		free(cr);
+
+	return reply;
+
 }
 
 static DBusMessage* handle_dev_pin_code_length_req(DBusMessage *msg, void *data)

------=_Part_15517_20874580.1140545399094--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
