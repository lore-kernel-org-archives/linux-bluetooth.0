Return-Path: <cyrus@holtmann.org>
Subject: Re: So very close, but so frustrating...
From: Bastien Nocera <hadess@hadess.net>
To: Dan Williams <dcbw@redhat.com>
In-Reply-To: <1254557285.8653.4.camel@localhost.localdomain>
References: <4AC3EFD9.1020602@shic.co.uk>
	<7cd7fc040909301718r3e441c53x767084b0b01f4a7c@mail.gmail.com>
	<1254433173.9657.155.camel@localhost.localdomain>
	<1254439169.22191.317.camel@localhost.localdomain>
	<1254534287.11531.41.camel@localhost.localdomain>
	<1254557285.8653.4.camel@localhost.localdomain>
Date: Mon, 05 Oct 2009 11:55:55 +0100
Message-Id: <1254740155.22191.5412.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	networkmanager-list@gnome.org
List-Unsubscribe: <http://mail.gnome.org/mailman/options/networkmanager-list>,
	<mailto:networkmanager-list-request@gnome.org?subject=unsubscribe>
List-Archive: <http://mail.gnome.org/archives/networkmanager-list/>
List-Post: <mailto:networkmanager-list@gnome.org>
List-Help: <mailto:networkmanager-list-request@gnome.org?subject=help>
List-Subscribe: <http://mail.gnome.org/mailman/listinfo/networkmanager-list>,
	<mailto:networkmanager-list-request@gnome.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: networkmanager-list-bounces@gnome.org
Errors-To: networkmanager-list-bounces@gnome.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-10-03 at 01:08 -0700, Dan Williams wrote:
> See the 'btdun' branch of nm-applet, where I've added DUN support to
> the
> gnome-bluetooth plugin.  There's nothing in the applet or NM side yet,
> both will need further fixes.  But the gnome-bt plugin seems to work
> OK
> at the moment.  Bastien, can you sanity check it?  There's a lot of
> async dbus calls going on there between the plugin, Bluez, and MM.
> Needs another set of eyes.
> 
> 8b0ae181efd1e3856851e6a44e16bd51d440d0ce
> c1c13b9dff6772bf13ab6217a2eecb986bd67687 

I'd do:
+ return (get_best_method (bdaddr, uuids) != BT_METHOD_UNKNOWN);
instead of:
+ return !!get_best_method (bdaddr, uuids);

Also, you're inside the wizard (or the properties, once I actually write
that code), so you can remove stuff like:
find_device_cb() and use bluetooth_client_get_model() instead

Something like:
client = bluetooth_client_new ();
model = bluetooth_client_get_model(client);
/* Loop to find the device's proxy object */
g_object_unref (model);
g_object_unref (client);
/* change the interface on the proxy object */

That would remove the need to get the default adapter as well.

You can use lib/test-client to see what the model looks like (adapters
with devices as the children).

The code under:
/* Watch for BT device property changes */
is probably racy-ish. Would need to connect to the properties before
launching the connect

Cheers

_______________________________________________
NetworkManager-list mailing list
NetworkManager-list@gnome.org
http://mail.gnome.org/mailman/listinfo/networkmanager-list
