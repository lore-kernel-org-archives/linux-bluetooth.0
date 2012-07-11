Return-Path: <cyrus@holtmann.org>
From: "Henrik Rydberg" <rydberg@bitmath.se>
Date: Wed, 11 Jul 2012 17:03:36 +0200
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
Message-ID: <20120711150336.GA1340@polaris.bitmath.org>
References: <1341958206-15610-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341958206-15610-1-git-send-email-gustavo@padovan.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 10, 2012 at 07:10:06PM -0300, Gustavo Padovan wrote:
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
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---

Thank you, Gustavo, this patch made me happy.

Henrik
