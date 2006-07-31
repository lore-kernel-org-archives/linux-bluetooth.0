Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200607312007.23046.dgollub@suse.de>
References: <200607311518.57014.dgollub@suse.de>
	<200607311850.09567.dgollub@suse.de>
	<1154373472.4982.21.camel@aeonflux.holtmann.net>
	<200607312007.23046.dgollub@suse.de>
Date: Tue, 01 Aug 2006 00:21:35 +0200
Message-Id: <1154384495.4982.33.camel@aeonflux.holtmann.net>
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

Hi Daniel,

> > So if you wanna have a random key generated on one side, then you need
> > to be the initiator of the pairing request. This can be achieved with
> > calling CreateBonding() and in this case you can register a device
> > specific passkey agent to create your random number.
> >
> > The default passkey agent is really meant to be default. It will do the
> > same task for every pairing request. If you need a specific, like random
> > number or fixed PIN then use a per device passkey agent.
> 
> Thanks for  the hint!
> 
> I planned to register kbluetoothd as default passkey agent and listen for all 
> passkey request. Have to recjet this and think about a new solution. I am 
> confused now, how to achieve that the pin dialog now can detect if it is the 
> initiator side. When another application triggers the pairing without calling 
> CreateBonding().

see my other email for how this is supposed to work. And you should play
with the example passkey-agent from bluez-utils source. This one can be
a default or a device specific passkey-agent. Then you will understand
how this is working.

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
