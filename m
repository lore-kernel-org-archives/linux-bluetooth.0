Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 31 Jul 2006 20:07:22 +0200
References: <200607311518.57014.dgollub@suse.de>
	<200607311850.09567.dgollub@suse.de>
	<1154373472.4982.21.camel@aeonflux.holtmann.net>
In-Reply-To: <1154373472.4982.21.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200607312007.23046.dgollub@suse.de>
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

On Monday 31 July 2006 21:17, Marcel Holtmann wrote:
> you can't bind incoming or outgoing connections with the assumption that
> this implies the initiator of the authentication request. It is not
> working this way. Both are two independent procedures (except for
> security mode 3, which is not really supported by BlueZ anymore).
i wasn't aware of this. thanks!

>
> So if you wanna have a random key generated on one side, then you need
> to be the initiator of the pairing request. This can be achieved with
> calling CreateBonding() and in this case you can register a device
> specific passkey agent to create your random number.
>
> The default passkey agent is really meant to be default. It will do the
> same task for every pairing request. If you need a specific, like random
> number or fixed PIN then use a per device passkey agent.

Thanks for  the hint!

I planned to register kbluetoothd as default passkey agent and listen for all 
passkey request. Have to recjet this and think about a new solution. I am 
confused now, how to achieve that the pin dialog now can detect if it is the 
initiator side. When another application triggers the pairing without calling 
CreateBonding().

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
