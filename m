Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Version 3 libs/utils
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
Message-Id: <1058870455.24408.66.camel@pegasus>
Mime-Version: 1.0
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
Date: 22 Jul 2003 12:40:48 +0200
Content-Type: text/plain

Hi Max,

> >The SDP server is needed in most cases (see my other post). Why do not
> >make it smart and integrate it. We need to keep track of different
> >Bluetooth adapters attached to one host, so if we have one daemon, the
> >SDP server can profite from a general approach.
> >
> >This idea is not completly designed, but it makes sense to me, because
> >in the long term, we can't live without SDP.
> I'd keep it separate. But I don't have very strong feeling about this one :).

let's see how it goes. If we have more details on how the new Bluetooth
master server will look like, we may can make a better decission.

> >> Also I don't see a need for user space inquiry cache. I guess you mean name database or
> >> something.
> >
> >I meant inquiry cache in a little bit wider range. It should store
> >device specific information, but also the inquiry results. I think it is
> >a good idea, that the library also have access to the inquiry results,
> >because name resolves can be much faster if you fill in the paramters
> >from an inquiry (even if the clock drifts).
> Yeah, I call it device database :).

Should we keep the kernel inquiry interface? The kernel inside inquiry
cache is a nice thing and works in the background like a charm :)

What about the idea to integrate the inquiry into the library or into
the Bluetooth master daemon.

> >> >I think we should have one tool (for example btconfig) which is staticly
> >> >linked with the Bluetooth library and can do all the configuration
> >> >stuff. This includes HCI, RFCOMM, BNEP etc. and such a tool should be
> >> >used by the bluetooth.agent and can be placed in an initrd.
> >> NO NO NO :-). We're going to have separate tools. hciconfig for example
> >> needs to be separate from rfcomm and pand. There is no questions about that. 
> >> If you absolutely need a single binary we could use Busybox way of combining
> >> things into a single binary.
> >
> >We will never agree on this point :)
> No. But at some point you'll realize that I'm right :). It sure won't happen the other 
> way though ;-).

We will see :)

> At least you're not saying - lets combine 'ifconfig', 'route', 'ip', 'iptables', 'netstat',
> into a single tool :).

You always hit me with this point, but what about "netstat -r" and
"netstat -i". Some things can be done with two different tools, but from
the kernel side they are all the same.

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
