Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Oct 2008 00:12:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: fix bug in suspend/resume code of btusb
Message-ID: <20081002221258.GA1664@elf.ucw.cz>
References: <200810022232.07165.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810022232.07165.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> this fixes an issue in btusb's suspend/resume support that strikes if
> the adapter is suspended while the hci is down.
> This probably fixes the bug Pavel sees with autosuspend and fixes a bug
> for me. I am currently looking at issues with new hardware, but with this patch
> it should work at least for the best hardware.

It seems to fix the problem here.

> What tree should I base a clean patch against?
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

Tested-by: Pavel Machek <pavel@suse.cz>

[okay, _lightly_ tested...]
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
