Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid and bluetoothd
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050914064849913a76@mail.gmail.com>
References: <e1effdeb050914064849913a76@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126775298.28510.40.camel@station6.example.com>
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
Date: Thu, 15 Sep 2005 11:08:18 +0200

Hi Claudio,

> You said in an old e-mail that hcid is your playground for D-Bus
> services. Probably, hcid D-Bus should be the starting point for
> bluetoothd.

since it is there and used, I think it is a good idea. At the moment it
is optional and so we can test it. At some point I will make bluez-utils
depend on D-Bus.

> I would like to align your ideas to avoid future reworks.
> 
> D-Bus provides 4 types of messages:
> 1. Method call
> 2. Method reply
> 3. Signals
> 4. Error
> Currently, only signals are sent. The following signals are sent as
> result of the hci commands:
> - InquiryStart
> - InquiryResult
> - InquiryComplete
> - RemoteName
> path: /org/bluez/DevAgent
> interface: org.bluez.DevAgent
> 
> The topics that I want discuss are:
> 1. hcid signals
> In my opinion it is not necessary send signals to notity inquiry
> start/complete. Only signals for news devices are enough. 

The idea behind also sending the InquiryStart and InquiryComplete events
is that applications can show some graphical indications that the local
device is now scanning for new devices in range. Since people can still
call "hcitool scan" it is need for applications to know when someone
else starts an inquiry.

> Another aspect is, inquiry result can contain repeated devices. This
> approach could cause D-Bus app client overhead(inconsistency), by
> other hand if periodic inquiry is active repeated signals must be sent
> because more than one client can be filtering these signals and they
> can start at different time. :)

And the RSSI values may changes in the repeated reponses. The clients
must do the filtering. There is no other way.

> 2. hcid and bluetoothd object path
> What is the object path that you want use?
> I suggested in an old email use a hierarchical paths. bluetoothd can
> be the main object path provided at /org/bluez/bluetoothd, hci D-Bus
> services could be provided at /org/bluez/bluetoothd/hci

The general idea is to abstract from any daemon names or Bluetooth
specification details. This makes it possible to reuse this interface
with FreeBSD in the future.

> 3. D-Bus services
> hci D-BUS services is the next step, I am going to starting coding
> ASAP. Regarding inquiry requests, what kind of implementation do you
> prefer, send method reply message or send only signals(like the
> current)?

We can do both, but I think signals should be preferred. This allows
graphical applications to dynamically update their lists.

> If you use signals, all D-Bus client capturing D-Bus hci signals are
> able to see the new devices found. Using a method reply only the peer
> (requestor) will receive. Using a method reply approach, we can
> implement device class filters and avoid repeated devices. We have the
> same problem for remote name, disconnect, authentication/security,
> info, role switch and display connections.

We should keep an eye on security, but the idea is to send stuff to
everybody that is interested in it.

> 4. bluetoothd
> There are shared codes like(pand/bnep.c, pand/sdp.c, hidd/sdp.c, ...)
> that we need be aware.
> It is NOT clear for me how hcid and bluetoothd should work. hcid must
> be running all the time, but the hci D-Bus service will be running
> only if the system has a D-Bus system daemon running. Therefore, who
> should register the hci object path? IMHO, bluetoothd should
> centralize all D-Bus services. It will not be easy separate the
> "normal" code from the "D-Bus code". Maybe your "new interface" that
> your are defining can solve this problem.

Once bluetoothd is in place hcid would no longer be needed.

> 5. new interface
> You said that a new interface for kernel and the userspace
> communication is being defined. What is the current status?

I am working on it.

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
