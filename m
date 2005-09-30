Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050929122670827a96@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <e1effdeb05092209516bbcb31a@mail.gmail.com>
	 <1127411650.12287.15.camel@blade>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
	 <1127897100.5321.13.camel@localhost.localdomain>
	 <e1effdeb05092812196392e0ac@mail.gmail.com>
	 <1128011132.30743.8.camel@localhost.localdomain>
	 <e1effdeb050929122670827a96@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128069460.4955.25.camel@localhost.localdomain>
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
Date: Fri, 30 Sep 2005 10:37:40 +0200

Hi Claudio,

> I don't want define a group domain for evey group of access. I think
> you didn't understand my idea. I defined fixed interfaces
> (org.bluez.manager or org.bluez.devices) and path names based on
> device identification. 

this might be true, because I am a total newbie when it comes to D-Bus
security. I have to rely on other peoples investigation here.

> In the security policy file we can define rules according with our
> need.  We can define rules based on paths, interfaces, users,
> group ... or a combination of these parameters. At first phase of
> bluetoothd development we need only define clear interfaces and path
> to make possible define security policy easily in the future. We don't
> need thinking on define a group domain or rules at this momment.
> 
> The interfaces name will be shared by method call, method reply,
> errors and signals. Remember that one path, can have a lot of
> interfaces.  Interfaces is just a way to group a set of
> methods(services). Therefore, if you apply one rule for a path, this
> rule will be applied for all interfaces that belongs to this path.

This means we will have a generell restricted policy and we create some
holes to make specific calls available for normal users.

> Regarding the device identification in the path name, I prefer use
> hci(for default kernel device), hci1, hci2, ... It's easier use the
> device id of "evt_si_device" event. You suggested use the bluetooth
> address, for this approach we can define a the default
> device(000000000000), and use the string  representation of bdaddr_t
> for the others devices. eg:"A089BE880D00", "E4A500461300" The final
> decision is yours.

I will go with "default", because at some point I might make the HCI
device identifier strings changeable, like we can do for Ethernet. The
BDADDR_ANY is not needed, but we can do this. However this means that I
have to implement a possibility to define a default device inside the
kernel. Otherwise BDADDR_ANY in D-Bus and inside the kernel might end up
in two different devices. For the address representation I will use the
string representation "00:11:22:33:44:55", because this is how normal
users will see the address and there is no need to obfuscate the address
for it.
 
> I checked the libhal code, a similar approach is implemented. See how
> the messages are created. The first argument of the
> dbus_message_new_method_call function is the service bus name, the
> second is the path, the third is the interface and 
> the last one is the member name(service). "udi" means unique device
> identification.
> 
> LIBHAL side(client):
> 
>         message = dbus_message_new_method_call ("org.freedesktop.Hal",
> udi,
> 
> "org.freedesktop.Hal.Device",
>                                                 "GetAllProperties");
>         message = dbus_message_new_method_call ("org.freedesktop.Hal",
> 
> "/org/freedesktop/Hal/Manager",
> 
> "org.freedesktop.Hal.Manager",
>                                                 "GetAllDevices");
>         message = dbus_message_new_method_call ("org.freedesktop.Hal",
> udi,
> 
> "org.freedesktop.Hal.Device",
>                                                 "GetPropertyType");
>         message = dbus_message_new_method_call ("org.freedesktop.Hal",
> udi,
> 
> "org.freedesktop.Hal.Device",
> 
> "GetPropertyStringList");
>         message = dbus_message_new_method_call ("org.freedesktop.Hal",
> udi,
> 
> "org.freedesktop.Hal.Device",
>                                                 "GetPropertyInteger");
>         message = dbus_message_new_method_call ("org.freedesktop.Hal",
> udi,
> 
> "org.freedesktop.Hal.Device",
>                                                 "GetPropertyInteger");
>         message = dbus_message_new_method_call ("org.freedesktop.Hal",
> udi,
> 
> "org.freedesktop.Hal.Device",
>                                                 "GetPropertyDouble");
> In the server side - hald(daemon)
> DBusHandlerResult
> device_get_property (DBusConnection * connection, DBusMessage *
> message){
> ...
> udi = dbus_message_get_path (message);
> ..
> }
> 
> Basically, HAL has two interfaces, one for devices and another for the
> manager. Each device has path registered in the system Bus, where the
> device identification belongs to the path.
> 
> After this analysis I think we are following the right path.

I think so, too. Please send in a new patch. We need something to get
started and as you, I like it step by step.

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
