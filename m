Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-F10B62AEDB77D8899D55CEABFDE0@phx.gbl>
In-Reply-To: <1165152937.19590.12.camel@localhost>
From: "Kelvin Xu" <kyoxu@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 05 Dec 2006 13:22:12 +0800
Mime-Version: 1.0
Subject: Re: [Bluez-users] PAN connection to a handphone
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

Hi Marcel,

Do i set up my computer as a PANU/GN or NAP node if i want to connect to my 
handphone for internet connection?

Regards,
Kelvin


>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
>To: BlueZ users <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] PAN connection to a handphone
>Date: Sun, 03 Dec 2006 14:35:37 +0100
>
>Hi Kelvin,
>
> > I have read the article. My question if the PAN consisted of only my
> > computer and my handphone. Would i be able to access the internet 
>through my
> > handphone which is GPRS enabled.
>
>in general it is as simple as establishing a BNEP connection to your
>cellphone with pand and than run DHCP on the new bnep0 interface. You
>will have Internet access as long as you configured your phone and set
>the correct GPRS AP.
>
>Regards
>
>Marcel
>
>
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share 
>your
>opinions on IT & business topics through brief surveys - and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Get MSN Messenger emoticons and display pictures here! 
http://ilovemessenger.msn.com/?mkt=en-sg


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
