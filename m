Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
Message-Id: <1058489472.31052.134.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Version 3 libs/utils
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 18 Jul 2003 02:51:05 +0200
Content-Type: text/plain

Hi Max,

> >I already started to implement the missing HCI defines and functions.
> >And we should clean this up and check the ordering. With Bluetooth 1.2
> >we will get some more.
> >
> >The "timeout" parameter is not needed by many functions. Kill it and use
> >some global timeout settings. But functions like the name resolv need a
> >bigger timeout, so we must take care of this.
> >
> >The inquiry must be rewritten to take care of Bluetooth devices that
> >report BDADDR more than once.
> Sounds good. Let's keep timeout for hci_send_req().

yes of course. The general functions should keep the timeout parameter.

> >One clean /etc/init.d/bluetooth, because I don't like the current way of
> >multiple init scripts which are used by the Debian packages.
> /etc/init.d/bluetooth is not enough. We have to have /etc/hotplug/bluetooth.agent 
> for hotplug. And it has to read configuration options like devices settings, etc.
> That stuff will be stored in /etc/sysconfig/bluetooth.

You are right with that, but this was not what I meant. There should be
only one /etc/init.d/bluetooth startup script (not many like in the
Debian packages). This script should read the basic options from
/etc/sysconfig/bluetoth (RedHat) or /etc/default/bluetooth (Debian) and
get some extra options from /etc/bluetooth/. This is for general
startup. Each device specific stuff must be done with bluetooth.agent
script.

> >What about a Bluetooth daemon (for exmaple btmgr) which integrates the
> >security manager and the sdpd. It can also store an userspace Bluetooth
> >inquiry cache, name database and remote SDP cache. The local
> >configuration (like local device name) for example can also modified
> >through this daemon and restored on next boot, which is good for
> >handheld devices. The access can be done through a defined protocol over
> >unix sockets.
> In general I don't like a 'kitchen sink' approach. Security manager, device names, etc
> is fine. But SDP is unrelated service. I'd keep SDP separate. 

The SDP server is needed in most cases (see my other post). Why do not
make it smart and integrate it. We need to keep track of different
Bluetooth adapters attached to one host, so if we have one daemon, the
SDP server can profite from a general approach.

This idea is not completly designed, but it makes sense to me, because
in the long term, we can't live without SDP.

> Also I don't see a need for user space inquiry cache. I guess you mean name database or
> something.

I meant inquiry cache in a little bit wider range. It should store
device specific information, but also the inquiry results. I think it is
a good idea, that the library also have access to the inquiry results,
because name resolves can be much faster if you fill in the paramters
from an inquiry (even if the clock drifts).

> >I think we should have one tool (for example btconfig) which is staticly
> >linked with the Bluetooth library and can do all the configuration
> >stuff. This includes HCI, RFCOMM, BNEP etc. and such a tool should be
> >used by the bluetooth.agent and can be placed in an initrd.
> NO NO NO :-). We're going to have separate tools. hciconfig for example
> needs to be separate from rfcomm and pand. There is no questions about that. 
> If you absolutely need a single binary we could use Busybox way of combining
> things into a single binary.

We will never agree on this point :)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
