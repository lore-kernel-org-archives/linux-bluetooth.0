Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 30 Nov 2015 09:59:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jonas Holmberg <jonas.holmberg@axis.com>
Cc: Andrejs Hanins <andrejs.hanins@ubnt.com>,
	Ryan Kuester <rkuester@insymbols.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT service object required in D-Bus ObjectManager result
Message-ID: <20151130075934.GA15562@t440s.lan>
References: <20151129020402.GB1912@lodi.internal.kspace.net>
 <565BF7B0.2020905@ubnt.com>
 <565BFE44.4060706@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <565BFE44.4060706@axis.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 30, 2015, Jonas Holmberg wrote:
> On 11/30/2015 08:16 AM, Andrejs Hanins wrote:
> > Hi,
> > 
> > On 11/29/2015 04:04 AM, Ryan Kuester wrote:
> >> Hello everyone,
> >>
> >> When registering a GATT service via the D-Bus API, bluez-5.36
> >> seems to expect the objects returned by the service's
> >> GetManagedObjects method to include the service object itself,
> >> the root of the managed object tree. Indeed, the included
> >> test/example-gatt-server behaves this way[1].
> >>
> >> However, the D-Bus Specification seems to say an ObjectManager
> >> should return the objects *under* the ObjectManager, i.e., only
> >> the service's children---characteristics and descriptors. This
> >> reading of the specification is in agreement with the
> >> ObjectManager implementations in GDBus and Python's txdbus (I
> >> didn't check other implementations).
> >>
> >> bluez's disagreement with the standard causes pain when trying to
> >> use the ObjectManager implementations in the libraries, because
> >> they don't return the ObjectManager itself, the service object,
> >> as bluez expects. E.g., in txdbus, it's impossible to implement
> >> the ObjectManager interface in application code (to get the
> >> non-standard behavior) without patching the library.
> >>
> >> Does the expectation that the service object appear in the
> >> GetManagedObjects result look like a disagreement with the D-Bus
> >> standard to anyone else?
> > 
> > The same to me. I'm using Glib/Glibmm to export GATT services and
> > Glib D-Bus code asserts in debug mode when object path matches
> > with object manager path. I'm currently blindly ignoring this, cause
> > it doesn't seems to cause any functionality problems in release code.
> 
> I was also bitten by that assert. I assumed it was a bug  so I wrote a
> bug report about it: https://bugzilla.gnome.org/show_bug.cgi?id=758393
> But after this discussion I'm not sure if it is a bug.

It appears to be a bug in the BlueZ implementation and D-Bus API. It
was already discussed many months ago, but no one seems to have
submitted patches to fix it:

http://comments.gmane.org/gmane.linux.bluez.kernel/63291
https://bugs.freedesktop.org/show_bug.cgi?id=91283
https://github.com/systemd/systemd/issues/525#issuecomment-126746787

Johan
