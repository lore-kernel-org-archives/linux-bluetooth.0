Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602200558l7946fa17ubdb3042e5014dc9e@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BondingCreated && BondingFailed
In-Reply-To: <1140201999.4747.16.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3346_6802621.1140443937984"
References: <e1effdeb0602171007p5c34580ahe93f1023694b68e5@mail.gmail.com>
	 <1140201999.4747.16.camel@aeonflux.holtmann.net>
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
Date: Mon, 20 Feb 2006 10:58:57 -0300

------=_Part_3346_6802621.1140443937984
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,


On 2/17/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here is another small patch...
> >
> > According with the BlueZ D-Bus API the bonding result must be sent
> > using the BondingCreated and BondingFailed signals.
> >
> > In the current code, the bonding result the status is added in the
> > signal argument.
>
> do something like
>
> signal =3D status ? DEV_SIG_BONDING_CREATED : DEV_SIG_BONDING_FAILED;
>
> and then call it with dbus_message_new_signal(..., signal).
>
> This end up in cleaner code and is easier to understand later.
[Claudio Takahasi]
Modification done!

>
> > The next step is start the development of the missing bonding
> > services: RemoveBonding, HasBonding and ListBonding.
>
> The textfile library should have all stuff for it all ready. So it
> should be really easy to add.
[Claudio Takahasi]
I've never checked the textfile functions. I will try understand the
implemented functions and send you new patches soon.

Regards,
Claudio.

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

------=_Part_3346_6802621.1140443937984
Content-Type: text/x-patch; name=bonding-signal01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejwo1cwz
Content-Disposition: attachment; filename="bonding-signal01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-17 15:57:24.000000000 -0200
+++ bluez-utils-cvs-bonding/hcid/dbus.c	2006-02-20 07:39:56.000000000 -0300
@@ -453,6 +453,7 @@
 {
 	DBusMessage *message = NULL;
 	char *local_addr, *peer_addr;
+	const char *name;
 	bdaddr_t tmp;
 	char path[MAX_PATH_LENGTH];
 	int id;
@@ -468,17 +469,21 @@
 
 	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
-	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
-						DEV_SIG_BONDING_CREATED);
+	/*
+	 * 0x00: authentication request successfully completed
+	 * 0x01-0x0F: authentication request failed
+	 */
+	name = ( !status? DEV_SIG_BONDING_CREATED : DEV_SIG_BONDING_FAILED);
+
+	message = dbus_message_new_signal(path, DEVICE_INTERFACE, name);
+
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
 		goto failed;
 	}
 
-	/*FIXME: create the signal based on status value - BondingCreated or BondingFailed*/
 	dbus_message_append_args(message,
 					DBUS_TYPE_STRING, &peer_addr,
-					DBUS_TYPE_BYTE, &status,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {




------=_Part_3346_6802621.1140443937984--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
