Return-Path: <cyrus@holtmann.org>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 3 Apr 2008 09:37:08 +1000
References: <47EDAEED.4000302@aircable.net>
	<200803311404.06902.denis.kenzior@trolltech.com>
	<47F3AEBC.9010407@idlum.be>
In-Reply-To: <47F3AEBC.9010407@idlum.be>
MIME-Version: 1.0
Message-Id: <200804030937.08794.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] CreateProxy usage?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pierre-Yves,

> I've observed the same thing: rfcomm ttys are not reliable. I've
> reported several time Oopses related to them, and so far each time one
> Oops/Warning/Bug is fixed, another one happens. Basically, I know no
> kernel version which is robust regarding rfcomm ttys.

We haven't observed this in the newer kernels, but I'm sure they exist.

>
> At the moment I'm looking for a reliable alternative to the ttys. From
> what I understand, using an rfcomm socket instead of the ttys would be a
> solution, as they are reputed more reliable. But going the socket's way
>   would mean abandonning the DBus API and linking against the bluetooth
> lib, or am I mistaken? My application is currently only accessing BlueZ
> through this DBus API, and it is indeed a great API. It would be sad to
> have to abandon that to get reliable rfcomm functionnality.
>
> I've no experience at all with the rfcomm sockets from the Bluetooth
> library (so take what I say with the required amount of salt). Wouldn't
> a solution be to allow opening sockets through the DBus serial service,
> instead of the current rfcomm ttys-only approach? I'm talking mostly
> about the ConnectService and ConnectServiceFromAdapter in the serial
> manager hierarchy.

Using sockets is fairly trivial, there are plenty of examples of how to use 
RFCOMM sockets in the bluez-utils.  Look under test/rctest.c for instance.  
You don't need to link against libbluetooth if you don't want to (e.g. for 
GPL license reasons), however you will have to re-invent some functionality 
yourself (e.g. Address parsing, etc).  

You will need some form of socket no matter what you do (e.g. use Bluetooth 
sockets directly, or use the Serial Proxy, which will still require unix 
domain or tcp sockets)

As a shameless plug, Qtopia has a much simplified socket API: 
http://doc.trolltech.com/qtopia4.3/qtopiabluetooth.html.

>
> Denis, could you also expand further about the kind of patching you
> perform on your kernels, regarding rfcomm tty's reliability?

See my patch submission from a few days ago.  Basically the current bugs are 
that tty doesn't do proper echoing and data can get lost during socket->tty 
adaptation (so a serious problem for HFP, GPS, etc)

-Denis

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
