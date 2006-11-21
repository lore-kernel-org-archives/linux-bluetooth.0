Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <200611211021.kALALWc1030513@news01.csr.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <b5dccebe0611210140u7ab8b44dv392d83826b7af205@mail.gmail.com> 
References: <b5dccebe0611210124h5076b396xa2e9c0617658cf13@mail.gmail.com>
	<1164101366.28429.22.camel@localhost>
	<b5dccebe0611210140u7ab8b44dv392d83826b7af205@mail.gmail.com>
Date: Tue, 21 Nov 2006 10:21:32 +0000
From: Peter Stephenson <pws@csr.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] concurrent operations
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

"Mikael Lindqvist" wrote:
> And a "page" does that mean a service search? I've seen the term page
> in the bluetooth standard but haven't really understood it. What about
> several "pages" at the same time, i. e. service search for several
> remote devices at the same time?

Paging is the period when you're trying to connect to the remote
device.  This takes variable amounts of time, depending on how
frequently the remote device is scanning.  Since scanning takes power,
most devices only scan occasionally.  For a battery powered device, once
every 1.28 seconds is typical.  Since the scan is short, it's important
that the paging device devote the entire radio bandwidth to trying to
pick up the remote device.  Hence you're stuck with not being able to do
anything else at this point.

The same argument applies to inquiry (device discovery), although it's
intrinsically unreliable --- you're not guaranteed to discover
everything.

Once connected it's possible to timeslice between different remote
devices (although there are more complicated issues to do with network
topology lurking).  The actual service search takes place when
connected, but the chances are the paging process before took longer, so
that will dominate the time.

pws


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
