Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3ad703600712110300j7a3e628cj1e4d55dd9d4a0d5b@mail.gmail.com>
References: <3ad703600712110300j7a3e628cj1e4d55dd9d4a0d5b@mail.gmail.com>
Date: Thu, 13 Dec 2007 17:15:54 +0100
Message-Id: <1197562554.5644.95.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Patch proposal for serial manager
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

Hi Geoffrey,

> I have added a connect service method in the serial service manager
> that take the address of an adapter as first parameter to be able to
> use more than one adapter. I realy would like to contribute to bluez
> and see my patch applied to the CVS. This is a first proposal, if you
> have any remarks, I will take them into account. 

first issue is the naming. You don't connect something to an adapter.
You use the adapter to connect to something. So it needs either to be
named ConnectServiceByAdapter or ConnectServiceFromAdapter. Join #bluez
channel on freenode.org to discuss this.

Second is that you did a nasty thing with the signature checking. That
is not how this should be implement. You should have your own callback
in the callback table. If code is shared between two callbacks then a
common function has to be created and both callbacks become a small shim
to call this function. Otherwise the code gets to complex and nobody
will understand it a year later.

Third is that we have to agree on the adapter parameter. Should it be
the adapter address or the adapter object path. Pros and cons needs to
be discussed on #bluez.

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
