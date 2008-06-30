Return-Path: <cyrus@holtmann.org>
From: Antti =?ISO-8859-1?Q?Kaijanm=E4ki?= <antti@kaijanmaki.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214548448.6624.61.camel@peura.elisa-laajakaista.fi>
References: <1214310088.6643.87.camel@peura.elisa-laajakaista.fi>
	<1214527364.4435.14.camel@cookie.hadess.net>
	<1214548448.6624.61.camel@peura.elisa-laajakaista.fi>
Content-Type: multipart/mixed; boundary="=-py1BkfIU6/qwJGLgbjFN"
Date: Mon, 30 Jun 2008 08:47:36 +0300
Message-Id: <1214804856.7011.8.camel@peura.elisa-laajakaista.fi>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Making library out of bluez-gnome
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


--=-py1BkfIU6/qwJGLgbjFN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

pe, 2008-06-27 kello 09:34 +0300, Antti Kaijanm=C3=A4ki kirjoitti:=20
> pe, 2008-06-27 kello 01:42 +0100, Bastien Nocera kirjoitti:=20
> > On Tue, 2008-06-24 at 15:21 +0300, Antti Kaijanm=C3=A4ki wrote:
> > > Hello list!
> > >=20

<snip>

> > >  5. add property for selected device name. It's always nice to be abl=
e
> > >     to show the user a nice name instead of bluetooth address.
> > >     - see an attached patch.
> >=20
> > That's useful, as it allows us to avoid another lookup, although it's
> > close to free as hcid would have cached it.
>=20
> True, but then yet another API must be used to make the lookup.=20
>=20
>=20
> > FYI, you're leaking a copy of the name though, as gtk_tree_model_get()
> > will make a copy of the value, as well as g_value_set_string(). Use
> > g_value_take_string().
>=20
> Yes, true. thanks! I thought that g_value_set_string() would not make a
> copy of the string. I just adapted the "device-selected" property so I
> suppose it's also leaking memory.=20

patch attached.
It's against clean CVS without my other modifications.


> Br,
> Antti

--=-py1BkfIU6/qwJGLgbjFN
Content-Disposition: attachment;
	filename*0=fix_memory_leak_in_bluetooth_device_selection_get_property.pa;
	filename*1=tch
Content-Type: text/x-patch;
	name=fix_memory_leak_in_bluetooth_device_selection_get_property.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

Index: common/bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.20
diff -u -p -r1.20 bluetooth-device-selection.c
--- common/bluetooth-device-selection.c	12 Mar 2008 21:03:38 -0000	1.20
+++ common/bluetooth-device-selection.c	30 Jun 2008 05:42:40 -0000
@@ -686,7 +686,7 @@ bluetooth_device_selection_get_property 
 
 	switch (prop_id) {
 	case PROP_DEVICE_SELECTED:
-		g_value_set_string (value, bluetooth_device_selection_get_selected_device (self));
+		g_value_take_string (value, bluetooth_device_selection_get_selected_device (self));
 		break;
 	case PROP_SHOW_BONDING:
 		g_value_set_boolean (value, priv->show_bonded);

--=-py1BkfIU6/qwJGLgbjFN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--=-py1BkfIU6/qwJGLgbjFN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-py1BkfIU6/qwJGLgbjFN--
