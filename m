Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201714289.2389.227.camel@cookie.hadess.net>
References: <1201227720.2389.17.camel@cookie.hadess.net>
	<1201626119.6218.15.camel@violet>
	<1201714289.2389.227.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-gv5JcdxNFGlz4QErGDXR"
Date: Thu, 31 Jan 2008 14:57:52 +0000
Message-Id: <1201791472.2389.275.camel@cookie.hadess.net>
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


--=-gv5JcdxNFGlz4QErGDXR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, 2008-01-30 at 17:31 +0000, Bastien Nocera wrote:
> On Tue, 2008-01-29 at 18:01 +0100, Marcel Holtmann wrote:
> > Hi Bastien,
> > 
> > > Some time ago I had problems with client.c's architecture. It would
> > > allow me to easily report completed discoveries without causing crashes.
> > > 
> > > The attached patch moves all the static variables into the main
> > > BluetoothClient object, and instead of return a new object when using
> > > _new() we return an existing instance of the client.
> > > 
> > > This makes no changes to the external API for the BluetoothClient, and
> > > should work just as well as older versions did.
> > 
> > patch has been applied. Don't really see the difference, but I am okay
> > with doing it this way.
> > 
> > > A couple of bugs I found in client.c:
> > > - launch test-client with a dongle inserted, remove and reinsert the
> > > dongle, the bdaddr of the device is not set anymore
> > > - launch test-client without a dongle inserted, insert it, the bdaddr is
> > > not set and there's no children to the adapter (although there are if
> > > inserted when started)
> 
> Both of those are a race:
> When the AdapterAdded signal is launched in hcid, the address isn't
> available yet. It is available when "ModeChanged" has been launched
> though.
> 
> hcid_dbus_register_device() setups the structures, and launched
> AdapterAdded, but the address is only set when hcid_dbus_start_device()
> is called (and the ModeChanged signal is launched).
> 
> How do you think we should be handling that? I would think we should
> make GetAddress fail if the data isn't available yet, or hack around it
> in client.c and only setup the adapters when the mode changes.

The easy fix for hcid attached (the default bdaddr should be
00:00:00:00:00:00:00, not an empty string).

And also a patch for client.c to get the device address again when the
device changes mode, so we can change it in the tree from the default
all-zeros address to the real one.

I'll fix the other bugs now.

Cheers

--=-gv5JcdxNFGlz4QErGDXR
Content-Disposition: attachment;
	filename=bluez-utils-hcid-set-default-address.patch
Content-Type: text/x-patch; name=bluez-utils-hcid-set-default-address.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: dbus-hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-hci.c,v
retrieving revision 1.35
diff -u -p -r1.35 dbus-hci.c
--- dbus-hci.c	28 Jan 2008 10:38:40 -0000	1.35
+++ dbus-hci.c	31 Jan 2008 14:41:40 -0000
@@ -477,6 +477,7 @@ int hcid_dbus_register_device(uint16_t i
 
 	adapter->dev_id = id;
 	adapter->pdiscov_resolve_names = 1;
+	strcpy(adapter->address, "00:00:00:00:00:00:00");
 
 	if (!dbus_connection_create_object_path(connection, path, adapter,
 						NULL)) {

--=-gv5JcdxNFGlz4QErGDXR
Content-Disposition: attachment; filename=bluez-gnome-update-bdaddr.patch
Content-Type: text/x-patch; name=bluez-gnome-update-bdaddr.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.37
diff -u -p -r1.37 client.c
--- client.c	29 Jan 2008 17:00:58 -0000	1.37
+++ client.c	31 Jan 2008 14:56:56 -0000
@@ -60,6 +60,8 @@ static int client_table_signals[LAST_SIG
 
 G_DEFINE_TYPE(BluetoothClient, bluetooth_client, G_TYPE_OBJECT)
 
+static void update_adapter(DBusGProxy *object, GtkTreeIter *iter, BluetoothClient *client);
+
 static gboolean find_iter_for_object(DBusGProxy *object,
 				     BluetoothClient *client,
 				     GtkTreeIter *iter)
@@ -87,6 +89,29 @@ static gboolean find_iter_for_object(DBu
 static void mode_changed(DBusGProxy *object,
 				const char *mode, gpointer user_data)
 {
+	BluetoothClient *client = (BluetoothClient *) user_data;
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+	GtkTreeIter iter;
+	gboolean cont;
+
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
+
+	while (cont == TRUE) {
+		DBusGProxy *o;
+
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
+						COLUMN_OBJECT, &o, -1);
+
+		if (object == o) {
+			gtk_tree_store_set(priv->store, &iter,
+						COLUMN_ACTIVE, TRUE, -1);
+			update_adapter(object, &iter, client);
+
+			return;
+		}
+
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
+	}
 }
 
 static void timeout_changed(DBusGProxy *object,

--=-gv5JcdxNFGlz4QErGDXR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-gv5JcdxNFGlz4QErGDXR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-gv5JcdxNFGlz4QErGDXR--
