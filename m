Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: close HCI device when user channel socket gets closed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441188612-18946-1-git-send-email-simon.fels@canonical.com>
Date: Wed, 2 Sep 2015 09:17:19 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A04078B1-08B8-41CF-88DD-1547BD1B4A34@holtmann.org>
References: <1441188612-18946-1-git-send-email-simon.fels@canonical.com>
To: Simon Fels <simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

> With 9380f9eacfbbee701daa416edd6625efcd3e29e1 the order of unsetting
> the HCI_USER_CHANNEL flag of the HCI device was reverted to ensure
> the device is first closed before making it available again.
> 
> Due to hci_dev_close checking for HCI_USER_CHANNEL being set on the
> device it was never really closed and was kept opened. We're now
> calling hci_dev_do_close directly to make sure the device is correctly
> closed and we keep the correct order to unset the flag on our device
> object.
> 
> Signed-off-by: Simon Fels <simon.fels@canonical.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 2 +-
> net/bluetooth/hci_sock.c         | 2 +-
> 3 files changed, 3 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

However I added an extra comment into the code on why this is actually doing the right thing in the end. I mentioned before that I failed to comment on this before and we do not want to keep forgetting to comment on code that is not intuitive.

Regards

Marcel

