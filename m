Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060731181105.GI29916@suse.de>
References: <200607311518.57014.dgollub@suse.de>
	<200607311850.09567.dgollub@suse.de>
	<1154373472.4982.21.camel@aeonflux.holtmann.net>
	<200607312007.23046.dgollub@suse.de> <20060731181105.GI29916@suse.de>
Date: Tue, 01 Aug 2006 00:15:15 +0200
Message-Id: <1154384115.4982.30.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Addition for hcid passkey dbus request
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> > I planned to register kbluetoothd as default passkey agent and listen for all 
> > passkey request. Have to recjet this and think about a new solution. I am 
> 
> I believe that you still can do this.
> 
> > confused now, how to achieve that the pin dialog now can detect if it is the 
> > initiator side. When another application triggers the pairing without calling 
> > CreateBonding().
> 
> Well, improve kbluetoothd in a way, that it is just way more convenient
> to pair devices by using it than with any other application :-)
> Once you know that you initiated the pairing, you can pre-fill the pin
> field with a generated value.
> 
> Basically, i think we do not want many applications doing the pairing
> stuff, there should be one application (per desktop environment...), that
> handles this stuff well in a centralized place. For KDE, this could be
> kbluetoothd (or maybe a control-center plugin, which could then communicate
> with kbluetoothd). This probably give the best user experience.

don't try to over-engineer this. We thought about all this stuff
already. You can make kbluetoothd the default passkey agent and then you
can register a device specific passkey agent. This stuff is stacked and
hcid will first look for a device specific agent before calling the
default agent.

So you need a default passkey agent that will be always available (take
care of D-Bus disconnects btw.) and it has to handle unexpected pairing
requests. In the case you connect to a phone and you want to pair (in
somekind of connection wizard), then you register a device specific
passkey agent and call CreateBonding(). It is that simple.

If something is actually not working as expect or documented in
dbus-api.txt then this might be simply a bug. The current D-Bus API for
BlueZ should be enough to handle all basic tasks. We thought really
careful about all methods and signals that are needed. However we might
have missed something, but you need a good argument to convince me that
something additional is needed.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
