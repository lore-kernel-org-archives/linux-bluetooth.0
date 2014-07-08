Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix toggling background scan when changing connectable state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404826534-5546-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Jul 2014 15:42:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FC7F2B67-4E60-48AC-87CE-F293A98F11EF@holtmann.org>
References: <1404826534-5546-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If the connectable state change doesn't require any special HCI commands
> the set_connectable_update_settings() function is used instead of the
> set_connectable_complete() function. We must therefore make sure to call
> hci_update_background_scan() there as well. This code path is used also
> when we're powered off, but that's fine since hci_update_background_scan()
> has the necessary checks for it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

