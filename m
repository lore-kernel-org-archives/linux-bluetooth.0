Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2a9506370712130701t2c1c7d33ocd2c44fde5e2abf1@mail.gmail.com>
References: <2a9506370712130701t2c1c7d33ocd2c44fde5e2abf1@mail.gmail.com>
Date: Thu, 13 Dec 2007 17:00:54 +0100
Message-Id: <1197561654.5644.85.camel@aeonflux>
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

> It only exports a local (127.0.0.1) port, but could be easily modified
> to export a port from any host. It is really simple as all the hard
> work was already done for the Unix socket proxy. My primary interest
> is export the internal N810 GPS so other devices can use it.

patch looks good, but it contains to many unneeded hunks. Which
indicates that you only changed whitespace into tabs or vise versa.
Please use an editor that visually shows whitespaces and tabs.

First thing it is "unsigned short port" and not some "short int" or
something. This also means you can skip all reformatting in struct
proxy.

Don't introduce extra empty lines in your if or case statements. They
are not needed.

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
