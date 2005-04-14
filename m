Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] first(?) bc4 module
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0504141909360.29800-100000@redbean.intranet.gw-instruments.de>
References: 
	 <Pine.LNX.4.33.0504141909360.29800-100000@redbean.intranet.gw-instruments.de>
Content-Type: text/plain
Message-Id: <1113500184.8989.65.camel@pegasus>
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
Date: Thu, 14 Apr 2005 19:36:24 +0200

Hi Peter,

> > > Things again look very different if you use a BC04 with internal SCO
> > > routing (e.g. for a A2DP headset). But this is a diffrent story.
> >
> > The SCO stuff has nothing to do with A2DP, because this is ACL based.
> 
> Of cause ! My mistake. However, even this ACL may be routed internaly on
> some future chips (maybe there will be something like a BC04MM........).
> I just wanted to point out that for special applications EDR can be
> usefull even if there is no fast Host to CHip connection. But such
> applications usually won't use BlueZ. So this is somehow unrelated here.

you will really need a BlueCore4 with DSP for it, because otherwise you
don't know what to do with all the data ;)

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
