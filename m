Return-Path: <cyrus@holtmann.org>
Message-ID: <1413367888.7328.1.camel@linux-0dmf.site>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Oliver Neukum <oneukum@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Naveen Kumar Parna <pnaveenkos@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
In-Reply-To: <Pine.LNX.4.44L0.1410091030580.1372-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1410091030580.1372-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Oct 2014 12:11:28 +0200
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2014-10-09 at 10:31 -0400, Alan Stern wrote:
> On Thu, 9 Oct 2014, Naveen Kumar Parna wrote:
> 
> > Hi Oliver & Alan,
> > 
> > 
> > 
> > Thanks for your inputs.
> > 
> > 
> > 
> > I enabled the dynamic debugging for USB HC driver. Please correct me
> > if I am wrong.
> 
> Debugging the kernel (or doing anything else to the kernel, for that
> matter) won't solve the problem if it is caused by a buggy hub.

Indeed. Could you just try a different hub?

	Regards
		Oliver



