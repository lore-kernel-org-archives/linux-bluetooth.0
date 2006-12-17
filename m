Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Neil MacLeod <gmane@nmacleod.com>
Date: Sun, 17 Dec 2006 17:45:42 +0000
Message-ID: <em3vo7$2cs$1@sea.gmane.org>
References: <elvlcl$drg$1@sea.gmane.org>
	<1166358880.6557.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1166358880.6557.25.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Nokia 770 / Sony Ericsson UIQ3 pairing / DUN
	problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> my wild guess would be that this phone has a similar problem as my
> Motorola RAZR V3x. If you use service search attribute request then it
> can't handle it, because that is not mandatory in the qualification.
> However it is mandatory to respond, but I think the Bluetooth part of
> the phone simply crashes at this point and leaves and unmaintained ACL
> link behind. The reset action on the Nokia 770 will clean this link and
> give the phone the chance to be able to reset itself. No matter what
> this phone is broken and it is not on the Linux software side.
> 
> Their might be an interop problem with the TI chip against the Philips
> chip for some strange reason, but you need a protocol analyzer to watch
> the LMP traffic. It could happen that a internal chip buffer on one side
> get overflooded by the response to the SDP request. It would be worth to
> see if you can reproduce this behavior with a CSR chip on normal PC
> hardware.
> 
> Besides that, this phone should support PAN for Internet access and I
> advise you to actually use it. Then you only have to obtain everything
> via DHCP and you are good.
> 
> Regards
> 
> Marcel

Thanks for the reply Marcel.

Hopefully a firmware upgrade for the phone will fix it, but I won't hold my breath. :(

The Nokia 770 works perfectly with my former phone - a Sony Ericsson T610, which is quite an old phone and not a Smartphone. Unfortunately I don't have a BT dongle for a PC so can't confirm the behaviour with a CSR chip.

I'll have a look at PAN but I'm not sure if the Nokia 770 supports this.

Finally, does anyone have any suggestions how it may be possible to contact the Symbian/SonyEricsson developers and ask them to look at fixing this? Newsgroups, web sites etc? I have a feeling contacting SonyEricsson CS will be a painful and fruitless excercise!


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
