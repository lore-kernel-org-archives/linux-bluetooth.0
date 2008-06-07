Return-Path: <cyrus@holtmann.org>
Message-ID: <000001c8c923$eeadb920$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Sat, 7 Jun 2008 12:24:26 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] UPDATE: Retrieving an Array of Strings,
	that is attached to a G_HASH_TABLE variant
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Regarding my question about Retrieving an Array of Strings, attached to a "dict" variant in the new interface (e.g., the Device 
interface, UUIDs property), I received the following answer.  I have implemented it in my code, and it works (of course).

Just submitting to bluez-devel (a "managed" cross-posting from dbus-devel), so that anybody else developing to the new Bluez DBus 
interfaces having similar issues can save time.

DS

----- Original Message ----- 
From: "Simon McVittie"

On Thu, 05 Jun 2008 at 23:42:00 -0500, David Stockwell wrote:
> (GStrv) gPropValue = (GStrv) g_hash_table_lookup(propTable, "Strings"); // Assume that the "key" is "Strings"

This is wrong - an a{sv} maps to a GHashTable from gchar * to GValue *.

The right way to access it is like this:

GValue *tmp = g_hash_table_lookup (propTable, "Strings");
gchar **gPropValue;

if (G_VALUE_HOLDS (tmp, G_TYPE_STRV))
  {
    gPropValue = g_value_get_boxed (tmp);
  }
else
  {
    /* caller has done the wrong thing - recover in whatever way you
     * think best (but crashing in response to D-Bus messages is never the
     * right answer) */
    g_debug ("wtf? someone's using the wrong type - ignoring this message");
    return;
  }

Similarly, if you have a (string|integer|...) value in your dictionary,
it'll actually be a GValue containing a (string|integer|...), and you
have to check with (G_VALUE_HOLDS_STRING|G_VALUE_HOLDS_INT|...) that the
caller gave you the right thing, then call
(g_value_get_string|g_value_get_int|...) to get the actual value.

The functions tp_asv_get_uint32 (etc.) in telepathy-glib/dbus.[ch],
available from <http://telepathy.freedesktop.org/releases/telepathy-glib/> or
<http://darcs.collabora.co.uk/>, illustrate how to use an a{sv} in
dbus-glib code.

Regards,
    Simon



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
