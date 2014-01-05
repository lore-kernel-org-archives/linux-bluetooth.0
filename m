Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Jan 2014 23:32:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	=?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH v4] Bluetooth: Add hci_h4p driver
Message-ID: <20140105223250.GB27517@amd.pavel.ucw.cz>
References: <1379703710-5757-1-git-send-email-pali.rohar@gmail.com>
 <1727897.LBX8128hIo@izba>
 <20140102161824.GA8204@amd.pavel.ucw.cz>
 <A5B72277-42D4-4A24-8A29-9BE18762E8C4@holtmann.org>
 <20140103001753.GA21023@amd.pavel.ucw.cz>
 <20140103010519.GA27678@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140103010519.GA27678@earth.universe>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> > Changes from v3: Moved platform data into
> > include/linux/platform_data/, something I missed before.
> 
> As I wrote before Tony plans to remove the boardcode for all
> OMAP boards including the Nokia N900 for 3.14, so you cannot
> boot without DT from 3.14 onwards.

Well, I believe it was agreed that DT should work for at least one
version before platform support is removed. 

> The drivers can still be initialized the old way using pdata quirks
> until all drivers are converted, but I think this driver can simply
> be prepared for DT directly:

Well, normally DT support means a bit of argumentation and bikeshed
painting... I believe it would be better to get the driver in as-is
and then work on adding DT support.

And yes, obviously it needs to be done.

Regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
