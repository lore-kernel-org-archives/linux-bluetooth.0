Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 28 Nov 2015 20:04:02 -0600
From: Ryan Kuester <rkuester@insymbols.com>
To: linux-bluetooth@vger.kernel.org
Subject: GATT service object required in D-Bus ObjectManager result
Message-ID: <20151129020402.GB1912@lodi.internal.kspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

When registering a GATT service via the D-Bus API, bluez-5.36
seems to expect the objects returned by the service's
GetManagedObjects method to include the service object itself,
the root of the managed object tree. Indeed, the included
test/example-gatt-server behaves this way[1].

However, the D-Bus Specification seems to say an ObjectManager
should return the objects *under* the ObjectManager, i.e., only
the service's children---characteristics and descriptors. This
reading of the specification is in agreement with the
ObjectManager implementations in GDBus and Python's txdbus (I
didn't check other implementations).

bluez's disagreement with the standard causes pain when trying to
use the ObjectManager implementations in the libraries, because
they don't return the ObjectManager itself, the service object,
as bluez expects. E.g., in txdbus, it's impossible to implement
the ObjectManager interface in application code (to get the
non-standard behavior) without patching the library.

Does the expectation that the service object appear in the
GetManagedObjects result look like a disagreement with the D-Bus
standard to anyone else?

Thanks for all the good work on bluez,
-- Ryan


P.S. A possibly related issue is causing tools/gatt-service.c to
fail. It implements the ObjectManager interface on the root path
of the bus connection, rather on the service object. Perhaps this
indicates the service object *was* under a separate ObjectManager
in past versions, and this evolved into the current discrepancy
now that the service object *is* the ObjectManager.

1: text/example-gatt-server implements the ObjectManger
interface directly, making it easy to include the service object
in the GetManagedObjects result, even if returning the object is
nonstandard behavior, because the example is is written using
dbus-python, which doesn't provide help implementing the
ObjectManager interface.

