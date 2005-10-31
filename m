Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051031224006.GA14057@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Some thoughts on the current D-BUS interface
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 1 Nov 2005 00:40:06 +0200

Hi,

We discussed on IRC with Claudio about the current D-BUS interface state
and decided that it would be good to have yet another thread about it.
The discussion actually started with me wondering about why there are
now two different DeviceList methods (one in the Device path and another
in the Manager path). It then evolved to the access control policies and
the differences between the Manager and Device paths.

It seems I hadn't really understood how the current design was meant to
to function, what internal assumptions there are, etc. I finally ended
up going through the HAL and NetworkManager[1] D-BUS interfaces and
comparing them with our current interface. As a result, here are some
ideas on how I think we should change the D-BUS interface.

[1] http://people.redhat.com/dcbw/NetworkManager/

We have borrowed the names "Manager" and "Device" from the HAL D-BUS
interface. However, they are currently used in a very different way than
in HAL (I'll explain this difference in the next paragraphs). This will
surely be quite confusing to someone trying to understand our interface
by relating to the HAL spec. In my opinion our options are to either not
use those names or to change the behaviour of our interface to be more
similar to HAL. I would suggest the latter.

As I mentioned, HAL has also a Manager and Device path. The Manager path
is used to discover available (local) devices, and not much else. It
provides methods for getting available device lists as well as signals
for removed or added devices. The actual device identifiers used by
these signals and methods are strings refering to D-BUS object paths
in the Device object path hierarchy. The objects in the Device object
path hierachy in turn represent the actual devices and provide
interfaces to perform different operations with them.

Our current interface design mixes these two functions: we have both
device discovery as well as device operations in both paths. To simplify
it (at least in my mind ;-), and to make it more similar to the HAL one,
I would suggest that we implement the following type of structure for
our interface:

Well-known path: /org/bluez/Manager
Interface: org.bluez.Manager
Methods: DeviceList, DefaultDevice
Signals: DeviceAdded, DeviceRemoved

The device identifiers used by the manager interface methods and signals
would be D-BUS object paths such as "/org/bluez/Device/hci0". To allow
discovering device sub-paths (e.g. "PAN" or "RFCOMM"), the Manager
interface could also provide an additional method which would return
the sub-paths as a string list.

I've also mentioned a new method, DefaultDevice, which would return a
string representing some real device path (or an error e.g.
"org.bluez.NoDevices"). Having a DefaultDevice method should simplify
the implementation since there's no need to handle the special case 
of a default device path.

The toplevel device paths (e.g. "/org/bluez/Device/hci0", would
implement an interface "org.bluez.Device" which would provide a set of
methods that are common for all devices (if needed this could be split
up to several interfaces also, e.g. in a hcitool vs. hciconfig fashion).

The proposed changes wouldn't really change the current implemented
methods in any way - it would only change their place in the object
hierarchy. Well, actually that's not quite true: the DeviceList and
Device(Added|Removed) signals would start using object paths as device
identifiers instead of device names. One benefit of this is that we can
later shuffle around the structure of the Device path hierarchy without
introducing API incompatibilities.

Any comments?

Johan




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
