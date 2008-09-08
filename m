Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48C562D4.9020005@free.fr>
References: <48C0E513.1040304@free.fr>
	<1220633911.6714.86.camel@californication> <48C562D4.9020005@free.fr>
Date: Mon, 08 Sep 2008 20:06:59 +0200
Message-Id: <1220897219.11655.2.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Some bluez-gnome 1.2 bugs
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Fabien,

> >> I just started to play recently with bluez 4.x.
> >>
> >> I found at least two very annoying bugs in the bluez-gnome-1.2 wizard:
> >>    - On my debian testing system,  the wizard does not allow me to enter
> >> the pin code. The pin code just gets displayed a fraction of second an
> >> then disappears. As a consequence the default 123456 pin code gets used
> >> and pairing fails.
> > 
> > I am working on improving the PIN handling way, but at the same time I
> > have to make sure that it works with Simple Pairing and in the most
> > simple way. It is not that easy.
> 
> I just retried with the latest 1.3 release. This time i am able to pair 
> my headset. :-)

it is not perfect yet. Just a quick hack to pick 0000 as PIN code for
headset devices.

> > Also for some devices the PIN code needs to be random instead of 123456.
> > 
> >>    - If i try to go back to the first wizard page where my bluetooth
> >> device is displayed, it is already selected. I have no way to go to the
> >> next page : the next button stays grey whatever i do. (screenshot attached).
> > 
> > Hold shift while selecting to unselect and then select again. I know
> > that this is broken.
> 
> Looks you fixed that too :-).

It was actually pretty simple to fix.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
