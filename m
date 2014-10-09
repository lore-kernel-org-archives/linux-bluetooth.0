Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Oct 2014 10:31:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkvJDLP2tgnzu7H_ZCRCnZwkw1zUd1uqWwoDkmrU_FLts7w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1410091030580.1372-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 9 Oct 2014, Naveen Kumar Parna wrote:

> Hi Oliver & Alan,
> 
> 
> 
> Thanks for your inputs.
> 
> 
> 
> I enabled the dynamic debugging for USB HC driver. Please correct me
> if I am wrong.

Debugging the kernel (or doing anything else to the kernel, for that
matter) won't solve the problem if it is caused by a buggy hub.

Alan Stern

