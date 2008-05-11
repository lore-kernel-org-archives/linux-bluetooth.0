Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1210536259.581.7.camel@richard-desktop>
References: <1209820958.6736.12.camel@richard-desktop>
	<1210336684.28002.29.camel@violet.holtmann.net>
	<be0d0f5e0805091434o26b8595eg9e7bbe57e920a2b5@mail.gmail.com>
	<4826F4E2.80200@gmx.de>  <1210521709.6776.1.camel@richard-desktop>
	<1210525996.16390.12.camel@violet.holtmann.net>
	<1210536259.581.7.camel@richard-desktop>
Date: Mon, 12 May 2008 00:48:51 +0200
Message-Id: <1210546131.16390.20.camel@violet.holtmann.net>
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

Hi,

> i do understand this.. it is wrong and i wish i could find a valid fix
> for it.  but, no body seems to be able to do this.  before this code i
> had to use my wired keyboard and type in sudo /etc/init.d/bluetooth
> restart myself.  which is actually the only "fix" known - i.e. everyone
> with this keyboard has to just that to use it.... there is no other fix
> that i've found. so restarting it every 30 minutes myself, or having the
> comp do it every 1 minute automatically... i'm happy with this for
> now...
> 
> so, but yeah, until we find a cure, can someone just give me some cold
> medicine and tell me how to get rid of that notify bubble?  i'm thinking
> it is native to ubuntu though, as even with the bluetooth icon turned
> off, i now get the bubble at another location of the screen...

it is technically impossible. Since what you do is equal with a device
reset and that is what you see with the bubbles. The UI doesn't get any
detailed information and that is on purpose. We keep our UI stupid since
the intelligence should be done within the system daemon and no the
desktop system.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
