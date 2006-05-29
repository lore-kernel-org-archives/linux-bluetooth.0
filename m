Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Antonio Terreno <antonio.terreno@gmail.com>
In-Reply-To: <100466c40605161025y72f1d718j1e4868a2ebbd3db6@mail.gmail.com>
References: <100466c40605161025y72f1d718j1e4868a2ebbd3db6@mail.gmail.com>
Date: Mon, 29 May 2006 15:34:20 +0200
Message-Id: <1148909660.31689.62.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] concurrent service searches
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

Hi Antonio,

> > > why if I start multiple services search on different devices (always
> > > less than 7)
> > >
> > > in that way:
> > > sdptool browse "DEVICE_ADDR"
> > > [gnome-obex-send --dest "DEVICE_ADDR" file2send.txt] (optional)
> > >
> > > I get always errors (on 4-5 devices is fine, on 3-2 devices is "Failed
> > > to connect to SDP server on "DEVICE_ADDR": File descriptor in bad
> > > state")
> > >
> > > The situation is better if I wait 1 or even 2 sec before starting a
> > > new search and send.
> > >
> > > The problem was triggered developing a multithreaded bluetooth server
> > > in java, with avetana bluetooth.
> > > I dont have these problem using the same code on windows....
> >
> > you can't have multiple inquiry or page attempts at the same time. This
> > is a limitation of the baseband and not the host.
> 
> Baseband limitation? And why on windows looks working? The inquiries
> are somehow "buffered"?
> And why if I put a sleep on my code/script looks also working?
> Maybe cos the Search4Services are already terminated?
> 
> At this point, assuming that we can do just one service discovery&obex
> push by time what about putting 10 antennas and do one discovery for
> each antenna?
> 
> And if it's stupid to have 10 antennas, is it possible to have 7
> concurrent object push at the same time or it's always the baseband
> problem?

you can have only an inquiry or a page at the same time. That is
different. Once the connection has been established then you can run
another inquiry or create a second connection (with almost every modern
chips).

So if you have a connection (ACL link) you can run as many upper layer
protocols (SDP, RFCOMM, OBEX etc.) as you like on it. They are all
multiplexed and this is done by the Bluetooth subsystem of the Linux
kernel.

However we don't buffer inquiry or page requests. If the fail, they fail
and we don't try again.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
