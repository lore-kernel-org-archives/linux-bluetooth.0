Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511030641k5b2dc809r3c76a146e0c5259c@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] more cleanup
In-Reply-To: <1131026420.6634.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3821_9262300.1131028875439"
References: <e1effdeb0511030532w61ccb889haee2e766a631f618@mail.gmail.com>
	 <1131026420.6634.26.camel@localhost.localdomain>
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
Date: Thu, 3 Nov 2005 12:41:15 -0200

------=_Part_3821_9262300.1131028875439
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

It's done!

Regards,
Claudio.

On 11/3/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here are some cleanups that I detected when I was reading the last modi=
fication.
> >
> > 1. Fallback
> > I changed the return message when the path is not registered.
> > Currently, the dbus-daemon returns the following message: 'Error
> > org.freedesktop.DBus.Error.UnknownMethod: Method "Inquiry" with
> > signature "yy" on interface "org.bluez.Device" doesn't exist'
> > Now it's returning "Unknow D-Bus path when a client sent a message to
> > invalid path(the path was unregistered or wrong).
> >
> > 2. msg unref
> >  It's not necessary check if the message is NULL, this verification is
> > already done inside the dbus_message_unref.
> >
> > 3. up_adapters removed
> >
> > 4. Added some comments
> >
> > 5. device path checking
> >    It's not necessary check if the message belongs to the device path
> > hierarchy because we split the msg_func(msg_func_device and
> > msg_func_manager)
>
> I applied the patch, but I don't like the BTADDR_LEN thingy. The size of
> BD_ADDR in string representation is always 18 and so do addr[18] inside
> the code. That's just fine. Please send me a patch that removes the
> BTADDR_LEN stuff and replaces it with 18.
>
> Regards
>
> Marcel
>
>
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_3821_9262300.1131028875439
Content-Type: text/x-patch; name=cleanup_02.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cleanup_02.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2005-11-03 11:33:57.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-11-03 11:32:00.000000000 -0200
@@ -48,7 +48,6 @@
 static int default_dev = -1;
 
 #define TIMEOUT				(30 * 1000)	/* 30 seconds */
-#define BTADDR_LEN			18
 #define MAX_PATH_LENGTH			64
 #define MAX_CONN_NUMBER			10
 
@@ -1548,7 +1547,7 @@
 	DBusMessageIter iter;
 	DBusMessageIter array_iter;
 	DBusMessageIter  struct_iter;
-	char addr[BTADDR_LEN];
+	char addr[18];
 	const char array_sig[] = HCI_CONN_INFO_STRUCT_SIGNATURE;
 	const char *paddr = addr;
 	struct hci_dbus_data *dbus_data = data;
@@ -1816,7 +1815,7 @@
 
 	for (i = 0; i < dl->dev_num; i++, dr++) {
 		char apath[MAX_PATH_LENGTH];
-		char aaddr[BTADDR_LEN];
+		char aaddr[18];
 		char *paddr = aaddr;
 		char *ppath = apath;
 		char *ptype;

------=_Part_3821_9262300.1131028875439--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
