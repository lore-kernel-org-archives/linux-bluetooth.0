Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202773661.3491.187.camel@cookie.hadess.net>
References: <1202751011.3491.165.camel@cookie.hadess.net>
	<1202752232.7664.178.camel@violet>
	<1202752359.3491.168.camel@cookie.hadess.net>
	<1202768715.7664.188.camel@violet>
	<1202773661.3491.187.camel@cookie.hadess.net>
Date: Tue, 12 Feb 2008 01:12:00 +0100
Message-Id: <1202775120.7664.205.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make search button (and discovery) work
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

Hi Bastien,

> > > > > Seems that some bits of client.c got mistakenly commented. The #endif
> > > > > should be before the call to DiscoverDevices, not after.
> > > > > 
> > > > > So I fixed this up and finished the work to make the search button
> > > > > behave as expected. I guess we should have it by default now.
> > > > 
> > > > where do you need the extra marshal entry for?
> > > 
> > > For the client.c signal changes in bluetooth_client_class_init().
> > 
> > patch has been applied, but I removed the two g_message calls.
> 
> I forgot to mention those were there for debugging, and that they should
> be removed before commit. I hope they were at least useful for your
> testing :)

just fixed a signal issue with it. Noticed only after the 0.19 release.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
