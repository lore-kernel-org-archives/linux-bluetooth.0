Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid: memory alignment problems on arm
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <74d0deb305092202185bd2308b@mail.gmail.com>
References: <74d0deb3050921035545e2a33d@mail.gmail.com>
	 <1127336002.23006.0.camel@blade>
	 <74d0deb305092202185bd2308b@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-04m6En3sOBWFphVGc/V6"
Message-Id: <1127381721.5344.4.camel@blade>
Mime-Version: 1.0
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
Date: Thu, 22 Sep 2005 11:35:21 +0200


--=-04m6En3sOBWFphVGc/V6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Philipp,

> On 9/21/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > the patch looks good, but you must redo it against the latest CVS. I
> > removed the compat code for the D-Bus 0.23 API.
> 
> Thanks, I have attached an updated patch against CVS.

is the attached patch also working for you? I think it is better to use
the D-Bus specific types.

Regards

Marcel


--=-04m6En3sOBWFphVGc/V6
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.16
diff -u -r1.16 dbus.c
--- hcid/dbus.c	15 Sep 2005 08:07:53 -0000	1.16
+++ hcid/dbus.c	22 Sep 2005 09:33:58 -0000
@@ -124,6 +124,7 @@
 	DBusPendingCall *pending = NULL;
 	struct pin_request *req;
 	uint8_t *addr = (uint8_t *) &ci->bdaddr;
+	dbus_uint32_t out = ci->out;
 
 	message = dbus_message_new_method_call(SERVICE_NAME, PATH_NAME,
 						INTERFACE_NAME, REQUEST_NAME);
@@ -136,7 +137,7 @@
 	req->dev = dev;
 	bacpy(&req->bda, &ci->bdaddr);
 
-	dbus_message_append_args(message, DBUS_TYPE_BOOLEAN, &ci->out,
+	dbus_message_append_args(message, DBUS_TYPE_BOOLEAN, &out,
 			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
 			&addr, sizeof(bdaddr_t), DBUS_TYPE_INVALID);
 
@@ -233,6 +234,8 @@
 {
 	DBusMessage *message;
 	char *local_addr, *peer_addr;
+	dbus_uint32_t tmp_class;
+	dbus_int32_t tmp_rssi = rssi;
 	bdaddr_t tmp;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
@@ -248,8 +251,8 @@
 	dbus_message_append_args(message,
 					DBUS_TYPE_STRING, &local_addr,
 					DBUS_TYPE_STRING, &peer_addr,
-					DBUS_TYPE_UINT32, &class,
-					DBUS_TYPE_INT32, &rssi,
+					DBUS_TYPE_UINT32, &tmp_class,
+					DBUS_TYPE_INT32, &tmp_rssi,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {

--=-04m6En3sOBWFphVGc/V6--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
