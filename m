Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
From: Marcel Holtmann <marcel@holtmann.org>
To: Julien Campana <juliencampana@yahoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085496174.900.127.camel@fischer>
References: <1085393268.892.40.camel@fischer>
	 <1085487245.9779.89.camel@pegasus>  <1085489942.900.89.camel@fischer>
	 <1085492205.9779.119.camel@pegasus>  <1085496174.900.127.camel@fischer>
Content-Type: text/plain
Message-Id: <1085497660.9779.139.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 May 2004 17:07:40 +0200

Hi Julien,

> There are main reason why I rewrote some BlueZ functions is that:
> - Functions like "sdp_service_search_attr_req" return a list of
> sdp_record_t. If I had to parse these sdp_record_t  in order to
> construct the requested Java Objects, this would have been an amazing
> amount of switch or if statement. The best solution was therefore to
> directly send the bytes to the java implementation.

put this problem up in a seperate thread on the mailing list and tell
how the Java Objects have to look like. We should find a better solution
for that.

> > What I also don't wanna use is somekind of "de.avetana.bluetooth" vendor
> > extensions. If something is not possible in pure Java JSR-82, sorry not
> > my bad ;)
> 
> JSR-82 provides just the minimal amount of classes. It lets the
> programmer use "background classes" but this is transparent for the
> end-user (I will give some example of this transparency in the future
> how-to). These de.avetana.bluetooth.* classes are really needed to fully
> implement all javax.bluetooth.* classes.

You must explain this to me in detail, because I don't understand why.
Actually I think we should avoid this.

> > The native interface should only be a wrapper. Let's talk about the
> > stuff and put some of it back to the Bluetooth library where it should
> > belong.
> 
> I would say that 90% of the native interface is today a wrapper. Only
> the service search uses home-made-functions derived from the BlueZ code.

As said already, lets fix this in the Bluetooth library itself. I know
that SDP itself is a horrible mess of object oriented stuff, but I think
we will find a solution for it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
