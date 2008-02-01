Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201801687.2389.286.camel@cookie.hadess.net>
References: <1201227720.2389.17.camel@cookie.hadess.net>
	<1201626119.6218.15.camel@violet>
	<1201714289.2389.227.camel@cookie.hadess.net>
	<1201791472.2389.275.camel@cookie.hadess.net>
	<1201801687.2389.286.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-MGlJ6Q7czFZKpzXT14nY"
Date: Fri, 01 Feb 2008 10:46:06 +0000
Message-Id: <1201862766.2389.302.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] client.c cleanup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-MGlJ6Q7czFZKpzXT14nY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 2008-01-31 at 17:48 +0000, Bastien Nocera wrote:
<snip>
> About the hcid bug, should GetInfo fail when the bdaddr for the device
> isn't available, or should it just give out empty information?

Patch to allow GetAddress to fail, and don't add the information that's
not available to the GetInfo dict.

Cheers

--=-MGlJ6Q7czFZKpzXT14nY
Content-Disposition: attachment;
	filename=bluez-utils-hcid-allow-getaddr-failure.patch
Content-Type: text/x-patch; name=bluez-utils-hcid-allow-getaddr-failure.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: adapter.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/adapter.c,v
retrieving revision 1.13
diff -u -p -r1.13 adapter.c
--- adapter.c	28 Jan 2008 10:38:40 -0000	1.13
+++ adapter.c	1 Feb 2008 10:44:20 -0000
@@ -302,16 +302,18 @@ static DBusHandlerResult adapter_get_inf
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	dbus_message_iter_append_dict_entry(&dict, "address",
-			DBUS_TYPE_STRING, &property);
-
-	memset(str, 0, sizeof(str));
-	property = str;
-	str2ba(adapter->address, &ba);
-
-	if (!read_local_name(&ba, str))
-		dbus_message_iter_append_dict_entry(&dict, "name",
-			DBUS_TYPE_STRING, &property);
+	if (check_address (property) == 0) {
+		dbus_message_iter_append_dict_entry(&dict, "address",
+						    DBUS_TYPE_STRING, &property);
+
+		memset(str, 0, sizeof(str));
+		property = str;
+		str2ba(adapter->address, &ba);
+
+		if (!read_local_name(&ba, str))
+			dbus_message_iter_append_dict_entry(&dict, "name",
+							    DBUS_TYPE_STRING, &property);
+	}
 
 	get_device_version(adapter->dev_id, str, sizeof(str));
 	dbus_message_iter_append_dict_entry(&dict, "version",
@@ -337,7 +339,7 @@ static DBusHandlerResult adapter_get_inf
 	dbus_message_iter_append_dict_entry(&dict, "discoverable_timeout",
 				DBUS_TYPE_UINT32, &adapter->discov_timeout);
 
-	if (!read_local_class(&ba, cls)) {
+	if (check_address (property) == 0 && !read_local_class(&ba, cls)) {
 		uint32_t class;
 
 		memcpy(&class, cls, 3);
@@ -368,6 +370,9 @@ static DBusHandlerResult adapter_get_add
 	if (!dbus_message_has_signature(msg, DBUS_TYPE_INVALID_AS_STRING))
 		return error_invalid_arguments(conn, msg, NULL);
 
+	if (check_address (paddr) < 0)
+		return error_not_ready(conn, msg);
+
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.135
diff -u -p -r1.135 dbus-api.txt
--- dbus-api.txt	28 Jan 2008 10:38:40 -0000	1.135
+++ dbus-api.txt	1 Feb 2008 10:44:20 -0000
@@ -335,7 +335,7 @@ Methods		dict GetInfo()
 
 			Example: "00:11:22:33:44:55"
 
-			Possible errors: none
+			Possible errors: org.bluez.Error.NotReady
 
 		string GetVersion()
 

--=-MGlJ6Q7czFZKpzXT14nY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-MGlJ6Q7czFZKpzXT14nY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-MGlJ6Q7czFZKpzXT14nY--
