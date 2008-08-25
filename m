Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Aug 2008 14:45:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-pm@lists.linux-foundation.org,
	Oliver Neukum <oliver@neukum.org>, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>
Subject: Re: btusb hibernation/suspend breakage in current -git
Message-ID: <20080825124517.GA1625@elf.ucw.cz>
References: <200808221520.19791.oliver@neukum.org> <200808221551.57225.oliver@neukum.org> <1219415470.7591.472.camel@violet.holtmann.net> <200808251337.16076.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200808251337.16076.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> Speaking of btusb, I'm obseving a reproducible breakage of suspend and
> hibernation (for hibernation it's 100% reproducible, for suspend to RAM about
> 50%) on my hp nx6325 with the current -git kernel.

I have been using btusb + s2ram for quite a long now... (and major
difference between hci_usb and btusb is that btusb will not randomly
corrupt memory when suspending with bluetooth in use...) lets see if I
can update to latest git...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
