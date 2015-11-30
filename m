Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: GATT service object required in D-Bus ObjectManager result
To: Ryan Kuester <rkuester@insymbols.com>,
	linux-bluetooth@vger.kernel.org
References: <20151129020402.GB1912@lodi.internal.kspace.net>
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
Message-ID: <565BF7B0.2020905@ubnt.com>
Date: Mon, 30 Nov 2015 09:16:00 +0200
MIME-Version: 1.0
In-Reply-To: <20151129020402.GB1912@lodi.internal.kspace.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11/29/2015 04:04 AM, Ryan Kuester wrote:
> Hello everyone,
> 
> When registering a GATT service via the D-Bus API, bluez-5.36
> seems to expect the objects returned by the service's
> GetManagedObjects method to include the service object itself,
> the root of the managed object tree. Indeed, the included
> test/example-gatt-server behaves this way[1].
> 
> However, the D-Bus Specification seems to say an ObjectManager
> should return the objects *under* the ObjectManager, i.e., only
> the service's children---characteristics and descriptors. This
> reading of the specification is in agreement with the
> ObjectManager implementations in GDBus and Python's txdbus (I
> didn't check other implementations).
> 
> bluez's disagreement with the standard causes pain when trying to
> use the ObjectManager implementations in the libraries, because
> they don't return the ObjectManager itself, the service object,
> as bluez expects. E.g., in txdbus, it's impossible to implement
> the ObjectManager interface in application code (to get the
> non-standard behavior) without patching the library.
> 
> Does the expectation that the service object appear in the
> GetManagedObjects result look like a disagreement with the D-Bus
> standard to anyone else?

The same to me. I'm using Glib/Glibmm to export GATT services and
Glib D-Bus code asserts in debug mode when object path matches
with object manager path. I'm currently blindly ignoring this, cause
it doesn't seems to cause any functionality problems in release code.

> 
> Thanks for all the good work on bluez,
> -- Ryan
> 
> 
> P.S. A possibly related issue is causing tools/gatt-service.c to
> fail. It implements the ObjectManager interface on the root path
> of the bus connection, rather on the service object. Perhaps this
> indicates the service object *was* under a separate ObjectManager
> in past versions, and this evolved into the current discrepancy
> now that the service object *is* the ObjectManager.
> 
> 1: text/example-gatt-server implements the ObjectManger
> interface directly, making it easy to include the service object
> in the GetManagedObjects result, even if returning the object is
> nonstandard behavior, because the example is is written using
> dbus-python, which doesn't provide help implementing the
> ObjectManager interface.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
