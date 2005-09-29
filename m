Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05092812196392e0ac@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <1127398647.5344.24.camel@blade>
	 <e1effdeb05092209516bbcb31a@mail.gmail.com>
	 <1127411650.12287.15.camel@blade>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
	 <1127897100.5321.13.camel@localhost.localdomain>
	 <e1effdeb05092812196392e0ac@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128011132.30743.8.camel@localhost.localdomain>
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
Date: Thu, 29 Sep 2005 18:25:32 +0200

Hi Claudio,

> Regarding the DeviceList permission, It possible define rules for
> allow/deny services based on interface name, path, user, groups,
> message type, service name(member name), ...
> 
> Therefore, provide just one interface or path is not a good idea
> because we will not be able to create permission rules and a clean
> API.

my hope is to make the permission of the BlueZ D-Bus API more flexible
and thus having a separate group "domain" for every group of access
sounds totally stupid to me. The permissions shouldn't have to do
anything with the logical structure of the API.

People with more D-Bus experience than me please comment on it.

> In my opinion, only a "bluez_admin" group should be able to use the
> service under the "/org/bluez/Devices" path. These services are
> related to device configuration(hciconfig). Application that don't
> have enough 
> privileges will receive the error message:
> org.freedesktop.DBus.Error.AccessDenied
> 
> The other ordinary services under "org/bluez/Manager..." can be
> available for everyone.
> 
> Currently we are not providing any kind of session control. All
> userspace applications will be able to control connections and
> interfere in a connection used by other application.

Maybe we should restrict this somehow, but I have no clue on how to do
it at the moment. I am fully open to proposals.

> Another subject is the logical function names. If you want support
> multiple adapters, it's necessary export one new path for each
> adapter. An adapter identification must belongs to the object path. My
> suggestion is use hci(default kernel device), hci0, hci1, ... We can
> suggest a more suitable message member name, like you suggested for
> DeviceList, but for the object path I don't see an easiest way.

We can always use the BD_ADDR instead and maybe also an alias that can
be set by bluetoothd/hcid.

> See below how I have want organize the service after your suggestions.
> 
> >>> Device PATH 
> permission: only bluez_admin group
> path: /org/bluez/device
> interface: org.bluez.device
> 
> >>> Manager PATH
> permission: everyone
> path: /org/bluez/Manager
> interface: org.bluez.manager

I think these are clear and they look good, but we should look at other
D-Bus services how they design their API.

> * Device Independent Service
>  path: "/org/bluez/manager" 
>  interface: "org.bluez.manager" (signals and request)
>  comment: Always active
>    1. Init (version check)
>    2. DeviceList
>    3. ListServices (list available services)
>    4. Enable (Enable an service. eg: all pan related services)
>    5. Disable 
> 
> * Device dependent Service
>  path: "/org/bluez/manager/hci/controller" (default HCI services)
>  path: "/org/bluez/manager/hci0/controller" (HCI services)
>  path: "/org/bluez/manager/hci1/controller" (HCI services)
>  path: "/org/bluez/manager/hci/pan" (default PAN services)
>  path: "/org/bluez/manager/hci0/pan" (PAN services)
>  path: "/org/bluez/manager/hci1/pan" (PAN services)
>  path: "/org/bluez/manager/hci/serial" (default RFCOMM services)
>  path: "/org/bluez/manager/hci0/serial" (RFCOMM services)
>  path: "/org/bluez/manager/hci1/serial" (RFCOMM services)
>  path: "/org/bluez/manager/hci/services" (default SDP publish/search)
>  path: "/org/bluez/manager/hci0/services" (services SDP
> publish/search)
>  path: "/org/bluez/manager/hci1/services" (services SDP
> publish/search)

I like to use the word "default" to select the default device/service
and "network" instead of "pan", because PAN is the way to go. The
fallback to LAP is optional.

>  interface: "org.bluez.manager" (signals and request) can be shared
> for all 
>  manager services and signals.
>  comment: Available only when there is a device UP. The daemon must
> monitor  DEV_UP/DEV_DOWN events and register/unregister the path
> dynamically. Each  service will be accessible through the default path
> and the device  dependent path.

Please check how HAL is handling the device register and unregister. I
think their current interface is quite good.

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
