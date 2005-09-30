Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050930075263b62ffb@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
	 <1127897100.5321.13.camel@localhost.localdomain>
	 <e1effdeb05092812196392e0ac@mail.gmail.com>
	 <1128011132.30743.8.camel@localhost.localdomain>
	 <e1effdeb050929122670827a96@mail.gmail.com>
	 <1128069460.4955.25.camel@localhost.localdomain>
	 <e1effdeb050930075263b62ffb@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128092607.4955.93.camel@localhost.localdomain>
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
Date: Fri, 30 Sep 2005 17:03:27 +0200

Hi Claudio,

> We CAN'T use the full string representation of the bluetooth address.
> According with D-Bus specification the path name is restricted to
> "[A-Z][a-z][0-9]_".  The character ":" is not allowed. See the rules:
>     "* The path may be of any length.
>     * The path must begin with an ASCII '/' (integer 47) character,
> and must consist of elements separated by slash characters.
>     * Each element must only contain the ASCII characters
> "[A-Z][a-z][0-9]_"
>     * No element may be the empty string.
>     * Multiple '/' characters cannot occur in sequence.
>     * A trailing '/' character is not allowed unless the path is the
> root path (a single '/' character)."
> 
> 
> Which approach do you want now ? :)

can you ask J5 (or D-Bus mailing list) about the ":" character, because
I don't see any problem with it.

> More inforamtion how D-Bus paths works:
> This is just to explain to you how DBus paths works and try pass an
> useful information. If we analize HAL API deeply you will notice a
> small difference, HAL provide a Manager interface used to recover the
> devices(including paths) information. The Device interface is used by
> clients that want change/get ONE DEVICE property.
> 
> Interfaces:
> org.freedesktop.Hal.Manager
> org.freedesktop.Hal.Device
> 
> Manager interface services:
> - GetAllDevices
> - DeviceExists
> - FindDeviceByCapability
> ....
> 
> Device interface services:
> - GetProperty
> - SetProperty
> - Lock
> - Unlock
> ...
> 
> Path example:
> /org/freedesktop/Hal/devices/usb_device_a12_1_noserial_if0 (iface
> org.freedesktop.Hal.Device)
> 
> One path represents a unique identification to where a message is
> sent. In the code that I am developing there is only one D-Bus message
> handler, the path will be the primary element to know which local
> adapter use. Remember that each path will provide a set of services,
> and each path can has more than one interface. 
> 
> We are using the path "/org/bluez/Manager" to provide to userspace
> application services to list ACTIVE devices and enable/disable
> services. The path "/org/bluez/Devices" will be restricted to device
> setup. Therefore, the message format used in "/org/bluez/Devices" path
> should contains one arguments to indicate the device identification,
> like hciconfig uses. For the messages send under the path
> "/org/bluez/Manager/BDADDR/..." is not necessary send this argument
> because the path already contains the device identification. 
> 
> The prefix "/org/bluez/Manager" used before device based path is not
> realy necessary. It is used only to make easier find services under
> this hierarchy.
> 
> HAL DOESN'T provide an extra path as we are doing for device setup
> "/org/bluez/Devices" all paths are device based. If you want copy
> exactly HAL paths principle, we should have:
> /org/bluez/Manager
> /org/bluez/Devices/BDADDR/Hciconfig (always active)
> /org/bluez/Devices/BDADDR/Hciconfig (always active)
> /org/bluez/Devices/BDADDR/Controller (if dev is UP)
> /org/bluez/Devices/default/Controller (if dev is UP)
> /org/bluez/Devices/BDADDR/Net (if dev is UP)
> /org/bluez/Devices/default/Net (if dev is UP)
> 
> And use two interfaces:
> org.bluez.Manager
> org.bluez.Devices
> 
> 
> 
> I will send a new patch in the next email.

Cool. Please don't try to include everything. Lets make small steps. I
am ready to do a new release in the next few days and I like to have
some preliminary D-Bus support in it for testing.

Will someone provide Python based graphical applications that are using
this new D-Bus interface?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
