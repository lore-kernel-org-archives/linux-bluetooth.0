Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix setting conn->pending_sec_level value from link key
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416401584-26705-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 19 Nov 2014 23:19:17 +0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D380748C-B52E-4E6A-97A6-9EB91C5F2CD8@holtmann.org>
References: <1416401584-26705-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When a connection is requested the conn->pending_sec_level value gets
> set to whatever level the user requested the connection to be. During
> the pairing process there are various sanity checks to try to ensure
> that the right length PIN or right IO Capability is used to satisfy the
> target security level. However, when we finally get hold of the link key
> that is to be used we should still set the actual final security level
> from the key type.
> 
> This way when we eventually get an Encrypt Change event the correct
> value gets copied to conn->sec_level.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 40 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

