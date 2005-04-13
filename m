Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Congratulation to qualification
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200504131635.25197.cijoml@volny.cz>
References: <200504122317.36423.cijoml@volny.cz>
	 <1113401810.9061.31.camel@pegasus>  <200504131635.25197.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1113430561.16014.9.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 14 Apr 2005 00:16:01 +0200

Hi Michal,

> > > It is great to have BlueZ qualificated. How did you do it, that company
> > > paid it? How expensive was it? Why only these two profiles and not
> > > others? Why not 1.2?
> >
> > this is correct. TomTom paid the listing fee for the qualification and
> > thus it is also listed under their name. The price for an adopter member
> > is 10,000 USD and I will not talk about any other expenses.
> >
> > The qualification of GAP and SPP and Bluetooth 1.1 only are because this
> > is what was needed to make it re-useable. Companies can now take this
> > listing and don't have to re-qualify the lower layers. A Bluetooth 1.2
> > or 2.0 qualification would have been nice, but actually there was no
> > time for it.
> 
> Are these planed too?

not at the moment and actually I only wanna do the testing again when we
have full L2CAP flow and retransmission and connectionless support. We
also need a lot more testing tools, because these automated tests can be
very picky about what they expect.

We also don't use any Bluetooth 1.2 or 2.0 features at the moment. All
features on the HCI level can't be qualified.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
