Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Edd Dumbill <edd@usefulinc.com>
To: Peter Klausler <peter@klausler.com>
Cc: Charles Bueche <charles@bueche.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031201093804.A1281@schnell.us.cray.com>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com>
Content-Type: text/plain
Message-Id: <1070380522.19169.52.camel@saag>
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
Date: Tue, 02 Dec 2003 15:55:22 +0000

Hmm, I'd thought I'd sent this to the list, but obviously didn't. 
Here's a patch for Peter's bthid stuff to work with the uinput driver in
Linux 2.6.  Use at your own risk.  I had it going OK with an Apple
keyboard and MS mouse.

-- Edd

On Mon, 2003-12-01 at 15:38, Peter Klausler wrote:
> On 2003.11.30 12:51 Charles Bueche wrote:
> > Hi again,
> > 
> > responding to my own email after studying fake.c : I got it to compile
> > on 2.6, but this code isn't able to run as module on 2.6 kernels,
> > which
> > changed the module format.
> > 
> > Peter : do you plan a 2.6 version anytime soon ?
> 
> For 2.6 the fake.o driver shouldn't be needed; I'm told that
> there's a legitimate driver in 2.6 that can be used to
> inject input events from user-land.  But I've been way
> too busy porting 2.6 to a new architecture to spend much
> time playing with it on i386, so I can't tell you how hard
> it would be to adjust bthid to use the new driver.

-- 
Edd Dumbill -- more from me at http://usefulinc.com/edd/blog/
Managing Editor, XML.com, XMLhack.com; Chair, XML Europe 2003



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
