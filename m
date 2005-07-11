Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand D-Bus service
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05071113164320e725@mail.gmail.com>
References: <e1effdeb05070811375af87810@mail.gmail.com>
	 <1120849681.7444.1.camel@notepaq>
	 <e1effdeb050711115470809e4a@mail.gmail.com>
	 <1121110034.5934.24.camel@notepaq>
	 <e1effdeb05071113164320e725@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1121117212.5934.34.camel@notepaq>
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
Date: Mon, 11 Jul 2005 23:26:52 +0200

Hi Claudio,

> My project goal is provide D-Bus support for pand 
> including automatic bridge creation and integration 
> with udhcp.
> 
> Setup the bt adapter is a dependency for me. bluetoothd is
> the daemon that was missing for provide  adapter configuration, 
> periodic inquiry and link setup. Some services(list adapters, 
> search, role switch) are being provided by pand D-Bus. 
> I know that is a incorrect approach, but they are required.
> 
> I am running behind the schedule, there are a lot projects
> (UPnP app, games) that require this feature for setup PANs. 
> Is it possible integrate the D-Bus services for pand?

as long as you don't introduce too much dependencies, there should be no
problem to include it. Simple send new versions to the mailing list and
when I have more time, I review them.

> After that can help you moving all code to bluetoothd.

I am going to develop it from scratch. I still have to solve some basic
problem with the new kernel interface.

> If you what I can help you developing bluetoothd?

Any help is always welcome. I will commit all code and compile it by
default, but don't install it.

> Regarding security, what are exactly the points that need
> by improved or developed?

The PIN code and link key handling for the kernel security manager.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
