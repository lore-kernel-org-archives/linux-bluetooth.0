Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 23:25:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Subject: Re: [RESEND PATCH] Bluetooth: btusb: Remove device lock on release
Message-ID: <20120209212501.GB453@x220.P-661HNU-F1>
References: <1328821115-12514-1-git-send-email-dh.herrmann@googlemail.com>
 <1328821115-12514-2-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328821115-12514-2-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, Feb 09, 2012, David Herrmann wrote:
> Recently we changed the way how we release driver-data. A driver is now
> responsible of destroying the data so we no longer need the device lock
> on deinitialization in btusb driver.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> Acked in: Message-ID: <1327960875.1955.183.camel@aeonflux>
> 
>  drivers/bluetooth/btusb.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
