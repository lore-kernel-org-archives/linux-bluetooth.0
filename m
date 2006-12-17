Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <86538205C715094CB44B7EB1119B886B31D302@nts028.kuka.de>
References: <86538205C715094CB44B7EB1119B886B31D302@nts028.kuka.de>
Date: Sun, 17 Dec 2006 13:42:22 +0100
Message-Id: <1166359342.6557.33.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] pand connection debug
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

Hi Torsten,

> i have successfully set up a pan connection between my laptop and my
> hand phone using this command:
> 
> pand -r NAP -d PANU -c xxx -n
> 
> If I try to access the connection from the phone (e.g. by browser) it
> says network connection error. Im not suprised, because there is
> nothing configured. The problem is: how to get information about the
> bnep interface. Ive read the PAN-HowTo. But it seems outdatet,
> because:
> 
> - their is no interface shown calling ifconfig  
> - their is no  /etc/sysconfig (at least at my distri, which is ubuntu
> 6.10) 
> - their is no /etc/bluetooth/pan folder or dev-up script
> 
> Does someone know of some more current information or how to configure
> this connection?

every distribution is a little bit different when it comes to
configuring the network interfaces. The Ubuntu is Debian based
distribution and so you should do it the Debian way. You might simply
call "man interfaces" and follow up on that. The bnep0 interfaces behave
like every other hotplug network card.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
