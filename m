Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:01:08 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
Message-ID: <20120710220108.GA28387@kroah.com>
References: <1341957063-11989-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341957063-11989-1-git-send-email-gustavo@padovan.org>
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 10, 2012 at 06:51:03PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> A lot of Broadcom Bluetooth devices provides vendor specific interface
> class and we are getting flooded by patches adding new device support.
> This change will help us enable support for any other Broadcom with vendor
> specific device that arrives in the future.
> 
> Only the product id changes for those devices, so this macro would be
> perfect for us:
> 
> { USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) }

Two entries in the cdc_wdm driver can also be converted to use this
interface.  Do you want to send a patch doing that, or do you want me to
do it?

thanks,

greg k-h
