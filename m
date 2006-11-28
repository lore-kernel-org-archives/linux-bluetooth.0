Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <001201c712e9$3ae9cfb0$3978f052@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<1164536005.25914.8.camel@aeonflux.holtmann.net>
	<002801c7125f$7197b7f0$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0611281118300.29749@redbean.intranet.gw-instruments.de>
	<000701c712dc$8e44ff20$3978f052@kayleigh>
	<Pine.LNX.4.63.0611281215240.29749@redbean.intranet.gw-instruments.de>
Date: Tue, 28 Nov 2006 13:32:06 +0100
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Master / Slave question
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Peter,

> There is no real hard limit for the number of adapters you can use with
> BlueZ. Link key managment may become a little bit confusing (on the phone
> side) because the Link key is bound to the BT address of the adaptor. So
> if a phone connects to, say adaptor 1 the first time and then to adaptor 2
> the second time it must pair again 8if your application needs security at
> all).

That's ok as I don't need security to be enabled :)

> I think most phones should, in general, support Master/Slave switch.
> However, even when th Bluetooth implementation on the phone supports it,
> it is possible that a role switch request is rejected on the profile layer
> (depends on implementation).

Unfortunately, Nokia mobile phones (implementing the JSR 82) have a
problem with role switch, and definetely can't do it ... So if they
initiate the connection, they will remain master, and my linux bluetooth
key slave :) Trying to force to "master=true" in the btspp: URL or
putting lm=master in hcid.conf automatically raises a "role switch"
exception Nokia phone-side.

> For a server application like yours I would suggest to use the role
> switch feature in a more relaxed way. So, once a connection comes in try
> to do a role switch. If it succeed it is fine and you're able to accept an
> additional connection. If it fails you're out of resources but at least
> can service the current connection.
>
> However, if I understand it right you can not set this behaviour in
> hcid.conf. You have to implement it in your application.

What do you mean by implementing this in my application ? Is it
possible to manually deal with this in my server application ? Would you
have a location with examples ?

Thanks a lot, I feel more clever now, and at least understand why I
haven't succeeded !

Oli 



-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.409 / Virus Database: 268.14.19/555 - Release Date: 27/11/2006


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
