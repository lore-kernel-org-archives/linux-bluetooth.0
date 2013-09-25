Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 7/7] Bluetooth: Add new mgmt_set_advertising command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380104770-8022-8-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 25 Sep 2013 12:31:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <906A652B-F6AF-461D-97FE-A03788DA44EA@holtmann.org>
References: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com> <1380104770-8022-8-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a new mgmt command for enabling and disabling
> LE advertising. The command depends on the LE setting being enabled
> first and will return a "rejected" response otherwise. The patch also
> adds safeguards so that there will ever only be one set_le or
> set_advertising command pending per adapter.
> 
> The response handling and new_settings event sending is done in an
> asynchronous request callback, meaning raw HCI access from user space to
> enable advertising (e.g. hciconfig leadv) will not trigger the
> new_settings event. This is intentional since trying to support mixed
> raw HCI and mgmt access would mean adding extra state tracking or new
> helper functions, essentially negating the benefit of using the
> asynchronous request framework. The HCI_LE_ENABLED and HCI_LE_PERIPHERAL
> flags however are updated correctly even with raw HCI access so this
> will not completely break subsequent access over mgmt.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/mgmt.h |  2 +
> net/bluetooth/mgmt.c         | 97 +++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 98 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

