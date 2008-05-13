Return-Path: <cyrus@holtmann.org>
From: Laurent Almeras <lntalm@free.fr>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <mailman.182757.1209832934.29930.bluez-devel@lists.sourceforge.net>
References: <mailman.182757.1209832934.29930.bluez-devel@lists.sourceforge.net>
Date: Tue, 13 May 2008 22:23:52 +0200
Message-Id: <1210710233.3028.22.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Link authentication problem with Logitech Dinovo
	Edge
Reply-To: lntalm@free.fr,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

> Date: Sat, 03 May 2008 18:42:14 +0200
> From: Laurent Almeras <lntalm@free.fr>
> Subject: [Bluez-devel] Link authentication problem with Logitech
> 	Dinovo Edge
> To: bluez-devel@lists.sourceforge.net
> Message-ID: <1209832934.29676.14.camel@localhost.localdomain>
> Content-Type: text/plain; charset="us-ascii"
> 
> Hello,
> 
> 
> I'm currently experiencing connection problem with my Logitech Dinovo
> keyboard. I can realise pairing via gnome bluetooth-applet (popup asks
> for passkey, I type in on computer, then on keyboard => popup says all
> is fine). But then, each time I type a key on the bt keyboard, I have
> the following message in /var/log/messages and the connection fails (in
> the gnome bluetooth program, connect icon appears for 2 seconds then
> disappear).

I'm no longer experiencing this problem. After downgrading/upgrading
several times, gnome UI asks me to authorize my keyboard (yes/no dialog)
in place of asking a pin pairing (pin entry dialog). I don't know why ;
but now my keyboard works fine.


Thanks for your work



Laurent


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
