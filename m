Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2556509.1131351177494.JavaMail.dnedved@mac.com>
From: David Nedved <dnedved@mac.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] choosing a bluetooth PCMCIA card
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
Date: Mon, 07 Nov 2005 00:12:57 -0800

Hi All,

I've been browsing the list for a few days now, and I'm pretty sure I have an idea of the support status for the cards I've been looking at, but I've seen so many posts where people get a card that's listed and end up with questions, I hope you don't mind if I ask which of the following three cards will be the best choice for me BEFORE I buy:

- 3COM 3CRWB6096

Seems to be supported using bt3c_cs after firmware download.  Any issues with this one?  Seems to be a little harder to find than the other two as there's only one on ebay right now but a solid choice right?

- generic card with CSR BlueCore 02 main chip

This card is everywhere.  It's the first hit you get when you google "PCMCIA bluetooth", it's all over ebay.  It has a retractable antenna, and it's always advertised as "Class 1" and "328 feet" but almost never has a manufacturer mentioned.  I see that CSR chips are on almost 50% of the supported cards... but there's only one post in the archive with this particular chip mentioned, but I don't quite understand the firmware version specific issues -- "firmware support between 14.3 and 16.4" -- what does that mean?  Will this one be a good choice?

- Motorola BTPCM101

Also all over ebay and CHEAP.  Might stick up and not be usable form factor for my application (see below) and the only comments in the archives are one person having trouble and Marcel saying "you must get it working with the serial_cs driver. The CIS of the card is weird ..." which doesn't sound promising.  Probably should pass on this one even though it's cheap, right?

My application is that I need the PCMCIA bluetooth card to work mainly with serial support to talk to a GPS, but would also be very nice if it worked with other (non EDR) applications just for playing with such as headsets, phones, etc.  My machine is a Toshiba Libretto 110 which has two PCMCIA slots stacked on top of each other (and no serial or USB onboard).  I have an Orinoco Gold card in the top slot, which sticks out and up (out to the side and up towards the ceiling).  The bluetooth card must go in the slot under the Orinoco card, so it can stick out (to the side) but NOT up because the Orinoco card would block anything sticking up, slightly limiting my choices.  I'm running Gentoo and am stuck on kernel 2.6.12 for now until they get some PCMCIA/driver issues fixed with 2.6.13.  I have a strong preference for devices that are supported in kernel or at least in the portage tree, and most importantly are quick and painless to set up.

Thanks in advance for any comments on the hardware!

David


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
