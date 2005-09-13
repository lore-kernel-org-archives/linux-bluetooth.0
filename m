Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with role switch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <5f30e26105091219156b689b30@mail.gmail.com>
References: <5f30e26105091219156b689b30@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126588119.28181.0.camel@localhost.localdomain>
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
Date: Tue, 13 Sep 2005 07:08:39 +0200

Hi Jeff,

> I'm a student in computer science, working on making Bluetooth do a
> certain task.  I wrote my own application as a proof-of-concept, using
> the source code from the various BlueZ utilities as an example.  Now
> I'm stuck, and I need some help troubleshooting.
> 
> Here's what my program does:
> First, host A starts up listening on RFCOMM channel 10.  Then host B
> connects, B sends to A, A sends to B ... for a total of three
> send()/recv() cycles.  Then both sides close() their sockets and sleep
> for ~ 30 seconds.  Then they switch roles and B listen()s for A to
> connect().  [ I don't actually explicitly issue any HCI command for
> this role switch, it just automagically happens. ]  Go back to the
> beginning and repeat 3 times.
> 
> So much for the program overview.  Now on to the post mortem of where
> it fell apart:
> 
> For the first cycle, they connect, exchange messages, disconnect, and
> both sides close their sockets.  Everything works as expected.
> 
> Then I switch roles, so that host B listens and host A connects.  This
> second cycle also works as expected.
> 
> On the third cycle, I try to switch roles again, so that A listens and
> B connects.  Every time I get to this third cycle, host A fails on
> bind() with EADDRINUSE, "Address already in use".  (I set
> SO_REUSEADDR, with no effect.)
> 
> Both hosts have Linux 2.6.11.6-mh2, hcidump ver. 1.19, and identical
> USB dongles (hciconfig posted below).  Can you help me understand what
> I've run into?  Is this a bug in BlueZ (probably not!), or a
> limitation of Bluetooth?  Or is it my mistake?

this sounds like a bug inside your code.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
