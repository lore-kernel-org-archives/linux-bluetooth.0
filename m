Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Some thoughts on the current D-BUS interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051031224006.GA14057@localhost.localdomain>
References: <20051031224006.GA14057@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1130799900.31561.38.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 01 Nov 2005 00:05:00 +0100

Hi Johan,

> We discussed on IRC with Claudio about the current D-BUS interface state
> and decided that it would be good to have yet another thread about it.
> The discussion actually started with me wondering about why there are
> now two different DeviceList methods (one in the Device path and another
> in the Manager path). It then evolved to the access control policies and
> the differences between the Manager and Device paths.
> 
> It seems I hadn't really understood how the current design was meant to
> to function, what internal assumptions there are, etc. I finally ended
> up going through the HAL and NetworkManager[1] D-BUS interfaces and
> comparing them with our current interface. As a result, here are some
> ideas on how I think we should change the D-BUS interface.
> 
> [1] http://people.redhat.com/dcbw/NetworkManager/
> 
> We have borrowed the names "Manager" and "Device" from the HAL D-BUS
> interface. However, they are currently used in a very different way than
> in HAL (I'll explain this difference in the next paragraphs). This will
> surely be quite confusing to someone trying to understand our interface
> by relating to the HAL spec. In my opinion our options are to either not
> use those names or to change the behaviour of our interface to be more
> similar to HAL. I would suggest the latter.

I think this is my fault, because I started proposing the names "Device"
and "Manager" and not taking care of that they are used in the same way
HAL is using them. I prefer to go with the HAL design. These guys have
the most experiences in using D-Bus (because it was written to support
the HAL idea in the first place) and their interface has been proofed in
real applications.

> As I mentioned, HAL has also a Manager and Device path. The Manager path
> is used to discover available (local) devices, and not much else. It
> provides methods for getting available device lists as well as signals
> for removed or added devices. The actual device identifiers used by
> these signals and methods are strings refering to D-BUS object paths
> in the Device object path hierarchy. The objects in the Device object
> path hierachy in turn represent the actual devices and provide
> interfaces to perform different operations with them.
> 
> Our current interface design mixes these two functions: we have both
> device discovery as well as device operations in both paths. To simplify
> it (at least in my mind ;-), and to make it more similar to the HAL one,
> I would suggest that we implement the following type of structure for
> our interface:
> 
> Well-known path: /org/bluez/Manager
> Interface: org.bluez.Manager
> Methods: DeviceList, DefaultDevice
> Signals: DeviceAdded, DeviceRemoved

Sound perfectly fine to me. Do you have a patch for this change?

> The device identifiers used by the manager interface methods and signals
> would be D-BUS object paths such as "/org/bluez/Device/hci0". To allow
> discovering device sub-paths (e.g. "PAN" or "RFCOMM"), the Manager
> interface could also provide an additional method which would return
> the sub-paths as a string list.
> 
> I've also mentioned a new method, DefaultDevice, which would return a
> string representing some real device path (or an error e.g.
> "org.bluez.NoDevices"). Having a DefaultDevice method should simplify
> the implementation since there's no need to handle the special case 
> of a default device path.

I also agree on this one.

> The toplevel device paths (e.g. "/org/bluez/Device/hci0", would
> implement an interface "org.bluez.Device" which would provide a set of
> methods that are common for all devices (if needed this could be split
> up to several interfaces also, e.g. in a hcitool vs. hciconfig fashion).

We need one interface to do the local device configuration and one for
the actual interaction with remote devices. This was the basic idea
behind the split into hcitool and hciconfig back then. And I think such
approach is still valid and useful.

> The proposed changes wouldn't really change the current implemented
> methods in any way - it would only change their place in the object
> hierarchy. Well, actually that's not quite true: the DeviceList and
> Device(Added|Removed) signals would start using object paths as device
> identifiers instead of device names. One benefit of this is that we can
> later shuffle around the structure of the Device path hierarchy without
> introducing API incompatibilities.

Feel free to send in a patch. For me these proposed changes are sounding
perfectly sane and I am happy to try them out. However it would be great
if you can include some small test applications written in Python like
Eduardo did.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
