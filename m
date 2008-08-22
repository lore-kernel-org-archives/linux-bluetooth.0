Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Aug 2008 09:42:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Frans Pop <elendil@planet.nl>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, maxk@qualcomm.com
Subject: Re: 2.6.17-rc3: hci-usb related warnings and error on resume
Message-ID: <20080822074228.GA27650@atrey.karlin.mff.cuni.cz>
References: <200808202055.46558.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200808202055.46558.elendil@planet.nl>
List-ID: <linux-bluetooth.vger.kernel.org>

> I recently got a new laptop (HP 2510p) and have been playing with 
> suspend/resume. Initially the dmesg after resume was fairly clean, but 
> that was with the bluetooth device disabled (I initially disabled it in 
> Windows).

avoid hci_usb. It is racy as hell. btusb actually works.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
