Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201866163.2389.311.camel@cookie.hadess.net>
References: <1201866163.2389.311.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-a4AkwzWidYVrQjsGBYxZ"
Date: Fri, 01 Feb 2008 12:33:16 +0000
Message-Id: <1201869196.2389.321.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Send DefaultAdapterChanged more often
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


--=-a4AkwzWidYVrQjsGBYxZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, 2008-02-01 at 11:42 +0000, Bastien Nocera wrote:
> Before the patch, we only used to send the DefaultAdapter changed from
> one adapter to another, never when there wasn't a new default adapter.
> 
> This allows us to remove bad tricks from client.c as well.
> 
> Both patches attached. The bluez-gnome patch includes the changes from
> the client.c cleanup thread.
> 
> Try plugging/unplugging your adapters after the patching, and the
> treeview will magically change its contents.

Updated patch with documentation changes.

--=-a4AkwzWidYVrQjsGBYxZ
Content-Disposition: attachment;
	filename=bluez-utils-more-default-adapter-signal-2.patch
Content-Type: text/x-patch;
	name=bluez-utils-more-default-adapter-signal-2.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: dbus-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-api.txt,v
retrieving revision 1.136
diff -u -p -r1.136 dbus-api.txt
--- dbus-api.txt	1 Feb 2008 12:22:09 -0000	1.136
+++ dbus-api.txt	1 Feb 2008 12:32:46 -0000
@@ -224,7 +224,8 @@ Signals		void AdapterAdded(string path)
 
 		void DefaultAdapterChanged(string path)
 
-			Parameter is object path of the new default adapter.
+			Parameter is object path of the new default adapter,
+			or an empty string if there is no available adapters.
 
 		void ServiceAdded(string path)
 
Index: dbus-hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-hci.c,v
retrieving revision 1.35
diff -u -p -r1.35 dbus-hci.c
--- dbus-hci.c	28 Jan 2008 10:38:40 -0000	1.35
+++ dbus-hci.c	1 Feb 2008 12:32:47 -0000
@@ -532,7 +532,7 @@ int hcid_dbus_unregister_device(uint16_t
 
 	ret = unregister_adapter_path(path);
 
-	if (ret == 0 && get_default_adapter() == id) {
+	if (ret == 0 && (get_default_adapter() == id || get_default_adapter() < 0)) {
 		int new_default = hci_get_route(NULL);
 		set_default_adapter(new_default);
 		if (new_default >= 0) {
@@ -543,6 +543,13 @@ int hcid_dbus_unregister_device(uint16_t
 							"DefaultAdapterChanged",
 							DBUS_TYPE_STRING, &pptr,
 							DBUS_TYPE_INVALID);
+		} else {
+			*path = '\0';
+			dbus_connection_emit_signal(connection, BASE_PATH,
+							MANAGER_INTERFACE,
+							"DefaultAdapterChanged",
+							DBUS_TYPE_STRING, &pptr,
+							DBUS_TYPE_INVALID);
 		}
 	}
 
@@ -551,7 +558,7 @@ int hcid_dbus_unregister_device(uint16_t
 
 int hcid_dbus_start_device(uint16_t id)
 {
-	char path[MAX_PATH_LENGTH];
+	char path[MAX_PATH_LENGTH], *pptr;
 	struct hci_dev_info di;
 	struct adapter* adapter;
 	struct hci_conn_list_req *cl = NULL;
@@ -633,10 +640,17 @@ int hcid_dbus_start_device(uint16_t id)
 					DBUS_TYPE_STRING, &mode,
 					DBUS_TYPE_INVALID);
 
-failed:
-	if (ret == 0 && get_default_adapter() < 0)
+	if (get_default_adapter() < 0) {
 		set_default_adapter(id);
+		pptr = path;
+		dbus_connection_emit_signal(connection, BASE_PATH,
+					    MANAGER_INTERFACE,
+					    "DefaultAdapterChanged",
+					    DBUS_TYPE_STRING, &pptr,
+					    DBUS_TYPE_INVALID);
+	}
 
+failed:
 	if (dd >= 0)
 		hci_close_dev(dd);
 

--=-a4AkwzWidYVrQjsGBYxZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-a4AkwzWidYVrQjsGBYxZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-a4AkwzWidYVrQjsGBYxZ--
