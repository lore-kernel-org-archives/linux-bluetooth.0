Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2a9506370712131041x6a356138nbc5d2e2fbc6bbc7c@mail.gmail.com>
References: <2a9506370712130701t2c1c7d33ocd2c44fde5e2abf1@mail.gmail.com>
	<1197561654.5644.85.camel@aeonflux>
	<2a9506370712131041x6a356138nbc5d2e2fbc6bbc7c@mail.gmail.com>
Date: Thu, 13 Dec 2007 20:09:48 +0100
Message-Id: <1197572989.5644.105.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Patch] Extending the serial service to export
	a	TCP socket.
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

Hi Vinicius,

> > > It only exports a local (127.0.0.1) port, but could be easily modified
> > > to export a port from any host. It is really simple as all the hard
> > > work was already done for the Unix socket proxy. My primary interest
> > > is export the internal N810 GPS so other devices can use it.
> >
> > patch looks good, but it contains to many unneeded hunks. Which
> > indicates that you only changed whitespace into tabs or vise versa.
> > Please use an editor that visually shows whitespaces and tabs.
> 
> Many of these hunks were showing whitespace being removed from the end
> of some lines.   Also there was a line with just a tab on it.

and your new patch introduced as many as it fixes. I am serious about
this and once you look at the diff file, I can even tell without
whitespace visualization. I fixed it up for you, but make sure in the
future this is all sane and sound. Patch is in the CVS.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
