Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05092604597481f1a9@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <1127398647.5344.24.camel@blade>
	 <e1effdeb05092209516bbcb31a@mail.gmail.com>
	 <1127411650.12287.15.camel@blade>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127897100.5321.13.camel@localhost.localdomain>
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
Date: Wed, 28 Sep 2005 10:45:00 +0200

Hi Claudio,

> Define clear object paths and interfaces will make easier define rules
> in the D-Bus configuration file. In this file it's possible specify
> the permissions for send and receive messages based on the interfaces,
> paths and users/groups.
> 
> Based on your comment I suggested the paths and interfaces. Defining
> this structure it's possible allow only the "root" or a "bluez
> manager" user/group change the adapter settings.
> 
> 
> SERVICE BUS NAME: org.bluez
> 
> <======= Device ======>
> description: device specific configuration services. eg: (#1)display
> local devices, inqmode, inqtype, up, down, reset, auth, noauth,
> encrypt, ...
> 
> object path: /org/bluez/Device
> interface: /org/bluez/Device

this looks good to me.

> <======= Manager ======>
> description: connection services. eg: inquiry, remote name, info,
> master/slave role switch, active connecions and profile specific
> tasks.
> Multiple local adapters scenario will be considered. The default
> object path and the adapter specific paths will provide the same
> services.
> 
> /***** HCI ******/
> default object path:/org/bluez/Manager/hci (will use the default
> device in the kernel)
> object path: /org/bluez/Manager/hci0/hci
> object path: /org/bluez/Manager/hci1/hci
> interface: org.bluez.Manager.hci
> 
> /***** SDP ******/
> default object path:/org/bluez/Manager/sdp
> object path: /org/bluez/Manager/hci0/sdp
> object path: /org/bluez/Manager/hci1/sdp
> interface: org.bluez.Manager.sdp
> 
> /***** PAN ******/
> default object path:/org/bluez/Manager/pan
> object path: /org/bluez/Manager/hci0/pan
> object path: /org/bluez/Manager/hci1/pan
> interface: org.bluez.Manager.pan
> 
> /***** RFCOMM ******/
> default object path:/org/bluez/Manager/rfcomm
> object path: /org/bluez/Manager/hci0/rfcomm
> object path: /org/bluez/Manager/hci1/rfcomm
> interface: org.bluez.Manager.rfcomm

Actually my plan is to don't use names like hci, sdp, rfcomm etc. at
all. We should define logical function names. The user of the D-Bus API
shouldn't need any Bluetooth protocol knowledge at all. So the idea
would be call it discovery, network etc.

> (#1) Probably the display local devices should be moved to other path
> due the permissions that I comment before. User  applications should
> be able list the local adapters to use in the pan, rfcomm, sdp ...

We maybe make Manager.DeviceList accessable by everybody. Are such
things possible?
 
> For me, your suggestion or my last suggestion are fine, both can
> address the permissions. You have the decision in your hands! :)

I like to have feedback and serious comments about, because I am still
in the process to open my mind for D-Bus.

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
