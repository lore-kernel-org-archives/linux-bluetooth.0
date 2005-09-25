Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Wacom Graphire Bluetooth  problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050924200358.GJ28437@polar.elf12.net>
References: <20050924200358.GJ28437@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1127644165.6362.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 25 Sep 2005 12:29:25 +0200

Hi Robert,

> Good news: I have a bluetooth tablet working under the Linux HID support.
> Bad news: it's far from usable.
> 
> It's called Wacom Graphire Bluetooth. So far I got it connected if I
> switch off authentication and encryption. Of course it works only mouse
> like but limited:
> 
> -pointer is moving a bunch of pixels in one go (on my 17" I have 1cm
>  jumps) - I expected pixel by pixel moves like my mouse does.
> -If the device stays connected a while (or maybe after some kind of
>  input), the events get processed slower
>  and queued. E.g. If I move the mouse/pen rapidly, so it does on the
>  screen, but after a while the pointer on the screen still starts moving
>  with my movements, but slower, and when I stop after some crazy testing
>  I can see the pointer on the screen still doing it's duty.
> 
>  Switching off and on the table seems to reset the issue.
> 
> -Click/Button events provoke pointer movement, but finer than the "grid"
>  mentioned. E.g. click --> pointer 2 pixels to the right, click --> pointer
>  4 pixels up and one pixel right.

are you using the -mh patch for the latest 2.6 kernel?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
