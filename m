Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v3] Bluetooth: Add hci_h4p driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140102161824.GA8204@amd.pavel.ucw.cz>
Date: Thu, 2 Jan 2014 08:34:19 -0800
Cc: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>,
	=?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Ville Tervo <ville.tervo@nokia.com>,
	Sebastian Reichel <sre@ring0.de>
Message-Id: <A5B72277-42D4-4A24-8A29-9BE18762E8C4@holtmann.org>
References: <1379703710-5757-1-git-send-email-pali.rohar@gmail.com> <1727897.LBX8128hIo@izba> <20140102161824.GA8204@amd.pavel.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavel,

> Add hci_h4p bluetooth driver to 3.12. This device is used for example
> on Nokia N900 cell phone.

I only care about patches against bluetooth-next btw.

> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> 
> Changes from v2: Cleanups as suggested by Marcel. Platform data are
> still used to communicate with board code; N900 is not quite ready
> for device tree just yet. Power management thread was removed.

And platform data goes into include/linux/platform_data/ as I mentioned before.

Regards

Marcel

