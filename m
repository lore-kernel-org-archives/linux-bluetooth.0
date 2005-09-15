Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid and bluetoothd
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05091507045d13ca3f@mail.gmail.com>
References: <e1effdeb050914064849913a76@mail.gmail.com>
	 <1126775298.28510.40.camel@station6.example.com>
	 <e1effdeb05091507045d13ca3f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126794184.3505.31.camel@station6.example.com>
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
Date: Thu, 15 Sep 2005 16:23:04 +0200

Hi Claudio,

> Remember that we need cover  normal inquiry and periodic inquiry. For
> periodic inquiry
> I agree with this approach of send signals every time. We can
> implement a cache 
> to make the inquiry fast/powerful. Two or more clients can request
> inquiry at same 
> time, this is a normal scenario, but it can happen. For normal
> inquiry, we can't
> use hci_inquiry because it a blocking operation. The inquiry must be
> integrated
> in the main loop of the bluetoothd, using a HCI raw socket or the new
> interface that 
> your are defining.

the kernel already has an inquiry cache. We can simply deliver that
cache at the moment.

I am not going to duplicate the inquiry stuff inside bluetoothd. We will
do it in hcid for now, but for bluetoothd the kernel should do all the
work.

> I suggested  previously use the bus name "org.bluez.bluetoothd", but
> do you think 
> relevant participate on freedesktop project?
> 
> The bus name could be "org.freedesktop.Bluez"
> 
> I don't know what are the advantages and which rules we need respect.

For now we will use "org.bluez" as base and I think about moving over to
"org.bluetooth" and propose it as an additional standard. However that
is not so important at the moment.

I like to use names that don't have any daemon names in it. This means
that something like "org.bluez.bluetoothd" is bad if FreeBSD wants to
provide a compat interface, but they don't call their daemon bluetoothd.
So what I like to see is something like "org.bluetooth.device" and so
on. Make it more logical. We don't even have to use the Bluetooth
terminology. This includes HCI command names. In general I like to have
an "discovery" procedure. This is doing an inquiry, a name resolve and
the SDP service stuff. In case of EIR the inquiry response may deliver
already enough information, because it can include a short name and a
service UUID list.

> I agree. We need define exactly which signals are necessary. I am
> going 
> to update the specification document that I am writing and I will send
> you soon.

My idea is to have multiple Bluetooth clients running at the same time
and if one starts a new inquiry the others also got informed of these
results. What they do with this results is their problem. I can draw a
picture if needed, but I think my ideas behind it are clear.

> hcid already contains the structure(main loop) required to register 
> D-Bus services, it will be easy implement the D-Bus services.

Since I dropped D-Bus 0.23 support now, I am happy to accept any
extensions to hcid.

> Regarding sdpd, currently an  application have to connect
> (sdp_connect) 
> and stablish a session to register/update a service. 
> sdp D-Bus service shall  be provided in the future, how do you 
> think it should work in this new scenario?

The SDP stuff is blocking at the moment and that is bad. My idea is to
rewrite the SDP support and include it in bluetoothd. This means that it
will be capable of caching SDP information and D-Bus clients can ask for
service information quite easy. This is also important with the extended
inquiry support, because the UUID list can be provided via an inquiry
response. And of course bluetoothd should add the UUID of all registered
services to the extended inquiry data when someone registers a new
record via D-Bus.

> Where is the CVS branch? If possible, send me the address.

It will be in the GIT tree, when I have some spare time to clean it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
