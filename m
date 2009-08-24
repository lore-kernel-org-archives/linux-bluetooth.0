Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb autosuspend and circular lock dep
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Arjan Van De Ven <arjan@linux.intel.com>,
	saharabeara@gmail.com
In-Reply-To: <200908242344.59861.oliver@neukum.org>
References: <20090615175435.GA4772@gamba.jf.intel.com>
	 <200908242326.01149.oliver@neukum.org>
	 <1251149817.2950.72.camel@localhost.localdomain>
	 <200908242344.59861.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 16:30:42 -0700
Message-Id: <1251156642.2950.83.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> This patch adds support of USB autosuspend to the btusb driver
> 
> If the device doesn't support remote wakeup, simple support based
> on up/down is provided. If the device supports remote wakeup,
> additional support for autosuspend while the interface is up is provided.
> This is done by queueing URBs in an anchor structure and waking the
> device up from a work queue on sending. Reception triggers remote
> wakeup.
> The last busy facility of the USB autosuspend code is used and
> to close a race between autosuspend and transmission a counter
> of ongoing transmissions is maintained.
> #ifdefs for CONFIG_PM are added as necessary.

actually git-am complaint about some whitespaces, but I fixed that
manually. Thanks for the patch.

Regards

Marcel


