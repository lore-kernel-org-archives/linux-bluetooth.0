Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Simplify Link Key Notification event handling logic
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417597386-24060-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 3 Dec 2014 09:42:02 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <75F3619E-FB5C-42E0-A5EA-22493F205BF0@holtmann.org>
References: <1417597386-24060-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we get a Link Key Notification HCI event we should already have a
> hci_conn object. This should have been created either in the Connection
> Request event handler, the hci_connect_acl() function or the
> hci_cs_create_conn() function (if the request was not sent by the
> kernel).
> 
> Since the only case that we'd end up not having a hci_conn in the Link
> Key Notification event handler would be essentially broken hardware it's
> safe to simply bail out from the function if this happens.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 25 ++++++++++++++-----------
> 1 file changed, 14 insertions(+), 11 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

