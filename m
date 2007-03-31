Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1175283949.5851.3.camel@localhost>
References: <BAY124-W15053C673FC32A41B2AF00F0630@phx.gbl>
	<1175283949.5851.3.camel@localhost>
Date: Sat, 31 Mar 2007 15:44:29 +0200
Message-Id: <1175348669.5815.251.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Multithread Service Discovery
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Malte,

> > I'm currently running a C program for service discovery on a list of
> > devices. The function loops through the list elements and performs an
> > SDP enquiry on each device and returns the results to the screen, but
> > I'm finding that if i get a slow device in the list it can hold things
> > up a little, and in general it would be fantastic to hit all the
> > devices with an enquiry simultaneously.
> 
> Multithreading is possible, I use the OpenThreads library to do so for
> the same reasons. Attention, OpenThreads is OO and C++ so you might look
> for another solution like pthreads.

if you have a recent kernel then this might work since the kernel queues
the page requests. However in general a simultaneous service discovery
(or name resolving for that matter) is not possible. The chips baseband
can only page one remote device at a time. So even if it looks like
simultaneous service discovery. It is not. The kernel serializes it for
you and this means the same page timeout problems appear when devices
are out of range.

The only way to speed this up is to change the page timeout value of the
Bluetooth chip.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
