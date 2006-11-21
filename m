Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4563155A.90905@vasmac.com>
References: <455392B6.5060209@free.fr> <45622D23.7070105@vasmac.com>
	<456234FB.4020506@xmission.com> <1164094500.28429.9.camel@localhost>
	<4563155A.90905@vasmac.com>
Date: Tue, 21 Nov 2006 16:26:37 +0100
Message-Id: <1164122797.28429.49.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO flow control (Was: New
	bluetooth-headset	release 20061109)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jose,

> > I am not against using flow control, but we must be really careful if it
> > supported or not. While for ACL it is mandatory, the SCO channel can be
> > used without it. However even the use of flow control on SCO is a job
> > for the Bluetooth core and no driver specific one. All Bluetooth drivers
> > are transport drivers. They have no intelligence whatsoever and they are
> > not interfering the HCI data. If they need to know some specific details
> > about changes in the core then the notify() callback is the right place
> > and if they need a special setup, then a quirk should be used. Other
> > than that, they are plain stupid and only moving HCI packets to the
> > hardware and back.
> >
> > So from my understanding the high resolution timer are a good choice to
> > submit SCO packets to the hardware. In addition we can enable the flow
> > control for SCO to have more control over the hardware. However please
> > keep in mind that the enabling flow control means for traffic on the ACL
> > links and so you might see a downgrade in bandwidth. So from my current
> > point of view, the flow control stuff must be optional.
> 
> The problem with using timers is that they are not synchronized
> with the bluetooth controller (dongle). This can cause drift after
> a while leading to underrun condition on the controller. This will
> cause pops or other audio artifacts. So this solution will always
> have a design flaw. I don't find this acceptable.

I don't see the synchronization as a problem, because once SCO traffic
is on, we get a PCM stream back from the chip we can use this one as a
synchronization source.

> Let me address some of your objections to using the flow control:
> 
> 1. extra bandwith - this is the price to pay for synchronization.
> In the case of USB no additional messages are sent and overhead
> is part of the USB isosynchronous transport.

Wrong. We always have additional HCI commands and events if SCO flow
control has been enabled. This is no difference from the actual
transport you use. The only difference for USB is that they are on a
different interface of the USB device.

> 2. some dongles may not support flow control - it's true that flow
> control can be turned off for synchronous traffic but it' s not clear
> to me that this is optional for controllers that support SCOs.
> We're really talking about UART or other interfaces. Can anyone
> provide an example where it's NOT supported?

It is optional no matter if it is UART, USB or any other transport. This
is has nothing to do with the actual hardware interface.

> 3. Transport drivers are dumb - this is a problem with the existing
> drivers that should be addressed. They need to differentiate
> between different types of traffic otherwise it's quite easy to
> starve the synchronous channel with ACL data. In fact, the
> current architecture can't support multiple SCOs reliably because
> of this. At the very least, separate queues must be used for
> synchronous and other traffic.

I don't see what you are actually talking about. We have separate queues
for ACL and SCO data, because the queues are connection specific. What
the actual driver is doing is up to the driver. However the Bluetooth
hardware drivers are transport drivers and the core has to be fully
agnostic from any hardware specific implementation of the transports.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
