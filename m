Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076502776.6281.81.camel@kalkyl.roxen.com>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076502776.6281.81.camel@kalkyl.roxen.com>
Content-Type: text/plain
Message-Id: <1076506129.2777.83.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 Feb 2004 14:28:49 +0100

Hi Fredrik,

> It's important for the Gnome applications to be able to do both
> configuration and device management. These are two separate things.
> 
> Configuration management is about the persistent configurations
> (past and present), basically those configrations stored in hcid.conf.
> The Gnome applications must be able to list, add, remove and modify
> such configurations. 
> 
> There may exist configurations for devices that are not attached, and 
> there may also be devices attached that do not have any specific
> configuration. The Gnome applications must be able to deal with these
> kinds of situations intelligently.
> 
> Device management is about the devices currently attached, basically
> a light version of the HCI functionality in the Bluetooth lib. The
> Gnome applications should be able to list, probe and control such
> devices, but probably only at a very basic/high level through DBus.
> 
> Your idea of having device managment in "org.bluetooth.hci" is good,
> I think. However, we will have to decide on what that interface looks
> like, because as noted in my previous e-mail, the HCI is not straight 
> forward for a DBus interface. Many things are too low-level.
> 
> The configuration management is probably better suited for another
> interface, possibly "org.bluetooth.conf".
> 
> Name caches, pairing etc. also have several requirements to address.
> For example, requesting a pairing procedure is a typical device management
> task. But managing paired devices (listing, removing etc.) is typically a 
> configuration management kind of thing.

for the real device management on HCI level we don't need any other
interface. All that we need is in the Bluetooth library and the new
version of the library brings full 1.2 support.

What I expect from a D-Bus interface is that it hides the HCI low level
tasks and combines it with storing of settings etc. for later use. The
setting of the local device is a good example. You can do this with the
HCI API, but it will only set the name and after a reboot it is gone and
have done again. If you set the local name through the D-Bus interface
than this name will be stored in somekind of database and the low level
HCI API will be used to set it. On reboot the hcid will retrieve these
setting and set the local name.

The other important part is the trusted devices management, which is not
defined in any part of the Bluetooth specification. From the low level
stuff it is easy, because we have to store the link keys and send them
on requests. For the UI level the link key itself is unimportant, but
the trusted devices must be manageable.

I think we should summarise what tasks an UI have to do and then design
a D-Bus interface from it.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
