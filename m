Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with Logitech Cordless Desktop NX for
	Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Ehrenthal <dizzinger@gmx.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411011547.55236.dizzinger@gmx.net>
References: <200411011547.55236.dizzinger@gmx.net>
Content-Type: text/plain
Message-Id: <1099323590.16247.127.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 01 Nov 2004 16:39:50 +0100

Hi Florian,

> i do have some difficulties with my bluetooth keyboard. one really annoying 
> thing is, that i cannot control my bootloader (nor my bios) with my bluetooth 
> keyboard. the thing is, if i pair my keyboard using windows i am able to use 
> the kb during boot procedure. so there is probably something wrong with my 
> init-scripts? can anyone please point out what the issue might be?

this has nothing to do with any init scripts, it is the HID proxy thing
and maybe the one from Logitech (a modified and extened version of the
one from CSR) is a little bit strict here. In general this should work
perfect, but using your keyboard with encryption and switching between
operating system is not really possible. However storing the link key on
the Bluetooth chip itself might helps here, but I haven't tried it so
far and Linux has no easy support for it at the moment.

> second thing i noticed, those multimedia keys that are literally everywhere on 
> that keyboard don't seem to function, at least the majority doesn't (like 5 
> out of 32 work, the others don't seem to generate keycodes).
> in a recent posting to that list i read something that this might be related 
> to boot-mode or something (if i got that right), but i am unsure if that 
> relates to my setup. hidd -show tells me that keyboard and mouse are in 
> boot-mode. what info do i need to provide to receive some help?
> btw, why doesn't the keyboards win-key work, when the numpad is active, is 
> that related?

If hidd says you are in boot mode then you are in boot mode, but your
kernel can't switch into report mode. The -mh patch is missing, because
the full report protocol support is not in the mainline kernel yet. The
keyword here is independent HID parser.

And I don't know anything about the Windows-Key, because actually I
never used it in my entire life.

> and there is one more thing that annoys me: there are certain words where 
> parts of the word get repeated. hmm, it's hard to explain that - it might 
> even be related to my bad typing style (which is not really 10-finger-typing, 
> it's more like 6-finger typing ;)
> let me give you an example: if i type the word "hier" i usually get "hieier" 
> as output. i can reproduce the problem if i hit (and hold) the keys h, i and 
> e at the same time. now if i press the r key to complete the word, and 
> release the other buttons as well, i get "hieier" as a result. 
> if i remember correctly, this doesn't happen using windows, so i guess it must 
> be related to bluez somehow. i'd love to provide further info, to get that 
> solved. (well, maybe i will have to simply improve my typing style ;)

This will go away when using the report mode. It is a problem of the
boot mode.

> And theres another thing i wanted to express for quite some time now: Marcel, 
> thanks a lot for all the hard work you're putting into this. sometimes i have 
> the impression that you never actually sleep, as you replay to mailings on 
> that list usually only 5 minutes after they arrived - no difference if that 
> message arrived like 3 o'clock in the morning or 15:00 o'clock.
> additionally i had the chance to attend one of your presentations this years 
> linux tag. that was one of the best i heard!
> long story short: thanks!

Many thanks for the nice words. And I do sleep, but my normal day looks
a little bit different and sometimes I take a day off ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
