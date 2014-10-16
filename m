Return-Path: <cyrus@holtmann.org>
Message-ID: <1413450936.29366.1.camel@linux-0dmf.site>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Oliver Neukum <oneukum@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Naveen Kumar Parna <pnaveenkos@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
In-Reply-To: <Pine.LNX.4.44L0.1410151207020.1210-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1410151207020.1210-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 16 Oct 2014 11:15:36 +0200
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-10-15 at 12:11 -0400, Alan Stern wrote:
> > If the hub is the problem… what will be the better solution? Is it
> > possible to change internal hub?
> 
> No, it is not possible.

Indeed. However, it is possible to use an additional in between your
devices and the internal hub.

	Regards
		Oliver


