Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Chafik Moalem <Chafik.Moalem@perdictum.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1164788211.17085.53.camel@chmo.prologistik.com>
References: <20061128071440.25196.qmail@bux.stollmann.net>
	<1164788211.17085.53.camel@chmo.prologistik.com>
Date: Wed, 29 Nov 2006 10:12:41 +0100
Message-Id: <1164791561.5071.5.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BECI
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

Hi Chafik,

> hmmm ... as I understood so far : 
> a BECI Module with the right abstraction API (dbus) might "replace"
> bluez then ?

or we write a daemon that maps our D-Bus base API over BECI and all
application using our API will working on top of both.

> btw.: I am currently working with a uart module which has already a
> complete BT-Stack with profiles and all the needed logic implemented
> "inside" a CSR BC03MM ! All I need to do is initiate profile, initiate
> connection (implicit pairing), open SCO et voila : I have a nice
> PCM-eSCO connection to my HS ! just testing concurrent connections at
> the moment (SPP + HSP)
> 
> Just have a look at
> http://www.lintech.de/index.php?index=19&pc=4&p=36  
> .. the datasheet is "on click" 

I know these kind of systems. Their usage always depends on how much
control you want and actually need.

> when they talk about "API" they mean a simple serial (uart) message
> format :)

No idea.

> Well if I have a bit more time I should try to implement a "special"
> uart<->dbus layer ... i think it is something pre-BECI !

Feel free to do so.

> Did you hear about other modules already implementing such intelligent
> subsystems and already available?

Almost every Bluetooth chip manufacturer provides a serial port profile
module somehow.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
