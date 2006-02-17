Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602171007p5c34580ahe93f1023694b68e5@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_356_9788531.1140199641830"
Subject: [Bluez-devel] [DBUS PATCH] BondingCreated && BondingFailed
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
Date: Fri, 17 Feb 2006 16:07:21 -0200

------=_Part_356_9788531.1140199641830
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is another small patch...

According with the BlueZ D-Bus API the bonding result must be sent
using the BondingCreated and BondingFailed signals.

In the current code, the bonding result the status is added in the
signal argument.

The next step is start the development of the missing bonding
services: RemoveBonding, HasBonding and ListBonding.


Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_356_9788531.1140199641830
Content-Type: text/x-patch; name=bonding01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejsmt89e
Content-Disposition: attachment; filename="bonding01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-17 11:31:06.000000000 -0200
+++ bluez-utils-cvs-bonding/hcid/dbus.c	2006-02-17 12:57:18.000000000 -0200
@@ -457,16 +457,14 @@
 	snprintf(path, sizeof(path), "%s/hci%d", DEVICE_PATH, id);
 
 	message = dbus_message_new_signal(path, DEVICE_INTERFACE,
-						DEV_SIG_BONDING_CREATED);
+						(!status?DEV_SIG_BONDING_CREATED:DEV_SIG_BONDING_FAILED));
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


------=_Part_356_9788531.1140199641830--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
