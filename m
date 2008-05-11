Return-Path: <cyrus@holtmann.org>
From: Gmail <patnjer12@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1210525996.16390.12.camel@violet.holtmann.net>
References: <1209820958.6736.12.camel@richard-desktop>
	<1210336684.28002.29.camel@violet.holtmann.net>
	<be0d0f5e0805091434o26b8595eg9e7bbe57e920a2b5@mail.gmail.com>
	<4826F4E2.80200@gmx.de>  <1210521709.6776.1.camel@richard-desktop>
	<1210525996.16390.12.camel@violet.holtmann.net>
Date: Sun, 11 May 2008 16:04:19 -0400
Message-Id: <1210536259.581.7.camel@richard-desktop>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Disable Notify Bubble?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

lol
i do understand this.. it is wrong and i wish i could find a valid fix
for it.  but, no body seems to be able to do this.  before this code i
had to use my wired keyboard and type in sudo /etc/init.d/bluetooth
restart myself.  which is actually the only "fix" known - i.e. everyone
with this keyboard has to just that to use it.... there is no other fix
that i've found. so restarting it every 30 minutes myself, or having the
comp do it every 1 minute automatically... i'm happy with this for
now...

so, but yeah, until we find a cure, can someone just give me some cold
medicine and tell me how to get rid of that notify bubble?  i'm thinking
it is native to ubuntu though, as even with the bluetooth icon turned
off, i now get the bubble at another location of the screen...

On Sun, 2008-05-11 at 19:13 +0200, Marcel Holtmann wrote:
> Hi,
> 
> > sudo crontab -e
> > 
> > then
> > 
> > * * * * * val=`hciconfig -a 2>/dev/null | head -c 1`; [ -z $val ]
> > && /etc/init.d/bluetooth restart
> > 
> > then exit and save
> 
> don't give people ideas. This is wrong. It is simply plain wrong and you
> have no clue what it is actually doing. This script only treats symptoms
> and not the problem. Actually that this works for you is simply pure
> luck.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
> Don't miss this year's exciting event. There's still time to save $100. 
> Use priority code J8TL2D2. 
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
