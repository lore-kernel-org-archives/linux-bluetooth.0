Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: Charles Bueche <charles@bueche.ch>, Edd Dumbill <edd@usefulinc.com>,
   Peter Klausler <peter@klausler.com>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031204085314.GA1780@smartdata.ch>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus>  <20031204085314.GA1780@smartdata.ch>
Content-Type: text/plain
Message-Id: <1070545978.24162.179.camel@pegasus>
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
Date: Thu, 04 Dec 2003 14:52:58 +0100

Hi Olivier,

> October 13, I have send a patch to Peter for the mouse button problems.
> See the two first email attached. No answer at all from Peter...
> This is against version 0.6 of bthid, but this is a very simple patch,
> so it must be easy to put in on the last release of bthid. The major
> problem is that the MX900 send all the button status when there is a
> change. And because if a button is not recognized by bthid, it was
> assigning it by default to the button 1. Has the MX900 has more buttons
> than bthid think. So, button 1 is always not pressed... (see attached
> emails for more info).
> 
> October 18, I have send a patch for non-US keyboard. This was used by
> another guy on bluez-users. Again, no answer from Peter... See 3rd email
> attached to this one.
> 
> October 28, I have send the patches on the bluez-users list. No answer
> from Peter... (see mailing list archive to find my message)

I have now applied both patches to my implementation.

> Here is another try (on bluez-devel this time). Thanks to let me known
> what is bad with my patches.  I'm sure if you will be put them in bthid,
> people using Logitech deviceces will be happy. And also people using
> non-us keyboard.

You should always post them to the mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
