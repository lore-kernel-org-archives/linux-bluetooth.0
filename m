Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: Edd Dumbill <edd@usefulinc.com>
Cc: Peter Klausler <peter@klausler.com>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1070380907.19169.55.camel@saag>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag>
Content-Type: text/plain
Message-Id: <1070482683.18058.6.camel@bluez.bueche.ch>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 03 Dec 2003 21:18:03 +0100

Hi,

[first, thanks a lot for helping me. I plan a mini-HOWTO ln a web page
when I'm done so other can get the same setup working.]

I tried your patch on my linux-2.6.0-test11-gentoo Dell I8600 with my
Logitech MX900 mouse. It applies OK, but (don't know if it's gentoo
specific), my uinput is at /dev/misc/uinput, not /dev/input/uinput. So I
had to fix the path in out.c.

After this, I get the mouse events in  X. The movements are OK, but the
button 1 is not doing its job. If I cat < /dev/input/mice, I see
something happen when I click it, so it's obviously not the button
hardware.

I have compiled my X with a patch to enable the PS/2++ protocol. The
patch is from Eric Wong, can be downloaded here :
http://www.yhbt.net/normalperson/files/linux/LogitechMX_kernel_and_X_patch/4.3.0-XFree86_logitech_ps2.patch

could this patch be the reason for my button 1 problem ?

Hints welcome.
Charles

On Tue, 2003-12-02 at 17:01, Edd Dumbill wrote:
> On Tue, 2003-12-02 at 15:55, Edd Dumbill wrote:
> > Hmm, I'd thought I'd sent this to the list, but obviously didn't. 
> > Here's a patch for Peter's bthid stuff to work with the uinput driver in
> > Linux 2.6.  Use at your own risk.  I had it going OK with an Apple
> > keyboard and MS mouse.
> 
> And if I'd attached the patch first time, it would have been truly
> impressive.
> 
> Here we are.
> 
> -- Edd




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
