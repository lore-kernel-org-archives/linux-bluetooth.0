Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D1E0FD51.AD61%adam.moore@savant.com>
References: <1436456267.26457.24.camel@redhat.com>
	<1539455180.3160545.1438363138455.JavaMail.zimbra@redhat.com>
	<D1E0FD51.AD61%adam.moore@savant.com>
Date: Fri, 31 Jul 2015 10:47:14 -0700
Message-ID: <CAPyD+=BTGLzEKanLSS7kV8bz7mr7BL5ed0GHuXEKxCJYuTpPVg@mail.gmail.com>
Subject: Re: GATT service DBus interface violates DBus spec
From: "Othman, Ossama" <ossama.othman@intel.com>
To: Adam Moore <adam.moore@savantsystems.com>
Cc: Nathaniel McCallum <npmccallum@redhat.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 31, 2015 at 10:30 AM, Adam Moore
<adam.moore@savantsystems.com> wrote:
> I ran into this as well when trying to build a an external service with
> GLibıs GDBusObjectManagerServer.  As I was highly motivated not to rewrite
> what I had, I have a little patch that relaxes the unwritten expectation,
> but it comes at the expense of being unable to enforce that
> characteristics reside under the service object.  (I think the proxy
> callback orderings are not guaranteed)  However, it does allow the service
> and characteristics to reside anywhere in the ObjectManager hierarchy.
>
> Iıll pass it along in case it helps accelerate a real fix, and perhaps it
> can unblock someone in the meantime.

I ran into a similar problem with GLib, and ended up reluctantly
replacing my use of GDBusObjectManagerServer with a hand-coded
implementation (except for the signals) of the ObjectManager interface
that was exported on the same object path as the
org.bluez.GattService1 skeleton via
g_dbus_interface_skeleton_export():
https://git.iotivity.org/cgit/iotivity/tree/resource/csdk/connectivity/src/bt_le_adapter/linux/service.c#n213

-Ossama
