Return-Path: <cyrus@holtmann.org>
Message-ID: <6238307d0804010503n2c3c3813p150d849747fb8a2e@mail.gmail.com>
Date: Tue, 1 Apr 2008 14:03:58 +0200
From: "=?ISO-8859-1?Q?Kai_R=F6mer?=" <smirfi@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <C5EBD7EB-6863-4B52-A4E2-15B772609FCA@holtmann.org>
MIME-Version: 1.0
References: <6238307d0803310503t724dedcfo9e9e587e87d41b8d@mail.gmail.com>
	<6238307d0803310509n15d73cb1wee14c9470e443d72@mail.gmail.com>
	<C5EBD7EB-6863-4B52-A4E2-15B772609FCA@holtmann.org>
Subject: Re: [Bluez-users] Fwd: Socket CF Bluetooth Adapter with mpc5200
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

Hi Macel!
Thanks for your immediate answer! But still i have no clue how to make it work.

* So far i found that it is a Socket BT CF adapter rev L.
* I added anything i found in kernel related to PCMCIA and bluetooth
* installed sys-apps/pcmcia-cs-3.2.8-r2 (using gentoo)

My system works fine with my bt usb adapter (CSR) But with this CF
adapter I get no messages in dmesg or any hint about where this card
is!

So my question: How do i get access to this CF BT card? Does it work
via PCMCIA? I have no clue even where to start! Perhaps someone can
give me a hint where to begin.

My Sys is a TB5200 made by TQ similar to this:
http://tq-components.de/307+M5e72ba27d84.html

Thanks for your help!

Kai

2008/3/31, Marcel Holtmann <marcel@holtmann.org>:
> Hi Kai,
>
>
>  > I want to use the CF-Bluetooth adapter from Socket in my TQM5200 board
>  > with integrated CF slot. How can i activate the card in Kernel?
>
>
> depends on the version of the card. Some use the dtl1_cs driver.
>  Others need to use hciattach to announce the serial port to the kernel.
>
>
>  > Can i use this card with a standard usb card reader?
>
>
> No.
>
>  Regards
>
>  Marcel
>
>
>  -------------------------------------------------------------------------
>  Check out the new SourceForge.net Marketplace.
>  It's the best place to buy or sell services for
>  just about anything Open Source.
>  http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
>  _______________________________________________
>  Bluez-users mailing list
>  Bluez-users@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
